//
//  Factory.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 8/12/22.
//


import Foundation

public struct Factory<T> {

    public init(factory: @escaping () -> T) {
        self.registration = Registration<Void, T>(factory: factory, scope: nil)
    }

    public init(scope: SharedContainer.Scope, factory: @escaping () -> T) {
        self.registration = Registration<Void, T>(factory: factory, scope: scope)
    }

    public func callAsFunction() -> T {
        registration.resolve(())
    }

    public func register(factory: @escaping () -> T) {
        registration.register(factory: factory)
    }

    public func reset() {
        registration.reset()
    }

    private let registration: Registration<Void, T>
}

public struct ParameterFactory<P, T> {

    public init(factory: @escaping (_ params: P) -> T) {
        self.registration = Registration<P, T>(factory: factory, scope: nil)
    }

    public init(scope: SharedContainer.Scope, factory: @escaping (_ params: P) -> T) {
        self.registration = Registration<P, T>(factory: factory, scope: scope)
    }

    public func callAsFunction(_ params: P) -> T {
        registration.resolve(params)
    }

    public func register(factory: @escaping (_ params: P) -> T) {
        registration.register(factory: factory)
    }

    public func reset() {
        registration.reset()
    }

    private let registration: Registration<P, T>
}

public class Container: SharedContainer {
}

open class SharedContainer {

    public class Registrations {


        public static func push() {
            defer { lock.unlock() }
            lock.lock()
            stack.append(registrations)
        }

        public static func pop() {
            defer { lock.unlock() }
            lock.lock()
            if let registrations = stack.popLast() {
                self.registrations = registrations
            }
        }

        public static func reset() {
            defer { lock.unlock() }
            lock.lock()
            registrations = [:]
        }

        fileprivate static func register(id: UUID, factory: AnyFactory) {
            defer { lock.unlock() }
            lock.lock()
            registrations[id] = factory
        }

        fileprivate static func factory(for id: UUID) -> AnyFactory? {
            defer { lock.unlock() }
            lock.lock()
            return registrations[id]
        }

        fileprivate static func reset(_ id: UUID) {
            defer { lock.unlock() }
            lock.lock()
            registrations.removeValue(forKey: id)
        }

        private static var lock = NSLock()
        private static var registrations: [UUID: AnyFactory] = .init(minimumCapacity: 64)
        private static var stack: [[UUID: AnyFactory]] = []

    }

    public class Scope {

        fileprivate init() {
            defer { lock.unlock() }
            lock.lock()
            Self.scopes.append(self)
        }

        public func reset() {
            defer { lock.unlock() }
            lock.lock()
            cache = [:]
        }

        public var isEmpty: Bool {
            defer { lock.unlock() }
            lock.lock()
            return cache.isEmpty
        }

        fileprivate func resolve<T>(id: UUID, factory: () -> T) -> T {
            defer { lock.unlock() }
            lock.lock()
            if let box = cache[id] {
                if let instance = box.instance as? T {
                    if let optional = instance as? OptionalProtocol {
                        if optional.hasWrappedValue {
                           return instance
                        }
                    } else {
                        return instance
                    }
                }
            }
            let instance: T = factory()
            if let box = box(instance) {
                cache[id] = box
            }
            return instance
        }

        fileprivate func reset(_ id: UUID) {
            defer { lock.unlock() }
            lock.lock()
            cache.removeValue(forKey: id)
        }

        fileprivate func box<T>(_ instance: T) -> AnyBox? {
            if let optional = instance as? OptionalProtocol {
                return optional.hasWrappedValue ? StrongBox<T>(boxed: instance) : nil
            } else {
                return StrongBox<T>(boxed: instance)
            }
        }

        private var lock = NSRecursiveLock()
        private var cache: [UUID: AnyBox] = .init(minimumCapacity: 64)

    }

    public struct Decorator {

        public static var decorate: ((_ dependency: Any) -> Void)?

    }
}

extension SharedContainer.Scope {

    public static let cached = Cached()
    public final class Cached: SharedContainer.Scope {
        public override init() {
            super.init()
        }
    }

    public static let shared = Shared()
    public final class Shared: SharedContainer.Scope {
        public override init() {
            super.init()
        }
        fileprivate override func box<T>(_ instance: T) -> AnyBox? {
            if let optional = instance as? OptionalProtocol {
                if let unwrapped = optional.wrappedValue, type(of: unwrapped) is AnyObject.Type {
                    return WeakBox(boxed: unwrapped as AnyObject)
                }
            } else if type(of: instance as Any) is AnyObject.Type {
                return WeakBox(boxed: instance as AnyObject)
            }
            return nil
        }
    }

    public static let singleton = Singleton()
    public final class Singleton: SharedContainer.Scope {
        public override init() {
            super.init()
        }
    }

    public static func reset(includingSingletons: Bool = false) {
        Self.scopes.forEach {
            if !($0 is Singleton) || includingSingletons {
                $0.reset()
            }
        }
    }

    private static var scopes: [SharedContainer.Scope] = []

}

#if swift(>=5.1)
@propertyWrapper public struct Injected<T> {
    private var dependency: T
    public init(_ factory: Factory<T>) {
        self.dependency = factory()
    }
    public var wrappedValue: T {
        get { return dependency }
        mutating set { dependency = newValue }
    }
}

@propertyWrapper public struct LazyInjected<T> {
    private var factory: Factory<T>
    private var dependency: T!
    private var initialize = true
    public init(_ factory: Factory<T>) {
        self.factory = factory
    }
    public var wrappedValue: T {
        mutating get {
            if initialize {
                dependency = factory()
                initialize = false
            }
            return dependency
        }
        mutating set {
            dependency = newValue
        }
    }
}

@propertyWrapper public struct WeakLazyInjected<T> {
    private var factory: Factory<T>
    private weak var dependency: AnyObject?
    private var initialize = true
    public init(_ factory: Factory<T>) {
        self.factory = factory
    }
    public var wrappedValue: T? {
        mutating get {
            if initialize {
                dependency = factory() as AnyObject
                initialize = false
            }
            return dependency as? T
        }
        mutating set {
            dependency = newValue as AnyObject
        }
    }
}
#endif

public protocol AutoRegistering {
    static func registerAllServices()
}

extension Container {
    fileprivate static var autoRegistrationCheck: Void  = {
        (Container.self as? AutoRegistering.Type)?.registerAllServices()
    }()
}

private protocol AnyFactory {}

private struct TypedFactory<P, T>: AnyFactory {
    let factory: (P) -> T
}

private struct Registration<P, T> {

    let id: UUID = UUID()
    let factory: (P) -> T
    let scope: SharedContainer.Scope?

    func resolve(_ params: P) -> T {
        let _ = Container.autoRegistrationCheck
        let currentFactory: (P) -> T = (SharedContainer.Registrations.factory(for: id) as? TypedFactory<P, T>)?.factory ?? factory
        let instance: T = scope?.resolve(id: id, factory: { currentFactory(params) }) ?? currentFactory(params)
        SharedContainer.Decorator.decorate?(instance)
        return instance
    }

    func register(factory: @escaping (_ params: P) -> T) {
        SharedContainer.Registrations.register(id: id, factory: TypedFactory<P, T>(factory: factory))
        scope?.reset(id)
    }

    func reset() {
        SharedContainer.Registrations.reset(id)
        scope?.reset(id)
    }

}

private protocol OptionalProtocol {
    var hasWrappedValue: Bool { get }
    var wrappedType: Any.Type { get }
    var wrappedValue: Any? { get }
}

extension Optional: OptionalProtocol {
    var hasWrappedValue: Bool {
        switch self {
        case .none:
            return false
        case .some:
            return true
        }
    }
    var wrappedType: Any.Type {
        Wrapped.self
    }
    var wrappedValue: Any? {
        switch self {
        case .none:
            return nil
        case .some(let value):
            return value
        }
    }
}

private protocol AnyBox {
    var instance: Any { get }
}

private struct StrongBox<T>: AnyBox {
    let boxed: T
    var instance: Any {
        boxed as Any
    }
}

private struct WeakBox: AnyBox {
    weak var boxed: AnyObject?
    var instance: Any {
        boxed as Any
    }
}

//
//  ViewController.swift
//  DXCats
//
//  Created by iQ on 8/13/22.
//

import UIKit
import RxSwift
import RxCocoa

class CatsViewController: UITableViewController {
    
    @UsesAutoLayout
    private var loadingIndicator = UIActivityIndicatorView(style: .gray)
    
    private var dataSource = CatsGalleryListDataSource()
    
    private var viewModel: CatsViewModel
    private var coordinator: ProjectCoordinator
    
    private let disposeBag = DisposeBag()
    
    init(coordinator: ProjectCoordinator, viewModel: CatsViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView()
        setupBindings()
        
        viewModel.fetchData()
        
        
    }
    
    private func createView() {
        
        tableView.dataSource = dataSource
        
        tableView.separatorStyle = .none
        
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier())
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = UIColor.lightGray
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loadingIndicator)
    }
    
    func setupBindings() {
        viewModel.success.drive(onNext: {[weak self] (_dataSources) in
            if _dataSources.isEmpty {return}
            self?.dataSource.updateDataSource(dataSources: _dataSources)
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.failure.drive(onNext: {[weak self] (_error) in
            guard let _error = _error else {return}
            let alert = UIAlertController(title: "Opps!", message: _error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        viewModel.loading.drive(onNext: {[weak self] (_isLoading) in
            if(_isLoading){
                self?.loadingIndicator.startAnimating()
            }else{
                self?.loadingIndicator.stopAnimating()
            }
        }).disposed(by: disposeBag)
    }
    
    @objc private func refresh(sender:AnyObject){
        viewModel.fetchData()
        tableView.refreshControl?.endRefreshing()
    }
    
}

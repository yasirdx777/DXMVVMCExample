//
//  ViewController.swift
//  DXDogs
//
//  Created by iQ on 8/13/22.
//

import UIKit

protocol DogsViewProtocol: NSObject {
    var viewModel: DogsViewModelProtocol? { get set }
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showError(error: Error)
    func updateDataSource(dataSources: [UITableViewDataSource])
    func reloadListData()
}

class DogsViewController: UITableViewController, DogsViewProtocol {
    
    @UsesAutoLayout
    private var loadingIndicator = UIActivityIndicatorView(style: .gray)
    private var dataSource = DogsGalleryListDataSource()
    
    var viewModel: DogsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView()
        
        viewModel?.viewDidLoad()
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
    
    
    
    @objc private func refresh(sender:AnyObject){
        viewModel?.viewDidLoad()
        tableView.refreshControl?.endRefreshing()
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Opps!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateDataSource(dataSources: [UITableViewDataSource]) {
        dataSource.updateDataSource(dataSources: dataSources)
    }
    
    func reloadListData() {
        tableView.reloadData()
    }
    
}

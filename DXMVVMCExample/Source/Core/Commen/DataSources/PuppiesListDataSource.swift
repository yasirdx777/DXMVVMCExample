//
//  PuppyListDataSource.swift
//  DXCats
//
//  Created by iQ on 8/14/22.
//

import Foundation
import UIKit

class PuppiesListDataSource: NSObject, UITableViewDataSource {
    private var dataSource: [Post] = []
    
    init(posts: [Post]) {
        self.dataSource = posts
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier()) as? ImageTableViewCell else { return UITableViewCell() }
        
        let item = dataSource[indexPath.row]
        
        cell.configure(imageUrl: item.urls.regular)
        
        return cell
    }
}

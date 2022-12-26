//
//  DogsListDataSource.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 8/14/22.
//

import Foundation
import UIKit

class DogsListDataSource: NSObject, UITableViewDataSource {
    private var dataSource: [DogsPost] = []
    
    init(posts: [DogsPost]) {
        self.dataSource = posts
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier()) as? ImageTableViewCell else { return UITableViewCell() }
        
        let item = dataSource[indexPath.row]
        
        cell.configure(imageUrl: item.imageUrl)
        
        return cell
    }
}


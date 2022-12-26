//
//  CatsGalleryListDataSource.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 8/14/22.
//

import Foundation
import UIKit

class CatsGalleryListDataSource: NSObject, UITableViewDataSource {
    
    private var dataSources: [UITableViewDataSource] = []
    
    func updateDataSource(dataSources: [UITableViewDataSource]) {
        self.dataSources = dataSources
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSources.count
    }
    
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSources[section].tableView(tableView, numberOfRowsInSection: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dataSources[indexPath.section].tableView(tableView, cellForRowAt: IndexPath(row: indexPath.row, section: 0))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dataSources[section].tableView?(tableView, titleForHeaderInSection: 0)
    }
}

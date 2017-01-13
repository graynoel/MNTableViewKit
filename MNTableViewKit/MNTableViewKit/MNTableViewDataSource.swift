//
//  MNTableViewDataSource.swift
//  SwiftTableView
//
//  Created by zhaohui on 2017/1/11.
//  Copyright © 2017年 HuiZhao. All rights reserved.
//

import UIKit

@objc protocol MNTableViewDataSourceProtocol: UITableViewDataSource {
    
    @objc optional func tableView(_ tableView: UITableView, cellClassFor object: AnyObject?) -> AnyClass
    @objc optional func tableView(_ tableView: UITableView, objectForRowAt indexPath: IndexPath) -> AnyObject?
}

class MNTableViewDataSource: NSObject, MNTableViewDataSourceProtocol {

    var sections: [MNTableViewSectionObject]
    
    // init
    override init() {
        sections = []
    }
    
    func sectionObject(_ section: Int) -> MNTableViewSectionObject? {
        if sections.count > section {
            return sections[section]
        }
        return nil
    }
    
    // MNTableViewDataSourceProtocol
    
    func tableView(_ tableView: UITableView, cellClassFor object: AnyObject?) -> AnyClass {
        return MNTableViewCell.self
    }
    
    func tableView(_ tableView: UITableView, objectForRowAt indexPath: IndexPath) -> AnyObject? {
        if sections.count > 0 {
            let sectionObject = sections[indexPath.section]
            if sectionObject.items.count > indexPath.row {
                return sectionObject.items[indexPath.row]
            }
        }
        return nil
    }
    
    // UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections.count > section {
            let sectionObject = sections[section]
            return sectionObject.items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = nil
        
        let object = self.tableView(tableView, objectForRowAt: indexPath) as? MNTableViewItem
        let cellClass = self.tableView(tableView, cellClassFor: object) as? UITableViewCell.Type
        
        var className = ""
        if cellClass != nil {
            className = "\(cellClass!)"
        }
        cell = tableView.dequeueReusableCell(withIdentifier: className)
        if cell == nil {
            cell = cellClass!.init(style: UITableViewCellStyle.default, reuseIdentifier: className)
        }
        
        if cell!.isKind(of: MNTableViewCell.self) {
            if let item = object {
                let numberOfRowsInSection = tableView.numberOfRows(inSection: indexPath.section)
                if numberOfRowsInSection == 1 {
                    item.isFirstItemInSection = true
                    item.isLastItemInSection = true
                } else if indexPath.row == numberOfRowsInSection - 1 {
                    item.isFirstItemInSection = false
                    item.isLastItemInSection = true
                } else if indexPath.row == 0 {
                    item.isFirstItemInSection = true
                    item.isLastItemInSection = false
                } else {
                    item.isFirstItemInSection = false
                    item.isLastItemInSection = false
                }
            }
            (cell as! MNTableViewCell).object = object
            (cell as! MNTableViewCell).bind(object)
        }
        
        return cell!
    }
    
}

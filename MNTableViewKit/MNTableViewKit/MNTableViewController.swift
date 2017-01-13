//
//  MNTableViewController.swift
//  SwiftTableView
//
//  Created by zhaohui on 2017/1/11.
//  Copyright © 2017年 HuiZhao. All rights reserved.
//

import UIKit

class MNTableViewController: UIViewController, MNTableViewDelegate {
    
    var tableViewStyle: UITableViewStyle
    var tableView: MNTableView
    var dataSource: MNTableViewDataSource? {
        didSet {
            tableView.mnDataSource = dataSource
        }
    }
    
    init(style: UITableViewStyle) {
        tableViewStyle = style
        tableView = MNTableView.init(frame: CGRect.zero, style: tableViewStyle)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.mnDelegate = self
        tableView.mnDataSource = dataSource
        tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
    }
}

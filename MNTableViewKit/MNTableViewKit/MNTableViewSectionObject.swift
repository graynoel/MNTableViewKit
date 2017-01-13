//
//  MNTableViewSectionObject.swift
//  SwiftTableView
//
//  Created by zhaohui on 2017/1/11.
//  Copyright © 2017年 HuiZhao. All rights reserved.
//

import UIKit

class MNTableViewSectionObject: NSObject {

    var items: [AnyObject]
    var identifier: String?
    
    override init () {
        items = []
    }
}

//
//  MNConvenience.swift
//  SwiftTableView
//
//  Created by zhaohui on 2017/1/12.
//  Copyright © 2017年 HuiZhao. All rights reserved.
//

import UIKit

extension UIView {
    
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.top + self.height
        }
    }
    
    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
    }
    
    var right: CGFloat {
        get {
            return self.left + self.width
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
    }
}

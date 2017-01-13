//
//  MNTableViewCell.swift
//  SwiftTableView
//
//  Created by zhaohui on 2017/1/11.
//  Copyright © 2017年 HuiZhao. All rights reserved.
//

import UIKit

enum MNCellSeparatorLocation {
    case NotSpecified
    case Both
    case Top
    case Bottom
    case NotFound
}

class MNTableViewCell: UITableViewCell {
    
    // cell data property
    var object: AnyObject?
    var indexPath: NSIndexPath?
    
    // cell UI property
    private var cellSeparatorLocation: MNCellSeparatorLocation = .NotSpecified
    private var cellTopSeparatorInset: UIEdgeInsets = UIEdgeInsets.zero
    private var cellBottomSeparatorInset: UIEdgeInsets = UIEdgeInsets.zero
    private var cellTopSeparatorColor: UIColor = UIColor.gray
    private var cellBottomSeparatorColor: UIColor = UIColor.gray
    private var cellTopLine: UIView
    private var cellBottomLine: UIView

    // init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        cellTopLine = UIView.init(frame: CGRect.zero)
        cellBottomLine = UIView.init(frame: CGRect.zero)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(cellTopLine)
        self.contentView.addSubview(cellBottomLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Separator
    func tableViewCellSeparatorLocation() -> MNCellSeparatorLocation {
        if let obj = object {
            if obj is MNTableViewItem {
                let item = obj as! MNTableViewItem
                if item.itemSeparatorLocation == .NotSpecified {
                    if item.isLastItemInSection {
                        item.itemSeparatorLocation = .NotFound
                    } else {
                        item.itemSeparatorLocation = .Bottom
                    }
                }
                cellSeparatorLocation = item.itemSeparatorLocation
            }
        }
        return cellSeparatorLocation
    }
    
    func tableViewCellTopSeparatorInset() -> UIEdgeInsets {
        return cellTopSeparatorInset
    }
    
    func tableViewCellBottomSeparatorInset() -> UIEdgeInsets {
        return cellBottomSeparatorInset
    }
    
    func tableViewCellTopSeparatorColor() -> UIColor {
        return cellTopSeparatorColor
    }
    
    func tableViewCellBottomSeparatorColor() -> UIColor {
        return cellBottomSeparatorColor
    }
    
    func setupCellSeparator() -> Void {
        cellTopLine.backgroundColor = self.tableViewCellTopSeparatorColor()
        cellBottomLine.backgroundColor = self.tableViewCellBottomSeparatorColor()
        
        let topLineInset = self.tableViewCellTopSeparatorInset()
        let bottomLineInset = self.tableViewCellBottomSeparatorInset()
        let topSeparatorFrame = CGRect(x: topLineInset.left, y: topLineInset.top, width: self.contentView.width - topLineInset.left - topLineInset.right, height: 1 / UIScreen.main.scale)
        let bottomSeparatorFrame = CGRect(x: bottomLineInset.left, y: self.contentView.bottom - 1 / UIScreen.main.scale - bottomLineInset.top, width: self.contentView.width - bottomLineInset.left - bottomLineInset.right, height: 1 / UIScreen.main.scale)
        cellTopLine.frame = topSeparatorFrame
        cellBottomLine.frame = bottomSeparatorFrame
        
        switch self.tableViewCellSeparatorLocation() {
            case .Both:
                cellTopLine.isHidden = false
                cellBottomLine.isHidden = false
            case .Top:
                cellTopLine.isHidden = false
                cellBottomLine.isHidden = true
            case .Bottom:
                cellTopLine.isHidden = true
                cellBottomLine.isHidden = false
            // .NotFound, .NotSpecified, default
            default:
                cellTopLine.isHidden = true
                cellBottomLine.isHidden = true
        }
    }
    
    // UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupCellSeparator()
    }
    
    // TableView Callback
    class func tableview(_ tableView: UITableView, rowHeightFor object: AnyObject?) -> CGFloat {
        return 44.0
    }
    
    // Implemented by subclasses
    func bind(_ object: AnyObject?) -> Void {
        
    }

}

//
//  MNTableView.swift
//  SwiftTableView
//
//  Created by zhaohui on 2017/1/11.
//  Copyright © 2017年 HuiZhao. All rights reserved.
//

import UIKit

@objc protocol MNTableViewDelegate: UITableViewDelegate {
    
    // Display customization
    
    @objc optional func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forObject object: AnyObject?, At indexPath: IndexPath)
    @objc optional func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forObject object: AnyObject?, At indexPath: IndexPath)
    
    // Section header & footer information
    
    @objc optional func tableView(_ tableView: UITableView, headerViewForSection object: MNTableViewSectionObject?, InSection section: Int) -> UIView?
    @objc optional func tableView(_ tableView: UITableView, footerViewForSection object: MNTableViewSectionObject?, InSection section: Int) -> UIView?
    
    // Selection
    
    @objc optional func tableView(_ tableView: UITableView, shouldHighlightFor object: AnyObject?, At indexPath: IndexPath) -> Bool
    @objc optional func tableView(_ tableView: UITableView, didHighlightFor object: AnyObject?, At indexPath: IndexPath)
    @objc optional func tableView(_ tableView: UITableView, didUnhighlightFor object: AnyObject?, At indexPath: IndexPath)
    
    @objc optional func tableView(_ tableView: UITableView, willSelect object: AnyObject?, At indexPath: IndexPath) -> IndexPath?
    @objc optional func tableView(_ tableView: UITableView, willDeselect object: AnyObject?, At indexPath: IndexPath) -> IndexPath?
    
    @objc optional func tableView(_ tableView: MNTableView, didSelect object: AnyObject?, At indexPath: IndexPath)
    @objc optional func tableView(_ tableView: UITableView, didDeselect object: AnyObject?, At indexPath: IndexPath)
    
}

class MNTableView: UITableView, MNTableViewDelegate {

    weak var mnDelegate: MNTableViewDelegate?
    weak var mnDataSource: MNTableViewDataSourceProtocol? {
        didSet {
            self.dataSource = mnDataSource
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        showsVerticalScrollIndicator = true
        showsHorizontalScrollIndicator = false
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separatorStyle = .none
        hideLines()
    }
    
    // UITableViewDelegate
    
    // Display customization
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:willDisplay:forObject:At:))) {
                    if let dataSource = mnTableView.mnDataSource {
                        let object = dataSource.tableView!(tableView, objectForRowAt: indexPath)
                        delegate.tableView!(tableView, willDisplay: cell, forObject: object, At: indexPath)
                    }
                } else if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:willDisplay:forRowAt:))) {
                    delegate.tableView!(tableView, willDisplay: cell, forRowAt: indexPath)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didEndDisplaying:forObject:At:))) {
                    if let dataSource = mnTableView.mnDataSource {
                        let object = dataSource.tableView!(tableView, objectForRowAt: indexPath)
                        delegate.tableView!(tableView, didEndDisplaying: cell, forObject: object, At: indexPath)
                    }
                } else if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didEndDisplaying:forRowAt:))) {
                    delegate.tableView!(tableView, didEndDisplaying: cell, forRowAt: indexPath)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:willDisplayHeaderView:forSection:))) {
                    delegate.tableView!(tableView, willDisplayHeaderView: view, forSection: section)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:willDisplayFooterView:forSection:))) {
                    delegate.tableView!(tableView, willDisplayFooterView: view, forSection: section)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didEndDisplayingHeaderView:forSection:))) {
                    delegate.tableView!(tableView, didEndDisplayingHeaderView: view, forSection: section)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didEndDisplayingFooterView:forSection:))) {
                    delegate.tableView!(tableView, didEndDisplayingFooterView: view, forSection: section)
                }
            }
        }
    }
    
    // Variable height support
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let mnTableView = tableView as? MNTableView {
            if let dataSource = mnTableView.mnDataSource {
                let object = dataSource.tableView!(tableView, objectForRowAt: indexPath)
                let cls = dataSource.tableView!(tableView, cellClassFor: object) as? MNTableViewCell.Type
                if cls != nil {
                    return cls!.tableview(tableView, rowHeightFor: object)
                }
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:heightForHeaderInSection:))) {
                    return delegate.tableView!(tableView, heightForHeaderInSection: section)
                }
            }
            
            if let dataSource = mnTableView.mnDataSource {
                if dataSource.responds(to: #selector(MNTableViewDataSourceProtocol.tableView(_:titleForHeaderInSection:))) {
                    return 28.0
                }
            }
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:heightForFooterInSection:))) {
                    return delegate.tableView!(tableView, heightForFooterInSection: section)
                }
            }
            
            if let dataSource = mnTableView.mnDataSource {
                if dataSource.responds(to: #selector(MNTableViewDataSourceProtocol.tableView(_:titleForFooterInSection:))) {
                    return 28.0
                }
            }
        }
        return 0.0
    }
    
    // Section header & footer information.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:headerViewForSection:InSection:))) {
                    if let dataSource = mnTableView.mnDataSource {
                        let object = (dataSource as! MNTableViewDataSource).sectionObject(section)
                        return delegate.tableView!(tableView, headerViewForSection: object, InSection: section)
                    }
                } else if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:viewForHeaderInSection:))) {
                    return delegate.tableView!(tableView, viewForHeaderInSection: section)
                }
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:footerViewForSection:InSection:))) {
                    if let dataSource = mnTableView.mnDataSource {
                        let object = (dataSource as! MNTableViewDataSource).sectionObject(section)
                        return delegate.tableView!(tableView, footerViewForSection: object, InSection: section)
                    }
                } else if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:viewForFooterInSection:))) {
                    return delegate.tableView!(tableView, viewForFooterInSection: section)
                }
            }
        }
        return nil
    }
    
    // Selection
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:shouldHighlightFor:At:))) {
                    if let dataSource = mnTableView.mnDataSource {
                        let object = dataSource.tableView!(tableView, objectForRowAt: indexPath)
                        return delegate.tableView!(tableView, shouldHighlightFor: object, At: indexPath)
                    }
                } else if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:shouldHighlightRowAt:))) {
                    return delegate.tableView!(tableView, shouldHighlightRowAt: indexPath)
                }
            }
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didHighlightFor:At:))) {
                    if let dataSource = mnTableView.mnDataSource {
                        let object = dataSource.tableView!(tableView, objectForRowAt: indexPath)
                        delegate.tableView!(tableView, didHighlightFor: object, At: indexPath)
                    }
                } else if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didHighlightRowAt:))) {
                    delegate.tableView!(tableView, didHighlightRowAt: indexPath)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didUnhighlightFor:At:))) {
                    if let dataSource = mnTableView.mnDataSource {
                        let object = dataSource.tableView!(tableView, objectForRowAt: indexPath)
                        delegate.tableView!(tableView, didUnhighlightFor: object, At: indexPath)
                    }
                } else if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didUnhighlightRowAt:))) {
                    delegate.tableView!(tableView, didUnhighlightRowAt: indexPath)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:willSelect:At:))) {
                    if let dataSource = mnTableView.mnDataSource {
                        let object = dataSource.tableView!(tableView, objectForRowAt: indexPath)
                        return delegate.tableView!(tableView, willSelect: object, At: indexPath)
                    }
                } else if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:willSelectRowAt:))) {
                    return delegate.tableView!(tableView, willSelectRowAt: indexPath)
                }
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:willDeselect:At:))) {
                    if let dataSource = mnTableView.mnDataSource {
                        let object = dataSource.tableView!(tableView, objectForRowAt: indexPath)
                        return delegate.tableView!(tableView, willDeselect: object, At: indexPath)
                    }
                } else if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:willDeselectRowAt:))) {
                    return delegate.tableView!(tableView, willDeselectRowAt: indexPath)
                }
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didSelect:At:))) {
                    if let dataSource = mnTableView.mnDataSource {
                        let object = dataSource.tableView!(tableView, objectForRowAt: indexPath)
                        delegate.tableView!(mnTableView, didSelect: object, At: indexPath)
                    }
                } else if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didSelectRowAt:))) {
                    delegate.tableView!(tableView, didSelectRowAt: indexPath)
                }
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let mnTableView = tableView as? MNTableView {
            if let delegate = mnTableView.mnDelegate {
                if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didDeselect:At:))) {
                    if let dataSource = mnTableView.mnDataSource {
                        let object = dataSource.tableView!(tableView, objectForRowAt: indexPath)
                        delegate.tableView!(tableView, didDeselect: object, At: indexPath)
                    }
                } else if delegate.responds(to: #selector(MNTableViewDelegate.tableView(_:didDeselectRowAt:))) {
                    delegate.tableView!(tableView, didDeselectRowAt: indexPath)
                }
            }
        }
    }
}

extension MNTableView {
    
    func hideLines() -> Void {
        if self.tableFooterView == nil {
            let view = UIView.init(frame: CGRect.zero)
            view.backgroundColor = UIColor.clear
            self.tableFooterView = view
        }
    }
}

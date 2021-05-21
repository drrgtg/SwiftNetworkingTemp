//
//  UIScrollView+Refresh.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/26.
//  Copyright © 2019 -. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    
    @objc func setHeaderRefresh(_ block: @escaping ()->Void) {
        setHeaderRefresh(block, config: nil)
    }
    
    @objc func setHeaderRefresh(_ block: @escaping ()->Void, config: ((MJRefreshNormalHeader)->Void)?) {
        let header = MJRefreshNormalHeader(refreshingBlock: block)
//        header.isAutomaticallyChangeAlpha = true
//        header.lastUpdatedTimeLabel?.isHidden = true
//        header.loadingView?.style = .white
//        header.isCollectionViewAnimationBug = true
        mj_header = header
        config?(header)
    }
    
    @objc func removeHeaderRefresh() {
        mj_header = nil
    }
    
    @objc func setFooterRefresh(_ block: @escaping ()->Void) {
        setFooterRefresh(block, config: nil)
    }
    
    @objc func setFooterRefresh(_ block: @escaping ()->Void, config: ((MJRefreshFooter)->Void)?) {
        let footer = MJRefreshAutoFooter(refreshingBlock: block)
        // footer.isAutomaticallyChangeAlpha = true
        // footer.autoTriggerTimes = -1
        mj_footer = footer
        config?(footer)
    }
    
    @objc func removeFooterRefresh() {
        mj_footer = nil
    }
    
    @objc func hideFooterRefreshView() {
        mj_footer?.isHidden = true
    }
    
    @objc func showFooterRefreshView() {
        mj_footer?.isHidden = false
    }
    
    @objc func beginHeaderRefreshing(_ block: (()->Void)? = nil) {
        if let block = block {
            mj_header?.beginRefreshing(completionBlock: block)
        } else {
            mj_header?.beginRefreshing()
        }
    }
    
    @objc func beginFooterRefreshing(_ block: (()->Void)? = nil) {
        if let block = block {
            mj_footer?.beginRefreshing(completionBlock: block)
        } else {
            mj_footer?.beginRefreshing()
        }
    }
    
    @objc func endRefresh() {
        mj_header?.endRefreshing()
        mj_footer?.endRefreshing()
    }
    
    @objc func endRefreshWithNoMoreData() {
        mj_header?.endRefreshing()
        mj_footer?.endRefreshingWithNoMoreData()
    }
    
    @objc func isRefreshing() -> Bool {
        return mj_header?.isRefreshing ?? false || mj_footer?.isRefreshing ?? false
    }
}

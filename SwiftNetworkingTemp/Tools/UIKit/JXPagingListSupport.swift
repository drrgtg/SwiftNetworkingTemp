//
//  JXPagingListSupport.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2020/1/13.
//  Copyright © 2020 -. All rights reserved.
//

#if canImport(JXSegmentedView)
import JXSegmentedView

extension UIViewController: JXSegmentedListContainerViewListDelegate {
    public func listView() -> UIView {
        view
    }
}
#endif /* canImport(JXSegmentedView) */


#if canImport(JXPagingView)
import JXPagingView

extension JXPagingListContainerView: JXSegmentedViewListContainer {}

extension UIViewController: JXPagingViewListViewDelegate {
    
    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallbackBlock = callback
    }
    
    public func listScrollView() -> UIScrollView {
        UIScrollView()
    }
}

extension QMUICommonTableViewController {
    public override func listScrollView() -> UIScrollView {
        tableView
    }
}

extension BaseCollectionViewController {
    public override func listScrollView() -> UIScrollView {
        collectionView
    }
}

//extension UIViewController: JXPagingMainTableViewGestureDelegate {
//    public func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        //禁止segmentedView左右滑动的时候，上下和左右都可以滚动
//        if otherGestureRecognizer == segmentedView.collectionView.panGestureRecognizer {
//            return false
//        }
//        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
//    }
//}

#endif  /* canImport(JXPagingView) */



extension UIViewController {
    private struct AssociatedKeys {
        static var kListViewDidScrollCallback = 0
    }
    
    private typealias JXListViewDidScrollCallback = (UIScrollView)->Void
    
    private var listViewDidScrollCallbackBlock: JXListViewDidScrollCallback? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.kListViewDidScrollCallback) as? JXListViewDidScrollCallback
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kListViewDidScrollCallback, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    @objc
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listViewDidScrollCallbackBlock?(scrollView)
    }
}

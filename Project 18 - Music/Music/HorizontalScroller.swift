//
//  HorizontalScroller.swift
//  Music
//
//  Created by 이다영 on 2021/04/24.
//

import UIKit

protocol HorizontalScrollerDataSource: class {
    func numberOfVies(in horizontalScrollerView: HorizontalScrollerView) -> Int
    
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView
}

protocol HorizontalScrollerDelegate: class {
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int)
}

extension HorizontalScrollerDataSource {
    func initialViewIndex(_ scroller: HorizontalScrollerView) -> Int {
        return 0
    }
}

class HorizontalScrollerView: UIView {

    weak var delegate: HorizontalScrollerDelegate?
    weak var dataSource: HorizontalScrollerDataSource?
    
    private enum ViewConstants {
        static let Padding: CGFloat = 10
        static let Dimensions: CGFloat = 100
        static let Offset: CGFloat = 100
    }
    
    private var scroller = UIScrollView()
    
    private var contentViews = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeScrollView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        initializeScrollView()
    }
    
    func initializeScrollView() {
        addSubview(scroller)
        
        scroller.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scroller.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scroller.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scroller.topAnchor.constraint(equalTo: self.topAnchor),
            scroller.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector.scrollerDidTap)
        scroller.addGestureRecognizer(tapRecognizer)
    }
    
    func scrollToView(at index: Int, animated: Bool = true) {
        guard index < contentViews.count else {
            return
        }
        let centralView = contentViews[index]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (scroller.bounds.width / 2)
        
        scroller.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: animated)
    }
    
    func viewAtIndex(_ index: Int) -> UIView {
        return contentViews[index]
    }
    
    func reload() {
        guard let dataSource = dataSource else {
            return
        }
        
        contentViews.forEach { $0.removeFromSuperview() }
        
        var xValue = ViewConstants.Offset
        
        contentViews = (0..<dataSource.numberOfVies(in: self)).map { index in
            xValue += ViewConstants.Padding
            
            let view = dataSource.horizontalScrollerView(self, viewAt: index)
            
            view.frame = CGRect(x: CGFloat(xValue), y: ViewConstants.Padding, width: ViewConstants.Dimensions, height: ViewConstants.Dimensions)
            scroller.addSubview(view)
            
            xValue += ViewConstants.Dimensions + ViewConstants.Padding
            
            return view
        }
        scroller.contentSize = CGSize(width: CGFloat(xValue + ViewConstants.Offset), height: frame.size.height)
    }
    
    func centerCurrentView() {
        let centerRect = CGRect(
            origin: CGPoint(x: scroller.bounds.midX - ViewConstants.Padding, y: 0),
            size: CGSize(width: ViewConstants.Padding, height: bounds.height)
        )
        
        guard let selectedIndex = contentViews.firstIndex(where: { $0.frame.intersects(centerRect) }) else {
            return
        }
        
        let centralView = contentViews[selectedIndex]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (scroller.bounds.width / 2)
        
        scroller.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
        delegate?.horizontalScrollerView(self, didSelectViewAt: selectedIndex)
    }
    
    override func didMoveToSuperview() {
        reload()
    }
    
    @objc func scrollerDidTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: gesture.view)
        
        guard let index = contentViews.firstIndex(where: { $0.frame.contains(location) }) else {
            return
        }
        
        delegate?.horizontalScrollerView(self, didSelectViewAt: index)
        scrollToView(at: index)
    }
}

extension HorizontalScrollerView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerCurrentView()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerCurrentView()
    }
}

private extension Selector {
    static let scrollerDidTap = #selector(HorizontalScrollerView.scrollerDidTap(_:))
}

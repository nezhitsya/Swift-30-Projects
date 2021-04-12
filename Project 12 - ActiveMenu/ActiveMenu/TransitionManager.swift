//
//  TransitionManager.swift
//  ActiveMenu
//
//  Created by 이다영 on 2021/04/11.
//

import UIKit

class TransitionManager: NSObject {
    private var presenting = false
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let screens: (from: UIViewController, to: UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        if (self.presenting) {
            offStageMenuController(menuViewController)
        }
        
        container.addSubview(bottomView!)
        container.addSubview(menuView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if (self.presenting) {
                self.onStageMenuControoler(menuViewController)
            } else {
                self.offStageMenuController(menuViewController)
            }
        }, completion: { finished in
            transitionContext.completeTransition(true)
            UIApplication.shared.keyWindow?.addSubview(screens.to.view)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func offStage(_ amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }

    func offStageMenuController(_ menuViewController: MenuViewController) {
        menuViewController.view.alpha = 0
        
        let topRowOffset: CGFloat = 300
        let middleRowOffset: CGFloat = 150
        let bottomRowOffset: CGFloat = 50
        
        menuViewController.camera.transform = self.offStage(-topRowOffset)
        menuViewController.text.transform = self.offStage(-middleRowOffset)
        menuViewController.call.transform = self.offStage(-bottomRowOffset)
        menuViewController.search.transform = self.offStage(topRowOffset)
        menuViewController.alarm.transform = self.offStage(middleRowOffset)
        menuViewController.setting.transform = self.offStage(bottomRowOffset)
    }

    func onStageMenuControoler(_ menuViewController: MenuViewController) {
        menuViewController.view.alpha = 1
        
        menuViewController.camera.transform = CGAffineTransform.identity
        menuViewController.text.transform = CGAffineTransform.identity
        menuViewController.call.transform = CGAffineTransform.identity
        menuViewController.search.transform = CGAffineTransform.identity
        menuViewController.alarm.transform = CGAffineTransform.identity
        menuViewController.setting.transform = CGAffineTransform.identity
    }
}

extension TransitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}

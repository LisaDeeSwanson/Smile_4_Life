//
//  ModalPresentController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 11/25/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class ModalPresentController: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
  
//  private let destinationFrame: CGRect
//
//  init(destinationFrame: CGRect) {
//    self.destinationFrame = destinationFrame
//  }
  var forward = true
  let duration = 0.3
  var originFrame = CGRect.zero
  
  weak var animationContext: UIViewControllerContextTransitioning?
  
  private func maskLayerForAnimation(frame: CGRect) -> CAShapeLayer {
    let maskLayer = CAShapeLayer()
    maskLayer.fillColor = UIColor.black.cgColor
    let maskRect = frame
    let path = CGPath(rect: maskRect, transform: nil)
    maskLayer.path = path
    return maskLayer
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1.0
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
//    guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to), let snapshot = toVC.view.snapshotView(afterScreenUpdates: true) else {
//      return
//    }
    
    self.animationContext = transitionContext
    
    let containerView = transitionContext.containerView
    
    var originView: UIView!
    var animatedView: UIView!
    
    if self.forward {
      animatedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
      originView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
      containerView.addSubview(animatedView)
    } else {
      animatedView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
      originView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
      containerView.addSubview(originView)
      containerView.addSubview(animatedView)
    }
    
    var startFrame: CGRect!
    var newPath: CGPath!
    
    if self.forward {
      startFrame = self.originFrame
      newPath = CGPath(rect: animatedView.frame, transform: nil)
    } else {
      startFrame = animatedView.frame
      newPath = CGPath(rect: self.originFrame, transform: nil)
    }
    
    let maskLayer = self.maskLayerForAnimation(frame: startFrame)
    animatedView.layer.mask = maskLayer
    
    let pathAnimation = CABasicAnimation(keyPath: "path")
    pathAnimation.delegate = self
    pathAnimation.fromValue = maskLayer.path
    pathAnimation.toValue = newPath
    pathAnimation.duration = duration
    pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
    
    maskLayer.path = newPath
    maskLayer.add(pathAnimation, forKey: "path")
  }
  
  // MARK: - CAAnimationDelegate Delegate
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    self.animationContext!.completeTransition(flag)
  }
    
}
  


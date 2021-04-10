//
//  DetailViewController.swift
//  Animation
//
//  Created by 이다영 on 2021/04/10.
//

import UIKit

class DetailViewController: UIViewController {
    
    var barTitle = ""
    var animateView: UIView!
    private let duration = 2.0
    private let delay = 0.2
    private let scale = 1.2

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRect()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = barTitle
    }
    
    private func setupRect() {
        if barTitle == "BezierCurve Position" {
            animateView = drawCircleView()
        } else if barTitle == "View Fade In" {
            animateView = UIImageView(image: UIImage(named: "1"))
            animateView.frame = generalFrame
            animateView.center = generalCenter
        } else {
            animateView = drawRectView(UIColor.lightGray, frame: generalFrame, center: generalCenter)
        }
        view.addSubview(animateView)
    }
    
    private func changeColor(_ color: UIColor) {
        UIView.animate(withDuration: self.duration, animations: {
            self.animateView.backgroundColor = color
        }, completion: nil)
    }
    
    private func rotateView(_ angel: Double) {
        UIView.animate(withDuration: duration, delay: delay, options: [.repeat], animations: {
            self.animateView.transform = CGAffineTransform(rotationAngle: CGFloat(angel))
        }, completion: nil)
    }
    
    private func multiColor(_ firstColor: UIColor, _ secondColor: UIColor) {
        UIView.animate(withDuration: duration, animations: {
            self.animateView.backgroundColor = firstColor
        }, completion: { finished in
            self.changeColor(secondColor)
        })
    }
    
    private func multiPosition(_ firstPosition: CGPoint, _ secondPosition: CGPoint) {
        func simplePosition(_ position: CGPoint) {
            UIView.animate(withDuration: self.duration, animations: {
                self.animateView.frame.origin = position
            }, completion: nil)
        }
        
        UIView.animate(withDuration: self.duration, animations: {
            self.animateView.frame.origin = firstPosition
        }, completion: { finished in
            simplePosition(secondPosition)
        })
    }
    
    private func curvePath(_ endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
        let path = UIBezierPath()
        
        path.move(to: self.animateView.center)
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = path.cgPath
        anim.duration = self.duration
        
        self.animateView.layer.add(anim, forKey: "animate position along path")
        self.animateView.center = endPoint
    }
    
    private func colorFrameChange(_ firstFrame: CGRect, _ secondFrame: CGRect, _ thirdFrame: CGRect, _ firstColor: UIColor, _ secondColor: UIColor, _ thirdColor: UIColor) {
        UIView.animate(withDuration: self.duration, animations: {
            self.animateView.backgroundColor = firstColor
            self.animateView.frame = firstFrame
        }, completion: { finished in
            UIView.animate(withDuration: self.duration, animations: {
                self.animateView.backgroundColor = secondColor
                self.animateView.frame = secondFrame
            }, completion: { finished in
                UIView.animate(withDuration: self.duration, animations: {
                    self.animateView.backgroundColor = thirdColor
                    self.animateView.frame = thirdFrame
                }, completion: nil)
            })
        })
    }
    
    private func viewFadeIn() {
        let secondView = UIImageView(image: UIImage(named: "2"))
        
        secondView.frame = self.animateView.frame
        secondView.alpha = 0.0
        
        view.insertSubview(secondView, aboveSubview: self.animateView)
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            secondView.alpha = 1.0
            self.animateView.alpha = 0.0
        }, completion: nil)
    }
    
    private func Pop() {
        UIView.animate(withDuration: duration / 4, animations: {
            self.animateView.transform = CGAffineTransform(scaleX: CGFloat(self.scale), y: CGFloat(self.scale))
        }, completion: { finished in
            UIView.animate(withDuration: self.duration / 4, animations: {
                self.animateView.transform = CGAffineTransform.identity
            })
        })
    }
    
    @IBAction func didTapTanimate(_ sender: AnyObject) {
        switch barTitle {
        case "2-Color":
            changeColor(UIColor.black)

        case "Simple 2D Rotation":
            rotateView(Double.pi)

        case "Multicolor":
            multiColor(UIColor.black, UIColor.gray)
            
        case "Multi Point Position":
            multiPosition(CGPoint(x: animateView.frame.origin.x, y: 100), CGPoint(x: animateView.frame.origin.x, y: 350))
            
        case "BezierCurve Position":
            var controlPoint1 = self.animateView.center
            controlPoint1.y -= 125.0
            
            var controlPoint2 = controlPoint1
            controlPoint2.x += 40.0
            controlPoint2.y -= 125.0
            
            var endPoint = self.animateView.center
            endPoint.x += 75.0
            
            curvePath(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
        case "Color and Frame Change":
            let currentFrame = self.animateView.frame
            let firstFrame = currentFrame.insetBy(dx: -30, dy: -50)
            let secondFrame = firstFrame.insetBy(dx: 10, dy: 15)
            let thirdFrame = secondFrame.insetBy(dx: -15, dy: -20)
            colorFrameChange(firstFrame, secondFrame, thirdFrame, UIColor.black, UIColor.gray, UIColor.white)
            
        case "View Fade In":
            viewFadeIn()
            
        case "Pop":
            Pop()
        
        default:
            let alert = makeAlert("Alert", message: "Error", actionTitle: "OK")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

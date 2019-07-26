/*
 Copyright (c) 2019 Vu Van Khac <khacvv0451@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

import UIKit

public class KVAlertController: UIViewController {
    public static var shared = KVAlertController()
    
    public var dimBackgroundColor: UIColor = UIColor(white: 0.0, alpha: 0.25)
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    public var titleTextColor: UIColor = UIColor(red: 140.0 / 255.0, green: 145.0 / 255.0, blue: 164.0 / 255.0, alpha: 1.0)
    public var messageFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    public var messageTextColor: UIColor = UIColor(red: 80.0 / 255.0, green: 85.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
    public var cancelButtonFont: UIFont = UIFont.boldSystemFont(ofSize: 16.0)
    public var submitButtonFont: UIFont = UIFont.boldSystemFont(ofSize: 16.0)
    
    private var topViewController = UIViewController()
    private var customAlertController: UIViewController?
    private var normalAlertController = KVNormalAlertController.loadFromXib()
    
    private var isKeyboardShown = false
    private var keyboardHeightValue: CGFloat = 0
    
    public func setAlertController(_ controller: UIViewController) {
        customAlertController = controller
    }
    
    public func showIn(_ controller: UIViewController, title: String? = nil, message: String? = nil, cancelTitle: String? = "CANCEL", cancelAction: (() -> ())? = nil, submitTitle: String? = nil, submitAction: (() -> ())? = nil) {
        topViewController = controller
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        view.layer.opacity = 0
        view.backgroundColor = dimBackgroundColor
        topViewController.view.addSubview(view)
        topViewController.addChild(self)
        didMove(toParent: topViewController)
        
        if let customAlertController = customAlertController {
            view.addSubview(customAlertController.view)
            customAlertController.view.center = view.center
            addChild(customAlertController)
            customAlertController.didMove(toParent: self)
        } else {
            view.addSubview(normalAlertController.view)
            normalAlertController.view.center = view.center
            normalAlertController.configTitleLabel(font: titleFont, textColor: titleTextColor)
            normalAlertController.configMessageLabel(font: messageFont, textColor: messageTextColor)
            normalAlertController.configCancel(font: cancelButtonFont)
            normalAlertController.configSubmit(font: submitButtonFont)
            normalAlertController.config(title: title, message: message, cancelTitleLabel: cancelTitle, submitTitleLabel: submitTitle)
            addChild(normalAlertController)
            normalAlertController.didMove(toParent: self)
            
            normalAlertController.cancelClosure = {
                cancelAction?()
                self.dismiss()
            }
            
            normalAlertController.submitClosure = {
                submitAction?()
                self.dismiss()
            }
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layer.opacity = 1.0
        }, completion: nil)
    }
    
    public func dismiss() {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layer.opacity = 0
        }, completion: { (finished) in
            for viewController in self.children {
                viewController.willMove(toParent: nil)
                viewController.removeFromParent()
                viewController.view.removeFromSuperview()
            }
        })
    }
    
    @objc func orientationDidChange() {
        view.frame = topViewController.view.bounds
        normalAlertController.view.frame = topViewController.view.bounds
        if let customAlertController = customAlertController {
            customAlertController.view.frame = topViewController.view.bounds
        }
    }
    
    @objc func keyboardWillShow() {
        isKeyboardShown = true
        autoCenter()
    }
    
    @objc func keyboardWillHide() {
        isKeyboardShown = false
        autoCenter()
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        if let keyboardFrame = (notification as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardHeightValue = keyboardFrame.cgRectValue.height
        } else {
            keyboardHeightValue = 0
        }
    }
    
    func autoCenter() {
        
    }
}

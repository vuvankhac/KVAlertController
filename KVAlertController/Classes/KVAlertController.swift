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
    
    private var window: UIView = {
        if let view = UIApplication.shared.keyWindow {
            return view
        }
        
        return UIView()
    }()
    
    public var dimBackgroundColor: UIColor = UIColor(white: 0.0, alpha: 0.25)
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    public var titleTextColor: UIColor = UIColor(red: 140.0 / 255.0, green: 145.0 / 255.0, blue: 164.0 / 255.0, alpha: 1.0)
    public var messageFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    public var messageTextColor: UIColor = UIColor(red: 80.0 / 255.0, green: 85.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
    public var cancelButtonFont: UIFont = UIFont.boldSystemFont(ofSize: 16.0)
    public var cancelButtonBorderColor: UIColor = UIColor(red: 32.0 / 255.0, green: 144.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    public var cancelButtonBorderWidth: CGFloat = 1.5
    public var cancelButtonTintColor: UIColor = .white
    public var cancelButtonCornerRadius: CGFloat = 6.0
    public var submitButtonFont: UIFont = UIFont.boldSystemFont(ofSize: 16.0)
    public var submitButtonBorderColor: UIColor = UIColor(red: 32.0 / 255.0, green: 144.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    public var submitButtonBorderWidth: CGFloat = 1.5
    public var submitButtonTintColor: UIColor = UIColor(red: 32.0 / 255.0, green: 144.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    public var submitButtonCornerRadius: CGFloat = 6.0
    
    private var isAlertControllerShown = false
    private var customAlertController: UIViewController?
    private var normalAlertController = KVNormalAlertController.loadFromXib()
    
    private var isKeyboardShown = false
    private var keyboardHeightValue: CGFloat?
    
    private var centerYConstraint: NSLayoutConstraint?
    private var customStackView: UIStackView?
    private lazy var normalStackView = UIStackView(arrangedSubviews: [normalAlertController.view])
    
    public func setAlertController(_ controller: UIViewController) {
        customAlertController = controller
    }
    
    public func show(title: String? = nil, message: String? = nil, cancelTitle: String? = "CANCEL", cancelAction: (() -> ())? = nil, submitTitle: String? = nil, submitAction: (() -> ())? = nil) {
        if isAlertControllerShown {
            return
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        view.layer.opacity = 0
        view.backgroundColor = dimBackgroundColor
        window.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: window.leftAnchor),
            view.topAnchor.constraint(equalTo: window.topAnchor),
            view.rightAnchor.constraint(equalTo: window.rightAnchor),
            view.bottomAnchor.constraint(equalTo: window.bottomAnchor)
            ])
        
        if let customAlertController = customAlertController {
            let stackView = UIStackView(arrangedSubviews: [customAlertController.view])
            view.addSubview(stackView)
            
            let leftConstraint = stackView.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 37.0)
            let rightConstraint = stackView.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: -37.0)
            let centerXConstraint = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            let centerYConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([leftConstraint, rightConstraint, centerXConstraint, centerYConstraint])
            self.centerYConstraint = centerYConstraint
            
            customStackView = stackView
        } else {
            view.addSubview(normalStackView)
            normalAlertController.configTitleLabel(font: titleFont, textColor: titleTextColor)
            normalAlertController.configMessageLabel(font: messageFont, textColor: messageTextColor)
            normalAlertController.configCancel(font: cancelButtonFont, tintColor: cancelButtonTintColor, borderColor: cancelButtonBorderColor, borderWidth: cancelButtonBorderWidth, cornerRadius: cancelButtonCornerRadius)
            normalAlertController.configSubmit(font: submitButtonFont, tintColor: submitButtonTintColor, borderColor: submitButtonBorderColor, borderWidth: submitButtonBorderWidth, cornerRadius: submitButtonCornerRadius)
            normalAlertController.config(title: title, message: message, cancelTitleLabel: cancelTitle, submitTitleLabel: submitTitle)
            
            let leftConstraint = normalStackView.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 37.0)
            let rightConstraint = normalStackView.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: -37.0)
            let centerXConstraint = normalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            let centerYConstraint = normalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            normalStackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([leftConstraint, rightConstraint, centerXConstraint, centerYConstraint])
            
            normalAlertController.cancelClosure = {
                cancelAction?()
                self.dismiss()
            }
            
            normalAlertController.submitClosure = {
                submitAction?()
                self.dismiss()
            }
        }
        
        isAlertControllerShown = true
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
            self.view.subviews.forEach({ $0.removeFromSuperview() })
            self.view.removeFromSuperview()
            self.customAlertController = nil
            self.isAlertControllerShown = false
        })
    }
    
    @objc func orientationDidChange() {
        
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
        }
    }
    
    func autoCenter() {
        guard let centerYConstraint = centerYConstraint else { return }
        if isKeyboardShown, let value = keyboardHeightValue {
            UIView.animate(withDuration: 0.3) {
                centerYConstraint.constant = -value / 2.0
                self.customStackView?.superview?.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                centerYConstraint.constant = 0
                self.customStackView?.superview?.layoutIfNeeded()
            }
        }
    }
}

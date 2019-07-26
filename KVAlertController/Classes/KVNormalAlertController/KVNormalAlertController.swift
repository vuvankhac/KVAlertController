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

class KVNormalAlertController: UIViewController {
    
    static func loadFromXib() -> KVNormalAlertController {
        let podBundle = Bundle(for: KVNormalAlertController.self)
        if let bundleURL = podBundle.url(forResource: "KVAlertController", withExtension: "bundle") {
            let bundle = Bundle(url: bundleURL)
            return KVNormalAlertController(nibName: String(describing: self), bundle: bundle)
        }
        
        return KVNormalAlertController(nibName: String(describing: self), bundle: Bundle.main)
    }

    @IBOutlet private weak var kvTitleLabel: UILabel!
    @IBOutlet private weak var kvMessageLabel: UILabel!
    @IBOutlet private weak var kvCancelButton: UIButton!
    @IBOutlet private weak var kvSubmitButton: UIButton!
    
    lazy var cancelClosure: (() -> ())? = nil
    lazy var submitClosure: (() -> ())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: Actions
extension KVNormalAlertController {
    @IBAction func clickToCancel(_ sender: Any) {
        cancelClosure?()
    }
    
    @IBAction func clickToSubmit(_ sender: Any) {
        submitClosure?()
    }
    
    func configTitleLabel(font: UIFont, textColor: UIColor) {
        kvTitleLabel.font = font
        kvTitleLabel.textColor = textColor
    }
    
    func configMessageLabel(font: UIFont, textColor: UIColor) {
        kvMessageLabel.font = font
        kvMessageLabel.textColor = textColor
    }
    
    func configCancel(font: UIFont, tintColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        kvCancelButton.layer.masksToBounds = true
        kvCancelButton.tintColor = tintColor
        kvCancelButton.titleLabel?.font = font
        kvCancelButton.layer.borderColor = borderColor.cgColor
        kvCancelButton.layer.borderWidth = borderWidth
        kvCancelButton.layer.cornerRadius = cornerRadius
    }
    
    func configSubmit(font: UIFont, tintColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        kvSubmitButton.layer.masksToBounds = true
        kvSubmitButton.tintColor = tintColor
        kvSubmitButton.titleLabel?.font = font
        kvSubmitButton.layer.borderColor = borderColor.cgColor
        kvSubmitButton.layer.borderWidth = borderWidth
        kvSubmitButton.layer.cornerRadius = cornerRadius
    }
    
    func config(title: String?, message: String?, cancelTitleLabel: String?, submitTitleLabel: String?) {
        if let value = title {
            kvTitleLabel.isHidden = false
            kvTitleLabel.text = value
        } else {
            kvTitleLabel.isHidden = true
        }
        
        if let value = message {
            kvMessageLabel.isHidden = false
            kvMessageLabel.text = value
        } else {
            kvMessageLabel.isHidden = true
        }
        
        if let value = cancelTitleLabel {
            kvCancelButton.isHidden = false
            kvCancelButton.titleLabel?.text = value
            kvCancelButton.setTitle(value, for: .normal)
        } else {
            kvCancelButton.isHidden = true
        }
        
        if let value = submitTitleLabel {
            kvSubmitButton.isHidden = false
            kvSubmitButton.titleLabel?.text = value
            kvSubmitButton.setTitle(value, for: .normal)
        } else {
            kvSubmitButton.isHidden = true
        }
    }
}

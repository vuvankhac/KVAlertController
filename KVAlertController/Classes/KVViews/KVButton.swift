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

@IBDesignable
class KVButton: UIButton {

    @IBInspectable var isMasksToBounds: Bool = false {
        didSet {
            kvAction()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            kvAction()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            kvAction()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            kvAction()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        kvAction()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        kvAction()
    }
    
    func kvAction() {
        clipsToBounds = true
        layer.masksToBounds = isMasksToBounds
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }

}

// Copyright (c) 2017 Vectorform, LLC
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
///Users/cbechtel/Desktop/Yarp Repo/Yarp/README.md
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its contributors may
// be used to endorse or promote products derived from this software without
// specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
// NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.


import Foundation
import UIKit

extension UIControlState: Hashable {
    
    public var hashValue: Int {
        return self.rawValue.hashValue
    }
    
}

internal class TextButtonTextStyleDelegate: TextStyleDelegate{
 
    fileprivate let button: TextyButton
    fileprivate let state: UIControlState
    fileprivate var possiblyTaggedText: String?
    
    init(button: TextyButton, state: UIControlState, possiblyTaggedText: String?){
        self.button = button
        self.state = state
        self.possiblyTaggedText = possiblyTaggedText
    }
    
    internal func didUpdate(style: TextStyle) {
        self.button.setTitle(self.possiblyTaggedText, for: self.state)
    }
    
}

open class TextyButton: UIButton {
    
    fileprivate var styles = [UIControlState:TextStyle]()
    fileprivate var styleDelegates = [UIControlState: TextButtonTextStyleDelegate]()
    
    open func setStyle(_ style: TextStyle?, for state: UIControlState) {
        var style = style
        var possiblyTaggedText = self.styleDelegates[state]?.possiblyTaggedText
        possiblyTaggedText = possiblyTaggedText ?? self.styleDelegates[.normal]?.possiblyTaggedText
        let styleDelegate = TextButtonTextStyleDelegate(button: self, state: state, possiblyTaggedText: possiblyTaggedText)
        style?.delegate = styleDelegate
        self.styleDelegates[state] = styleDelegate
        self.styles[state] = style
        
        self.setTitle(possiblyTaggedText, for: state)
    }

    open func style(for state: UIControlState) -> TextStyle{
        var style = self.styles[state]
        
        if(style == nil){
            style = TextStyle()
            self.setStyle(style, for: state)
        }
        
        return style!
    }
    
    open override func setTitle(_ title: String?, for state: UIControlState) {
        let style = self.style(for: state)
        let styleDelegate = self.styleDelegates[state]
        styleDelegate?.possiblyTaggedText = title
        self.setAttributedTitle(title == nil ? nil : style.attributedString(with: title!), for: state)
        
        if state == .normal{
            for (otherState, styleDelegate) in self.styleDelegates{
                if state != otherState {
                    if styleDelegate.possiblyTaggedText == nil {
                        styleDelegate.possiblyTaggedText = title
                        self.setTitle(title, for: otherState)
                    }
                }
               
            }
        }
       
    }
    
    open override func title(for state: UIControlState) -> String? {
        return self.attributedTitle(for: state)?.string
    }
    
    open override func setTitleColor(_ color: UIColor?, for state: UIControlState) {
        var style = self.style(for: state)
        style.foregroundColor = color
        self.setStyle(style, for: state)
    }
    
    open override func titleColor(for state: UIControlState) -> UIColor? {
        let style = self.style(for: state)
        return style.foregroundColor
    }
    
    open override func setTitleShadowColor(_ color: UIColor?, for state: UIControlState) {
        var style = self.style(for: state)
        var shadow = style.shadow
        if(shadow == nil){
            shadow = NSShadow()
            style.shadow = shadow
        }
        shadow?.shadowColor = color
        self.setStyle(style, for: state)
    }
    
    open override func titleShadowColor(for state: UIControlState) -> UIColor? {
        let style = self.style(for: state)
        return style.shadow?.shadowColor as? UIColor
    }
    
    public convenience init() {
        self.init(style: TextStyle())
    }
    
    public required init(style: TextStyle, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setStyle(style, for: .normal)
        self.setDefaults()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setDefaults() {
        /// If the font/textColor are not set yet by the TextStyle passed in, then set some default values
        self.setTitle(nil, for: .normal)
        var style = self.style(for: .normal)
        
        if style.font == nil  {
            style.font = UIFont.systemFont(ofSize: 17.0)
        }
        
        if style.foregroundColor == nil {
            style.foregroundColor = UIColor.black
        }
        
        if style.paragraphStyle == nil {
            let pstyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
            pstyle.alignment = .natural
            pstyle.lineBreakMode = .byTruncatingTail
            style.paragraphStyle = pstyle
        }
        self.setStyle(style, for: .normal)
    }
    
  
    
}

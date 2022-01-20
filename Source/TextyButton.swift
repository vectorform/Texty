// Copyright (c) 2018 Vectorform, LLC
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
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

// Extend UIControlState so it can be used as a key in a dictionary
extension UIControl.State: Hashable {
    
    public var hashValue: Int {
        return self.rawValue.hashValue
    }
    
}

// To stay organized, there will be an instance of this class for every TextStyle
internal class TextButtonTextStyleDelegate: TextStyleDelegate{
 
    fileprivate weak var button: TextyButton?
    fileprivate let state: UIControl.State
    fileprivate var possiblyTaggedText: String?
    
    init(button: TextyButton, state: UIControl.State, possiblyTaggedText: String?){
        self.button = button
        self.state = state
        self.possiblyTaggedText = possiblyTaggedText
    }
    
    internal func didUpdate(style: TextStyle) {
        self.button?.setTitle(self.possiblyTaggedText, for: self.state)
    }
}

open class TextyButton: UIButton {
    
    // Styles for the different control states
    fileprivate var styles = [UIControl.State:TextStyle]()
    
    // Delegates for the different control states
    fileprivate var styleDelegates = [UIControl.State: TextButtonTextStyleDelegate]()
    
    // Set a style for a state. This copies the TextStyle.
    open func setStyle(_ style: TextStyle, for state: UIControl.State) {
        
        // Copy any incoming style. This will make it so changes aren't made outside of here
        let style = TextStyle(with: style)
        
        // See if there's existing text for this state. It's stored in the style delegate.
        var possiblyTaggedText = self.styleDelegates[state]?.possiblyTaggedText
        
        // Either use that existing text, or grab it from the normal style
        possiblyTaggedText = possiblyTaggedText ?? self.styleDelegates[.normal]?.possiblyTaggedText
        
        // Create a new style delegate for this style
        let styleDelegate = TextButtonTextStyleDelegate(button: self, state: state, possiblyTaggedText: possiblyTaggedText)
        
        // Set the delegate on the style
        style.delegate = styleDelegate
        
        // Save the delegate to our array of delegates
        self.styleDelegates[state] = styleDelegate
        
        // Save the style to our array of styles
        self.styles[state] = style
        
        // Finally, set the title again to let the style take effect
        self.setTitle(possiblyTaggedText, for: state)
    }

    // Get a style for a state
    open func style(for state: UIControl.State) -> TextStyle{
        
        // Try to the style from our array
        var style = self.styles[state]
        
        // If it doesn't exist, create it
        if(style == nil){
            self.setStyle(self.styles[.normal]!, for: state)
            style = self.style(for: state)
        }
        
        // There shouldn't be a case where style is nil at this point
        return style!
    }
    
    open override func setTitle(_ title: String?, for state: UIControl.State) {
        
        // Get the style for this state
        let style = self.style(for: state)
        
        // Set the text on the delegate
        (style.delegate as? TextButtonTextStyleDelegate)?.possiblyTaggedText = title
        
        // Set the attributed string
        self.setAttributedTitle(title == nil ? nil : style.attributedString(with: title!), for: state)
        
        // Set text for non-normal states that have no text
        if state == .normal{
            for (otherState, styleDelegate) in self.styleDelegates{
                if(otherState != state){
                    if(styleDelegate.possiblyTaggedText == nil || styleDelegate.possiblyTaggedText?.count == 0){
                        self.setTitle(title, for: otherState)
                    }
                }
            }
        }
    }
    
    open override func title(for state: UIControl.State) -> String? {
        return self.attributedTitle(for: state)?.string
    }
    
    open override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        self.style(for: state).foregroundColor = color
    }
    
    open override func titleColor(for state: UIControl.State) -> UIColor? {
        return self.style(for: state).foregroundColor
    }
    
    open override func setTitleShadowColor(_ color: UIColor?, for state: UIControl.State) {
        let style = self.style(for: state)
        var shadow = style.shadow
        if(shadow == nil){
            shadow = NSShadow()
            shadow?.shadowOffset = CGSize(width: -2.0, height: -2.0)
        }
        shadow?.shadowColor = color
        // Styles only react to changes in their properties, so reassign shadow
        style.shadow = shadow
    }
    
    open override func titleShadowColor(for state: UIControl.State) -> UIColor? {
        return self.style(for: state).shadow?.shadowColor as? UIColor
    }
    
    // Init with default style
    public convenience init() {
        self.init(style: TextStyle())
    }
    
    // Init with a TextStyle. This copies the TextStyle.
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
        
        let style = self.style(for: .normal)
        
        if style.font == nil  {
            style.font = self.titleLabel?.font
        }
        
        if style.foregroundColor == nil {
            style.foregroundColor = super.titleColor(for: .normal)
        }
    }
    
  
    
}

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


open class TextyLabel: UILabel, TextStyleDelegate {
    
    // A copy will be created when setting this property
    public var style: TextStyle!{
        didSet{
            self.style = TextStyle(with: style)
            
            let possiblyTaggedText = self.possiblyTaggedText
            
            // Set the delegate on the style
            style.delegate = self
            
            // Finally, set the title again to let the style take effect
            self.text = possiblyTaggedText
        }
    }
    
    /// In each of the below setters, style is accessed using self.style? because
    /// the super.init() call will attempt to set default values, at which point
    /// style does not exist yet.
    
    open override var font: UIFont! {
        get { return self.style.font }
        set { self.style?.font = newValue }
    }
    
    open override var lineBreakMode: NSLineBreakMode {
        get { return self.style.paragraphStyle!.lineBreakMode }
        set {
            let pstyle: NSMutableParagraphStyle = self.style.paragraphStyle!.mutableCopy() as! NSMutableParagraphStyle
            pstyle.lineBreakMode = newValue
            self.style.paragraphStyle = pstyle
        }
    }
    
    internal var possiblyTaggedText: String?            //A seperate property is needed in order to support tags properly
    open override var text: String? {
        get { return self.attributedText?.string }
        set {
            self.possiblyTaggedText = newValue
            self.attributedText = newValue == nil ? nil : self.style.attributedString(with: newValue!)
        }
    }
    
    open override var textAlignment: NSTextAlignment {
        get { return self.style.paragraphStyle!.alignment }
        set {
            let pstyle: NSMutableParagraphStyle = self.style.paragraphStyle!.mutableCopy() as! NSMutableParagraphStyle
            pstyle.alignment = newValue
            self.style.paragraphStyle = pstyle
        }
    }
    
    open override var textColor: UIColor! {
        get { return self.style.foregroundColor }
        set { self.style?.foregroundColor = newValue }
    }
    
    
    public convenience init() {
        self.init(style: TextStyle())
    }
    
    // A copy of style will be created
    public required init(style: TextStyle, frame: CGRect = .zero) {
        super.init(frame: frame)
        // Set style and ensure that didSet is called
        self.style = style
        self.setDefaults()
        self.style.delegate = self
    }

    public convenience init(textStyle: TextStyle, textColor: UIColor) {
        self.init(style: textStyle)
        self.style.foregroundColor = textColor
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("not supported")
    }

    private func setDefaults() {
        /// If the font/textColor are not set yet by the TextStyle passed in, then set some default values
        self.text = nil
        
        if self.style.font == nil  {
            self.style.font = UIFont.systemFont(ofSize: 17.0)
        }
        
        if self.style.foregroundColor == nil {
            self.style.foregroundColor = UIColor.black
        }
        
        if self.style.paragraphStyle == nil {
            let pstyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
            pstyle.alignment = .natural
            pstyle.lineBreakMode = .byTruncatingTail
            self.style.paragraphStyle = pstyle
        }
    }
    
    internal func didUpdate(style: TextStyle) {
        /// Update attributed string with new attributes called by the textStyle when it detects an update
        self.text = possiblyTaggedText
    }
}

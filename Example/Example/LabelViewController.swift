// Copyright (c) 2017 Vectorform, LLC
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
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

import Texty


fileprivate extension UIControlEvents {
    
    fileprivate static var allTouchDownEvents: UIControlEvents {
        return UIControlEvents(rawValue: UIControlEvents.touchDragEnter.rawValue | UIControlEvents.touchDown.rawValue)
    }
    
    fileprivate static var allTouchUpEvents: UIControlEvents {
        return UIControlEvents(rawValue: UIControlEvents.touchCancel.rawValue | UIControlEvents.touchDragExit.rawValue | UIControlEvents.touchUpInside.rawValue | UIControlEvents.touchUpOutside.rawValue)
    }
    
}


fileprivate class VCButton: UIButton {
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.setTitleColor(UIColor.lightGray, for: .normal)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 3.0
        self.layer.cornerRadius = 5.0
        
        self.addTarget(self, action: #selector(VCButton.onTouchDown), for: .allTouchDownEvents)
        self.addTarget(self, action: #selector(VCButton.onTouchUp), for: .allTouchUpEvents)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not supported")
    }
    
    
    @objc private func onTouchDown() {
        self.backgroundColor = UIColor.lightGray
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    @objc private func onTouchUp() {
        self.backgroundColor = UIColor.white
        self.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
}


class LabelViewController: UIViewController, AdjustValueViewDelegate, AdjustAlignViewDelegate {
    
    private let changeAlignButton: VCButton = VCButton()
    private let changeColorButton: VCButton = VCButton()
    private let changeKernButton: VCButton = VCButton()
    private let changeSizeButton: VCButton = VCButton()
    
    private let titleLabel: TextyLabel = TextyLabel(style: Styles.Header)
    
    private var shownPopup: UIView?
    
    
    override func loadView() {
        super.loadView()
    
        self.changeColorButton.addTarget(self, action: #selector(LabelViewController.changeColorButtonPressed), for: .touchUpInside)
        self.changeColorButton.setTitle("Color", for: .normal)
        self.changeColorButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.changeSizeButton.addTarget(self, action: #selector(LabelViewController.changeSizeButtonPressed), for: .touchUpInside)
        self.changeSizeButton.setTitle("Size", for: .normal)
        self.changeSizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.changeAlignButton.addTarget(self, action: #selector(LabelViewController.changeAlignButtonPressed), for: .touchUpInside)
        self.changeAlignButton.setTitle("Align", for: .normal)
        self.changeAlignButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.changeKernButton.addTarget(self, action: #selector(LabelViewController.changeKernButtonPressed), for: .touchUpInside)
        self.changeKernButton.setTitle("Kern", for: .normal)
        self.changeKernButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.style.add(attributes: [TextAttribute.underlineStyle : NSNumber(value: NSUnderlineStyle.styleSingle.rawValue)], forTag: "underline")
        self.titleLabel.text = "This is a <underline>TextyLabel<underline/>"
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = UIColor(hue: 0.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.backgroundColor = UIColor.white
        self.view.frame = UIScreen.main.bounds
        
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.changeColorButton)
        self.view.addSubview(self.changeSizeButton)
        self.view.addSubview(self.changeAlignButton)
        self.view.addSubview(self.changeKernButton)
        
        NSLayoutConstraint(item: self.titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.titleLabel, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: self.titleLabel, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: -10.0).isActive = true
        
        NSLayoutConstraint(item: self.changeColorButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.25, constant: -10.0).isActive = true
        NSLayoutConstraint(item: self.changeColorButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0.0, constant: 50.0).isActive = true
        NSLayoutConstraint(item: self.changeColorButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -5.0).isActive = true
        NSLayoutConstraint(item: self.changeColorButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 5.0).isActive = true
        
        NSLayoutConstraint(item: self.changeSizeButton, attribute: .width, relatedBy: .equal, toItem: self.changeColorButton, attribute: .width, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.changeSizeButton, attribute: .height, relatedBy: .equal, toItem: self.changeColorButton, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.changeSizeButton, attribute: .left, relatedBy: .equal, toItem: self.changeColorButton, attribute: .right, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: self.changeSizeButton, attribute: .top, relatedBy: .equal, toItem: self.changeColorButton, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.changeAlignButton, attribute: .width, relatedBy: .equal, toItem: self.changeColorButton, attribute: .width, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.changeAlignButton, attribute: .height, relatedBy: .equal, toItem: self.changeColorButton, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.changeAlignButton, attribute: .left, relatedBy: .equal, toItem: self.changeSizeButton, attribute: .right, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: self.changeAlignButton, attribute: .top, relatedBy: .equal, toItem: self.changeColorButton, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.changeKernButton, attribute: .width, relatedBy: .equal, toItem: self.changeColorButton, attribute: .width, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.changeKernButton, attribute: .height, relatedBy: .equal, toItem: self.changeColorButton, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.changeKernButton, attribute: .left, relatedBy: .equal, toItem: self.changeAlignButton, attribute: .right, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: self.changeKernButton, attribute: .top, relatedBy: .equal, toItem: self.changeColorButton, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
    }
    
    
    private func hideShownPopup(completion: (() -> Void)?) {
        guard let view = self.shownPopup else {
            completion?()
            return
        }
        
        self.view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.25, animations: { 
            view.alpha = 0.0
        }) { (result) in
            view.removeFromSuperview()
            self.shownPopup = nil
            self.view.isUserInteractionEnabled = true
            completion?()
        }
    }
    
    private func showPopup(_ popup: UIView, completion: (() -> Void)?) {
        guard self.shownPopup == nil else {
            self.hideShownPopup(completion: { 
                self.showPopup(popup, completion: completion)
            })
            return
        }
        
        self.view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.25, animations: { 
            popup.alpha = 1.0
        }) { (result) in
            self.shownPopup = popup
            self.view.isUserInteractionEnabled = true
            completion?()
        }
    }
    
    @objc private func changeAlignButtonPressed() {
        if let view = self.shownPopup, view is AdjustAlignView {
            self.hideShownPopup(completion: nil)
            return
        }
        
        let alignView: AdjustAlignView = AdjustAlignView(alignment: self.titleLabel.textAlignment)
        
        alignView.alpha = 0.0
        alignView.delegate = self
        alignView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(alignView)
        
        NSLayoutConstraint(item: alignView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: alignView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: -5.0).isActive = true
        NSLayoutConstraint(item: alignView, attribute: .bottom, relatedBy: .equal, toItem: self.changeColorButton, attribute: .top, multiplier: 1.0, constant: -15.0).isActive = true
        
        self.showPopup(alignView, completion: nil)
    }
    
    @objc private func changeColorButtonPressed() {
        if let view = self.shownPopup, view is AdjustColorView {
            self.hideShownPopup(completion: nil)
            return
        }
        
        var hue: CGFloat = 0.0
        self.titleLabel.textColor.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        let colorView: AdjustColorView = AdjustColorView(hue: hue)
        
        colorView.alpha = 0.0
        colorView.delegate = self
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(colorView)
        
        NSLayoutConstraint(item: colorView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: colorView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: -5.0).isActive = true
        NSLayoutConstraint(item: colorView, attribute: .bottom, relatedBy: .equal, toItem: self.changeColorButton, attribute: .top, multiplier: 1.0, constant: -15.0).isActive = true
        
        self.showPopup(colorView, completion: nil)
    }
    
    @objc private func changeKernButtonPressed() {
        if let view = self.shownPopup, view is AdjustKernView {
            self.hideShownPopup(completion: nil)
            return
        }
        
        let kernView: AdjustKernView = AdjustKernView()
        
        kernView.alpha = 0.0
        kernView.delegate = self
        kernView.maximumValue = 30.0
        kernView.minimumValue = 0.0
        kernView.translatesAutoresizingMaskIntoConstraints = false
        kernView.value = Float(self.titleLabel.style.kern == nil ? 0.0 : self.titleLabel.style.kern!.floatValue)          //Has to be set after minimum/maximum values have been adjusted
        
        self.view.addSubview(kernView)
        
        NSLayoutConstraint(item: kernView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: kernView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: -5.0).isActive = true
        NSLayoutConstraint(item: kernView, attribute: .bottom, relatedBy: .equal, toItem: self.changeColorButton, attribute: .top, multiplier: 1.0, constant: -15.0).isActive = true
        
        self.showPopup(kernView, completion: nil)
    }
    
    @objc private func changeSizeButtonPressed() {
        if let view = self.shownPopup, view is AdjustSizeView {
            self.hideShownPopup(completion: nil)
            return
        }
        
        let sizeView: AdjustSizeView = AdjustSizeView()
        
        sizeView.alpha = 0.0
        sizeView.delegate = self
        sizeView.maximumValue = 30.0
        sizeView.minimumValue = 10.0
        sizeView.translatesAutoresizingMaskIntoConstraints = false
        sizeView.value = Float(self.titleLabel.font.pointSize)          //Has to be set after minimum/maximum values have been adjusted
        
        self.view.addSubview(sizeView)
        
        NSLayoutConstraint(item: sizeView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: sizeView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: -5.0).isActive = true
        NSLayoutConstraint(item: sizeView, attribute: .bottom, relatedBy: .equal, toItem: self.changeColorButton, attribute: .top, multiplier: 1.0, constant: -15.0).isActive = true
        
        self.showPopup(sizeView, completion: nil)
    }
    
    func alignmentChanged(view: AdjustAlignView, alignment: NSTextAlignment) {
        self.titleLabel.textAlignment = alignment
    }
    
    func valueAdjusted(view: AdjustValueView) {
        if(view is AdjustColorView) {
            self.titleLabel.textColor = (view as! AdjustColorView).color
        } else if(view is AdjustSizeView) {
            self.titleLabel.font = self.titleLabel.font.withSize(CGFloat(view.value))
        } else if(view is AdjustKernView) {
            self.titleLabel.style.kern = NSNumber(value: view.value)
        }
    }
    
}

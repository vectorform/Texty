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

class ButtonViewController1: UIViewController, AdjustValueViewDelegate {
    private let changeColorButton: ModificationButton = ModificationButton()
    private let changeKernButton: ModificationButton = ModificationButton()
    private let changeSizeButton: ModificationButton = ModificationButton()
    
    private lazy var titleButton: TextyButton = {
        var style = TextStyle(with: Styles.Header)
        
        style.setAttributes([TextAttribute.obliqueness : 0.2], forTag: "italic")
        style.setAttributes([TextAttribute.underlineStyle : NSUnderlineStyle.single.rawValue], forTag: "underline")
    
        let button = TextyButton(style: style)
        var highlightedStyle = TextStyle(with: Styles.Header)
        
        highlightedStyle.setAttributes([TextAttribute.obliqueness : -0.5], forTag: "italic")
        highlightedStyle.setAttributes([TextAttribute.underlineStyle : NSUnderlineStyle.double.rawValue], forTag: "underline")
        highlightedStyle.foregroundColor = UIColor.blue
       
        button.setStyle(highlightedStyle, for: .highlighted)
        
        button.addTarget(self, action: #selector(textyButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var shownPopup: UIView?
    
    @objc private func textyButtonPressed() {
        print("textyButtonPressed")
    }
    
    override func loadView() {
        super.loadView()
        
        self.changeColorButton.addTarget(self, action: #selector(changeColorButtonPressed), for: .touchUpInside)
        self.changeColorButton.setTitle("Color", for: .normal)
        self.changeColorButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.changeSizeButton.addTarget(self, action: #selector(changeSizeButtonPressed), for: .touchUpInside)
        self.changeSizeButton.setTitle("Size", for: .normal)
        self.changeSizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.changeKernButton.addTarget(self, action: #selector(changeKernButtonPressed), for: .touchUpInside)
        self.changeKernButton.setTitle("Kern", for: .normal)
        self.changeKernButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleButton.setTitle("TextButton <italic>Example - <underline>Click </italic> Me</underline>", for: .normal)
        self.titleButton.setTitleColor(UIColor(hue: 0.0, saturation: 1.0, brightness: 1.0, alpha: 1.0), for: .normal)
        self.titleButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.backgroundColor = UIColor.white
        self.view.frame = UIScreen.main.bounds
        
        self.view.addSubview(self.titleButton)
        self.view.addSubview(self.changeColorButton)
        self.view.addSubview(self.changeSizeButton)
        self.view.addSubview(self.changeKernButton)
        
        NSLayoutConstraint(item: self.titleButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.titleButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.titleButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: self.titleButton, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: -10.0).isActive = true
        
        NSLayoutConstraint(item: self.changeColorButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: (1.0 / 3.0), constant: -10.0).isActive = true
        NSLayoutConstraint(item: self.changeColorButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0.0, constant: 50.0).isActive = true
        NSLayoutConstraint(item: self.changeColorButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 5.0).isActive = true
        if #available(iOS 11.0, *) {
            NSLayoutConstraint(item: self.changeColorButton, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -60.0).isActive = true
        } else {
            NSLayoutConstraint(item: self.changeColorButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -60.0).isActive = true
        }
        
        NSLayoutConstraint(item: self.changeSizeButton, attribute: .width, relatedBy: .equal, toItem: self.changeColorButton, attribute: .width, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.changeSizeButton, attribute: .height, relatedBy: .equal, toItem: self.changeColorButton, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.changeSizeButton, attribute: .left, relatedBy: .equal, toItem: self.changeColorButton, attribute: .right, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: self.changeSizeButton, attribute: .top, relatedBy: .equal, toItem: self.changeColorButton, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.changeKernButton, attribute: .width, relatedBy: .equal, toItem: self.changeColorButton, attribute: .width, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.changeKernButton, attribute: .height, relatedBy: .equal, toItem: self.changeColorButton, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.changeKernButton, attribute: .left, relatedBy: .equal, toItem: self.changeSizeButton, attribute: .right, multiplier: 1.0, constant: 10.0).isActive = true
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
        
        popup.alpha = 0.0
        popup.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(popup)
        
        NSLayoutConstraint(item: popup, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: popup, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: -5.0).isActive = true
        NSLayoutConstraint(item: popup, attribute: .bottom, relatedBy: .equal, toItem: self.changeColorButton, attribute: .top, multiplier: 1.0, constant: -15.0).isActive = true
        
        UIView.animate(withDuration: 0.25, animations: {
            popup.alpha = 1.0
        }) { (result) in
            self.shownPopup = popup
            self.view.isUserInteractionEnabled = true
            completion?()
        }
    }
    
    @objc private func changeColorButtonPressed() {
        if let view = self.shownPopup, view is AdjustColorView {
            self.hideShownPopup(completion: nil)
            return
        }
        
        var hue: CGFloat = 0.0
        self.titleButton.titleColor(for: .normal)?.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        
        let colorView: AdjustColorView = AdjustColorView(hue: hue)
        colorView.delegate = self
        self.showPopup(colorView, completion: nil)
    }
    
    @objc private func changeKernButtonPressed() {
        if let view = self.shownPopup, view is AdjustKernView {
            self.hideShownPopup(completion: nil)
            return
        }
        
        let kernView: AdjustKernView = AdjustKernView()
        
        kernView.delegate = self
        kernView.maximumValue = 30.0
        kernView.minimumValue = 0.0
        kernView.value = Float(self.titleButton.style(for: .normal).kern == nil ? 0.0 : self.titleButton.style(for: .normal).kern!.floatValue)          //Has to be set after minimum/maximum values have been adjusted

        self.showPopup(kernView, completion: nil)
    }
    
    @objc private func changeSizeButtonPressed() {
        if let view = self.shownPopup, view is AdjustSizeView {
            self.hideShownPopup(completion: nil)
            return
        }
        
        let sizeView: AdjustSizeView = AdjustSizeView()
        
        sizeView.delegate = self
        sizeView.maximumValue = 30.0
        sizeView.minimumValue = 10.0
        sizeView.value = Float((self.titleButton.titleLabel?.font.pointSize)!)          //Has to be set after minimum/maximum values have been adjusted
 
        self.showPopup(sizeView, completion: nil)
    }
    
    func valueAdjusted(view: AdjustValueView) {
        if(view is AdjustColorView) {
            self.titleButton.setTitleColor((view as! AdjustColorView).color, for: .normal)
        } else if(view is AdjustSizeView) {
            self.titleButton.style(for: .normal).font = self.titleButton.style(for: .normal).font?.withSize(CGFloat(view.value))
        } else if(view is AdjustKernView) {
            self.titleButton.style(for: .normal).kern = NSNumber(value: view.value)
        }
    }
}

// Copyright (c) 2018 Vectorform, LLC
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


protocol AdjustValueViewDelegate: class {
    
    func valueAdjusted(view: AdjustValueView)
    
}


class AdjustValueView: PopupView {
    
    weak var delegate: AdjustValueViewDelegate?
    
    
    private let titleLabel: TextyLabel = TextyLabel(style: Styles.PopupHeader)
    
    private let sliderView: UISlider = UISlider()
    
    
    var minimumValue: Float {
        get { return self.sliderView.minimumValue }
        set { self.sliderView.minimumValue = newValue }
    }
    
    var maximumValue: Float {
        get { return self.sliderView.maximumValue }
        set { self.sliderView.maximumValue = newValue }
    }
    
    var value: Float {
        get { return self.sliderView.value }
        set { self.sliderView.value = newValue }
    }
    
    var title: String? {
        get { return self.titleLabel.text }
        set { self.titleLabel.text = newValue }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.sliderView.addTarget(self, action: #selector(AdjustValueView.sliderValueChanged), for: UIControl.Event.valueChanged)
        self.sliderView.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.textAlignment = .center
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.sliderView)
        
        NSLayoutConstraint(item: self.titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0).isActive = true
        
        NSLayoutConstraint(item: self.sliderView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 15.0).isActive = true
        NSLayoutConstraint(item: self.sliderView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -15.0).isActive = true
        NSLayoutConstraint(item: self.sliderView, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: self.sliderView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -10.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not supported")
    }
    
    
    @objc private func sliderValueChanged() {
        self.delegate?.valueAdjusted(view: self)
    }
    
}

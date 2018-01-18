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


protocol AdjustAlignViewDelegate: class {
    
    func alignmentChanged(view: AdjustAlignView, alignment: NSTextAlignment)
    
}

class AdjustAlignView: PopupView {
    
    weak var delegate: AdjustAlignViewDelegate?
    
    
    private let titleLabel: TextyLabel = TextyLabel(style: Styles.PopupHeader)
    
    private let segmentedControl: UISegmentedControl = UISegmentedControl(items: ["Left", "Center", "Right"])
    
    
    convenience init(alignment: NSTextAlignment) {
        self.init(frame: .zero)
        
        switch(alignment) {
        case .left:
            self.segmentedControl.selectedSegmentIndex = 0
            break
        
        case .center:
            self.segmentedControl.selectedSegmentIndex = 1
            break
        
        case .right:
            self.segmentedControl.selectedSegmentIndex = 2
            break
            
        default:
            break
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel.text = "Adjust Alignment"
        self.titleLabel.textAlignment = .center
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.segmentedControl.addTarget(self, action: #selector(AdjustAlignView.valueChanged), for: .valueChanged)
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.segmentedControl)
        
        NSLayoutConstraint(item: self.titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0).isActive = true
        
        NSLayoutConstraint(item: self.segmentedControl, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: self.segmentedControl, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -10.0).isActive = true
        NSLayoutConstraint(item: self.segmentedControl, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: self.segmentedControl, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -10.0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not supported")
    }
    
    
    @objc private func valueChanged() {
        self.delegate?.alignmentChanged(view: self, alignment: (self.segmentedControl.selectedSegmentIndex == 0 ? .left : self.segmentedControl.selectedSegmentIndex == 1 ? .center : .right))
    }
    
}

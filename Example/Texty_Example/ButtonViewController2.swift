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

class ButtonViewController2: UIViewController{
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor.white
        
        let test1Buttons = [UIButton(),TextyButton()]
        for button in test1Buttons{
            button.setTitle("hello", for: [.normal])
            button.setTitleColor(UIColor.brown, for: [.normal])
        }
        
        let test2Buttons = [UIButton(),TextyButton()]
        for button in test2Buttons{
            button.setTitle("hello", for: [.normal])
            button.setTitleColor(UIColor.red, for: [.selected])
            button.isSelected = true
            button.backgroundColor = UIColor.black
        }
        
        let test3Buttons = [UIButton(),TextyButton()]
        for button in test3Buttons{
            button.setTitle("hello", for: [.highlighted,.normal])
            button.setTitle("olleh", for: [.normal])
            button.setTitleColor(UIColor.red, for: [.highlighted])
            button.setTitleColor(UIColor.brown, for: [.normal])
            button.backgroundColor = UIColor.black
        }
        
        let test4Buttons = [UIButton(),TextyButton()]
        for button in test4Buttons{
            button.setTitle("hello", for: [.normal])
            button.setTitleColor(UIColor.red, for: [.normal])
            button.setTitleColor(UIColor.blue, for: [.highlighted])
            button.setTitleColor(UIColor.green, for: [.highlighted, .selected])
            button.isSelected = true
            button.backgroundColor = UIColor.black
        }
        
        let uiButton5 = UIButton()
        uiButton5.setAttributedTitle(NSAttributedString(string: "hello", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24.0)]), for: .normal)
        uiButton5.titleLabel?.font = uiButton5.titleLabel?.font.withSize(50)
        uiButton5.setTitleShadowColor(UIColor.purple, for: .normal)
        uiButton5.setTitleShadowColor(UIColor.yellow, for: .highlighted)
        uiButton5.titleLabel?.shadowOffset = CGSize(width: 2.0, height: 2.0);
        
        let textyButton5 = TextyButton(style: Styles.Header)
        textyButton5.setTitle("hello", for: .normal)
        textyButton5.titleLabel?.font = textyButton5.titleLabel?.font.withSize(50)
        textyButton5.setTitleShadowColor(UIColor.purple, for: .normal)
        textyButton5.setTitleShadowColor(UIColor.yellow, for: .highlighted)
        textyButton5.titleLabel?.shadowOffset = CGSize(width: 2.0, height: 2.0);
        
        let uiButtonStackView = UIStackView(arrangedSubviews: [test1Buttons[0],test2Buttons[0],test3Buttons[0],test4Buttons[0],uiButton5])
        uiButtonStackView.axis = .vertical
        uiButtonStackView.spacing = 10
        uiButtonStackView.distribution = .fillEqually
        
        let textyButtonStackView = UIStackView(arrangedSubviews: [test1Buttons[1],test2Buttons[1],test3Buttons[1],test4Buttons[1],textyButton5])
        textyButtonStackView.axis = .vertical
        textyButtonStackView.spacing = 10
        textyButtonStackView.distribution = .fillEqually
        
        let columnStackView = UIStackView(arrangedSubviews: [uiButtonStackView,textyButtonStackView])
        columnStackView.axis = .horizontal
        columnStackView.distribution = .fillEqually
        
        self.view.addSubview(columnStackView)
        
        columnStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: columnStackView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: columnStackView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0).isActive = true
    
        if #available(iOS 11.0, *) {
            NSLayoutConstraint(item: columnStackView, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: columnStackView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -60.0).isActive = true
        } else {
            NSLayoutConstraint(item: columnStackView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: columnStackView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -60.0).isActive = true
        }
    }
}

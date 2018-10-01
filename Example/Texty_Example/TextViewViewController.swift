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

fileprivate let BodyText: String = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sagittis pellentesque elementum. Suspendisse potenti. Vivamus ut nibh dapibus, suscipit magna vitae, mattis nisi. Mauris metus arcu, vulputate vitae leo sit amet, mattis molestie ex. Donec maximus vulputate est, at imperdiet ex. Nulla vel lectus ut diam sagittis ornare eu vitae enim. Etiam sed ligula euismod, congue nibh vel, tincidunt leo. Phasellus vel purus turpis. Nullam libero purus, posuere quis bibendum eget, scelerisque eu metus. Ut a ante ante. In tincidunt fringilla arcu, eu vehicula metus cursus ac. Donec non risus at lorem tincidunt placerat id vel sem. Vivamus iaculis felis metus, sed interdum massa accumsan eu.

Etiam congue turpis lorem, non vehicula est iaculis vitae. Ut nibh diam, suscipit vitae purus in, finibus laoreet odio. In hac habitasse platea dictumst. Donec in risus vel neque luctus gravida. Nulla non consectetur orci, id gravida nunc. Nam posuere mi ut nisl fermentum fermentum. Aenean elementum tellus feugiat neque suscipit, sit amet consequat libero egestas. Nullam iaculis auctor massa, id consectetur velit tempor elementum. Aenean blandit nulla mollis imperdiet imperdiet. Mauris ornare ante ligula, et feugiat lacus tincidunt eget. Duis posuere lectus elit, non cursus est consectetur nec. Pellentesque massa orci, rhoncus non eleifend sed, bibendum sit amet massa. Proin ornare purus non maximus sodales. Praesent maximus sollicitudin luctus.

Donec magna nunc, pharetra eget tellus sit amet, dignissim rutrum sapien. Vivamus interdum, libero in pharetra fringilla, turpis orci ornare elit, eu consequat ipsum sapien non ligula. Sed tempus euismod pharetra. Curabitur euismod accumsan nisi, eu mattis ipsum laoreet at. Donec molestie sit amet urna nec rhoncus. Fusce porta dolor massa, convallis auctor turpis fringilla et. Aliquam id lectus orci. Lorem ipsum dolor sit amet, consectetur adipiscing elit.

In faucibus pharetra ultrices. Proin fermentum pellentesque posuere. Etiam tortor magna, scelerisque a turpis dictum, ornare interdum nisl. Suspendisse vitae orci tortor. Nam a gravida diam. Cras in faucibus magna, quis dapibus enim. Phasellus euismod risus in malesuada fermentum. Sed lacinia felis nisl, at pharetra ipsum aliquam in. Sed et lacus convallis, placerat mi sit amet, tempus velit.

Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed semper augue sem, at egestas augue pretium ut. Integer mattis volutpat interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc auctor dolor urna, nec malesuada augue imperdiet eget. Donec tempus molestie urna id convallis. Vivamus facilisis pharetra euismod. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Phasellus aliquet sem eu tellus efficitur vulputate.
"""

class TextViewViewController: UIViewController{
    private let textView: TextyTextView = TextyTextView(style: TextStyle())
    
    override func loadView() {
        super.loadView()
        
        self.textView.style!.setStyle(Styles.Header, forTag: "header")
        self.textView.style!.setStyle(Styles.Body, forTag: "body")
        
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.text = "<header>TextyTextView</header>\n\n<body>\(BodyText)</body>"
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.textView)
        
        NSLayoutConstraint(item: self.textView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.textView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0).isActive = true
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint(item: self.textView, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 60.0).isActive = true
            NSLayoutConstraint(item: self.textView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -60.0).isActive = true
        } else {
            NSLayoutConstraint(item: self.textView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 60.0).isActive = true
            NSLayoutConstraint(item: self.textView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -60.0).isActive = true
        }
    }
}

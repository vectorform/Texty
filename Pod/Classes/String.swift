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


internal extension String {
    
    @discardableResult private mutating func stripTags(scanner: Scanner, tags: inout [String : NSRange], lastOpenTag: String? = nil, locationOffset: inout Int) -> Int {
        guard !scanner.isAtEnd else {
            return 0
        }
        
        var openLocation: Int
        var length: Int = 0
        
        while let left: String = scanner.scan(upto: "<") {
            openLocation = scanner.scanLocation
            
            scanner.incrementLocation()
            self.append(left)
            length += left.characters.count
            
            if let tag: String = scanner.scan(upto: ">") {
                scanner.incrementLocation()
                
                if(tag.hasSuffix("/")) {
                    let correctedTag = String(tag.characters.dropLast())
                    locationOffset += 2 + tag.characters.count
                    
                    assert(lastOpenTag != nil, "found closing tag \"<\(correctedTag)/>\" without opening tag")
                    assert(correctedTag == lastOpenTag!, "found nonmatcing tags \"<\(lastOpenTag!)>\" and \"<\(correctedTag)\"/>")
                    
                    tags[correctedTag]!.length = length
                    return length
                } else {
                    tags[tag] = NSRange(location: openLocation - locationOffset, length: 0)
                    locationOffset += 2 + tag.characters.count
                    length += self.stripTags(scanner: scanner, tags: &tags, lastOpenTag: tag, locationOffset: &locationOffset)
                }
            }
        }

        return length
    }
    
    internal mutating func stripTags() -> [String : NSRange] {
        let scanner: Scanner = Scanner(string: self)
        var tags: [String : NSRange] = [:]
        var locationOffset: Int = 0
        
        scanner.charactersToBeSkipped = nil
        self = ""
        
        self.stripTags(scanner: scanner, tags: &tags, locationOffset: &locationOffset)
        return tags
    }
    
}

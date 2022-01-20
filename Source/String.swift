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

internal extension String {
    
    @discardableResult private mutating func stripTags(scanner: Scanner, tags: inout [String : NSRange], lastOpenTag: String? = nil, locationOffset: inout Int) -> Int {
        guard !scanner.isAtEnd else {
            return 0
        }
        
        var openLocation: Int
        var length: Int = 0

        while let left: String = scanner.scanUpToString("<") {
            openLocation = scanner.currentIndex.utf16Offset(in: self)

            scanner.incrementLocation()
            self.append(left)
            length += left.count
            
            if let tag: String = scanner.scanUpToString(">") {
                scanner.incrementLocation()
                
                if(tag.hasSuffix("/")) {
                    let correctedTag = String(tag.dropLast())
                    locationOffset += 2 + tag.count
                    
                    assert(lastOpenTag != nil, "Texty: found closing tag \"<\(correctedTag)/>\" without opening tag")
                    assert(correctedTag == lastOpenTag!, "Texty: found non-matching tags \"<\(lastOpenTag!)>\" and \"<\(correctedTag)\"/>")
                    
                    tags[correctedTag]!.length = length
                    return length
                } else {
                    tags[tag] = NSRange(location: openLocation - locationOffset, length: 0)
                    locationOffset += 2 + tag.count
                    length += self.stripTags(scanner: scanner, tags: &tags, lastOpenTag: tag, locationOffset: &locationOffset)
                }
            }
        }

        return length
    }
    
    mutating func findAndRemoveTags() -> [(tag: String, range: NSRange)] {
        let scanner: Scanner = Scanner(string: self)
        
        var tagLocation: Int
        var isClosingTag: Bool
        var isShortTag: Bool
        var lengthOffset: Int = 0
        
        var newString: String = ""
        var mutableTagString: String
        
        var tags: [Tag] = []
        
        var ret: [(tag: String, range: NSRange)] = []
        var openTags: [Tag] = []

        scanner.charactersToBeSkipped = nil
        
        //This will scan in one tag at a time
        while let left: String = scanner.scanUpToString("<") {
            newString += left
            guard !scanner.isAtEnd else {
                break
            }
            tagLocation = scanner.currentIndex.utf16Offset(in: self)
            scanner.incrementLocation()
            
            guard let tagString: String = scanner.scanUpToCharacters(from: CharacterSet(charactersIn: "<>")) else {
                newString += "<"
                break
            }

            let scanLocation: Int = scanner.currentIndex.utf16Offset(in: self)
            //This will check for consecutive '<' characters (i.e. <underline> < </underline>)
            if scanLocation < self.count, String(self[self.index(self.startIndex, offsetBy: scanLocation)]) == "<" {
                //The next loop will catch the next '<'
                newString += "<" + tagString
                continue
            }
            scanner.incrementLocation()
            
            //Create the tag
            mutableTagString = tagString
            isClosingTag = false
            isShortTag = false
            
            if(mutableTagString.hasPrefix("/")) {
                isClosingTag = true
                mutableTagString = String(mutableTagString.dropFirst())
            } else if(mutableTagString.hasSuffix("/")) {
                isShortTag = true
                mutableTagString = String(mutableTagString.dropLast())
            }
            mutableTagString = mutableTagString.trimmingCharacters(in: .whitespaces)
            
            tags.append(Tag(string: mutableTagString, location: tagLocation - lengthOffset, closing: isClosingTag, short: isShortTag))
            lengthOffset += 2 + tagString.count
        }
        
        for tag: Tag in tags {
            guard !tag.short else {
                ret.append((tag: tag.name, range: NSRange(location: tag.location, length: 0)))
                continue
            }
            
            guard !tag.opening else {
                openTags.insert(tag, at: 0)
                continue
            }
            
            //The tag is closing, and we need to find the first opening tag for it
            //== compares Tag.name properties only
            guard let index = openTags.firstIndex(of: tag) else {
                assertionFailure("Texty: closing tag found without opening tag (unbalanced tags found in string)")
                continue
            }
            
            ret.append((tag: tag.name, range: NSRange(location: openTags[index].location, length: tag.location - openTags[index].location)))
            openTags.remove(at: index)
        }
        
        guard openTags.count == 0 else {
            assertionFailure("Texty: open tags without matching closing tags (unbalanced tags found in string)")
            return ret
        }
        
        self = newString
        return ret
    }
    
    mutating func stripTags() -> [String : NSRange] {
        let scanner: Scanner = Scanner(string: self)
        var tags: [String : NSRange] = [:]
        var locationOffset: Int = 0
        
        scanner.charactersToBeSkipped = nil
        self = ""
        
        self.stripTags(scanner: scanner, tags: &tags, locationOffset: &locationOffset)
        return tags
    }
}

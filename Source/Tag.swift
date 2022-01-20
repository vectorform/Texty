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

/// The Hashable protocol is here so that a Tag instance can be used as a key in a
/// dictionary.  For that reason, == only compares the literal string tag.
internal struct Tag: Hashable {
    
    internal var opening: Bool { return (!self.closing) && (!self.short) }
    internal let closing: Bool
    internal let short: Bool
    
    internal let name: String
    internal let location: Int
    
    func hash(into hasher: inout Hasher) {
        return self.name.hash(into: &hasher)
    }
    
    public init(string: String, location: Int, closing: Bool, short: Bool) {
        assert(!(closing && short), "Texty: a tag can be closing, short, or neither, but not both closing and short")
        self.closing = closing
        self.short = short
        self.name = string
        self.location = location
    }
}

internal func ==(lhs: Tag, rhs: Tag) -> Bool {
    return lhs.name == rhs.name
}

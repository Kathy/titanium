// Copyright 2007, Google Inc.
//
// Redistribution and use in source and binary forms, with or without 
// modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, 
//     this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//  3. Neither the name of Google Inc. nor the names of its contributors may be
//     used to endorse or promote products derived from this software without
//     specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
// EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
// OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "gears/base/safari/nsstring_utils.h"

#import <WebKit/WebKit.h>

#import "gears/base/common/string_utils.h"
#import "gears/base/common/string_utils_osx.h"
#import "third_party/scoped_ptr/scoped_ptr.h"

@implementation NSString(GearsString16Conversion)
//------------------------------------------------------------------------------
+ (NSString *)stringWithString16:(const char16 *)str {
  return [(NSString *)CFStringCreateWithString16(str) autorelease];
}

//------------------------------------------------------------------------------
- (bool)string16:(std::string16 *)out16 {
  const char *utf8 = [self UTF8String];
  
  if (!strlen(utf8)) {
    out16->empty();
    return true;
  }
  
  return(UTF8ToString16(utf8, out16));
}

//------------------------------------------------------------------------------
- (UniChar *)copyCharacters {
  int len = [self length];
  UniChar *buffer = new UniChar[len + 1];

  if (len)
    [self getCharacters:buffer];
  
  buffer[len] = 0;
  
  return buffer;
}

@end

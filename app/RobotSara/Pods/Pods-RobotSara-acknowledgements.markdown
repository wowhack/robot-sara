# Acknowledgements
This application makes use of the following third party libraries:

## AFNetworking

Copyright (c) 2013-2014 AFNetworking (http://afnetworking.com/)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


## StringScore

# StringScore

StringScore is an Objective-C library which provides super fast fuzzy string matching/scoring. Based on the [JavaScript library of the same name](https://github.com/joshaven/string_score), by [Joshaven Potter](https://github.com/joshaven).


## Using StringScore

StringScore adds 3 new methods to `NSString`:

````
- (CGFloat) scoreAgainst:(NSString *)otherString;

- (CGFloat) scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness;

- (CGFloat) scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness options:(NSStringScoreOption)options;
````

All three methods return a `CGFloat` representing how closely the string
matched the `otherString` parameter.


## Additional Parameters

### Fuzziness

A number between 0 and 1 which varys how fuzzy/ the calculation is.
Defaults to `nil` (fuzziness disabled).


### Options

There are 3 options available: `NSStringScoreOptionNone`, `NSStringScoreOptionFavorSmallerWords` and `NSStringScoreOptionReducedLongStringPenalty`. Each of which is pretty self-explanatory, see example below for usage.


## Examples

Given the following sample application:

````
NSString *testString = @"Hello world!";

CGFloat result1 = [testString scoreAgainst:@"Hello world!"];
CGFloat result2 = [testString scoreAgainst:@"world"];
CGFloat result3 = [testString scoreAgainst:@"wXrld" fuzziness:[NSNumber numberWithFloat:0.8]];
CGFloat result4 = [testString scoreAgainst:@"world" fuzziness:nil options:NSStringScoreOptionFavorSmallerWords];
CGFloat result5 = [testString scoreAgainst:@"world" fuzziness:nil options:(NSStringScoreOptionFavorSmallerWords & NSStringScoreOptionReducedLongStringPenalty)];
CGFloat result6 = [testString scoreAgainst:@"HW"]; // abbreviation matching example

NSLog(@"Result 1 = %f", result1);
NSLog(@"Result 2 = %f", result2);
NSLog(@"Result 3 = %f", result3);
NSLog(@"Result 4 = %f", result4);
NSLog(@"Result 5 = %f", result5);
NSLog(@"Result 6 = %f", result6);
````

The resulting output is:

````
2012-05-14 15:13:38.074 StringScore[13415:18a03] Result 1 = 1.000000
2012-05-14 15:13:38.075 StringScore[13415:18a03] Result 2 = 0.425000
2012-05-14 15:13:38.075 StringScore[13415:18a03] Result 3 = 0.271528
2012-05-14 15:13:38.076 StringScore[13415:18a03] Result 4 = 0.250000
2012-05-14 15:13:38.077 StringScore[13415:18a03] Result 5 = 0.425000
2012-05-14 15:13:38.078 StringScore[13415:18a03] Result 6 = 0.645833
````

## Credits

Author: [Nicholas Bruning](https://github.com/thetron)

Special thanks to [Joshaven Potter](https://github.com/joshaven) for
providing the basis for this library.


## License

Licensed under the [MIT license](http://www.opensource.org/licenses/mit-license.php).


## pop

BSD License

For Pop software

Copyright (c) 2014, Facebook, Inc. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

 * Neither the name Facebook nor the names of its contributors may be used to
   endorse or promote products derived from this software without specific
   prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Generated by CocoaPods - http://cocoapods.org

## Introduction ##
Reduce Memory is a utility that reduces the working memory of processes it is watching. This can be useful in squeezing out more programs with the same amount of RAM. As a tradeoff, it can slow the process it watches for down. Programs load information into memory so they can use it faster than would be possible than from the hard drive. When working memory is cleared, any currently unuseful data is cleaned out. If the program needs to access that information again, it will have to reload that information back into RAM so the program can use it.

## How to use ##
Open the included "Reduce Memory.ini" and edit it as you see fit. Programs should be separated by the pipe symbol "```|```". Interval in millseconds sets how often Redude Memory will attempt to reduce the working memory of programs it is watching. Setting this interval too low can cause watched programs to freeze up. If this happens, close Reduce Memory. If this doesn't fix it, restart your computer, increase the interval and try again. 

## Logs ## 
The "Reduce Memory.log" file can be checked to see how long it takes to reduce the working memory of all watched process. This can be useful in determining how long to set the interval in millseconds value.

## Support ## 
Support can be obtained by contacting the developer at BetaLeaf@gmail.com or via the contact page on the official website: https://www.betaleaf.net/contact/

## Source Code ##
Source code is contained inside the "Reduce Memory.au3" file. This source code can be compiled by following the instructions found at: https://www.autoitscript.com/autoit3/docs/intro/compiler.htm

## License ## 
MIT License

Copyright (c) 2019 Jeff Savage (BetaLeaf)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

html2pdf
--------

A simple command line tool for Mac OS X.  html2pdf converts HTML files to PDFs using the WebKit
rendering engine.

Inspiration and a little bit of code from monkeeboi's MacPython script html2pdf.py: 
http://thinkpython.blogspot.com/2009/08/convert-html-files-to-pdf.html

Usage
-----

html2pdf [options] htmlfile.html [htmlfile2.html ...]

* --papersize=PAPERSIZE, -s PAPERSIZE: Specify a paper size preset to use.  Currently, html2pdf supports
  the following paper sizes: 4x6, 3x5, letter.
  
TODO
----

* Support more paper sizes; possibly user-configurable using a plist?
* Support asymmetric margins
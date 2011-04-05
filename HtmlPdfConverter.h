//
//  HtmlPdfConverter.h
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import <WebKit/WebKit.h>
#include "PaperSize.h"
#include "FileToConvert.h"

@interface HtmlPdfConverter : NSObject<NSApplicationDelegate> {
	PaperSize *paperSize;
	FileToConvert *currentWorkItem;
	NSMutableArray *todoList;
	WebView *webview;
}

-(id)initWithWebView:(WebView *)wv fileDests:(NSDictionary *)fileDests paperSize:(PaperSize *)ps;

-(void)startNextItem;
-(void)printFrame:(WebFrame *)frame toFile:(NSString *)destFile;

-(void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame;
-(void)webView:(WebView *)sender didFailProvisionalLoadWithError:(NSError *)error forFrame:(WebFrame *)frame;
-(void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame;

@end

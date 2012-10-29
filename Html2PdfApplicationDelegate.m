//
//  Html2PdfApplicationDelegate.m
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import "Html2PdfApplicationDelegate.h"
#import <WebKit/WebKit.h>
#include "HtmlPdfConverter.h"

@implementation Html2PdfApplicationDelegate
-(id)initWithArgc:(int)ac argv:(char **)av paperSize:(PaperSize *)size {
	argc = ac;
	argv = av;
	paperSize = size;
	return self;
}

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	NSRect rect = NSMakeRect(0, 0, 400, 400);
	NSApplication *app = [NSApplication sharedApplication];
	[[[NSWindow alloc] initWithContentRect:rect styleMask:NSBorderlessWindowMask backing:2 defer:FALSE] autorelease];
	WebView *webview = [[WebView alloc] initWithFrame:rect];
	WebPreferences *webprefs = [[WebPreferences alloc] init];
	
	[webprefs setShouldPrintBackgrounds:TRUE];
	[webview setPreferences:webprefs];
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSMutableDictionary *fileDests = [[NSMutableDictionary alloc] initWithCapacity:argc];
	for (int i=0; i<argc; i++) {
		NSString *htmlFile = [[NSString alloc] initWithCString:argv[i] encoding:NSUTF8StringEncoding];
		
		NSMutableString *pdfFile;
		if ([htmlFile length] >= 5 &&
			[[htmlFile substringFromIndex:[htmlFile length] - 5] isEqualToString:@".html"]) {
			pdfFile = [NSMutableString stringWithString:[htmlFile substringToIndex:[htmlFile length] - 5]];
		} else {
			pdfFile = [NSMutableString stringWithString:htmlFile];
		}
		
		[pdfFile appendString:@".pdf"];
		[fileDests setObject:pdfFile forKey:htmlFile];
		[htmlFile autorelease];
	}
	
	HtmlPdfConverter *converter = [[HtmlPdfConverter alloc] initWithWebView:webview fileDests:fileDests paperSize:paperSize];
	[webview setFrameLoadDelegate:converter];
	[converter startNextItem];
	
	[app run];
	[converter release];
	[webprefs release];
	[fileDests release];
	[pool release];
}

-(void)dealloc {
	[paperSize release];
	[super dealloc];
}
@end

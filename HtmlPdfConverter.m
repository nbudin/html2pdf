//
//  HtmlPdfConverter.m
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import "HtmlPdfConverter.h"
#include <stdio.h>

@implementation HtmlPdfConverter

-(id)initWithWebView:(WebView *)wv fileDests:(NSDictionary *)fileDests paperSize:(PaperSize *)ps {	
	webview = wv;
	
	todoList = [[NSMutableArray alloc] initWithCapacity:[fileDests count]];
	for (NSString *htmlFile in fileDests) {
		FileToConvert *item = [[FileToConvert alloc] initWithHtmlFile:htmlFile pdfFile:[fileDests valueForKey:htmlFile]];
		[todoList addObject:item];
		[item autorelease];
	}
	
	paperSize = ps;
	
	return self;
}

-(void)startNextItem {
	currentWorkItem = [todoList objectAtIndex:0];
	[todoList removeObjectAtIndex:0];
	
	printf("Generating %s from %s\n", [[currentWorkItem pdfFile] UTF8String], [[currentWorkItem htmlFile] UTF8String]);
	
	NSURL *url = [[NSURL alloc] initFileURLWithPath:[currentWorkItem htmlFile]];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	
	[[webview mainFrame] loadRequest:request];
	
	[request release];
	[url release];
}

-(void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
	if (frame == [sender mainFrame]) {
		[self printFrame:frame toFile:[currentWorkItem pdfFile]];
		
		if ([todoList count] > 0) {
			[self startNextItem];
		} else {
			[[NSApplication sharedApplication] terminate:self];
		}
	}
}

-(void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame {
	printf("%s\n", [[error localizedDescription] UTF8String]);
	[[NSApplication sharedApplication] terminate:self];
}


-(void)webView:(WebView *)sender didFailProvisionalLoadWithError:(NSError *)error forFrame:(WebFrame *)frame {
	printf("%s\n", [[error localizedDescription] UTF8String]);
	[[NSApplication sharedApplication] terminate:self];
}

-(void)printFrame:(WebFrame *)frame toFile:(NSString *)destFile {
	WebFrameView *frameView = [frame frameView];
	NSPrintInfo *sharedInfo = [NSPrintInfo sharedPrintInfo];
	NSMutableDictionary *printInfoDict = [NSMutableDictionary dictionaryWithDictionary:[sharedInfo dictionary]];
	[printInfoDict setObject:NSPrintSaveJob forKey:NSPrintJobDisposition];
	[printInfoDict setObject:destFile forKey:NSPrintSavePath];
	
	NSPrintInfo *printInfo = [[NSPrintInfo alloc] initWithDictionary:printInfoDict];
	[printInfo setHorizontalPagination:NSAutoPagination];
	[printInfo setVerticalPagination:NSAutoPagination];
	[printInfo setVerticallyCentered:FALSE];
	[paperSize setupPrintInfo:printInfo];
	
	NSPrintOperation *printOp = [frameView printOperationWithPrintInfo:printInfo];
	[printOp setShowsPrintPanel:FALSE];
	[printOp setShowsProgressPanel:FALSE];
	[printOp runOperation];
	
	[printInfo release];
}

-(void)dealloc {
	[currentWorkItem release];
	[todoList release];
	[super dealloc];
}

@end

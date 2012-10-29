//
//  html2pdf_main.m
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import <CoreFoundation/CoreFoundation.h>
#include "Html2PdfApplicationDelegate.h"
#include <getopt.h>

static struct option longopts[] = {
	{ "papersize", required_argument, NULL, 's' }
};

void usage() {
	printf("Usage: html2pdf [options] file.html [file2.html ...]\n");
	printf("       --papersize=PAPERSIZE, -s PAPERSIZE: Specify a paper size\n");
}

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	PaperSize *paperSize = nil;
	NSString *preset;
	
	int ch;
	while ((ch = getopt_long(argc, argv, "s:", longopts, NULL)) != -1) {
		switch (ch) {
			case 's':
				preset = [[NSString alloc] initWithCString:optarg encoding:NSUTF8StringEncoding];
				paperSize = [PaperSize newWithPreset:preset];
				[paperSize autorelease];
				[preset release];
				
				if (paperSize == NULL) {
					printf("%s is not a valid paper size preset\n", optarg);
					return 1;
				}
				
				break;
			default:
				usage();
				[pool autorelease];
				return 1;
		}
	}
	
	if (paperSize == NULL) {
		paperSize = [PaperSize newWithPreset:@"letter"];
		[paperSize autorelease];
	}
	
	argc -= optind;
	argv += optind;
	
	if (argc == 0) {
		printf("Please specify at least one HTML file to convert to PDF.\n\n");
		usage();
		
		[pool release];
		return 1;
	}
	
	
	Html2PdfApplicationDelegate *delegate = 
	[[Html2PdfApplicationDelegate alloc] initWithArgc:argc argv:argv paperSize:paperSize];
		
	NSApplication *app = [NSApplication sharedApplication];
	[app setDelegate:delegate];
	[app run];
	
	[pool release];
	
	return 0;
}

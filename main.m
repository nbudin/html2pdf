//
//  html2pdf_main.m
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import <CoreFoundation/CoreFoundation.h>
#include "Html2PdfApplicationDelegate.h"
#include <getopt.h>
#import <AppKit/AppKit.h>

static struct option longopts[] = {
	{ "papersize", required_argument, NULL, 's' },
    { "orientation", required_argument, NULL, 'o' }
};

void usage() {
	printf("Usage: html2pdf [options] file.html [file2.html ...]\n");
	printf("       --papersize=PAPERSIZE, -s PAPERSIZE: Specify a paper size\n");
    printf("       --orientation=ORIENTATION, -o ORIENTATION: landscape or portrait (default portrait)\n");
    printf("\n");
    printf("Valid paper sizes: ");
    
    NSArray *paperSizes = [[PaperSize validPresetNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    int i = 0;
    char cStringSize[81];
    for (NSString *paperSize in paperSizes) {
        [paperSize getCString:cStringSize maxLength:80 encoding:NSASCIIStringEncoding];
        printf("%s", cStringSize);
        i++;
        if (i < [paperSizes count]) {
            printf(", ");
        }
    }
    printf("\n");
}

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	PaperSize *paperSize = nil;
	NSString *presetName = @"letter";
    NSString *orientationString;
    NSPrintingOrientation orientation = NSPortraitOrientation;
	
	int ch;
	while ((ch = getopt_long(argc, argv, "s:o:", longopts, NULL)) != -1) {
		switch (ch) {
			case 's':
				presetName = [[NSString alloc] initWithCString:optarg encoding:NSUTF8StringEncoding];
				
				if (![PaperSize isValidPresetName:presetName]) {
					printf("%s is not a valid paper size preset (valid options: %s)\n", optarg, [[[PaperSize validPresetNames] componentsJoinedByString:@", "] cStringUsingEncoding:NSUTF8StringEncoding]);
					return 1;
				}
				
				break;
            case 'o':
                orientationString = [[NSString alloc] initWithCString:optarg encoding:NSUTF8StringEncoding];

                if ([orientationString isEqualToString:@"portrait"])
                    orientation = NSPortraitOrientation;
                else if ([orientationString isEqualToString:@"landscape"])
                    orientation = NSLandscapeOrientation;
                else {
                    printf("%s is not a valid orientation (must be either portrait or landscape)\n", optarg);
                    [orientationString release];
                    return 1;
                }
                
                [orientationString release];
                
                break;
			default:
				usage();
				return 1;
		}
	}
	
	paperSize = [PaperSize newWithPreset:presetName orientation:orientation];
	[paperSize autorelease];
	
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

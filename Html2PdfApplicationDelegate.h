//
//  Html2PdfApplicationDelegate.h
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import "PaperSize.h"

@interface Html2PdfApplicationDelegate : NSObject<NSApplicationDelegate> {
	int argc;
	char **argv;
	PaperSize *paperSize;
}

-(id)initWithArgc:(int)ac argv:(char **)av paperSize:(PaperSize *)size;
-(void)applicationDidFinishLaunching:(NSNotification *)aNotification;

@end

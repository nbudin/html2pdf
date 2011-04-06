//
//  Html2PdfApplicationDelegate.h
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import "PaperSize.h"

#if (MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_5)
@interface Html2PdfApplicationDelegate : NSObject
#else
@interface Html2PdfApplicationDelegate : NSObject<NSApplicationDelegate>
#endif
{
	int argc;
	char **argv;
	PaperSize *paperSize;
}

-(id)initWithArgc:(int)ac argv:(char **)av paperSize:(PaperSize *)size;
-(void)applicationDidFinishLaunching:(NSNotification *)aNotification;

@end

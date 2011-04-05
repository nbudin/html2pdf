//
//  PaperSize.h
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

@interface PaperSize : NSObject {
	CGFloat margin;
	CGFloat width;
	CGFloat height;
	NSPrintingOrientation orientation;
}

-(id)initWithWidth:(CGFloat)width height:(CGFloat)height margin:(CGFloat)margin 
	   orientation:(NSPrintingOrientation) orientation;

-(void)setupPrintInfo:(NSPrintInfo *)printInfo;

+(PaperSize *)newWithPreset:(NSString *)name;

@end

//
//  PaperSize.m
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import "PaperSize.h"


@implementation PaperSize

-(id)initWithWidth:(CGFloat)w height:(CGFloat)h margin:(CGFloat)m orientation:(NSPrintingOrientation)o {

	width = w;
	height = h;
	margin = m;
	orientation = o;
	
	return self;
}

-(void)setupPrintInfo:(NSPrintInfo*)printInfo {
	[printInfo setBottomMargin:margin];
	[printInfo setTopMargin:margin];
	[printInfo setLeftMargin:margin];
	[printInfo setRightMargin:margin];
	[printInfo setPaperSize:NSMakeSize(width, height)];
	[printInfo setOrientation:orientation];
}

+(PaperSize *)newWithPreset:(NSString *)name {
	
	PaperSize *size = nil;
	
	if ([name isEqualToString:@"letter"]) {
		size = [[PaperSize alloc] initWithWidth:612 height:796 margin:36 orientation:NSPortraitOrientation];
	} else if ([name isEqualToString:@"4x6"]) {
		size = [[PaperSize alloc] initWithWidth:432 height:288 margin:18 orientation:NSLandscapeOrientation];
	} else if ([name isEqualToString:@"3x5"]) {
		size = [[PaperSize alloc] initWithWidth:360 height:216 margin:18 orientation:NSLandscapeOrientation];
	}
	
	return size;
}
@end

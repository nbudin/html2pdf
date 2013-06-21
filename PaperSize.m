//
//  PaperSize.m
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import "PaperSize.h"

NSDictionary *presets;

@implementation PaperSize

+(void)initialize {
    presets = @{@"letter" : @{@"width": @612, @"height": @796, @"margin": @36},
    @"4x6" : @{@"width": @432, @"height": @288, @"margin": @18},
    @"3x5" : @{@"width": @360, @"height": @216, @"margin": @18},
    @"a4"  : @{@"width": @595, @"height": @842, @"margin": @36}
  };
}

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

+(PaperSize *)newWithPreset:(NSString *)name orientation:(NSPrintingOrientation)orientation {
	
	PaperSize *size = nil;
    
    NSDictionary *presetParams = [presets objectForKey:name];
    if (presetParams != nil) {
        NSNumber *width = [presetParams objectForKey:@"width"];
        NSNumber *height = [presetParams objectForKey:@"height"];
        NSNumber *margin = [presetParams objectForKey:@"margin"];
        
        size = [[PaperSize alloc] initWithWidth:[width intValue] height:[height intValue] margin:[margin intValue] orientation:orientation];
    }
	
	return size;
}

+(NSArray *)validPresetNames {
    return [presets allKeys];
}

+(BOOL)isValidPresetName:(NSString *)name {
    return ([presets objectForKey:name] != nil);
}
@end

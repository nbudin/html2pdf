//
//  FileToConvert.m
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import "FileToConvert.h"


@implementation FileToConvert

-(id)initWithHtmlFile:(NSString*)html pdfFile:(NSString *)pdf {
	htmlFile = html;
	pdfFile = pdf;
	
	return self;
}

@synthesize htmlFile;
@synthesize pdfFile;
@end

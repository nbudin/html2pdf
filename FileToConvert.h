//
//  FileToConvert.h
//  html2pdf
//
//  Created by Nat Budin on 4/5/11.
//

#import <Cocoa/Cocoa.h>


@interface FileToConvert : NSObject {
	NSString *htmlFile;
	NSString *pdfFile;
}

-(id)initWithHtmlFile:(NSString *)html pdfFile:(NSString *)pdf;

@property(assign, readonly) NSString* htmlFile;
@property(assign, readonly) NSString* pdfFile;

@end

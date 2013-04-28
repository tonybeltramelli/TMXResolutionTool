//
//  TBImageHandler.h
//  TMXResolutionTool
//
//  Created by Tony BELTRAMELLI on 09/01/13.
//  Copyright (c) 2013 Tony BELTRAMELLI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface TBImageHandler : NSObject
{
    NSFileManager* _fileManager;
}

-(id) initWithFileManager:(NSFileManager *)fileManager;
-(void) processImage:(NSString *)path fromRatio:(float)ratio;
-(void) processImage:(NSString *)path fromWidth:(int)width andHeight:(int)height;

@end

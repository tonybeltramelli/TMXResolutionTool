//
//  TBXMLParser.h
//  TMXResolutionTool
//
//  Created by Tony BELTRAMELLI on 09/01/13.
//  Copyright (c) 2013 Tony BELTRAMELLI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBDefinition.h"

@interface TBXMLParser : NSObject
{
    NSXMLDocument* _xmlDocument;
}

-(NSMutableArray *) getImageNamesFromData:(NSData *)data;
-(NSData *) setDataWithRatio:(float)ratio;

@end

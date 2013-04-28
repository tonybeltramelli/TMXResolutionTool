//
//  TBXMLParser.m
//  TMXResolutionTool
//
//  Created by Tony BELTRAMELLI on 09/01/13.
//  Copyright (c) 2013 Tony BELTRAMELLI. All rights reserved.
//

#import "TBXMLParser.h"
#import "TBNameUtil.h"

@implementation TBXMLParser

-(NSMutableArray *) getImageNamesFromData:(NSData *)data
{
    NSError *error = nil;
    _xmlDocument = [[NSXMLDocument alloc] initWithData:data options:(NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA) error:&error];
    
    if (!_xmlDocument) {
        printf("Error : %s", [[error localizedDescription] UTF8String]);
    }
    
    NSArray *children = [[_xmlDocument rootElement] children];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    int i = 0;
    int length = (int) [children count];
    
    for (i = 0; i < length; i++)
    {
        NSXMLElement *child = [children objectAtIndex:i];
        
        if ([child.name isEqualToString:@"tileset"])
        {
            NSArray *childs = [child children];
            
            int j = 0;
            int count = (int) [childs count];
            
            for (j = 0; j < count; j++)
            {
                NSXMLElement *currentChild = [childs objectAtIndex:j];
                if ([currentChild.name isEqualToString:@"image"])
                {
                    [images addObject: [[currentChild attributeForName:@"source"] stringValue]];
                }
            }
        }
    }
    
    return images;
}

-(NSData *) setDataWithRatio:(float)ratio
{
    NSXMLElement *rootElement = [_xmlDocument rootElement];
    
    if([[rootElement name] isEqualToString:@"map"])
    {
        int map_tilewidth = [[[rootElement attributeForName:@"tilewidth"] stringValue] intValue] * ratio;
        int map_tileheight = [[[rootElement attributeForName:@"tileheight"] stringValue] intValue] * ratio;
        
        [[rootElement attributeForName:@"tilewidth"] setStringValue:[NSString stringWithFormat:@"%d", map_tilewidth]];
        [[rootElement attributeForName:@"tileheight"] setStringValue:[NSString stringWithFormat:@"%d", map_tileheight]];
    }
    
    NSArray *children = [rootElement children];
    int i = 0;
    int length = (int) [children count];
    
    for (i = 0; i < length; i++)
    {
        NSXMLElement *child = [children objectAtIndex:i];
        
        if ([child.name isEqualToString:@"tileset"])
        {
            int tileset_tilewidth = [[[child attributeForName:@"tilewidth"] stringValue] intValue] * ratio;
            int tileset_tileheight = [[[child attributeForName:@"tileheight"] stringValue] intValue] * ratio;
            
            [[child attributeForName:@"tilewidth"] setStringValue:[NSString stringWithFormat:@"%d", tileset_tilewidth]];
            [[child attributeForName:@"tileheight"] setStringValue:[NSString stringWithFormat:@"%d", tileset_tileheight]];
            
            NSArray *childs = [child children];
            
            int j = 0;
            int count = (int) [childs count];
            
            for (j = 0; j < count; j++)
            {
                NSXMLElement *currentChild = [childs objectAtIndex:j];
                if ([currentChild.name isEqualToString:@"image"])
                {
                    NSString *image_source = [[currentChild attributeForName:@"source"] stringValue];
                    NSString *targetPath = [NSString stringWithFormat:@"%@.%@",[TBNameUtil getFileNameFrom:image_source andRatio:ratio], [image_source pathExtension]];
                    
                    int image_width = [[[currentChild attributeForName:@"width"] stringValue] intValue] * ratio;
                    int image_height = [[[currentChild attributeForName:@"height"] stringValue] intValue] * ratio;
                    
                    [[currentChild attributeForName:@"width"] setStringValue:[NSString stringWithFormat:@"%d", image_width]];
                    [[currentChild attributeForName:@"height"] setStringValue:[NSString stringWithFormat:@"%d", image_height]];
                    [[currentChild attributeForName:@"source"] setStringValue:targetPath];
                }
            }
        }
    }
    
    return [_xmlDocument XMLDataWithOptions:NSXMLNodePrettyPrint];
}

- (void)dealloc
{
    [_xmlDocument release];
    _xmlDocument = nil;
    
    [super dealloc];
}

@end

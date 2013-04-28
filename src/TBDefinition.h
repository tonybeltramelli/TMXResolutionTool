//
//  TBDefinition.h
//  TMXResolutionTool
//
//  Created by Tony BELTRAMELLI on 09/01/13.
//  Copyright (c) 2013 Tony BELTRAMELLI. All rights reserved.
//

#ifndef TMXResolutionTool_TBDefinition_h
#define TMXResolutionTool_TBDefinition_h

struct TBTilesetImage {
    NSString *source;
    int width;
    int height;
};
typedef struct TBTilesetImage TBTilesetImage;

NS_INLINE TBTilesetImage TBMakeTilesetImage(NSString *s, int w, int h) {
    TBTilesetImage ti;
    ti.source = s;
    ti.width = w;
    ti.height = h;
    return ti;
}

#endif

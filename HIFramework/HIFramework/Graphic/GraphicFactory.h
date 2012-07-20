//
//  GraphicFactory.h
//  HIFramework
//
//  Created by He JiaBin on 12-7-3.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sprite.h"
#import "MovieClip.h"


@interface GraphicFactory : NSObject
{
    //TODO 
}

+ (GraphicFactory*)sharedInstance;


- (Sprite*)CreateSprite:(NSString*)imgName;

- (MovieClip*)CreateMovieClip:(NSString*)imgName withInterval:(float)interval;


@end

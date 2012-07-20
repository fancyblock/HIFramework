//
//  MovieClip.h
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sprite.h"

@interface frameInfo : NSObject

@property (nonatomic, readwrite) float U1;
@property (nonatomic, readwrite) float V1;
@property (nonatomic, readwrite) float U2;
@property (nonatomic, readwrite) float V2;
@property (nonatomic, readwrite) float ANCHOR_X;
@property (nonatomic, readwrite) float ANCHOR_Y;
@property (nonatomic, readwrite) float SIZE_WID;
@property (nonatomic, readwrite) float SIZE_HEI;

@end


@interface MovieClip : NSObject
{
    Sprite* m_sprite;
    NSMutableArray* m_frameList;
    
    float m_times;
    float m_x;
    float m_y;
    float m_angle;
    
    NSString* m_texImgName;
}

@property (nonatomic, retain) NSString* TEXTURE;
@property (nonatomic, readwrite) float INTERVAL;

@property (nonatomic, readwrite) float ANGLE;


- (void)AddFrame:(CGRect)region withAnchor:(CGPoint)anchor withSize:(CGPoint)size;

- (void)Update:(float)elapsed;

- (void)Draw;

- (void)Reset;

- (void)SetPosition:(CGPoint)position;

@end

//
//  Sprite.m
//  HIFramework
//
//  Created by He JiaBin on 12-7-1.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite

@synthesize U1;
@synthesize V1;
@synthesize U2;
@synthesize V2;

@synthesize X1;
@synthesize Y1;
@synthesize X2;
@synthesize Y2;
@synthesize X3;
@synthesize Y3;
@synthesize X4;
@synthesize Y4;

@synthesize COLOR_R;
@synthesize COLOR_G;
@synthesize COLOR_B;
@synthesize COLOR_A;
@synthesize TEXTURE_INDEX;



/**
 * @desc    constructor
 * @para    none
 * @return  id  self
 */
- (id)init
{
    [super init];
    
    self.COLOR_R = 1.0f;
    self.COLOR_G = 1.0f;
    self.COLOR_B = 1.0f;
    self.COLOR_A = 1.0f;
    
    return self;
}


//TODO


@end

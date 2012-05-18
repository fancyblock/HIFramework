//
//  HIApp.m
//  HIFramework
//
//  Created by He jia bin on 5/18/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import "HIApp.h"

@implementation HIApp

@synthesize viewController = m_glViewController;
@synthesize delegate = m_delegate;


/**
 * @desc    constructor
 * @para    none
 * @return  self
 */
- (id)init
{
    [super init];
    
    //TODO 
    
    m_glContext = [[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1] autorelease];
    m_glView = [GLKView alloc] initWithFrame:<#(CGRect)#> [context:m_glContext];
    
    return self;
}


/**
 * @desc    constructor
 * @para    orientation
 * @para    fps
 * @return  self
 */
- (id)initWithOrientation:(int)orientation withFPS:(int)fps
{
    m_orientation = orientation;
    m_fps = fps;
    
    [self init];
    
    return self;
}


/**
 * @desc    destructor
 * @para    none
 * @return  none
 */
- (void)dealloc
{
    [super dealloc];
    
    //TODO 
}


/*
 Required method for implementing GLKViewControllerDelegate. This update method variant should be used
 when not subclassing GLKViewController. This method will not be called if the GLKViewController object
 has been subclassed and implements -(void)update.
 */
- (void)glkViewControllerUpdate:(GLKViewController *)controller
{
    //TODO 
}


/*
 Delegate method that gets called when the pause state changes. 
 */
- (void)glkViewController:(GLKViewController *)controller willPause:(BOOL)pause
{
    //TODO 
}


/*
 Required method for implementing GLKViewDelegate. This draw method variant should be used when not subclassing GLKView.
 This method will not be called if the GLKView object has been subclassed and implements -(void)drawRect:(CGRect)rect.
 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    //TODO 
}


@end

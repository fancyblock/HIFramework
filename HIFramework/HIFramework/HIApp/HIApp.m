//
//  HIApp.m
//  HIFramework
//
//  Created by He jia bin on 5/18/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import "HIApp.h"

@interface HIApp(private)

- (void)setupOpenGL;

@end


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
    
    CGRect frame;
    if( m_orientation == ORIENTATION_LANDSCAPE )
    {
        frame = CGRectMake( 0, 0, 480, 320 );
    }
    
    if( m_orientation == ORIENTATION_PORTRAIT )
    {
        frame = CGRectMake( 0, 0, 320, 480 );
    }
    
    m_glContext = [[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1] autorelease];
    m_glView = [[GLKView alloc] initWithFrame:frame context:m_glContext];
    m_glViewController = [[GLKViewController alloc] init];
    
    m_glViewController.view = m_glView;
    m_glViewController.delegate = self;
    m_glView.delegate = self;
    m_glView.context = m_glContext;
    m_glView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupOpenGL];
    
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
    
    [m_glViewController release];
    [m_glView release];
    [m_glContext release];
}
     
     
//------------------------------ private functions -------------------------------
     

// setup the openGL
- (void)setupOpenGL
{
    [EAGLContext setCurrentContext:m_glContext];
    
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

//
//  HIApp.m
//  HIFramework
//
//  Created by He jia bin on 5/18/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import "HIApp.h"
#import "../Graphic/RenderCore.h"
#import "../Task/TaskManager.h"


@interface HIApp(private)

- (void)setupOpenGL;
- (void)frame:(float)dt;
- (void)rander:(float)dt;

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
        if( m_isIphone == YES )
        {
            frame = CGRectMake( 0, 0, IPHONE_SCREEN_HEIGHT, IPHONE_SCREEN_WIDTH );
        }
        else 
        {
            frame = CGRectMake( 0, 0, IPAD_SCREEN_HEIGHT, IPAD_SCREEN_WIDTH );
        }
    }
    
    if( m_orientation == ORIENTATION_PORTRAIT )
    {
        if( m_isIphone == YES )
        {
            frame = CGRectMake( 0, 0, IPHONE_SCREEN_WIDTH, IPHONE_SCREEN_HEIGHT );
        }
        else 
        {
            frame = CGRectMake( 0, 0, IPAD_SCREEN_WIDTH, IPAD_SCREEN_HEIGHT );
        }
    }
    
    m_glContext = [[[EAGLContext alloc] initWithAPI:HI_OGL_VERSION] autorelease];
    m_glView = [[GLKView alloc] initWithFrame:frame context:m_glContext];
    m_glViewController = [[GLController alloc] init];
    
    m_glView.autoresizesSubviews = NO;
    m_glView.autoresizingMask = UIViewAutoresizingNone;
    
    if( m_orientation == ORIENTATION_LANDSCAPE )
    {
        m_glViewController.CUR_ORIENTATION = UIInterfaceOrientationLandscapeLeft;
    }
    if( m_orientation == ORIENTATION_PORTRAIT )
    {
        m_glViewController.CUR_ORIENTATION = UIInterfaceOrientationPortrait;
    }
    
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
 * @para    isIphone
 * @para    orientation
 * @para    fps
 * @return  self
 */
- (id)initWithOrientation:(int)orientation deviceType:(BOOL)isIphone withFPS:(int)fps
{
    m_orientation = orientation;
    m_isIphone = isIphone;
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
    
    [[RenderCore sharedInstance] SetupOpenGL:m_glView.frame.size];
    
    // initial the render core
    [[RenderCore sharedInstance] Initial];
}


// frame update (HIFramework)
- (void)frame:(float)dt
{
    [[TaskManager sharedInstance] ProcessPending];
    
    //TODO  ui manager update
    [[TaskManager sharedInstance] Main:dt];
}


// render update (HIFramework)
- (void)rander:(float)dt
{
    [[RenderCore sharedInstance] Clear];
    
    [[TaskManager sharedInstance] Draw:dt];
    //TODO  ui render
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
    [[RenderCore sharedInstance] Render];
}


@end

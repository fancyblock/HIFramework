//
//  HIApp.m
//  HIFramework
//
//  Created by He jia bin on 5/18/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import "HIApp.h"
#import "RenderCore.h"
#import "TaskManager.h"
#import "UIManager.h"


@interface HIApp(private)

- (void)setupOpenGL;
- (void)frame:(float)dt;
- (void)render:(float)dt;

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
    
    CGRect frame = CGRectMake( 0, 0, 0, 0 );
    if( m_orientation == ORIENTATION_LANDSCAPE )
    {
        if( m_deviceType == DEVICE_IPHONE )
        {
            frame = CGRectMake( 0, 0, IPHONE_SCREEN_HEIGHT, IPHONE_SCREEN_WIDTH );
        }
        
        if( m_deviceType == DEVICE_IPAD )
        {
            frame = CGRectMake( 0, 0, IPAD_SCREEN_HEIGHT, IPAD_SCREEN_WIDTH );
        }
    }
    
    if( m_orientation == ORIENTATION_PORTRAIT )
    {
        if( m_deviceType == DEVICE_IPHONE )
        {
            frame = CGRectMake( 0, 0, IPHONE_SCREEN_WIDTH, IPHONE_SCREEN_HEIGHT );
        }
        
        if( m_deviceType == DEVICE_IPAD )
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
        m_glViewController.CUR_ORIENTATION_SIDE1 = UIInterfaceOrientationLandscapeLeft;
        m_glViewController.CUR_ORIENTATION_SIDE2 = UIInterfaceOrientationLandscapeRight;
    }
    if( m_orientation == ORIENTATION_PORTRAIT )
    {
        m_glViewController.CUR_ORIENTATION_SIDE1 = UIInterfaceOrientationPortrait;
        m_glViewController.CUR_ORIENTATION_SIDE2 = UIInterfaceOrientationPortraitUpsideDown;
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
- (id)initWithOrientation:(int)orientation deviceType:(int)type withFPS:(int)fps
{
    m_orientation = orientation;
    m_deviceType = type;
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
    [m_glViewController release];
    [m_glView release];
    [m_glContext release];
    
    [super dealloc];
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
    
    [[UIManager sharedInstance] UIMain:dt];
    [[TaskManager sharedInstance] Main:dt];
}


// render update (HIFramework)
- (void)render:(float)dt
{
    [[RenderCore sharedInstance] Clear];
    
    [[TaskManager sharedInstance] Draw:dt];
    [[UIManager sharedInstance] UIDraw:dt];
}


/*
 Required method for implementing GLKViewControllerDelegate. This update method variant should be used
 when not subclassing GLKViewController. This method will not be called if the GLKViewController object
 has been subclassed and implements -(void)update.
 */
- (void)glkViewControllerUpdate:(GLKViewController *)controller
{
    [self frame:0.033f];          //[TEMP]    elapse time calculation unfinish
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
    [self render:0.0f];         //[TEMP]     elapse time calculation unfinish
    
    [[RenderCore sharedInstance] Render];
}


@end

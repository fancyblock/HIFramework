//
//  GLController.m
//  HIFramework
//
//  Created by He JiaBin on 12-6-30.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "GLController.h"
#import "UIManager.h"
#import "TaskManager.h"


@interface GLController (private)

- (void)injectTouches:(NSSet*)touches withType:(int)type;

@end

@implementation GLController

@synthesize CUR_ORIENTATION_SIDE1;
@synthesize CUR_ORIENTATION_SIDE2;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ( interfaceOrientation == self.CUR_ORIENTATION_SIDE1 ||
             interfaceOrientation == self.CUR_ORIENTATION_SIDE2 );
}


//-------------------------------------- private functions -------------------------------------


// inject the touch events to the ui system & task system
- (void)injectTouches:(NSSet*)touches withType:(int)type
{
    NSArray* touchList = [touches allObjects];
    NSMutableArray* hiTouchList = [[NSMutableArray alloc] init];
    
    TouchEvent* evt = nil;
    int count = [touchList count];
    for( int i = 0; i < count; i++ )
    {
        evt = [[TouchEvent alloc] init];
        
        UITouch* touch = [touchList objectAtIndex:i];
        CGPoint pt = [touch locationInView:self.view];
        
        evt.X = pt.x;
        evt.Y = pt.y;
        evt.TOUCH_TYPE = type;
        
        [hiTouchList addObject:evt];
        [evt release];
    }
    
    if( [[UIManager sharedInstance] onTouchEvent:hiTouchList] == NO )
    {
        [[TaskManager sharedInstance] onTouchEvent:hiTouchList];
    }
    
    [hiTouchList removeAllObjects];
    [hiTouchList release];
}


//---------------------------------------- touch events ----------------------------------------


// touch begin
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self injectTouches:touches withType:TOUCH];
}


// touch moved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self injectTouches:touches withType:MOVE];
}


// touch ended
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self injectTouches:touches withType:UNTOUCH];
}


// touch cancelled
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TODO 
}


@end

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

- (void)injectTouches:(NSMutableArray*)touches;

@end

@implementation GLController

@synthesize CUR_ORIENTATION;

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
    return (interfaceOrientation == self.CUR_ORIENTATION);
}


//-------------------------------------- private functions -------------------------------------


// inject the touch events to the ui system & task system
- (void)injectTouches:(NSMutableArray*)touches
{
    if( [[UIManager sharedInstance] onTouchEvent:touches] == NO )
    {
        [[TaskManager sharedInstance] onTouchEvent:touches];
    }
    
    [touches removeAllObjects];
    [touches release];
}


//---------------------------------------- touch events ----------------------------------------


// touch begin
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
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
        evt.TOUCH_TYPE = TOUCH;
        
        [hiTouchList addObject:evt];
    }
    
    [self injectTouches:hiTouchList];
}


// touch moved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TODO 
}


// touch ended
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TODO 
}


// touch cancelled
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TODO 
}


@end

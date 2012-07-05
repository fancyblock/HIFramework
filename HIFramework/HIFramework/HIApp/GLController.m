//
//  GLController.m
//  HIFramework
//
//  Created by He JiaBin on 12-6-30.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "GLController.h"

@interface GLController ()

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

@end

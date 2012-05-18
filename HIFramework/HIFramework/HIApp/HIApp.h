//
//  HIApp.h
//  HIFramework
//
//  Created by He jia bin on 5/18/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLKit/GLKit.h"
#import "HIFDefines.h"

// app delegate
@protocol HIAppDelegate <NSObject>

- (void)GameCreate;
- (void)GameDestory;

@end


@interface HIApp : NSObject<GLKViewControllerDelegate, GLKViewDelegate>
{
    // for OpenGL
    GLKViewController* m_glViewController;
    GLKView* m_glView;
    EAGLContext* m_glContext;
    
    int m_orientation;
    int m_fps;
    
    id<HIAppDelegate> m_delegate;
}

@property (nonatomic, retain)GLKViewController* viewController;
@property (nonatomic, retain)id<HIAppDelegate> delegate;


- (id)initWithOrientation:(int)orientation withFPS:(int)fps;

@end

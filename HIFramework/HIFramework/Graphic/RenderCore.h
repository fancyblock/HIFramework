//
//  RenderCore.h
//  HIFramework
//
//  Created by He JiaBin on 12-6-18.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLKit/GLKit.h"
#import "../HIApp/HIFDefines.h"


#define HI_OGL_VERSION  kEAGLRenderingAPIOpenGLES1



@interface RenderCore : NSObject
{
    GLfloat* m_vertexBuffer;
    GLfloat* m_colorBuffer;
    GLfloat* m_textCoordBuffer;
    GLushort* m_indexBuffer;
    
    GLuint* m_textures;
}

+ (RenderCore*)sharedInstance;

- (void)SetupOpenGL:(CGSize)size;
- (void)Initial;
- (void)Destory;
- (void)Render;


@end

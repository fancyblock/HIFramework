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
#import "Sprite.h"


#define HI_OGL_VERSION  kEAGLRenderingAPIOpenGLES1


// texture info struct
@interface TextureInfo : NSObject

@property (nonatomic, readwrite) int INDEX;
@property (nonatomic, readwrite) int WIDTH;
@property (nonatomic, readwrite) int HEIGHT;

@end

// render chunk struct
@interface RenderChunk : NSObject

@property (nonatomic, readwrite) int TEXTURE_INDEX;
@property (nonatomic, readwrite) struct CGColor COLOR;
@property (nonatomic, readwrite) int INDEX_OFFSET;
@property (nonatomic, readwrite) int VERTEX_NUM;

@end


@interface RenderCore : NSObject
{
    GLfloat* m_vertexBuffer;
    GLfloat* m_textCoordBuffer;
    GLushort* m_indexBuffer;
    
    GLuint* m_textures;
    int m_textureCount;
    NSMutableDictionary* m_textureDic;
}

+ (RenderCore*)sharedInstance;

- (void)SetupOpenGL:(CGSize)size;
- (void)Initial;
- (void)Destory;
- (void)Render;
- (void)Clear;

- (BOOL)CreateTexture:(NSString*)picName;
- (BOOL)IsTextureExist:(NSString*)picName;
- (void)AddSprite:(Sprite*)spr;


@end

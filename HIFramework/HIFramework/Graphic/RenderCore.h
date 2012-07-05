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
#define NO_TEXTURE      -1
#define INIT_TEXTURE    -2


// texture info struct
@interface TextureInfo : NSObject

@property (nonatomic, readwrite) int INDEX;
@property (nonatomic, readwrite) int WIDTH;
@property (nonatomic, readwrite) int HEIGHT;

@end

// render chunk struct
@interface RenderChunk : NSObject

@property (nonatomic, readwrite) int TEXTURE_INDEX;
@property (nonatomic, readwrite) float COLOR_R;
@property (nonatomic, readwrite) float COLOR_G;
@property (nonatomic, readwrite) float COLOR_B;
@property (nonatomic, readwrite) float COLOR_A;
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
    
    int m_curTextureIndex;
    float m_curColorR;
    float m_curColorG;
    float m_curColorB;
    float m_curColorA;
    int m_curRenderChunkIndex;
    int m_renderChunkCnt;
    int m_spriteNum;
    NSMutableArray* m_renderChunks;
    float m_curDepth;
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

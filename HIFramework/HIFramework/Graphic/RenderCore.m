//
//  RenderCore.m
//  HIFramework
//
//  Created by He JiaBin on 12-6-18.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "RenderCore.h"

#define COORD_PER_VERTEX    3
#define COORD_PER_UV        2
#define COORD_PER_COLOR     4

#define MAX_VERTEX_NUM      1024
#define MAX_INDEX_NUM       2048
#define MAX_TEXTURE_NUM     32

#define Z_DEPTH             100.0f


@implementation TextureInfo

@synthesize INDEX;
@synthesize WIDTH;
@synthesize HEIGHT;

@end


@implementation RenderChunk

@synthesize TEXTURE_INDEX;
@synthesize COLOR_R;
@synthesize COLOR_G;
@synthesize COLOR_B;
@synthesize COLOR_A;
@synthesize INDEX_OFFSET;
@synthesize VERTEX_NUM;

@end


@interface RenderCore(private)

//TODO 

@end


@implementation RenderCore

static RenderCore* m_instance;
static BOOL m_safeFlag = NO;


/**
 * @desc    return the singleton of this class
 * @para    none
 * @return  the singleton
 */
+ (RenderCore*)sharedInstance
{
    if( m_instance == nil )
    {
        m_safeFlag = YES;
        m_instance = [[RenderCore alloc] init];
        m_safeFlag = NO;
    }
    
    return m_instance;
}


/**
 * @desc    constructor
 * @para    none
 * @return  self
 */
+ (id)alloc
{
    if( m_safeFlag == NO )
    {
        NSException* exception = [NSException exceptionWithName:@"Alloc Error" reason:@"RenderCore is a singleton , can not be alloc directly" userInfo:nil];
        @throw exception;
        
        return nil;
    }
    
    return [super alloc];
}


/**
 * @desc    setup the openGL
 * @para    size    viewport region
 * @return  none
 */
- (void)SetupOpenGL:(CGSize)size
{
    // set view port
    glViewport( 0, 0, size.width, size.height );
    
    // set projection type
    glMatrixMode( GL_PROJECTION );
    glLoadIdentity();
    glOrthof( 0, size.width - 1, size.height - 1, 0, 0, Z_DEPTH );
    
    // reset model view matrix
    glMatrixMode( GL_MODELVIEW );
    glLoadIdentity();
    
    // set the clear color
    glClearColor( 0.0f, 0.0f, 0.0f, 1 );
    
    // OpenGL settings
    /////////////////////
    
    // shade model
    glShadeModel( GL_FLAT );
    // back face cull
    glEnable( GL_CULL_FACE );
    glFrontFace( GL_CW );
    glCullFace( GL_BACK );
    
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_TEXTURE_2D );
    glEnable( GL_BLEND );
    glEnable( GL_ALPHA_TEST );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    //glEnable( GL_COLOR_LOGIC_OP );
    
    glEnableClientState( GL_VERTEX_ARRAY );
    glEnableClientState( GL_TEXTURE_COORD_ARRAY );
    
    glActiveTexture( GL_TEXTURE0 );
}


/**
 * @desc    alloc the memory for the buffers ( vertex, index, uv )
 * @para    none
 * @return  none
 */
- (void)Initial
{
    // create all the buffers
    m_vertexBuffer = (GLfloat*)malloc( MAX_VERTEX_NUM * COORD_PER_VERTEX * sizeof(GLfloat) );
    m_indexBuffer = (GLushort*)malloc( MAX_INDEX_NUM * sizeof(GLushort) );
    m_textCoordBuffer = (GLfloat*)malloc( MAX_VERTEX_NUM * COORD_PER_UV * sizeof(GLfloat) );
    
    // create textures
    m_textures = (GLuint*)malloc( MAX_TEXTURE_NUM * sizeof( GLuint ) );
    glGenTextures( MAX_TEXTURE_NUM, m_textures );
    m_textureCount = 0;
    m_textureDic = [[NSMutableDictionary alloc] initWithCapacity:MAX_TEXTURE_NUM];
    
    // init render info
    m_renderChunks = [[NSMutableArray alloc] init];
    //TODO 
    
    [self CreateTexture:@"nackm.png"];
}


/**
 * @desc    release all the resource ( dealloc the vars )
 * @para    none
 * @return  none
 */
- (void)Destory
{
    free( m_vertexBuffer );
    free( m_indexBuffer );
    free( m_textCoordBuffer );
    
    glDeleteTextures( MAX_TEXTURE_NUM, m_textures );
    free( m_textures );
    [m_textureDic removeAllObjects];
    [m_textureDic release];
}


/**
 * @desc    openGL render
 * @para    none
 * @return  none
 */
- (void)Render
{
    glClear( GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT );
    
    //TODO 
    
    //[TEMP]
    glMatrixMode( GL_MODELVIEW );
    glLoadIdentity();
    
    float dep = -22.0f;
    m_vertexBuffer[0] = 10.0f; m_vertexBuffer[1] = 10.0f; m_vertexBuffer[2] = dep;
    m_vertexBuffer[3] = 200.0f; m_vertexBuffer[4] = 10.0f; m_vertexBuffer[5] = dep;
    m_vertexBuffer[6] = 200.0f; m_vertexBuffer[7] = 200.0f; m_vertexBuffer[8] = dep;
    m_vertexBuffer[9] = 10.0f; m_vertexBuffer[10] = 200.0f; m_vertexBuffer[11] = dep;
    
    m_indexBuffer[0] = 0; m_indexBuffer[1] = 1; m_indexBuffer[2] = 2;
    m_indexBuffer[3] = 0; m_indexBuffer[4] = 2; m_indexBuffer[5] = 3;
    
    m_textCoordBuffer[0] = 0.0f; m_textCoordBuffer[1] = 0.0f;
    m_textCoordBuffer[2] = 1.0f; m_textCoordBuffer[3] = 0.0f;
    m_textCoordBuffer[4] = 1.0f; m_textCoordBuffer[5] = 1.0f;
    m_textCoordBuffer[6] = 0.0f; m_textCoordBuffer[7] = 1.0f;
    
    glColor4f( 1.0f, 1.0f, 1.0f, 1.0f );
    
    glBindTexture( GL_TEXTURE_2D, m_textures[0] );
    
    glVertexPointer( COORD_PER_VERTEX, GL_FLOAT, 0, m_vertexBuffer );
    glTexCoordPointer( COORD_PER_UV, GL_FLOAT, 0, m_textCoordBuffer );
    glDrawElements( GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, (GLvoid*)m_indexBuffer );
    
    glColor4f( 1.0f, 0.1f, 0.5f, 1.0f );
    glMatrixMode( GL_MODELVIEW );
    glTranslatef( 80, 80, 0 );
    glDrawElements( GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, (GLvoid*)m_indexBuffer );
    
    //[TEMP]
    
    glFlush();
}


/**
 * @desc    clear the render info from last frame
 * @para    none
 * @return  none
 */
- (void)Clear
{
    m_curColorR = 1.0f;
    m_curColorG = 1.0f;
    m_curColorB = 1.0f;
    m_curColorA = 1.0f;
    
    m_curTextureIndex = INIT_TEXTURE;
    
    [m_renderChunks removeAllObjects];
    m_renderChunkCnt = 0;
    
    m_spriteNum = 0;
    m_curRenderChunkIndex = -1;
}


/**
 * @desc    add a sprite to the render chunk
 * @para    spr
 * @return  none
 */
- (void)AddSprite:(Sprite*)spr
{
    //TODO 
}


/**
 * @desc    create a OpenGL texture
 * @para    image name ( already in app main bundle )
 * @return  success or fail
 */
- (BOOL)CreateTexture:(NSString*)picName
{
    if( m_textureCount >= MAX_TEXTURE_NUM )
    {
        return NO;
    }
    
    glBindTexture( GL_TEXTURE_2D, m_textures[m_textureCount] );
    
    // get the image
    UIImage* pic = [UIImage imageNamed:picName];
    CGSize size = pic.size;
    
    // judge if the size can be use for OpenGL
    //TODO 
    
    GLubyte* buff = (GLubyte*)malloc( size.width * size.height * 4 );
    CGContextRef imageContext = CGBitmapContextCreate( buff, size.width, size.height, 8, size.width * 4, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(imageContext, CGRectMake(0.0, 0.0, size.width, size.height), pic.CGImage);
    CGContextRelease(imageContext); 
    
    glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, size.width, size.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, buff );
    free( buff );
    
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );

    // add to textures dictionary
    TextureInfo* texInfo = [[TextureInfo alloc] init];
    texInfo.WIDTH = size.width;
    texInfo.HEIGHT = size.height;
    texInfo.INDEX = m_textureCount;
    [m_textureDic setObject:texInfo forKey:picName];
    
    m_textureCount++;
    
    return YES;
}


/**
 * @desc    judge if the texture exist
 * @para    picName
 * @return  YES or NO
 */
- (BOOL)IsTextureExist:(NSString*)picName
{
    TextureInfo* texInfo = [m_textureDic objectForKey:picName];
    
    if( texInfo != nil )
    {
        return YES;
    }
    
    return NO;
}


//------------------------------- private function -------------------------------


//TODO 


@end

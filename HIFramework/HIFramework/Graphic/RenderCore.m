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
#define Z_STEP              0.1f
#define INIT_Z_VAL          -99.9f      // magic number


@implementation TextureInfo

@synthesize INDEX;
@synthesize WIDTH;
@synthesize HEIGHT;

@end


@implementation RenderChunk

@synthesize TEXTURE_INDEX;
@synthesize INDEX_OFFSET;
@synthesize VERTEX_NUM;

@end


@interface RenderCore(private)

- (BOOL)isImgSizeLegal:(CGSize)size;
- (UIImage*)reviseImage:(UIImage*)img scaleBigger:(BOOL)bigger;

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
    glOrthof( 0, size.width, size.height, 0, 0, Z_DEPTH );
    
    // reset model view matrix
    glMatrixMode( GL_MODELVIEW );
    glLoadIdentity();
    
    // set the clear color
    glClearColor( 0.0f, 0.0f, 0.0f, 1 );
    
    glClearDepthf( Z_DEPTH );
    
    // OpenGL settings
    /////////////////////
    
    // shade model
    glShadeModel( GL_FLAT );
    // back face cull
    glDisable( GL_CULL_FACE );
    
    glEnable( GL_DEPTH_TEST );
    glEnable( GL_TEXTURE_2D );
    glEnable( GL_BLEND );
    glEnable( GL_ALPHA_TEST );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    
    glEnableClientState( GL_VERTEX_ARRAY );
    glEnableClientState( GL_TEXTURE_COORD_ARRAY );
    glEnableClientState( GL_COLOR_ARRAY );
    
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
    m_colorBuffer = (GLfloat*)malloc( MAX_VERTEX_NUM * COORD_PER_COLOR * sizeof(GLfloat) );
    
    // create textures
    m_textures = (GLuint*)malloc( MAX_TEXTURE_NUM * sizeof( GLuint ) );
    glGenTextures( MAX_TEXTURE_NUM, m_textures );
    m_textureCount = 0;
    m_textureDic = [[NSMutableDictionary alloc] initWithCapacity:MAX_TEXTURE_NUM];
    
    // init render info
    m_renderChunks = [[NSMutableArray alloc] init];
    //TODO 
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
    free( m_colorBuffer );
    
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
    
    // set buffer
    glVertexPointer( COORD_PER_VERTEX, GL_FLOAT, 0, m_vertexBuffer );
    glTexCoordPointer( COORD_PER_UV, GL_FLOAT, 0, m_textCoordBuffer );
    glColorPointer( COORD_PER_COLOR, GL_FLOAT, 0, m_colorBuffer );
    
    int count = [m_renderChunks count];
    RenderChunk* chunk = nil;
    
    // draw all the chunks
    for( int i = 0; i < count; i++ )
    {
        chunk = [m_renderChunks objectAtIndex:i];
        
        glBindTexture( GL_TEXTURE_2D, m_textures[chunk.TEXTURE_INDEX] );
        glDrawElements( GL_TRIANGLES, chunk.VERTEX_NUM, GL_UNSIGNED_SHORT, (GLvoid*)&m_indexBuffer[chunk.INDEX_OFFSET] );
    }
    
    glFlush();
}


/**
 * @desc    clear the render info from last frame
 * @para    none
 * @return  none
 */
- (void)Clear
{
    m_curTextureIndex = INIT_TEXTURE;
    
    [m_renderChunks removeAllObjects];
    
    m_curIndexOffset = 0;
    m_curVertexOffset = 0;
    m_curUVOffset = 0;
    m_curColorOffset = 0;
    m_curDepth = INIT_Z_VAL;
}


/**
 * @desc    add a sprite to the render chunk
 * @para    spr
 * @return  none
 */
- (void)AddSprite:(Sprite*)spr
{
    int texIdx = spr.TEXTURE_INDEX;
    RenderChunk* rc = nil;
    
    if( texIdx != m_curTextureIndex )
    {
        rc = [[RenderChunk alloc] init];
        rc.TEXTURE_INDEX = texIdx;
        rc.INDEX_OFFSET = m_curIndexOffset;
        rc.VERTEX_NUM = 0;
        
        m_curTextureIndex = texIdx;
        [m_renderChunks addObject:rc];
        
        [rc release];
    }
    
    int idxStart = m_curVertexOffset / 3;
    
    // set the indexes
    m_indexBuffer[m_curIndexOffset++] = idxStart;
    m_indexBuffer[m_curIndexOffset++] = idxStart + 1;
    m_indexBuffer[m_curIndexOffset++] = idxStart + 2;
    
    m_indexBuffer[m_curIndexOffset++] = idxStart;
    m_indexBuffer[m_curIndexOffset++] = idxStart + 2;
    m_indexBuffer[m_curIndexOffset++] = idxStart + 3;
    
    // set the vertexs
    m_vertexBuffer[m_curVertexOffset++] = spr.X1;
    m_vertexBuffer[m_curVertexOffset++] = spr.Y1;
    m_vertexBuffer[m_curVertexOffset++] = m_curDepth;
    
    m_vertexBuffer[m_curVertexOffset++] = spr.X2;
    m_vertexBuffer[m_curVertexOffset++] = spr.Y2;
    m_vertexBuffer[m_curVertexOffset++] = m_curDepth;
    
    m_vertexBuffer[m_curVertexOffset++] = spr.X3;
    m_vertexBuffer[m_curVertexOffset++] = spr.Y3;
    m_vertexBuffer[m_curVertexOffset++] = m_curDepth;
    
    m_vertexBuffer[m_curVertexOffset++] = spr.X4;
    m_vertexBuffer[m_curVertexOffset++] = spr.Y4;
    m_vertexBuffer[m_curVertexOffset++] = m_curDepth;
    
    // set the uv
    m_textCoordBuffer[m_curUVOffset++] = spr.U1;
    m_textCoordBuffer[m_curUVOffset++] = spr.V1;
    
    m_textCoordBuffer[m_curUVOffset++] = spr.U2;
    m_textCoordBuffer[m_curUVOffset++] = spr.V1;
    
    m_textCoordBuffer[m_curUVOffset++] = spr.U2;
    m_textCoordBuffer[m_curUVOffset++] = spr.V2;
    
    m_textCoordBuffer[m_curUVOffset++] = spr.U1;
    m_textCoordBuffer[m_curUVOffset++] = spr.V2;
    
    // set the color
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_R;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_G;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_B;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_A;
    
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_R;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_G;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_B;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_A;
    
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_R;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_G;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_B;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_A;
    
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_R;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_G;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_B;
    m_colorBuffer[m_curColorOffset++] = spr.COLOR_A;
    
    rc = [m_renderChunks lastObject];
    rc.VERTEX_NUM += 6;                     // each facet contain two trangles ( 6 indexes )
    
    m_curDepth += Z_STEP;
    
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
    
    // if the bitmap size if fit to OpenGL texture size ( 2^N x 2^N )
    if( [self isImgSizeLegal:size] == NO )
    {
        UIImage* newPic = [self reviseImage:pic scaleBigger:YES];
        [pic release];
        pic = newPic;
        size = pic.size;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    GLubyte* buff = (GLubyte*)malloc( size.width * size.height * 4 );
    memset( buff, 0, size.width * size.height * 4 );
    CGContextRef imageContext = CGBitmapContextCreate( buff, size.width, size.height, 8, size.width * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(imageContext, CGRectMake(0.0, 0.0, size.width, size.height), pic.CGImage);
    CGContextRelease(imageContext); 
    
    glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, size.width, size.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, buff );
    free( buff );
    CGColorSpaceRelease( colorSpace );
    
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );

    // add to textures dictionary
    TextureInfo* texInfo = [[TextureInfo alloc] init];
    texInfo.WIDTH = size.width;
    texInfo.HEIGHT = size.height;
    texInfo.INDEX = m_textureCount;
    [m_textureDic setObject:texInfo forKey:picName];
    
    [texInfo release];
    
    m_textureCount++;
    
    glBindTexture( GL_TEXTURE_2D, 0 );
    
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


/**
 * @desc    return the texture info 
 * @para    picName 
 * @return  texture info struct
 */
- (TextureInfo*)GetTextureInfo:(NSString*)picName
{
    TextureInfo* texInfo = [m_textureDic objectForKey:picName];
    
    return texInfo;
}


/**
 * @desc    clean all the textures and release memory
 * @para    none
 * @return  none
 */
- (void)CleanTextures
{
    glBindTexture( GL_TEXTURE_2D, 0 );
    
    glDeleteTextures( MAX_TEXTURE_NUM, m_textures );
    free( m_textures );
    [m_textureDic removeAllObjects];
    [m_textureDic release];
    
    m_textures = (GLuint*)malloc( MAX_TEXTURE_NUM * sizeof( GLuint ) );
    glGenTextures( MAX_TEXTURE_NUM, m_textures );
    m_textureCount = 0;
    m_textureDic = [[NSMutableDictionary alloc] initWithCapacity:MAX_TEXTURE_NUM];
    
    glGenTextures( MAX_TEXTURE_NUM, m_textures );
}


//------------------------------------------ private function ------------------------------------------


// check the size of the bitmap is legal or not ( if the number of width | height is pow of 2 or not )
- (BOOL)isImgSizeLegal:(CGSize)size
{
    int wid = size.width;
    int hei = size.height;
    
    return ( ( wid & ( wid - 1 ) ) == 0 ) && ( ( hei & ( hei - 1 ) ) == 0 );
}


// scale the bitmap make it to the correct size for OpenGL
- (UIImage*)reviseImage:(UIImage*)img scaleBigger:(BOOL)bigger
{
    UIImage* newImg = nil;
    
    int size = img.size.width > img.size.height ? img.size.width : img.size.height;
    
    int sizeList[] = { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048 };
    int listLen = sizeof( sizeList ) / sizeof(int);
    int i;
    int newSize = -1;
    
    // calculate the new size
    if( bigger == YES )
    {
        for( i = 0; i < listLen; i++ )
        {
            if( sizeList[i] >= size )
            {
                newSize = sizeList[i];
                break;
            }
        }
    }
    
    if( bigger == NO )
    {
        for( i = 0; i < listLen; i++ )
        {
            if( sizeList[i] > size )
            {
                newSize = sizeList[i-1];
                break;
            }
        }
    }
    
    // draw the image with the new size
    UIGraphicsBeginImageContext( CGSizeMake( newSize, newSize ) );
    [img drawInRect:CGRectMake( 0, 0, newSize, newSize )];
    newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImg;
}


@end

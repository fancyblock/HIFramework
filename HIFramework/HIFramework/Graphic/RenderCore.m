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
    
    // set the clear depth
    glClearDepthf( 1 );
    
    // OpenGL settings
    /////////////////////
    
    // shade model
    glShadeModel( GL_FLAT );
    // back face cull
    glEnable( GL_CULL_FACE );
    glFrontFace( GL_CW );
    glCullFace( GL_BACK );
    
    glEnable( GL_DEPTH_TEST );
    glEnable( GL_TEXTURE_2D );
    glEnable( GL_BLEND );
    glEnable( GL_ALPHA_TEST );
    glEnable( GL_COLOR_LOGIC_OP );
    
    glEnableClientState( GL_VERTEX_ARRAY );
    //glEnableClientState( GL_COLOR_ARRAY );
    glEnableClientState( GL_TEXTURE_COORD_ARRAY );
    
    glActiveTexture( GL_TEXTURE0 );
    
    glEnable( GL_BLEND );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
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
    m_colorBuffer = (GLfloat*)malloc( MAX_VERTEX_NUM * COORD_PER_COLOR * sizeof(GLfloat) );
    m_textCoordBuffer = (GLfloat*)malloc( MAX_VERTEX_NUM * COORD_PER_UV * sizeof(GLfloat) );
    
    // create textures
    m_textures = (GLuint*)malloc( MAX_TEXTURE_NUM * sizeof( GLuint ) );
    glGenTextures( MAX_TEXTURE_NUM, m_textures );
    
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
    free( m_colorBuffer );
    free( m_textCoordBuffer );
    
    glDeleteTextures( MAX_TEXTURE_NUM, m_textures );
    free( m_textures );
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
    m_vertexBuffer[0] = 10.0f; m_vertexBuffer[1] = 10.0f; m_vertexBuffer[2] = 0.0f;
    m_vertexBuffer[3] = 100.0f; m_vertexBuffer[4] = 10.0f; m_vertexBuffer[5] = 0.0f;
    m_vertexBuffer[6] = 100.0f; m_vertexBuffer[7] = 100.0f; m_vertexBuffer[8] = 0.0f;
    m_vertexBuffer[9] = 10.0f; m_vertexBuffer[10] = 100.0f; m_vertexBuffer[11] = 0.0f;
    
    m_indexBuffer[0] = 0; m_indexBuffer[1] = 1; m_indexBuffer[2] = 2;
    m_indexBuffer[3] = 0; m_indexBuffer[4] = 2; m_indexBuffer[5] = 3;
    
    m_colorBuffer[0] = 1.0f; m_colorBuffer[1] = 0.0f; m_colorBuffer[2] = 0.5f; m_colorBuffer[3] = 1.0f;
    m_colorBuffer[4] = 1.0f; m_colorBuffer[5] = 0.0f; m_colorBuffer[6] = 0.5f; m_colorBuffer[7] = 1.0f;
    m_colorBuffer[8] = 1.0f; m_colorBuffer[9] = 0.0f; m_colorBuffer[10] = 0.5f; m_colorBuffer[11] = 1.0f;
    m_colorBuffer[12] = 1.0f; m_colorBuffer[13] = 0.0f; m_colorBuffer[14] = 0.5f; m_colorBuffer[15] = 1.0f;
    
    m_textCoordBuffer[0] = 0.0f; m_textCoordBuffer[1] = 0.0f;
    m_textCoordBuffer[2] = 1.0f; m_textCoordBuffer[3] = 0.0f;
    m_textCoordBuffer[4] = 1.0f; m_textCoordBuffer[5] = 1.0f;
    m_textCoordBuffer[6] = 0.0f; m_textCoordBuffer[7] = 1.0f;
    
    glColor4f( 0.0f, 1.0f, 0.5f, 1.0f );
    
    // texture
    glBindTexture( GL_TEXTURE_2D, m_textures[0] );
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, 64, 64, 0, GL_RGBA, GL_UNSIGNED_SHORT_4_4_4_4, 0 );
    
    glVertexPointer( COORD_PER_VERTEX, GL_FLOAT, 0, m_vertexBuffer );
    //glColorPointer( COORD_PER_COLOR, GL_FLOAT, 0, m_colorBuffer );
    glTexCoordPointer( COORD_PER_UV, GL_UNSIGNED_SHORT, 0, m_textCoordBuffer );
    glDrawElements( GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, (GLvoid*)m_indexBuffer );
    //[TEMP]
    
    glFlush();
}


@end

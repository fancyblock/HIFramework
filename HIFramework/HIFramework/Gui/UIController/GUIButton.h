//
//  GUIButton.h
//  HIFramework
//
//  Created by He JiaBin on 12-7-21.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "UIWidget.h"
#import "Sprite.h"
#import "GraphicFactory.h"

@class GUIButton;

@protocol IButtonCallback <NSObject>

- (void)onButtonDown:(GUIButton*)btn;
- (void)onButtonUp:(GUIButton*)btn;
- (void)onButtonClick:(GUIButton*)btn;

@end


@interface GUIButton : UIWidget
{
    id<IButtonCallback> m_callback;
    BOOL m_isDown;
    BOOL m_tracking;
    
    Sprite* m_imgUp;
    Sprite* m_imgDown;
    Sprite* m_imgDisable;
}

@property (nonatomic, readonly) BOOL IsDown;


- (id)initWithRes:(NSString*)imgName;

- (void)SetUpUVFrom:(CGPoint)uvLeftTop to:(CGPoint)uvRightDown;

- (void)SetDownUVFrom:(CGPoint)uvLeftTop to:(CGPoint)uvRightDown;

- (void)SetDisableUVFrom:(CGPoint)uvLeftTop to:(CGPoint)uvRightDown;

- (void)SetCallback:(id<IButtonCallback>)callback;

@end

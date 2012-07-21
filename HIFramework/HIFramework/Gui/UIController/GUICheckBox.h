//
//  GUICheckBox.h
//  HIFramework
//
//  Created by He JiaBin on 12-7-21.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "UIWidget.h"
#import "Sprite.h"

@class GUICheckBox;

@protocol ICheckBoxCallback <NSObject>

- (void)onCheckBoxCheck:(GUICheckBox*)checkbox;

@end


@interface GUICheckBox : UIWidget
{
    id<ICheckBoxCallback> m_callback;
    BOOL m_isChecked;
    
    Sprite* m_imgChecked;
    Sprite* m_imgUnChecked;
}

@property (nonatomic, readwrite) BOOL CHECKED;


- (id)initWithRes:(NSString*)imgName;

- (void)SetCheckedUVFrom:(CGPoint)uvLeftTop to:(CGPoint)uvRightDown;

- (void)SetUnCheckedUVFrom:(CGPoint)uvLeftTop to:(CGPoint)uvRightDown;

- (void)SetCallback:(id<ICheckBoxCallback>)callback;

@end

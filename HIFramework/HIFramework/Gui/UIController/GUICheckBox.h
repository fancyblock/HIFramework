//
//  GUICheckBox.h
//  HIFramework
//
//  Created by He JiaBin on 12-7-21.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "UIWidget.h"

@class GUICheckBox;

@protocol ICheckBoxCallback <NSObject>

- (void)onCheckBoxCheck:(GUICheckBox*)checkbox;

@end


@interface GUICheckBox : UIWidget
{
    //TODO 
}

@end

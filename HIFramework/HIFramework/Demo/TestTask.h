//
//  TestTask.h
//  HIFramework
//
//  Created by He JiaBin on 12-7-10.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "HIFramework.h"

@interface TestTask : Task<IButtonCallback>
{
    Sprite* m_spr;
    Sprite* m_spr2;
    Sprite* m_spr3;
    
    GUIButton* m_btn;
    GUICheckBox* m_cb;
    
    int m_soundId;
    int m_seId;
}

@end

//
//  KOSettingItem.m
//  MenuSettingViewDemo
//
//  Created by kino on 16/4/5.
//  Copyright © 2016年 kino. All rights reserved.
//

#import "KOSettingItem.h"

@implementation KOSettingItem

+ (instancetype) itemWithTitle:(NSString *)title
                          icon:(UIImage *)image{
    return [KOSettingItem itemWithTitle:title icon:image block:nil];
}

+ (instancetype) itemWithTitle:(NSString *)title
                          icon:(UIImage *)image
                          block:(void(^)())handle{
    KOSettingItem *item = [[self alloc] initWithTitle:title icon:image block:handle];
    return item;
}

- (instancetype)initWithTitle:(NSString *)title
                         icon:(UIImage *)image
                        block:(void(^)())handle{
    if (self = [super init]) {
        self.title = title;
        self.imageIcon = image;
        self.handleCallback = handle;
        self.itemHeight = 44;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        self.canSelectCell = YES;
    }
    return self;
}


+ (instancetype)itemBlankWithBackColor:(UIColor *)color{
    KOSettingItem *item = [[self alloc] initWithTitle:@"" icon:nil block:nil];
    item.backgroundColor = color;
    item.itemHeight = 20;
    item.accessoryType = UITableViewCellAccessoryNone;
    item.separatorInset = UIEdgeInsetsZero;
    item.canSelectCell = NO;
    return item;
}

@end

//
//  ViewController.m
//  MenuSettingViewDemo
//
//  Created by kino on 16/4/5.
//  Copyright © 2016年 kino. All rights reserved.
//

#import "ViewController.h"

#import "KOSettingItem.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *settingItems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    KOSettingItem *item1 = [KOSettingItem itemWithTitle:@"菜单1" icon:[UIImage imageNamed:@"Carrot"]];
    [item1 setHandleCallback:^{
        NSLog(@"点击菜单1");
    }];
    
    KOSettingItem *item2 = [KOSettingItem itemWithTitle:@"菜单2" icon:[UIImage imageNamed:@"Owl"]];
    item2.separatorInset = UIEdgeInsetsZero;
    [item2 setHandleCallback:^{
        NSLog(@"点击菜单2");
    }];
    
    KOSettingItem *item3 = [KOSettingItem itemWithTitle:@"菜单3" icon:[UIImage imageNamed:@"Rubber-Duck"]];
    item3.separatorInset = UIEdgeInsetsZero;
    item3.canSelectCell = NO;
    [item3 setCustomAccessoryView:^UIView *{
        UISwitch *someSwitch = [[UISwitch alloc] init];
        
        return someSwitch;
    }];
    [item3 setHandleCallback:^{
        NSLog(@"点击菜单3");
    }];
    
    KOSettingItem *item4 = [KOSettingItem itemWithTitle:@"菜单4" icon:[UIImage imageNamed:@"Snowman"]];
    [item4 setHandleCallback:^{
        NSLog(@"点击菜单4");
    }];
    
    KOSettingItem *blankItem = [KOSettingItem itemBlankWithBackColor:[UIColor groupTableViewBackgroundColor]];
    
    self.settingItems = @[item1, item2, blankItem, item3, blankItem, item4];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.settingItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KOSettingItem *item = self.settingItems[indexPath.row];
    return item.itemHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    
    KOSettingItem *item = self.settingItems[indexPath.row];
    cell.textLabel.text = item.title;
    
    cell.imageView.image = item.imageIcon;
    cell.accessoryType = item.accessoryType;
    
    cell.separatorInset = item.separatorInset;
    
    if (item.customAccessoryView) {
        cell.accessoryView = item.customAccessoryView();
    }else{
        cell.accessoryView = nil;
    }
    
    if (item.backgroundColor) {
        cell.contentView.backgroundColor = item.backgroundColor;
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    if (item.textColor) {
        cell.textLabel.textColor = item.textColor;
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    cell.userInteractionEnabled = item.canSelectCell;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KOSettingItem *item = self.settingItems[indexPath.row];
    if (item.handleCallback) {
        item.handleCallback();
    }
}


- (void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KOSettingItem *item = self.settingItems[indexPath.row];
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:item.separatorInset];
    }
}


@end

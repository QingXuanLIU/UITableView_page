//
//  ViewController.h
//  UITableView_page
//
//  Created by Mac on 13-6-26.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *myTableView;
    NSMutableArray *items;
}
@property(retain, nonatomic)IBOutlet UITableView *myTableView;

@end

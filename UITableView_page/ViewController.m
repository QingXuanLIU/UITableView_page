//
//  ViewController.m
//  UITableView_page
//
//  Created by Mac on 13-6-26.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    self.myTableView.dataSource=self;
    self.myTableView.delegate=self;
    items=[[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<10; i++) {
        [items addObject:[NSString stringWithFormat:@"cell %i",i]];
//        NSLog(@"%@",items);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = [items count];
//    NSLog(@"%d",[items count]);
    return  count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tag=@"tag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tag];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag] autorelease];
    }
    if([indexPath row] == ([items count])) {
        //创建loadMoreCell
        cell.textLabel.text=@"More..";
    }else {
        cell.textLabel.text=[items objectAtIndex:[indexPath row]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [items count]) {
        UITableViewCell *loadMoreCell=[tableView cellForRowAtIndexPath:indexPath];
        loadMoreCell.textLabel.text=@"loading more …";
        [self performSelectorInBackground:@selector(loadMore) withObject:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    //其他cell的事件
    
}
-(void)loadMore
{
    NSMutableArray *more;
    more=[[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<10; i++) {
        [more addObject:[NSString stringWithFormat:@"cell ++%i",i]];
    }
    //加载你的数据
    [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:NO];
    [more release];
}
-(void) appendTableWith:(NSMutableArray *)data
{
    for (int i=0;i<[data count];i++) {
        [items addObject:[data objectAtIndex:i]];
    }
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
    for (int ind = 0; ind < [data count]; ind++) {
        NSIndexPath *newPath =  [NSIndexPath indexPathForRow:[items indexOfObject:[data objectAtIndex:ind]] inSection:0];
        [insertIndexPaths addObject:newPath];
    }
    [self.myTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    
}
- (void)viewDidUnload {
    items=nil;
    self.myTableView=nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [self.myTableView release];
    [items release];
    [super dealloc];
}
@end
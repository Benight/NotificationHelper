//
//  ViewController.m
//  NotificationHelper
//
//  Created by 0o on 2017/12/14.
//  Copyright © 2017年 Benight. All rights reserved.
//

#import "ViewController.h"
#import "NotificationHelper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __weak typeof(self) weakSelf = self;
    [self addObserverForName:NotifyMsg_BPopANoti block:^(NSNotification * _Nullable note) {
        
        NSLog(@"%@,%@,%@",note.userInfo, note.object, note.name);
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.titleLabel.text = [NSString stringWithFormat:@"下一页传过来的值:%@",note.userInfo[@"title"]];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

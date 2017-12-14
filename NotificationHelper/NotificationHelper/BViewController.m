//
//  BViewController.m
//  NotificationHelper
//
//  Created by 0o on 2017/12/14.
//  Copyright © 2017年 Benight. All rights reserved.
//

#import "BViewController.h"
#import "NotificationHelper.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)processPopAction:(id)sender {
    
    [self postNotificationName:NotifyMsg_BPopANoti object:self userInfo:@{@"title":@"test1000000"}];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {

    NSLog(@"BViewController----dealloc");

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

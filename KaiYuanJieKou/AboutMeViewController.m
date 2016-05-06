//
//  AboutMeViewController.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/5/6.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)openMyGithub:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:GithubURL]];
}
- (IBAction)openMyJIanshu:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:MyJianShuURL]];
}
- (IBAction)returnToFront:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end

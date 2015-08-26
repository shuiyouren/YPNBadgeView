//
//  ViewController.m
//  CustomBadgeViewTest
//
//  Created by syr on 15/8/24.
//  Copyright (c) 2015年 syr. All rights reserved.
//

#import "ViewController.h"
#import "YPNBadgeView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet YPNBadgeView *badgeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(update:) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)update:(NSTimer *)timer {
    static int num = 0;
    self.badgeView.badgeAlignment = YPNBadgeAlignmentRight|YPNBadgeAlignmentTop;
    if (num > 100 && num < 300) {
        self.badgeView.badgeType = YPNBadgeTypePoint;
    }
    else {
        self.badgeView.badgeType = YPNBadgeTypeNumber;
    }
    self.badgeView.badgeText = [NSString stringWithFormat:@"%d", ++num];
    self.badgeView.badgeTextColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

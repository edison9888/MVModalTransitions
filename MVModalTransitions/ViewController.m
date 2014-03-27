//
//  ViewController.m
//  MVModalTransitions
//
//  Created by Andrea Bizzotto on 27/03/2014.
//  Copyright (c) 2014 musevisions. All rights reserved.
//

#import "ViewController.h"
#import "MVCustomAlertView.h"
#import "MVPickerAlertView.h"

@interface ViewController ()<MVCustomAlertViewClientDelegate>
- (IBAction)popupButtonPressed:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popupButtonPressed:(UIButton *)sender {


    MVPickerAlertView *picker = [[MVPickerAlertView alloc] initWithTitle:@"Find the intruder" values:@[ @"Apples", @"Oranges", @"Bananas", @"Monkeys" ] presentingViewController:self delegate:self];
    [picker show];

}

#pragma mark - MVCustomAlertViewClientDelegate
- (void)customAlertViewDidCancel:(MVCustomAlertView *)alertView {

}
- (void)customAlertViewDidConfirm:(MVCustomAlertView *)alertView {

}


@end

//
// Created by Andrea Bizzotto on 27/03/2014.
// Copyright (c) 2014 musevisions. All rights reserved.
//

#import "MVPickerAlertView.h"

@interface MVPickerAlertView ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property(strong, nonatomic) UIPickerView *pickerView;
@property(strong, nonatomic) NSArray *values;
@end

@implementation MVPickerAlertView

- (id)initWithTitle:(NSString *)title values:(NSArray *)values presentingViewController:(UIViewController *)presentingViewController delegate:(id)delegate {

    if ((self = [super initWithPresentingViewController:presentingViewController delegate:delegate])) {

        self.title = title;
        self.values = values;
        self.pickerView = [UIPickerView new];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.showsSelectionIndicator = YES;
    }
    return self;
}

- (UIView *)contentView
{
    [self cancelButtonTitle:@"Dismiss" confirmButtonTitle:@"OK"];
    return self.pickerView;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.values.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.values[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {

}

@end
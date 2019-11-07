//
//  MessageController.m
//  WriteALetter
//
//  Created by Apple on 27/02/19.
//  Copyright © 2019 Rajesh Shinde. All rights reserved.
//

#import "MessageController.h"

@interface MessageController ()
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) IBOutlet UILabel *msglabel;
@property (strong, nonatomic) IBOutlet UIButton *okbutton;

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mainView.layer.cornerRadius = 35;
    _mainView.layer.shadowColor = [UIColor grayColor].CGColor;
    _mainView.layer.shadowOffset = CGSizeMake(0, 0);
    _mainView.layer.shadowOpacity = 0.5;
    _mainView.layer.shadowRadius = 3;
    [self.navigationController setNavigationBarHidden:YES];
    
    _okbutton.layer.cornerRadius = 10;
    _okbutton.layer.shadowColor = [UIColor grayColor].CGColor;
    _okbutton.layer.shadowOffset = CGSizeMake(0, 0);
    _okbutton.layer.shadowOpacity = 0.5;
    _okbutton.layer.shadowRadius = 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - Button Action

- (IBAction)okAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

//
//  ViewController.m
//  WriteALetter
//
//  Created by Apple on 25/02/19.
//  Copyright © 2019 Rajesh Shinde. All rights reserved.
//

#import "ViewController.h"
#import "MailSendController.h"
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *draftBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _draftBtn.layer.cornerRadius = 15;
    _draftBtn.layer.shadowColor = [UIColor grayColor].CGColor;
    _draftBtn.layer.shadowOffset = CGSizeMake(0, 0);
    _draftBtn.layer.shadowOpacity = 0.5;
    _draftBtn.layer.shadowRadius = 3;
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)draftAction:(id)sender {
    MailSendController *maView = [self.storyboard instantiateViewControllerWithIdentifier:@"MailSendController"];
    [self.navigationController pushViewController:maView animated:NO];
    
}

@end

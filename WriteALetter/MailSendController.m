//
//  MailSendController.m
//  WriteALetter
//
//  Created by Apple on 25/02/19.
//  Copyright © 2019 Rajesh Shinde. All rights reserved.
//

#import "MailSendController.h"
#import "ViewController.h"
#import "MessageController.h"
#import <SKPSMTPMessage.h>
@interface MailSendController ()<MFMailComposeViewControllerDelegate/*, SKPSMTPMessageDelegate*/>
{
    
    NSString *mail;
    NSString *password;
    
}
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;

@property (strong, nonatomic) IBOutlet UIView *viewTV;
@property (strong, nonatomic) IBOutlet UITextView *tvMail;
@end

@implementation MailSendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
/*
    _btnSend.hidden = YES;
    _viewTV.hidden = YES;
    _editBtn.hidden = YES;*/
    _loginBtn.hidden = YES;
    _emailTF.hidden = YES;
    _passwordTF.hidden = YES;
    
    _loginBtn.layer.cornerRadius = 10;
    _loginBtn.layer.shadowColor = [UIColor grayColor].CGColor;
    _loginBtn.layer.shadowOffset = CGSizeMake(0, 0);
    _loginBtn.layer.shadowOpacity = 0.5;
    _loginBtn.layer.shadowRadius = 3;
    
    _btnSend.layer.cornerRadius = 15;
    _btnSend.layer.shadowColor = [UIColor grayColor].CGColor;
    _btnSend.layer.shadowOffset = CGSizeMake(0, 0);
    _btnSend.layer.shadowOpacity = 0.5;
    _btnSend.layer.shadowRadius = 3;
    
    _viewTV.layer.cornerRadius = 35;
    _viewTV.layer.shadowColor = [UIColor grayColor].CGColor;
    _viewTV.layer.shadowOffset = CGSizeMake(0, 0);
    _viewTV.layer.shadowOpacity = 0.5;
    _viewTV.layer.shadowRadius = 3;
     [self.navigationController setNavigationBarHidden:YES];
    self.tvMail.text = @"Edit Message........";
  
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.tvMail.text = @"Enter your text…";
     self.tvMail.textColor = [UIColor lightGrayColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Enter your text…"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Enter your text…";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
#pragma mark - Button Action

- (IBAction)sendAction:(id)sender {
  
   // [self sendEmailInBackground];
   
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        mailVC.mailComposeDelegate = self;
        [mailVC setSubject:@"Write A Letter"];
        [mailVC setMessageBody:_tvMail.text isHTML:NO];
        [mailVC setToRecipients:@[@"help.app124@gmail.com"]];  //Set a test email recipient here if you want.
        //[mailVC  addAttachmentData: dataForImage mimeType: @”image/jpeg”; fileName: @”My image”]; This is where you would add the attachment.
        
        [self presentViewController:mailVC animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"This device cannot send email"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)editLetterAction:(id)sender {
    
    ViewController *jfjf = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:jfjf animated:YES];
}
/*
-(void) sendEmailInBackground {
    NSLog(@"Start Sending");
    SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
    emailMessage.fromEmail = mail; //sender email address
    emailMessage.toEmail = @"abc@abc.abc";  //receiver email address
    emailMessage.relayHost = @"smtp.gmail.com";
    emailMessage.relayPorts = @[@587, @465];
    emailMessage.validateSSLChain = YES;
    //emailMessage.ccEmail =@"your cc address";
    //emailMessage.bccEmail =@"your bcc address";
    emailMessage.requiresAuth = YES;
    emailMessage.login = mail; //sender email address
    emailMessage.pass = password; //sender email password
    emailMessage.subject =@"Write A Letter";
    emailMessage.wantsSecure = YES;
    emailMessage.delegate = self; // you must include <SKPSMTPMessageDelegate> to your class
    NSString *messageBody = _tvMail.text;
    //for example :   NSString *messageBody = [NSString stringWithFormat:@"Tour Name: %@\nName: %@\nEmail: %@\nContact No: %@\nAddress: %@\nNote: %@",selectedTour,nameField.text,emailField.text,foneField.text,addField.text,txtView.text];
    // Now creating plain text email message
    NSDictionary *plainMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey, messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    emailMessage.parts = [NSArray arrayWithObjects:plainMsg,nil];
    //in addition : Logic for attaching file with email message.
 */
    /*
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"filename" ofType:@"JPG"];
     NSData *fileData = [NSData dataWithContentsOfFile:filePath];
     NSDictionary *fileMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx- unix-mode=0644;\r\n\tname=\"filename.JPG\"",kSKPSMTPPartContentTypeKey,@"attachment;\r\n\tfilename=\"filename.JPG\"",kSKPSMTPPartContentDispositionKey,[fileData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
     emailMessage.parts = [NSArray arrayWithObjects:plainMsg,fileMsg,nil]; //including plain msg and attached file msg
     */
   /* [emailMessage send];
    // sending email- will take little time to send so its better to use indicator with message showing sending...
}*/

/*
-(void)messageSent:(SKPSMTPMessage *)message{
    
    MessageController *msg = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageController"];
    [self.navigationController pushViewController:msg animated:YES];
    
}
// On Failure

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    // open an alert with just an OK button
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    NSLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
}
- (IBAction)loginAction:(id)sender {
    
    mail = _emailTF.text;
    password = _passwordTF.text;
    _btnSend.hidden = NO;
    _viewTV.hidden = NO;
    _editBtn.hidden = NO;
    
    _loginBtn.hidden = YES;
    _emailTF.hidden = YES;
    _passwordTF.hidden = YES;
}*/
#pragma mark - Other Methods

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
        {
            NSLog(@"Email sent");
            MessageController *jfjf = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageController"];
            [self.navigationController pushViewController:jfjf animated:YES];
            break;
            
        }
        case MFMailComposeResultSaved:
        {
            NSLog(@"Email saved");
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:@"Email Saved"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        case MFMailComposeResultCancelled:
        {
            NSLog(@"Email Cancelled");
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:@"Email Cancelled"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        case MFMailComposeResultFailed:
        {
            NSLog(@"Email Failed");
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:@"Email Failed"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        default:
        {
            NSLog(@"Error occured during email creation");
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:@"Error occured during email creation"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end

//
//  ViewController.m
//  objcApp
//
//  Created by Oleksii Mykhalchuk on 6/28/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

UIView *loginView;
UILabel *label;
UITextField *login;
UITextField *password;
UIButton *btn;
NSUserDefaults *userDefaults;


- (void)viewDidLoad {
    [super viewDidLoad];
//    UITableView *tableView = [[UITableView alloc]initWithFrame:[self view].frame];
//    [[self view]addSubview:tableView];
    [self addLoginView];
    [self addLabel];
    [self addLoginField];
    [self addPasswordField];
    [self addButton];
    userDefaults = [[NSUserDefaults alloc]init];
    [userDefaults setObject:@"user" forKey:@"user"];
    [userDefaults setObject:@"pass" forKey:@"pass"];
    self.view.backgroundColor = [UIColor grayColor];
}
- (void)addLoginView {
    loginView = [[UIView alloc]initWithFrame:CGRectZero];
    loginView.translatesAutoresizingMaskIntoConstraints = false;
    loginView.backgroundColor = [UIColor whiteColor];
    loginView.layer.cornerRadius = 20;
    loginView.layer.masksToBounds = true;
    [[self view]addSubview:loginView];

    [loginView.widthAnchor constraintEqualToConstant: 300.0].active = true;
    [loginView.heightAnchor constraintEqualToConstant: 300.0].active = true;
    [loginView.centerYAnchor constraintEqualToAnchor: self.view.centerYAnchor].active = true;
    [loginView.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor].active = true;
}
-(void)addLabel {
    label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"Login";
    [[self view]addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = false;
    [label.centerXAnchor constraintEqualToAnchor:loginView.centerXAnchor].active = true;
    [label.topAnchor constraintEqualToAnchor:loginView.topAnchor constant:50].active = true;
}
-(void)addLoginField {
    login = [[UITextField alloc]initWithFrame:CGRectZero];
    login.placeholder = @"Login";
    login.borderStyle = UITextBorderStyleRoundedRect;
    [[self view]addSubview:login];
    login.translatesAutoresizingMaskIntoConstraints = false;
    [login.leadingAnchor constraintEqualToAnchor:loginView.leadingAnchor constant:20].active = true;
    [login.topAnchor constraintEqualToAnchor:label.bottomAnchor constant:30].active = true;
    [login.trailingAnchor constraintEqualToAnchor:loginView.trailingAnchor constant:-20].active = true;
}
-(void)addPasswordField {
    password = [[UITextField alloc]initWithFrame:CGRectZero];
    password.placeholder = @"Password";
    password.textContentType = @"password";
    password.borderStyle = UITextBorderStyleRoundedRect;
    [[self view]addSubview:password];
    password.translatesAutoresizingMaskIntoConstraints = false;
    [password.leadingAnchor constraintEqualToAnchor:loginView.leadingAnchor constant:20].active = true;
    [password.topAnchor constraintEqualToAnchor:login.bottomAnchor constant:30].active = true;
    [password.trailingAnchor constraintEqualToAnchor:loginView.trailingAnchor constant:-20].active = true;
}
-(void)addButton {
    btn = [[UIButton alloc]init];
    [btn setTitle:@"Login" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.tintColor forState:UIControlStateNormal];
    [[self view]addSubview:btn];
    [btn addTarget:self action: @selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    btn.translatesAutoresizingMaskIntoConstraints = false;
    [btn.centerXAnchor constraintEqualToAnchor:loginView.centerXAnchor].active = true;
    [btn.topAnchor constraintEqualToAnchor:password.bottomAnchor constant:30].active = true;
}
-(void)buttonPress:(id)senderbuttonPress {
    NSString *user = [userDefaults objectForKey:@"user"];
    NSString *pass = [userDefaults objectForKey:@"pass"];
    NSLog(@"user %@, pass is %@", user, pass);
}

@end


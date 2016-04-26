//
//  ViewController.m
//  AudioTracker
//
//  Created by TangYunfei on 16/4/25.
//  Copyright © 2016年 TangYunfei. All rights reserved.
//

#import "ViewController.h"
#import "SRWebSocket.h"

@interface ViewController ()<SRWebSocketDelegate>
@property (nonatomic, retain) UILabel *label_ip_and_port;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UIButton *submitBtn;
@property (nonatomic, retain) SRWebSocket *webSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.label_ip_and_port = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 80, 30)];
    self.label_ip_and_port.text = @"IP&Port:";
    
    [self.view addSubview:self.label_ip_and_port];
    
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.label_ip_and_port.frame.size.width, 100, 200, 30)];
    self.textField.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    self.textField.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textField];
    
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.submitBtn.frame = CGRectMake(0, 140, 100, 40);
    [self.submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(onSubmit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.submitBtn];
    
}

- (void)onSubmit:(UIControl *)btn {
    [self connectWebSocket];
}

#pragma mark - Connection

- (void)connectWebSocket {
    self.webSocket.delegate = nil;
    self.webSocket = nil;
    
    NSString *urlString = @"ws://localhost:8880/ws";
    SRWebSocket *newWebSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    newWebSocket.delegate = self;
    
    [newWebSocket open];
}


#pragma mark - SRWebSocket delegate

- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
    self.webSocket = newWebSocket;
    [self.webSocket send:[NSString stringWithFormat:@"Hello from %@", [UIDevice currentDevice].name]];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [self connectWebSocket];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [self connectWebSocket];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    
}

- (IBAction)sendMessage:(id)sender {
    
}


@end

//
//  ChatViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-24.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "ChatViewController.h"
#import "AppDelegate.h"
#import "ChatMessage.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <JSMessagesViewController/JSMessage.h>
#import <socket.IO/SocketIO.h>
#import <socket.IO/SocketIOPacket.h>
#import <DevelopMesser/DevelopMesser.h>

static NSString *CHAT_SERVER_ADDRESS = @"180.96.23.114";
static NSInteger CHAT_SERVER_PORT = 13700;


@interface ChatViewController ()<JSMessagesViewDelegate,JSMessagesViewDataSource, SocketIODelegate, UIAlertViewDelegate>
{
    SocketIO *_socketIO;
    NSMutableArray *_messages;
}

@property (nonatomic, strong) DMUserinfo *userinfo;

@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    DMPRINTMETHODNAME();
    
    //JSMessagesViewController init
    self.delegate = self;
    self.dataSource = self;
    [super viewDidLoad];
    
    [[JSBubbleView appearance] setFont:[UIFont systemFontOfSize:16.f]];
    self.messageInputView.textView.placeHolder = @"请输入文字内容";
    [self.messageInputView.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.messageInputView.sendButton setTitle:@"发送" forState:UIControlStateDisabled];
    [self.messageInputView.sendButton setTitle:@"发送" forState:UIControlStateHighlighted];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self setBackgroundColor:[UIColor whiteColor]];
    
    //socket init
    _socketIO = [[SocketIO alloc] initWithDelegate:self];
    
    //message init
    _messages = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning
{
    DMPRINTMETHODNAME();
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    DMPRINTMETHODNAME();
    
    //隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
    
    //获取用户
    _userinfo = [self userinfo];
    [_messages removeAllObjects];

    if ([_userinfo isLogon]) {
        self.sender = _userinfo[@"name"];
        
        //登录聊天服务器
        [_socketIO connectToHost:CHAT_SERVER_ADDRESS onPort:CHAT_SERVER_PORT];
        NSDictionary *data = @{@"appId": @"JinLi",
                               @"username":self.sender};
            [_socketIO sendEvent:@"login" withData:data];
        
    } else {
        
        UIAlertView *nameAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请先返回首页登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        nameAlert.alertViewStyle = UIAlertViewStyleDefault;
        [nameAlert show];
    }
}

#pragma mark private method

/**
 *  取出共享用户对象
 *
 *  @return 返回蓝牙对象
 */
-(DMUserinfo*) userinfo
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return appDelegate.userinfo;
}

- (void)goBack
{
    self.tabBarController.selectedIndex = 0;
    
    if (self.tabBarController.tabBar.hidden == YES) {
        self.tabBarController.tabBar.hidden = NO;
    }
}

#pragma mark IBAction

- (IBAction)backAction:(id)sender
{
    [self goBack];
}

#pragma mark JSMessagesViewController method

- (void)buttonPressed:(UIButton *)sender
{
    // Testing pushing/popping messages view
    ChatViewController *vc = [[ChatViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messages.count;
}

#pragma mark - Messages view delegate: REQUIRED

- (void)didSendText:(NSString *)text fromSender:(NSString *)sender onDate:(NSDate *)date
{
    [JSMessageSoundEffect playMessageSentSound];
    
    
    ChatMessage *message = [[ChatMessage alloc] initWithFromId:(NSInteger)_userinfo[@"uid"]
                                                     avatarUrl:_userinfo[@"logoUrl"]
                                                          text:text
                                                        sender:_userinfo[@"name"]
                                                          date:[NSDate date]];
    
    //当前Unix时间戳
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)timeInterval*1000];
    
    NSDictionary *sendMsg = @{@"appId": @"JinLi",
                              @"fromId":_userinfo[@"uid"],
                              @"message":text,
                              @"dateline":timeSp};
    [_socketIO sendEvent:@"pms" withData:sendMsg];
    [_messages addObject:message];
    [self finishSend];
    [self scrollToBottomAnimated:YES];
}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMessage *message =  _messages[indexPath.row];
    
    if (message.fromeId == (NSInteger)_userinfo[@"uid"]) {
        return JSBubbleMessageTypeOutgoing;
    } else {
        return JSBubbleMessageTypeIncoming;
    }
}

- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type
                       forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMessage *message =  _messages[indexPath.row];
    
    if (message.fromeId == (NSInteger)_userinfo[@"uid"]) {
        return [JSBubbleImageViewFactory bubbleImageViewForType:type
                                                          color:[UIColor js_bubbleBlueColor]];
    } else {
        return [JSBubbleImageViewFactory bubbleImageViewForType:type
                                                          color:[UIColor js_bubbleLightGrayColor]];
    }
}

- (JSMessageInputViewStyle)inputViewStyle
{
    return JSMessageInputViewStyleFlat;
}

#pragma mark - Messages view delegate: OPTIONAL

- (BOOL)shouldDisplayTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}

//
//  *** Implement to customize cell further
//
- (void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if ([cell messageType] == JSBubbleMessageTypeOutgoing) {
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
        
        if ([cell.bubbleView.textView respondsToSelector:@selector(linkTextAttributes)]) {
            NSMutableDictionary *attrs = [cell.bubbleView.textView.linkTextAttributes mutableCopy];
            [attrs setValue:[UIColor blueColor] forKey:UITextAttributeTextColor];
            
            cell.bubbleView.textView.linkTextAttributes = attrs;
        }
    }
    
    if (cell.timestampLabel) {
        cell.timestampLabel.textColor = [UIColor lightGrayColor];
        cell.timestampLabel.shadowOffset = CGSizeZero;
    }
    
    if (cell.subtitleLabel) {
        cell.subtitleLabel.textColor = [UIColor lightGrayColor];
    }
}

//  *** Implement to use a custom send button
//
//  The button's frame is set automatically for you
//
//  - (UIButton *)sendButtonForInputView
//

//  *** Implement to prevent auto-scrolling when message is added
//
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling
{
    return YES;
}

// *** Implemnt to enable/disable pan/tap todismiss keyboard
//
- (BOOL)allowsPanToDismissKeyboard
{
    return YES;
}

#pragma mark - Messages view data source: REQUIRED

- (JSMessage *)messageForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_messages objectAtIndex:indexPath.row];
}

- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath sender:(NSString *)sender
{
    ChatMessage *msg = _messages[indexPath.row];
    if (msg.avatarUrl != nil) {
        NSURL *avatarUrl = [NSURL URLWithString:msg.avatarUrl];
        
        UIImageView *avatarView = [[UIImageView alloc] init];
        [avatarView setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar-placeholder"]];
        return avatarView;
    }
   
    return nil;
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self goBack];
}


#pragma mark - SocketIODelegate


- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    DMPRINTMETHODNAME();
    
    if ([packet.name isEqualToString:@"pms"] && packet.args.count > 0) {
        
        NSDictionary *data = packet.args[0];
        
        //时间戳转换NSDate
        NSString *datelineString = data[@"dateline"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[datelineString longLongValue]/1000];
        
        NSString *messageString = data[@"message"];
        NSData *messageData = [messageString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *messageJson = [NSJSONSerialization JSONObjectWithData:messageData options:0 error:nil];
        
        if ([messageJson count] > 0) {
            ChatMessage *msg = [[ChatMessage alloc] initWithFromId:(NSInteger)data[@"fromId"]
                                                         avatarUrl:messageJson[@"avatar"]
                                                              text:messageJson[@"content"]
                                                            sender:messageJson[@"name"]
                                                              date:date];
            [_messages addObject:msg];
            [self.tableView reloadData];
        }
    }
}

-(void)socketIODidConnect:(SocketIO *)socket
{
    DMPRINT(@"Connected!");
}

-(void)socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    DMPRINT(@"Disconnected!");
    if (error != nil) {
        DMPRINT(@"%@", error.description);
    }
}

@end

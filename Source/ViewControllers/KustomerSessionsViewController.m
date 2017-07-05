//
//  KustomerSessionsViewController.m
//  Kustomer
//
//  Created by Daniel Amitay on 7/3/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KustomerSessionsViewController.h"

#import "KustomerChatViewController.h"
#import "KustomerPlaceholderTableViewCell.h"
#import "KustomerSessionTableViewCell.h"

#import "KUSImage.h"

@interface KustomerSessionsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *createSessionButton;

@end

@implementation KustomerSessionsViewController

#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeRight;

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 88.0;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];

    UIColor *blueColor = [UIColor colorWithRed:66.0/255.0
                                         green:130.0/255.0
                                          blue:252.0/255.0
                                         alpha:1.0];
    CGFloat buttonRadius = 4.0;
    CGSize size = CGSizeMake(buttonRadius * 2.0, buttonRadius * 2.0);
    UIImage *circularImage = [KUSImage circularImageWithSize:size color:blueColor];
    UIEdgeInsets capInsets = UIEdgeInsetsMake(buttonRadius, buttonRadius, buttonRadius, buttonRadius);
    UIImage *buttonImage = [circularImage resizableImageWithCapInsets:capInsets];

    // TODO: Encapsulate into class
    self.createSessionButton = [[UIButton alloc] init];
    [self.createSessionButton setTitle:@"New Conversation" forState:UIControlStateNormal];
    self.createSessionButton.titleLabel.textColor = [UIColor whiteColor];
    self.createSessionButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.createSessionButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    self.createSessionButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.createSessionButton.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.createSessionButton.layer.shadowRadius = 1.0;
    self.createSessionButton.layer.shadowOpacity = 0.5;
    [self.createSessionButton addTarget:self
                                 action:@selector(_createSession)
                       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.createSessionButton];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    self.tableView.frame = self.view.bounds;

    // TODO: Extract layout constants
    CGSize createSessionButtonSize = CGSizeMake(182.0, 44.0);
    self.createSessionButton.frame = (CGRect) {
        .origin.x = (self.view.bounds.size.width - createSessionButtonSize.width) / 2.0,
        .origin.y = self.view.bounds.size.height - createSessionButtonSize.height - 23.0,
        .size = createSessionButtonSize
    };
}

#pragma mark - Interface element methods

- (void)_createSession
{
    KustomerChatViewController *chatViewController = [[KustomerChatViewController alloc] init];
    [self.navigationController pushViewController:chatViewController animated:YES];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // TODO: Calculate placeholder row count based on screen height
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *kSessionCellIdentifier = @"SessionCell";
        KustomerSessionTableViewCell *cell = (KustomerSessionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kSessionCellIdentifier];
        if (cell == nil) {
            cell = [[KustomerSessionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSessionCellIdentifier];
        }
        return cell;
    }

    static NSString *kPlaceholderCellIdentifier = @"PlaceholderCell";
    KustomerPlaceholderTableViewCell *cell = (KustomerPlaceholderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kPlaceholderCellIdentifier];
    if (cell == nil) {
        cell = [[KustomerPlaceholderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPlaceholderCellIdentifier];
    }
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    KustomerChatViewController *chatViewController = [[KustomerChatViewController alloc] init];
    [self.navigationController pushViewController:chatViewController animated:YES];
}

@end
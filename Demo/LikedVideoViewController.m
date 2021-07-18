//
//  LikedVideoViewController.m
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

#import "LikedVideoViewController.h"
#import "PrivacyViewController.h"

#define CELL_ID @"cell_id"

@interface LikedVideoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *settingTable;
@property (nonatomic, strong) NSMutableDictionary *option_State;

@end

@implementation LikedVideoViewController

- (instancetype)init {
    self = [super init];
    self.option_State = [[NSMutableDictionary alloc] init];
    NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePatch stringByAppendingPathComponent:@"State.plist"];
    self.option_State = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Liked videos";
    self.settingTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.settingTable registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_ID];
    self.settingTable.dataSource = self;
    self.settingTable.delegate = self;
    [self.settingTable setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:self.settingTable];
}

# pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 35, tableView.bounds.size.width, 18)];
        headerLabel.text = @"Who can view your liked videos";
    headerLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    headerLabel.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
    [backgroundView addSubview:headerLabel];
    return backgroundView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

# pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *c = [self.settingTable dequeueReusableCellWithIdentifier:CELL_ID];
    
    //刷新前先删除之前的
    for (UIView* subView in c.subviews) {
        [subView removeFromSuperview];
    }
    
    UIImageView *display;
    NSString *stateName = [self.option_State objectForKey:@("Liked videos")];
    switch (indexPath.row) {
        case 0:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 17, 283, 18)];
            label.text = @"Everyone";
            label.font = [UIFont fontWithName:@"ArialMT" size:15];
            label.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
            [c addSubview:label];
            if ([stateName intValue] == LIKED_VIDEO_EVERYONE) {
                display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choose"]];
            } else {
                display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not_choose"]];
            }
            display.tag = 0;
            break;
        }
        case 1:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 17, 283, 18)];
            label.text = @"Only me";
            label.font = [UIFont fontWithName:@"ArialMT" size:15];
            label.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
            [c addSubview:label];
            if ([stateName intValue] == LIKED_VIDEO_ONLY_ME) {
                    display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choose"]];
            } else {
                display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not_choose"]];
            }
            display.tag = 1;
            break;
        }
        default:
            break;
    }
    display.frame = CGRectMake(tableView.bounds.size.width - 120, 16, display.bounds.size.width, display.bounds.size.height);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
    [display addGestureRecognizer:tapGesture];
    display.userInteractionEnabled = YES;
    [c addSubview:display];
    c.contentView.userInteractionEnabled = NO;
    return c;
}

#pragma mark - clickEvent

- (void)clickImage:(UITapGestureRecognizer*)sender
{
    NSInteger index = sender.view.tag;
    switch (index) {
        case 0:
        {
            [self.option_State setValue:@(LIKED_VIDEO_EVERYONE) forKey:@"Liked videos"];
            break;
        }
        case 1:
        {
            [self.option_State setValue:@(LIKED_VIDEO_ONLY_ME) forKey:@"Liked videos"];
            break;
        }
        default:
            break;
    }
    [self.delegate likedVideoChangeState:self];
    NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePatch stringByAppendingPathComponent:@"State.plist"];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    [self.option_State writeToURL:fileUrl atomically:YES];
    [self.settingTable reloadData];
}

@end


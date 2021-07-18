//
//  PrivacyViewController.m
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

//#import "AppDelegate.h"
#import "PrivacyViewController.h"
#import "DownloadsViewController.h"
#import "CommentViewController.h"
#import "DuetViewController.h"
#import "StitchViewController.h"
#import "LikedVideoViewController.h"
#import "DirectMessageViewController.h"
#import "BlockedAccountsViewController.h"
#import "PrivacySetDescription.h"

#define PRIVACY_CELL @"privacy_cell"

//NSMutableDictionary *option_State;

@interface PrivacyViewController ()
    <UITableViewDelegate, UITableViewDataSource, DownloadsViewControllerDelegate, DuetViewControllerDelegate, StitchViewControllerDelegate, LikedVideoViewControllerDelegate, DirectMessageViewControllerDelegate>

@property (nonatomic, strong) NSString *DocPath;
@property (nonatomic, strong) UITableView *optionTable;
@property (nonatomic, strong) NSMutableArray *optionTableData;
@property (nonatomic, strong) NSMutableDictionary *option_State;

@end

@implementation PrivacyViewController

- (instancetype)init {
    self = [super init];
    self.optionTableData = [[NSMutableArray alloc] init];
    self.option_State = [[NSMutableDictionary alloc] init];
    for(int i = 0; i < 7; i++){
        PrivacySetDescription *new = [[PrivacySetDescription alloc] init];
        switch (i) {
            case 0:
                new.icon = @"arrow_down_to_line.png";
                new.name = @"Downloads";
                new.state = [[NSMutableDictionary alloc] init];
                [new.state setObject:@"off" forKey:@(DOWNLOADS_OFF)];
                [new.state setObject:@"on" forKey:@(DOWNLOADS_ON)];
                [self.optionTableData
                    addObject:new];
                [self.option_State setObject:@(DOWNLOADS_OFF) forKey:new.name];  //默认状态
                break;
            case 1:
                new.icon = @"bubble_ellipsis_right.png";
                new.name = @"Comments";
                new.state = [[NSMutableDictionary alloc] init];
                [new.state setObject:@"" forKey:@(COMMENTS_EVERYONE)];
                [new.state setObject:@"" forKey:@(COMMENTS_FRIENDS)];
                [new.state setObject:@"" forKey:@(COMMENTS_NO_ONE)];
                [self.optionTableData
                    addObject:new];
                [self.option_State setObject:@(COMMENTS_FRIENDS) forKey:new.name];
                break;
            case 2:
                new.icon = @"duet.png";
                new.name = @"Duet";
                new.state = [[NSMutableDictionary alloc] init];
                [new.state setObject:@"Everyone" forKey:@(DUET_EVERYONE)];
                [new.state setObject:@"Friends" forKey:@(DUET_FRIENDS)];
                [new.state setObject:@"Only me" forKey:@(DUET_ONLY_ME)];
                [self.optionTableData
                    addObject:new];
                [self.option_State setObject:@(DUET_EVERYONE) forKey:new.name];
                break;
            case 3:
                new.icon = @"Vector (Stroke).png";
                new.name = @"Stitch";
                new.state = [[NSMutableDictionary alloc] init];
                [new.state setObject:@"Everyone" forKey:@(STITCH_EVERYONE)];
                [new.state setObject:@"Friends" forKey:@(STITCH_FRIENDS)];
                [new.state setObject:@"Only me" forKey:@(STITCH_ONLY_ME)];
                [self.optionTableData
                    addObject:new];
                [self.option_State setObject:@(STITCH_EVERYONE) forKey:new.name];
                break;
            case 4:
                new.icon = @"heart.png";
                new.name = @"Liked videos";
                new.state = [[NSMutableDictionary alloc] init];
                [new.state setObject:@"Everyone" forKey:@(LIKED_VIDEO_EVERYONE)];
                [new.state setObject:@"Only me" forKey:@(LIKED_VIDEO_ONLY_ME)];
                [self.optionTableData
                    addObject:new];
                [self.option_State setObject:@(LIKED_VIDEO_EVERYONE) forKey:new.name];
                break;
            case 5:
                new.icon = @"paperplane.png";
                new.name = @"Direct message";
                new.state = [[NSMutableDictionary alloc] init];
                [new.state setObject:@"Everyone" forKey:@(DIRECT_MESSAGE_EVERYONE)];
                [new.state setObject:@"Friends" forKey:@(DIRECT_MESSAGE_FRIENDS)];
                [new.state setObject:@"No one" forKey:@(DIRECT_MESSAGE_NO_ONE)];
                [self.optionTableData
                    addObject:new];
                [self.option_State setObject:@(DIRECT_MESSAGE_EVERYONE) forKey:new.name];
                break;
            case 6:
                new.icon = @"_source (Stroke).png";
                new.name = @"Blocked accounts";
                new.state = [[NSMutableDictionary alloc] init];
                [new.state setObject:@"" forKey:@(BLOCKED_ACCOUNTS_DEFAULT)];
                [self.optionTableData
                    addObject:new];
                [self.option_State setObject:@(BLOCKED_ACCOUNTS_DEFAULT) forKey:new.name];
                break;
            default:
                break;
        }
    }
    NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePatch stringByAppendingPathComponent:@"State.plist"];
    //将路径转换为本地url形式
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    //writeToURL 的好处是，既可以写入本地url也可以写入远程url，苹果推荐使用此方法写入plist文件
    [self.option_State writeToURL:fileUrl atomically:YES];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Privacy";
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:17],
    NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    //左边返回键
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Path 13 Copy 2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:nil];
//    self.navigationItem.leftBarButtonItem = left;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent =NO;
    
    //table设置
    self.optionTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.optionTable registerClass:[UITableViewCell class] forCellReuseIdentifier:PRIVACY_CELL];
    self.optionTable.dataSource = self;
    self.optionTable.delegate = self;
    self.optionTable.backgroundColor = [UIColor whiteColor];
    [self.optionTable setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:self.optionTable];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.optionTableData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 41)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, tableView.bounds.size.width, 20)];
    headerLabel.text = @"Safety";
    headerLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:13];
    headerLabel.textColor = [UIColor grayColor];
    [backgroundView addSubview:headerLabel];
    return backgroundView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            DownloadsViewController *subview = [[DownloadsViewController alloc] init];
//            [subview setOption_State:self.option_State];
//            NSLog(@"option state %@",self.option_State);
            subview.delegate = self;
            [self.navigationController pushViewController:subview animated:YES];
            break;
        }
        case 1:
        {
            CommentViewController *subview = [[CommentViewController alloc] init];
            [self.navigationController pushViewController:subview animated:YES];
            break;
        }
        case 2:
        {
            DuetViewController *subview = [[DuetViewController alloc] init];
            subview.delegate = self;
            [self.navigationController pushViewController:subview animated:YES];
            break;
        }
        case 3:
        {
            StitchViewController *subview = [[StitchViewController alloc] init];
            subview.delegate = self;
            [self.navigationController pushViewController:subview animated:YES];
            break;
        }
        case 4:
        {
            LikedVideoViewController *subview = [[LikedVideoViewController alloc] init];
            subview.delegate = self;
            [self.navigationController pushViewController:subview animated:YES];
            break;
        }
        case 5:
        {
            DirectMessageViewController *subview = [[DirectMessageViewController alloc] init];
            subview.delegate = self;
            [self.navigationController pushViewController:subview animated:YES];
            break;
        }
        case 6:
        {
            BlockedAccountsViewController *subview = [[BlockedAccountsViewController alloc] init];
            
            [self.navigationController pushViewController:subview animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePatch stringByAppendingPathComponent:@"State.plist"];
    NSMutableDictionary *now_States = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    UITableViewCell *c = [self.optionTable dequeueReusableCellWithIdentifier:PRIVACY_CELL];
    //c.frame = CGRectMake(0, 0, 375, 100);
    
    //刷新前先删除之前的
    for (UIView* subView in c.subviews) {
        [subView removeFromSuperview];
    }
    
    PrivacySetDescription *description = [self.optionTableData objectAtIndex:indexPath.row];
    
    //最左边的图
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:description.icon]];
    image.frame = CGRectMake(14, 12, 27, 27);
    image.contentMode = UIViewContentModeCenter;
    //image.tintColor = [UIColor redColor];
    [c addSubview:image];
    
    //选项文本
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(48, 17, 283, 18)];
    label.text = description.name;
    label.font = [UIFont fontWithName:@"ArialMT" size:15];
    label.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
    [c addSubview:label];
    
    //右边的状态
    UILabel *rightText = [[UILabel alloc] initWithFrame:CGRectMake(tableView.bounds.size.width - 120, 17, 80, 18)];
    rightText.text = [description.state objectForKey:[now_States objectForKey:description.name]];
    rightText.font = [UIFont fontWithName:@"ArialMT" size:15];
    rightText.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:0.5];
    rightText.textAlignment = NSTextAlignmentRight;
    [c addSubview:rightText];
    
    //右边的箭头
    UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chevron_right_offset.png"]];
    rightArrow.frame = CGRectMake(tableView.bounds.size.width - 30, 20, 6.67, 12);
    rightArrow.contentMode = UIViewContentModeTopLeft;
    //rightArrow.tintColor = [UIColor grayColor];
    //rightArrow.backgroundColor = [UIColor blackColor];
    [c addSubview:rightArrow];
    
    return c;
}

# pragma mark - DownloadsViewControllerDelegate
- (void)downloadsChangeState:(DownloadsViewController *)controller
{
    [self.optionTable reloadData];
}

# pragma mark - DuetViewControllerDelegate
- (void)duetChangeState:(DuetViewController *)controller
{
    [self.optionTable reloadData];
}

# pragma mark - StitchViewControllerDelegate
- (void)stitchChangeState:(StitchViewController *)controller
{
    [self.optionTable reloadData];
}

# pragma mark - LikedVideoViewControllerDelegate
- (void)likedVideoChangeState:(StitchViewController *)controller
{
    [self.optionTable reloadData];
}

# pragma mark - DirectMessageViewControllerDelegate
- (void)directMessageChangeState:(StitchViewController *)controller
{
    [self.optionTable reloadData];
}
@end


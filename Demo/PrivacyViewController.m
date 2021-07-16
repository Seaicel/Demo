//
//  PrivacyViewController.m
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

#import "PrivacyViewController.h"
#import "DownloadsViewController.h"
#import "CommentViewController.h"
#import "DuetViewController.h"
#import "StitchViewController.h"
#import "LikedVideoViewController.h"
#import "DirectMessageViewController.h"

@interface PrivacyViewController ()
    <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *optionTable;
@property (nonatomic, strong) NSMutableArray *optionTableData;

@end

@implementation PrivacyViewController

- (instancetype)init {
    self = [super init];
    NSMutableArray *a = [[NSMutableArray alloc] init];
    self.optionTableData = a;
    for (int i = 0; i < 7; i++){
        switch (i) {
            case 0:
                [self.optionTableData
                    addObject:@[@"arrow_down_to_line.png", @"Downloads", @"Off"]];
                break;
            case 1:
                [self.optionTableData addObject:@[@"bubble_ellipsis_right.png", @"Comments", @""]];
                break;
            case 2:
                [self.optionTableData addObject:@[@"duet.png", @"Duet", @"Friends"]];
                break;
            case 3:
                [self.optionTableData addObject:@[@"Vector (Stroke).png", @"Stitch", @"Friends"]];
                break;
            case 4:
                [self.optionTableData addObject:@[@"heart.png", @"Liked videos", @"Everyone"]];
                break;
            case 5:
                [self.optionTableData addObject:@[@"paperplane.png", @"Direct message", @"Everyone"]];
                break;
            case 6:
                [self.optionTableData addObject:@[@"_source (Stroke).png", @"Blocked accounts", @""]];
                break;
            default:
                break;
        }
        NSLog(@"%@", self.optionTableData);
    }
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
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Path 13 Copy 2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.backItem.title = @"wevbr";
    //self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent =NO;
    
    //table设置
    self.optionTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.optionTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
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
            [self.navigationController pushViewController:[[DownloadsViewController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[CommentViewController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[DuetViewController alloc] init] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[StitchViewController alloc] init] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[[LikedVideoViewController alloc] init] animated:YES];
            break;
        case 5:
            [self.navigationController pushViewController:[[DirectMessageViewController alloc] init] animated:YES];
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"cellId";
    UITableViewCell *c = [self.optionTable dequeueReusableCellWithIdentifier:cellId];
    c.frame = CGRectMake(0, 0, 375, 100);
    
    //最左边的图
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[self.optionTableData objectAtIndex:indexPath.row] objectAtIndex:0]]];
    image.frame = CGRectMake(14, 12, 27, 27);
    image.contentMode = UIViewContentModeCenter;
    //image.tintColor = [UIColor redColor];
    [c addSubview:image];
    
    //选项文本
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(48, 17, 283, 18)];
    label.text = [[self.optionTableData objectAtIndex:indexPath.row] objectAtIndex:1];
    label.font = [UIFont fontWithName:@"ArialMT" size:15];
    label.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
    [c addSubview:label];
    
    //右边的状态
    UILabel *rightText = [[UILabel alloc] initWithFrame:CGRectMake(265, 17, 80, 18)];
    rightText.text = [[self.optionTableData objectAtIndex:indexPath.row] objectAtIndex:2];
    rightText.font = [UIFont fontWithName:@"ArialMT" size:15];
    rightText.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:0.5];
    rightText.textAlignment = NSTextAlignmentRight;
    [c addSubview:rightText];
    
    //右边的箭头
    UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chevron_right_offset.png"]];
    rightArrow.frame = CGRectMake(355, 20, 6.67, 12);
    rightArrow.contentMode = UIViewContentModeTopLeft;
    //rightArrow.tintColor = [UIColor grayColor];
    //rightArrow.backgroundColor = [UIColor blackColor];
    [c addSubview:rightArrow];
    
    return c;
}

@end

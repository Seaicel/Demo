//
//  DownloadsViewController.m
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

#import "DownloadsViewController.h"
#import "PrivacyViewController.h"

#define CELL_ID @"cell_id"

@interface DownloadsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *settingTable;
@property (nonatomic, strong) NSMutableDictionary *option_State;

@end

@implementation DownloadsViewController

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
    // Do any additional setup after loading the view
    self.navigationItem.title = @"Downloads";
    self.settingTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.settingTable registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_ID];
    self.settingTable.dataSource = self;
    self.settingTable.delegate = self;
    [self.settingTable setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:self.settingTable];
}

# pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

# pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *c = [self.settingTable dequeueReusableCellWithIdentifier:CELL_ID];
    
    //刷新前先删除之前的
    for (UIView* subView in c.subviews) {
        [subView removeFromSuperview];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 25, 307, 18)];
    label.text = @"Allow your videos to be downloaded";
    label.font = [UIFont fontWithName:@"ArialMT" size:15];
    label.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
    [c addSubview:label];
    NSString *stateName = [self.option_State objectForKey:@("Downloads")];
    UIImageView *display;
    switch ([stateName intValue]) {
        case DOWNLOADS_OFF:
            display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"off"]];
            break;
        case DOWNLOADS_ON:
            display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"on"]];
            break;
        default:
            break;
    }
    display.frame = CGRectMake(tableView.bounds.size.width - 100, 20, 80, 25);
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
    NSString *stateName = [self.option_State objectForKey:@("Downloads")];
    switch ([stateName intValue]) {
        case 0:
        {
            [self.option_State setValue:@(DOWNLOADS_ON) forKey:@"Downloads"];
            break;
        }
        case 1:
        {
            [self.option_State setValue:@(DOWNLOADS_OFF) forKey:@"Downloads"];
            break;
        }
        default:
            break;
    }
    [self.delegate downloadsChangeState:self];
    NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePatch stringByAppendingPathComponent:@"State.plist"];
    //将路径转换为本地url形式
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    //writeToURL 的好处是，既可以写入本地url也可以写入远程url，苹果推荐使用此方法写入plist文件
    [self.option_State writeToURL:fileUrl atomically:YES];
    [self.settingTable reloadData];
}

@end

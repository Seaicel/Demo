//
//  DownloadsViewController.m
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

#import "DownloadsViewController.h"

#define CELL_ID @"cell_id"

@interface DownloadsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *settingTable;

@end

//待做：设置state，显示不同按钮

@implementation DownloadsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 25, 307, 18)];
    label.text = @"Allow your videos to be downloaded";
    label.font = [UIFont fontWithName:@"ArialMT" size:15];
    label.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
    [c addSubview:label];
    UIImageView *on = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"on"]];
    on.frame = CGRectMake(280, 20, 80, 25);
    //on.contentMode = UIViewContentModeTopLeft;
    //rightArrow.tintColor = [UIColor grayColor];
    //rightArrow.backgroundColor = [UIColor blackColor];
    [c addSubview:on];
    return c;
}
@end

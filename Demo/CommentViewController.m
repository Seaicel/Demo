//
//  CommentViewController.m
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

#import "CommentViewController.h"
#import "PrivacyViewController.h"

#define CELL_ID @"cell_id"

typedef NS_ENUM (NSInteger, FILTER_SPAM) {
    FILTER_SPAM_OFF,
    FILTER_SPAM_ON
};

typedef NS_ENUM (NSInteger, FILTER_KEYWORDS) {
    FILTER_KEYWORDS_OFF,
    FILTER_KEYWORDS_ON
};

FILTER_SPAM filterSpamState;
FILTER_KEYWORDS filterKeywordsState;

@interface CommentViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *settingTable;
@property (nonatomic, strong) NSMutableDictionary *option_State;

@end

@implementation CommentViewController

- (instancetype)init {
    self = [super init];
    self.option_State = [[NSMutableDictionary alloc] init];
    NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePatch stringByAppendingPathComponent:@"State.plist"];
    self.option_State = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    filterSpamState =FILTER_SPAM_OFF;
    filterKeywordsState = FILTER_KEYWORDS_OFF;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.settingTable.rowHeight = 80;
    self.navigationItem.title = @"Comments";
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    switch (section) {
        case 0:
            num = 3;
            break;
        case 1:
            num = 2;
            break;
        default:
            break;
    }
    return num;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 35, tableView.bounds.size.width, 18)];
    switch (section) {
        case 0:
            headerLabel.text = @"Who can comment on your videos";
            break;
        case 1:
            headerLabel.text = @"Comment filters";
            break;
        default:
            break;
    }
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
    CGFloat height = 0;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                height = 40;
                break;
            case 1:
                height = 65;
                break;
            case 2:
                height = 40;
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                height = 86;
                break;
            case 1:
                height = 86;
                break;
            default:
                break;
        }
    }
    return height;
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
    if (indexPath.section == 0) {
        NSString *stateName = [self.option_State objectForKey:@("Comments")];
        switch (indexPath.row) {
            case 0:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 17, 283, 18)];
                label.text = @"Everyone";
                label.font = [UIFont fontWithName:@"ArialMT" size:15];
                label.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
                [c addSubview:label];
                if ([stateName intValue] == COMMENTS_EVERYONE) {
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
                label.text = @"Friends";
                label.font = [UIFont fontWithName:@"ArialMT" size:15];
                label.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
                [c addSubview:label];
                UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(16, 41, 283, 18)];
                label2.text = @"Followers that you follow back";
                label2.font = [UIFont fontWithName:@"ArialMT" size:12];
                label2.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:0.5];
                [c addSubview:label2];
                if ([stateName intValue] == COMMENTS_FRIENDS) {
                        display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choose"]];
                } else {
                    display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not_choose"]];
                }
                display.tag = 1;
                break;
            }
            case 2:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 17, 283, 18)];
                label.text = @"No one";
                label.font = [UIFont fontWithName:@"ArialMT" size:15];
                label.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
                [c addSubview:label];
                if ([stateName intValue] == COMMENTS_NO_ONE) {
                        display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choose"]];
                } else {
                    display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not_choose"]];
                }
                display.tag = 2;
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
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 17, tableView.bounds.size.width - 16, 18)];
                label.text = @"Filter spam and offensive comments";
                label.font = [UIFont fontWithName:@"ArialMT" size:15];
                label.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
                [c addSubview:label];
                UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(16, 41, tableView.bounds.size.width - 16,40)];
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.numberOfLines = 0;
                label2.text = @"Automatically hide comments that may be spam or offensive from \n your videos.";
                label2.font = [UIFont fontWithName:@"ArialMT" size:12];
                label2.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:0.5];
                [c addSubview:label2];
                switch (filterSpamState) {
                    case FILTER_SPAM_OFF:
                        display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"off"]];
                        break;
                    case FILTER_SPAM_ON:
                        display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"on"]];
                        break;
                    default:
                        break;
                }
                display.tag = 0;
                break;
            }
            case 1:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 17, 283, 18)];
                label.text = @"Filter keywords";
                label.font = [UIFont fontWithName:@"ArialMT" size:15];
                label.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:1];
                [c addSubview:label];
                UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(16, 41, tableView.bounds.size.width - 16, 40)];
                label2.text = @"Automatically hide comments with specified keywords on your videos.";
                label.numberOfLines = 0;
                label2.font = [UIFont fontWithName:@"ArialMT" size:12];
                label2.textColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:35/255.0 alpha:0.5];
                [c addSubview:label2];
                switch (filterKeywordsState) {
                    case FILTER_KEYWORDS_OFF:
                        display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"off"]];
                        break;
                    case FILTER_KEYWORDS_ON:
                        display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"on"]];
                        break;
                    default:
                        break;
                }
                display.tag = 1;
                break;
            }
            default:
                break;
        }
        display.frame = CGRectMake(tableView.bounds.size.width - 120, 12, display.bounds.size.width, display.bounds.size.height);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filterImage:)];
        [display addGestureRecognizer:tapGesture];
        display.userInteractionEnabled = YES;
        [c addSubview:display];
        c.contentView.userInteractionEnabled = NO;
    }
    
    return c;
}

#pragma mark - clickEvent

- (void)clickImage:(UITapGestureRecognizer*)sender
{
    NSInteger index = sender.view.tag;
    switch (index) {
        case 0:
        {
            [self.option_State setValue:@(COMMENTS_EVERYONE) forKey:@"Comments"];
            break;
        }
        case 1:
        {
            [self.option_State setValue:@(COMMENTS_FRIENDS) forKey:@"Comments"];
            break;
        }
        case 2:
        {
            [self.option_State setValue:@(COMMENTS_NO_ONE) forKey:@"Comments"];
            break;
        }
        default:
            break;
    }
    NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePatch stringByAppendingPathComponent:@"State.plist"];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    [self.option_State writeToURL:fileUrl atomically:YES];
    [self.settingTable reloadData];
}

- (void)filterImage:(UITapGestureRecognizer*)sender
{
    NSInteger index = sender.view.tag;
    switch (index) {
        case 0:
        {
            filterSpamState = (filterSpamState == FILTER_SPAM_ON) ? FILTER_SPAM_OFF :FILTER_SPAM_ON;
            break;
        }
        case 1:
        {
            filterKeywordsState = (filterKeywordsState == FILTER_KEYWORDS_ON) ? FILTER_KEYWORDS_OFF :FILTER_KEYWORDS_ON;
            break;
        }
        default:
            break;
    }
    [self.settingTable reloadData];
}

@end

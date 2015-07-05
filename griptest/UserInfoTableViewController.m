//
//  UserInfoTableViewController.m
//  griptest
//
//  Created by MaggieWei on 15-7-5.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "UserUtils.h"
#import "User.h"

@interface UserInfoTableViewController ()

@end

@implementation UserInfoTableViewController
@synthesize ageLabel;
@synthesize heightLabel;
@synthesize weightLabel;
@synthesize bmiLabel;
@synthesize bfpLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshLabels{
    if([UserUtils isUserLoggedIn]){
        User *user=[UserUtils readUser];
        ageLabel.text=[NSString stringWithFormat:@"%ld岁",(long)user.age];
        heightLabel.text=[NSString stringWithFormat:@"%ld厘米",(long)user.height];
        weightLabel.text=[NSString stringWithFormat:@"%ld厘米",(long)user.weight];
        float bmi= user.weight/(user.height/100)/(user.height/100);
        bmiLabel.text=[NSString stringWithFormat:@"%.2f",bmi];
        if(user.body_fat_per == 0){
            bmiLabel.text = @"未知";
        }
        else{
            bmiLabel.text = [NSString stringWithFormat:@"%.2f",user.body_fat_per];
        }
    }
    else{
        ageLabel.text=@"未知";
        heightLabel.text=@"未知";
        weightLabel.text=@"未知";
        bmiLabel.text=@"未知";
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

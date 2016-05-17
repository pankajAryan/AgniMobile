/* 
 
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of Philip Kluz, 'zuui.org' nor the names of its contributors may 
 be used to endorse or promote products derived from this software 
 without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL PHILIP KLUZ BE LIABLE FOR ANY DIRECT, 
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SideViewController.h"
#import "CustomNavigation.h"
#import "CommonHeader.h"
#import "SideViewCell.h"
#import "AboutViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "GlobalDataPersistence.h"
#import "MyProfileViewController.h"
#import "ContactViewController.h"
#import "ALUtilityClass.h"

@interface SideViewController()
{
   
}
@property(nonatomic,strong)IBOutlet EGOImageView *imgSchool;
@property(nonatomic,strong)IBOutlet UILabel *lblSchoolName;
@end

@implementation SideViewController
@synthesize tblViewSide;

- (void)viewDidLoad
{
   // [CustomNavigation addTarget:self backRequired:NO title:@""];
    for (UIView *v1 in self.view.subviews)
    {
        if ([v1 isKindOfClass:[CommonHeader class]])
        {
            for (UIView *view in v1.subviews)
            {
                if ([view isKindOfClass:[UIButton class]])
                {
                    //view.hidden = YES;
                }
            }
        }
    }
    

    
    self.arrMenuItems = [NSArray arrayWithObjects:@"About",@"Contact Us",@"Rate the App",@"My Profile",@"Logout",nil];
    self.arrImages = [NSArray arrayWithObjects:@"about.png",@"contact.png",@"rate_app.png",@"profile.png",@"logout.png",nil];
    NSLog(@"width=%f",[UIScreen mainScreen].applicationFrame.size.width);
    NSLog(@"height=%f",[UIScreen mainScreen].applicationFrame.size.height);
    NSLog(@"self.view=%@",[self.view description]);
    
    GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
    
    NSLog(@"%@",[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolImage"] );
    
    self.imgSchool.placeholderImage = [UIImage imageNamed:@"app_logo.png"];
    [self.imgSchool setImageURL:[NSURL URLWithString:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolImage"]]];
    self.lblSchoolName.text=[NSString stringWithFormat:@"  %@",[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolName"]];
    
   
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, [UIScreen mainScreen].applicationFrame.size.height+20);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrMenuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SideViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SideViewCell"];
    if (cell == nil)
    {
        UIViewController *view1=[[UIViewController alloc]initWithNibName:@"SideViewCell" bundle:nil];
        cell=(SideViewCell *)view1.view;
        
    }
    cell.lblHeading.text=[self.arrMenuItems objectAtIndex:indexPath.row];
   [cell.imgIcon setImage:[UIImage imageNamed:[self.arrImages objectAtIndex:indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
	{
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            AboutViewController *searchTool = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
           // NSArray *controllers = [NSArray arrayWithObject:searchTool];
            //navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            [navigationController pushViewController:searchTool animated:YES];

        }
    }
    if (indexPath.row == 1)
	{
        ContactViewController *searchTool = [[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
       
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        [navigationController pushViewController:searchTool animated:YES];


	}
    if (indexPath.row == 2)
	{
        // Rate app.
        NSString * appId = @"1010170694";

        NSString *theUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",appId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:theUrl]];
	}
    if (indexPath.row == 3)
	{
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            MyProfileViewController *searchTool = [[MyProfileViewController alloc] initWithNibName:@"MyProfileViewController" bundle:nil];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            //[navigationController pushViewController:searchTool animated:YES];

            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            [navigationController pushViewController:searchTool animated:YES];

        }
	}
    if (indexPath.row == 4)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Logout from AgnitioMobile" message:@"Are you sure?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel",@"Yes", nil];
        alertView.tag = 1;
        [alertView show];
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ( (alertView.tag == 1) && (buttonIndex == 1)) {
        AppDelegate *appdel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        LoginViewController *LoginViewObj=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
        
        appdel.navigationController= [[UINavigationController alloc]initWithRootViewController:LoginViewObj];
        [appdel.navigationController setNavigationBarHidden:YES];
        [appdel.window setRootViewController:appdel.navigationController];
        
        [ALUtilityClass SaveDatatoUserDefault:@"NO" :@"isLoggedIn"];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
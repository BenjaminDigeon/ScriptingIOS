//
//  ScriptsListViewController.m
//  ScriptingIOS
//
//  Created by Benjamin Digeon on 24/04/13.
//  Copyright (c) 2013 Benjamin Digeon. All rights reserved.
//

#import "ScriptsListViewController.h"
#import "ScriptViewController.h"

@interface ScriptsListViewController ()
    @property(nonatomic,retain) NSArray * files;
@end

@implementation ScriptsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.files = [[NSBundle mainBundle] pathsForResourcesOfType:nil inDirectory:@"Scripts/."];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}


/***************************************************************************************************************************************/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.files count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[NSString stringWithFormat:@"%@",[self.files objectAtIndex:indexPath.row]] lastPathComponent];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ScriptViewController* newView = [[ScriptViewController alloc] initWithNibName:@"ScriptViewController" bundle:nil];
    newView.path = [NSString stringWithFormat:@"%@",[self.files objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:newView animated:YES];
    
}
@end

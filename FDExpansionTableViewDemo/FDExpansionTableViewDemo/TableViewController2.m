//
//  TableViewController2.m
//  FDExpansionTableViewDemo
//
//  Created by fergusding on 15/10/9.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#define SectionCount 5
#define ExpandCount 3

#import "TableViewController2.h"

@interface TableViewController2 ()

@property (assign, nonatomic) BOOL isExpand;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation TableViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isExpand = NO;
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (NSArray *)indexPathsForExpandSection:(NSInteger)section {
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i = 1; i <= ExpandCount; i++) {
        NSIndexPath *idxPth = [NSIndexPath indexPathForRow:i inSection:section];
        [indexPaths addObject:idxPth];
    }
    return [indexPaths copy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isExpand && self.selectedIndexPath.section == section) {
        return 1 + ExpandCount;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.isExpand && self.selectedIndexPath.section == indexPath.section) {     // Expand Cell
        cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    } else {    // Normal Cell
        cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell" forIndexPath:indexPath];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isExpand && self.selectedIndexPath.section == indexPath.section && indexPath.row != 0) {
        return 77;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.selectedIndexPath) {
        self.isExpand = YES;
        self.selectedIndexPath = indexPath;
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:[self indexPathsForExpandSection:indexPath.section] withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
    } else {
        if (self.isExpand) {
            if (self.selectedIndexPath == indexPath) {
                self.isExpand = NO;
                [self.tableView beginUpdates];
                [self.tableView deleteRowsAtIndexPaths:[self indexPathsForExpandSection:indexPath.section] withRowAnimation:UITableViewRowAnimationTop];
                [self.tableView endUpdates];
                self.selectedIndexPath = nil;
            } else if (self.selectedIndexPath.row != indexPath.row && indexPath.section <= self.selectedIndexPath.section) {
                // Select the expand cell, do the relating dealing.
            } else {
                self.isExpand = NO;
                [self.tableView beginUpdates];
                [self.tableView deleteRowsAtIndexPaths:[self indexPathsForExpandSection:self.selectedIndexPath.section] withRowAnimation:UITableViewRowAnimationTop];
                [self.tableView endUpdates];
                self.selectedIndexPath = nil;
            }
        }
    }
}

@end

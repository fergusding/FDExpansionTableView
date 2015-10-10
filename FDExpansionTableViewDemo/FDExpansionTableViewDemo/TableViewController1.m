//
//  TableViewController1.m
//  FDExpansionTableViewDemo
//
//  Created by fergusding on 15/10/9.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#define CellCount 5
#define ExpandCount 3

#import "TableViewController1.h"

@interface TableViewController1 ()

@property (assign, nonatomic) BOOL isExpand;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation TableViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isExpand = NO;
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (NSArray *)indexPathsForExpandRow:(NSInteger)row {
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i = 1; i <= ExpandCount; i++) {
        NSIndexPath *idxPth = [NSIndexPath indexPathForRow:row + i inSection:0];
        [indexPaths addObject:idxPth];
    }
    return [indexPaths copy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isExpand) {
        return CellCount + ExpandCount;
    }
    return CellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.isExpand && self.selectedIndexPath.row < indexPath.row && indexPath.row <= self.selectedIndexPath.row + ExpandCount) {   // Expand cell
        cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    } else {    // Normal cell
        cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell" forIndexPath:indexPath];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isExpand && self.selectedIndexPath.row < indexPath.row && indexPath.row <= self.selectedIndexPath.row + ExpandCount) {
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
        [self.tableView insertRowsAtIndexPaths:[self indexPathsForExpandRow:indexPath.row] withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
    } else {
        if (self.isExpand) {
            if (self.selectedIndexPath == indexPath) {
                self.isExpand = NO;
                [self.tableView beginUpdates];
                [self.tableView deleteRowsAtIndexPaths:[self indexPathsForExpandRow:indexPath.row] withRowAnimation:UITableViewRowAnimationTop];
                [self.tableView endUpdates];
                self.selectedIndexPath = nil;
            } else if (self.selectedIndexPath.row < indexPath.row && indexPath.row <= self.selectedIndexPath.row + ExpandCount) {
                // Select the expand cell, do the relating dealing.
            } else {
                self.isExpand = NO;
                [self.tableView beginUpdates];
                [self.tableView deleteRowsAtIndexPaths:[self indexPathsForExpandRow:self.selectedIndexPath.row] withRowAnimation:UITableViewRowAnimationTop];
                [self.tableView endUpdates];
                self.selectedIndexPath = nil;
            }
        }
    }
}

@end

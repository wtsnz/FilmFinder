//
//  FLMFilmsTableViewController.m
//  FilmFinder
//
//  Created by Will Townsend on 19/08/14.
//  Copyright (c) 2014 wtsnz. All rights reserved.
//

#import "FLMFilmsTableViewController.h"

#import "FLMFilm.h"

#import "FLMFilmTableViewCell.h"

@interface FLMFilmsTableViewController ()

@property (strong, nonatomic) NSArray *films;

@end

@implementation FLMFilmsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Films";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:FLMFilmTableViewCell.class forCellReuseIdentifier:[FLMFilmTableViewCell reuseIdentifier]];
    
    [FLMFilm fetchFilms:^(NSArray *films, NSError *error) {
        self.films = films;
        [self.tableView reloadData];
    }];
    
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (NSInteger) self.films.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FLMFilmTableViewCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLMFilmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[FLMFilmTableViewCell reuseIdentifier] forIndexPath:indexPath];
    
    FLMFilm *film = self.films[(NSUInteger)indexPath.row];
    
    [cell configureWithFLMFilm:film];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLMFilm *film = self.films[(NSUInteger)indexPath.row];
    [film download];
}

@end

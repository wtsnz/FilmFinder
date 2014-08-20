//
//  FLMFilmTableViewCell.m
//  FilmFinder
//
//  Created by Will Townsend on 20/08/14.
//  Copyright (c) 2014 wtsnz. All rights reserved.
//

#import "FLMFilmTableViewCell.h"

#import "FLMFilm.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface FLMFilmTableViewCell ()

@property (strong, nonatomic) UILabel *filmTitleLabel;
@property (strong, nonatomic) UILabel *filmTagLineLabel;
@property (strong, nonatomic) UILabel *filmPlotLabel;
@property (strong, nonatomic) UIImageView *coverImageView;

@end

@implementation FLMFilmTableViewCell

static NSString * const kReuseIdentifier = @"FilmCell";

#pragma mark - Class

+ (NSString *)reuseIdentifier
{
    return kReuseIdentifier;
}

+ (CGFloat)heightForCell
{
    return 160.0;
}

#pragma mark - Instance

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.filmTitleLabel];
        [self.contentView addSubview:self.filmTagLineLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.coverImageView.width = self.contentView.width * 0.3f;
    self.coverImageView.left = 10.0f;
    self.coverImageView.top = 10.0f;
    self.coverImageView.height = self.contentView.height - 20.0f;
    
    self.filmTitleLabel.top = self.coverImageView.top;
    self.filmTitleLabel.width = self.contentView.width - 10 - self.coverImageView.width - 10 - 10;
    self.filmTitleLabel.left = self.coverImageView.right + 10.0f;
    [self.filmTitleLabel sizeToFit];
    
    self.filmTagLineLabel.top = self.filmTitleLabel.bottom;
    self.filmTagLineLabel.width = self.contentView.width - 10 - self.coverImageView.width - 10 - 10;
    self.filmTagLineLabel.left = self.coverImageView.right + 10.0f;
    [self.filmTagLineLabel sizeToFit];
    
}

- (void)configureWithFLMFilm:(FLMFilm *)film
{
    [self.coverImageView setImageWithURL:film.coverURL];
    
    self.filmTitleLabel.text = [NSString stringWithFormat:@"%@ (%@) %@", film.infoImdbTitle, film.infoImdbYear, film.infoImdbScore];
    self.filmTagLineLabel.text = film.infoImdbTagline;
    
}

- (void)prepareForReuse
{
    self.coverImageView.image = nil;
}

#pragma mark - Getters

- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _coverImageView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3f];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImageView;
}

- (UILabel *)filmTitleLabel
{
    if (!_filmTitleLabel) {
        _filmTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _filmTitleLabel.numberOfLines = 0;
    }
    return _filmTitleLabel;
}

- (UILabel *)filmTagLineLabel
{
    if (!_filmTagLineLabel) {
        _filmTagLineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _filmTagLineLabel.numberOfLines = 0;
    }
    return _filmTagLineLabel;
}

@end

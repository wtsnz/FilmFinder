//
//  FLMFilmTableViewCell.h
//  FilmFinder
//
//  Created by Will Townsend on 20/08/14.
//  Copyright (c) 2014 wtsnz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLMFilm;

@interface FLMFilmTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (CGFloat)heightForCell;

- (void)configureWithFLMFilm:(FLMFilm *)film;

@end

//
//  FLMFilm.h
//  FilmFinder
//
//  Created by Will Townsend on 19/08/14.
//  Copyright (c) 2014 wtsnz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLMFilm : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *guid;
@property (strong, nonatomic) NSURL *link;
@property (strong, nonatomic) NSString *category;

@property (strong, nonatomic) NSString *size;
@property (strong, nonatomic) NSString *files;
@property (strong, nonatomic) NSString *poster;
@property (strong, nonatomic) NSString *infoImdbId;
@property (strong, nonatomic) NSString *infoImdbTitle;
@property (strong, nonatomic) NSString *infoImdbTagline;
@property (strong, nonatomic) NSString *infoImdbPlot;
@property (strong, nonatomic) NSString *infoImdbScore;
@property (strong, nonatomic) NSString *infoImdbGenre;
@property (strong, nonatomic) NSString *infoImdbYear;
@property (strong, nonatomic) NSString *infoImdbDirector;
@property (strong, nonatomic) NSString *infoImdbActors;
@property (strong, nonatomic) NSString *grabs;
@property (strong, nonatomic) NSString *comments;
@property (strong, nonatomic) NSString *datePosted;

@property (strong, nonatomic) NSURL *posterURL;
@property (strong, nonatomic) NSURL *coverURL;

+ (void)fetchFilms:(void (^)(NSArray *films, NSError *error))completion;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)download;

@end

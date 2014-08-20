//
//  FLMFilm.m
//  FilmFinder
//
//  Created by Will Townsend on 19/08/14.
//  Copyright (c) 2014 wtsnz. All rights reserved.
//

#import "FLMFilm.h"

#import "FLMAPIClient.h"

@implementation FLMFilm

#pragma mark - Class

+ (void)fetchFilms:(void (^)(NSArray *films, NSError *error))completion
{
    [[FLMAPIClient shared] fetchLatestFilmsWithCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                return completion(nil, error);
            });
        }
        
        NSArray *films = nil;
        
        if (data) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            if (dictionary) {
                NSLog(@"%@", dictionary);
                
                id channel = dictionary[@"channel"];
                
                if (channel && [channel isKindOfClass:NSDictionary.class]) {
                    
                    id items = channel[@"item"];
                    
                    if (items && [items isKindOfClass:NSArray.class]) {
                        
                        NSMutableArray *mutableFilms = [NSMutableArray array];
                        
                        for (NSDictionary *filmDictionary in items) {
                            
                            FLMFilm *film = [[FLMFilm alloc] initWithDictionary:filmDictionary];
                            [mutableFilms addObject:film];
                            
                        }
                        
                        films = mutableFilms;
                        
                    }
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            return completion(films, nil);
        });
        
    }];
    
}

#pragma mark - Instance

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        NSString *title = dictionary[@"title"];
        if (title) {
            self.title = title;
        }
        
        NSString *guid = dictionary[@"guid"];
        if (guid) {
            self.guid = guid;
        }
        
        NSString *link = dictionary[@"link"];
        if (link) {
            self.link = [NSURL URLWithString:link];
        }
        
        NSString *category = dictionary[@"category"];
        if (category) {
            self.category = category;
        }
        
        NSArray *attributes = dictionary[@"attr"];
        
        if (attributes) {
            
            for (NSDictionary *attrDictionary in attributes) {
                
                NSDictionary *attrInnerDictionary = attrDictionary[@"@attributes"];
                
                if (attrInnerDictionary) {
                    
                    NSString *name = attrInnerDictionary[@"name"];
                    NSString *value = attrInnerDictionary[@"value"];
                    
                    if ([name isEqualToString:@"size"]) {
                        self.size = value;
                    } else if ([name isEqualToString:@"files"]) {
                        self.files = value;
                    } else if ([name isEqualToString:@"poster"]) {
                        self.poster = value;
                    } else if ([name isEqualToString:@"imdb"]) {
                        self.infoImdbId = value;
                    } else if ([name isEqualToString:@"imdbtitle"]) {
                        self.infoImdbTitle = value;
                    } else if ([name isEqualToString:@"imdbtagline"]) {
                        self.infoImdbTagline = value;
                    } else if ([name isEqualToString:@"imdbplot"]) {
                        self.infoImdbPlot = value;
                    } else if ([name isEqualToString:@"imdbscore"]) {
                        self.infoImdbScore = value;
                    } else if ([name isEqualToString:@"genre"]) {
                        self.infoImdbGenre = value;
                    } else if ([name isEqualToString:@"imdbyear"]) {
                        self.infoImdbYear = value;
                    } else if ([name isEqualToString:@"imdbdirector"]) {
                        self.infoImdbDirector = value;
                    } else if ([name isEqualToString:@"imdbactors"]) {
                        self.infoImdbActors = value;
                    } else if ([name isEqualToString:@"grabs"]) {
                        self.grabs = value;
                    } else if ([name isEqualToString:@"comments"]) {
                        self.comments = value;
                    } else if ([name isEqualToString:@"usenetdate"]) {
                        self.datePosted = value;
                    } else if ([name isEqualToString:@"coverurl"]) {
                        self.coverURL = [NSURL URLWithString:value];
                    }
                    
                }
                
            }
            
        }
        
        
    }
    return self;
}

- (void)download
{
    [[FLMAPIClient shared] sendNZBURLToSABnzb:self.link completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", response);
    }];
}


@end

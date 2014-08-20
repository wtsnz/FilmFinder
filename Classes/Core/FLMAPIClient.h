//
//  FLMAPIClient.h
//  
//
//  Created by Will Townsend on 19/08/14.
//
//

#import <Foundation/Foundation.h>

@interface FLMAPIClient : NSObject

+ (FLMAPIClient *)shared;

- (void)fetchLatestFilmsWithCompletion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion;
- (void)sendNZBURLToSABnzb:(NSURL *)url completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion;

@end

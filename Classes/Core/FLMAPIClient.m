//
//  FLMAPIClient.m
//  
//
//  Created by Will Townsend on 19/08/14.
//
//

#import "FLMAPIClient.h"

#import "constants.h"

@interface FLMAPIClient ()

@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSURLSession *urlSession;
@property (strong, nonatomic) NSURLSessionConfiguration *urlSessionConfiguration;

@end

@implementation FLMAPIClient

#pragma mark - Class

+ (FLMAPIClient *)shared
{
    static FLMAPIClient *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

#pragma mark - NSObject

- (instancetype)init
{
    if (self = [super init]) {
        self.urlSession = [NSURLSession sessionWithConfiguration:self.urlSessionConfiguration];
    }
    return self;
}

#pragma mark - Data

- (void)fetchLatestFilmsWithCompletion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion
{
    NSURL *url = [NSURL URLWithString:kNZBFINDERMOVIEWURL];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.allHTTPHeaderFields = [self headersForDataRequest];
    
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:request completionHandler:completion];
    
    [task resume];
}

- (void)sendNZBURLToSABnzb:(NSURL *)nzbUrl completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion
{
    
    [self makeTinyURL:nzbUrl completion:^(NSURL *tinyUrl, NSError *error) {
        
        if (!tinyUrl) {
            
            NSLog(@"Failed");
            return completion(nil, nil, nil);
            
        }
        
        //NSString *nzburl = [NSString stringWithFormat:@"%@&apikey=82f0aefb3e943b98c578f3f759c7bd02", [tinyUrl absoluteString]];
   //
        
        NSString *sabURL = [NSString stringWithFormat:@"%@api?mode=addurl&name=%@&cat=%@&apikey=%@", kSABNZBURL, [tinyUrl absoluteString], kSABNZBFILMCATEGORY, kSABNZBAPIKEY];
        
        NSURL *url = [NSURL URLWithString:[sabURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.allHTTPHeaderFields = [self headersForDataRequest];
        
        NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:request completionHandler:completion];
        
        [task resume];
        
    }];
    
    
}

- (void)makeTinyURL:(NSURL *)url completion:(void (^)(NSURL *tinyUrl, NSError *error))completion
{
    
    NSString *tinyUrl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@", [url absoluteString]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:tinyUrl]];
    request.allHTTPHeaderFields = [self headersForDataRequest];
    
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            return completion(nil, error);
        }
        
        NSString *tinyUrled = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (tinyUrl) {
            NSURL *url = [NSURL URLWithString:tinyUrled];
            
            if (url) {
                return completion(url, nil);
            }
            
        }
        
        return completion(nil, [NSError errorWithDomain:@"com.wtsnz.film" code:0 userInfo:nil]);
        
        
    }];
    
    [task resume];
}

#pragma mark - Getters

- (NSURLSessionConfiguration *)urlSessionConfiguration
{
    if (!_urlSessionConfiguration) {
        _urlSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    return _urlSessionConfiguration;
}

- (NSDictionary *)headersForDataRequest
{
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    
    [headers setObject:@"application/json" forKey:@"Content-Type"];
    [headers setObject:@"application/json" forKey:@"Accept"];
    
    return headers;
}


@end

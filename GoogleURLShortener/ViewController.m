//
//  ViewController.m
//  GoogleURLShortener
//
//  Created by Jose on 19/4/18.
//  Copyright © 2018 Copanonga. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    NSLog(@"\nViewController");
    [super viewDidLoad];
    
    [self getURLShortener];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)getURLShortener {
    
    // URL: https://www.googleapis.com/urlshortener/v1/url?key=API_KEY
    
    NSString *URL_BASE = [NSString stringWithFormat:@"https://www.googleapis.com/urlshortener/v1/url?key="];
    NSString *API_KEY = [NSString stringWithFormat:@"API_KEY"];
    NSString *URL = [NSString stringWithFormat:@"%@%@",URL_BASE, API_KEY];
    
    NSString *longURL = [NSString stringWithFormat:@"https://github.com/copanonga"];
    
    NSArray *campos = [NSArray arrayWithObjects:@"longUrl",nil];
    NSArray *valores = [NSArray arrayWithObjects:longURL, nil];
    NSDictionary *parametros = [NSDictionary dictionaryWithObjects:valores forKeys:campos];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:URL parameters:parametros progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError* error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                                                           options:0
                                                             error:&error];
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:jsonData
                              options:kNilOptions
                              error:&error];
        
        NSLog(@"JSON: %@", json);
        NSLog(@"Short URL: %@", [json objectForKey:@"id"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error getURLShortener: %@", error);
    }];
    
}

@end

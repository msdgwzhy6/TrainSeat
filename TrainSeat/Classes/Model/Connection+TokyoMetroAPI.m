//
//  Connection+TokyoMetroAPI.m
//  TrainSeat
//
//  Created by Jin Sasaki on 2014/10/28.
//  Copyright (c) 2014年 Jin Sasaki. All rights reserved.
//

#import "Connection+TokyoMetroAPI.h"

@implementation Connection (TokyoMetroAPI)

- (void)sendRequestWithOdptType:(OdptType)type andQuery:(NSDictionary *)query {
    
    NSURL *url = [Connection createURLWithOdptType:type andQuery:query];
    [self sendRequestWithURL:url];
    
}

// タイプでリクエストを送る
- (void)sendRequestWithOdptType:(OdptType)type {
    
    NSURL *url = [Connection createURLWithOdptType:type andQuery:nil];
    [self sendRequestWithURL:url];
}

- (NSData *)connectBySynchronousRequestWithOdptType:(OdptType)type{
    NSURL *url = [Connection createURLWithOdptType:type andQuery:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error) {
        LOG_METHOD;
        LOG(@"%@",error);
    }
    return data;
    
}

// クエリを用いて接続
- (NSData *)connectBySynchronousRequestWithOdptType:(OdptType)type andQuery:(NSDictionary *)query {
    NSURL *url = [Connection createURLWithOdptType:type andQuery:query];
    LOG_PRINTF(@"Request to \n%@", url);

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error) {
        LOG_METHOD;
        LOG(@"%@",error);
    }
    if (data == nil) {
        LOG(@"data is nil!!!!");
    }
    return data;
    
}

//https //api.tokyometroapp.jp/api/v2/datapoints?rdf:type=odpt:StationTimetable&odpt:station=odpt.Station:TokyoMetro.Marunouchi.Ginza&acl:consumerKey=3b81939a6c9d1b5ba703e05e0855e670053ecd49172013ed7ecb61e3dea28a71


// URLの生成
+ (NSURL *)createURLWithOdptType:(OdptType)type andQuery:(NSDictionary *)query {
    
    // アクセストークンとベースのURL
    NSString *urlStr = [NSString
                        stringWithFormat:@"%@?acl:consumerKey=%@",
                        ORIGIN_DATA,
                        ACCESS_TOKEN
                        ];
    
    // クエリのタイプを追加
    NSString *appendType = [NSString stringWithFormat:@"&%@=%@&",StringWithParameter(ParameterRdfType),StringWithOdptType(type)];
    urlStr = [urlStr stringByAppendingString:appendType];
    
    // クエリがあればそれに従って生成
    if (query) {
        urlStr = [urlStr stringByAppendingString:[Connection createURLStringWithQuery:query]];
    }
    return [NSURL URLWithString:urlStr];
}

+ (NSString *)createURLStringWithQuery:(NSDictionary *)query {
    NSString *urlStr = @"";
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in query) {
        NSString *appendQuery = [NSString stringWithFormat:@"%@=%@",key,query[key]];
        [array addObject:appendQuery];
    }
    urlStr = [array componentsJoinedByString:@"&"];

    return urlStr;
}

@end

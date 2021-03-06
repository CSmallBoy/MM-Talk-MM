//
//  HCHomePublishApi.m
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomePublishApi.h"
#import "HCHomeInfo.h"

@implementation HCHomePublishApi

- (void)startRequest:(HCHomePublishBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"FamilyTimes/FamilyTimes.ashx";
}

- (id)requestArgument
{
    NSString *permitUserString = @"";
    if (!IsEmpty(_PermitUserArr))
    {
        permitUserString = [_PermitUserArr componentsJoinedByString:@","];
    }
    if (IsEmpty(_FTImages))
    {
        _FTImages = @[];
    }
    
    NSDictionary *head = @{@"Action": @"Publish", @"Token": [HCAccountMgr manager].loginInfo.Token, @"UUID": [HCAppMgr manager].uuid, @"PlatForm": [HCAppMgr manager].systemVersion};
    
    NSString *defaultFamilyId = [HCAccountMgr manager].loginInfo.DefaultFamilyID;
    
    NSDictionary *entity = @{
                             @"FamilyID": [Utils getNumberWithString:defaultFamilyId],
                             @"FTImages": _FTImages,
                             @"FTContent": _FTContent,
                             @"OpenAddress": @([_OpenAddress integerValue]),
                             @"PermitType": @([_PermitType integerValue]),
                             @"PermitUserArr": permitUserString,
                             @"CreateLocation": [NSString stringWithFormat:@"%@,%@", [HCAppMgr manager].longitude, [HCAppMgr manager].latitude],
                             @"CreateAddrSmall": [HCAppMgr manager].addressSmall,
                             @"CreateAddr": [HCAppMgr manager].address
                             };
    
    NSDictionary *body = @{@"Head": head, @"Entity": entity};
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    NSDictionary *dic = responseObject[@"Data"][@"TimeInf"];
    return [HCHomeInfo mj_objectWithKeyValues:dic];
}

@end

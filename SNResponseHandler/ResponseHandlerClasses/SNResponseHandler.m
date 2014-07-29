//
//  SNResponseHandler.m
//  SNResponseHandler
//
//  Created by Sanju Naik on 7/28/14.
//  Copyright (c) 2014 Sanju Naik. All rights reserved.
//

#import "SNResponseHandler.h"

@implementation SNResponseHandler

+ (SNResponseHandler*)sharedInstance
{
    static SNResponseHandler *responseHandler = nil;
    
    if (responseHandler == nil)
    {
        responseHandler = [[self alloc] init];
        
    }
    return responseHandler;
}

- (BOOL)isSuccessResponse:(NSDictionary *)response
{
    BOOL status = YES;
    
    NSArray *allKeys = [response allKeys];
    
    for (NSString *key in allKeys)
    {
        if([[response objectForKey:key] isKindOfClass:[NSString class]])
        {
            if(![[response objectForKey:key] length])
            {
                status = NO;
                break;
            }
            
        }
        else if([[response objectForKey:key] isKindOfClass:[NSNumber class]])
        {
            status = YES;
        }
        else if ([[response objectForKey:key] isKindOfClass:[NSDictionary class]])
        {
            status = [self isSuccessResponse:[response objectForKey:key]];
            if(status == NO)
                break;
            
        }
        else if ([[response objectForKey:key] isKindOfClass:[NSArray class]] && [[response objectForKey:key] count])
        {
            status = [self validateArray:[response objectForKey:key]];
        }
        else
            status = NO;
    }
    
    return status;
}

- (BOOL)validateArray:(NSArray*)array
{
    BOOL status = YES;
    
    for (id obj in array)
    {
        if([obj isKindOfClass:[NSDictionary class]])
        {
            status = [self isSuccessResponse:obj];
            if(status == NO)
                break;
        }
    }
    
    return status;
}

- (void)showErrorAlert
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Server failed to respond please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}


@end

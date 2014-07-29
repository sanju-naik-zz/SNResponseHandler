//
//  SNResponseHandler.h
//  SNResponseHandler
//
//  Created by Sanju Naik on 7/28/14.
//  Copyright (c) 2014 Sanju Naik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNResponseHandler : NSObject

+ (SNResponseHandler*)sharedInstance;

- (BOOL)isSuccessResponse:(NSDictionary*)response;

- (void)showErrorAlert;

@end

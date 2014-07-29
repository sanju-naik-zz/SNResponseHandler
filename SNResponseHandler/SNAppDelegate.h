//
//  SNAppDelegate.h
//  SNResponseHandler
//
//  Created by Sanju Naik on 7/28/14.
//  Copyright (c) 2014 Sanju Naik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>

#define sharedAppDelegate ((SNAppDelegate*)[[UIApplication sharedApplication] delegate])

@protocol CYFBLoginDelegate <NSObject>

-(void)sessionSuccess;

@end

@interface SNAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic,weak) id<CYFBLoginDelegate> delegate;

@property (strong, nonatomic) UIWindow *window;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;


@end

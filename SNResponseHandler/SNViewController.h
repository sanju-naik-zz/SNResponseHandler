//
//  SNViewController.h
//  SNResponseHandler
//
//  Created by Sanju Naik on 7/28/14.
//  Copyright (c) 2014 Sanju Naik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNViewController : UIViewController<CYFBLoginDelegate>

- (IBAction)loginWithFacebook:(id)sender;

-(void)getUserDetails;


@end

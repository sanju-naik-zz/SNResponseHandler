//
//  SNViewController.m
//  SNResponseHandler
//
//  Created by Sanju Naik on 7/28/14.
//  Copyright (c) 2014 Sanju Naik. All rights reserved.
//

#import "SNViewController.h"
#import "SNResponseHandler.h"

@interface SNViewController ()

@end

@implementation SNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Response Handler";
    [self setNeedsStatusBarAppearanceUpdate];
    
    /*Creating Object
     PFObject *libraryObject = [PFObject objectWithClassName:@"LibraryObject"];
     NSDictionary *bookDict1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"20",@"book_id",@"test-link",
     @"book_url",@"test-name",@"book_name", nil];
     NSDictionary *bookDict2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"21",@"book_id",@"test-link",
     @"book_url",@"test-name",@"book_name", nil];
     NSArray *bookArray = [[NSArray alloc]initWithObjects:bookDict1,bookDict2, nil];
     libraryObject[@"details"] = [[NSDictionary alloc]initWithObjectsAndKeys:@"testLibrary",@"libraryName",@"Koramangala Bangalore",@"address",bookArray,@"books",userDict,@"readingUser", nil];
     [libraryObject saveInBackground];
     [self showLibraryDetails];*/

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginWithFacebook:(id)sender
{
    [FBSession openActiveSessionWithReadPermissions:[NSArray arrayWithObjects: @"public_profile", @"email", nil]
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
         sharedAppDelegate.delegate = self;
         [sharedAppDelegate sessionStateChanged:session state:state error:error];
     }];
    
}

- (void)sessionSuccess
{
    [self getUserDetails];
}

-(void)getUserDetails
{
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection,NSDictionary<FBGraphUser> *fb_user,NSError *error)
     {
         if (!error) {
             NSLog(@"Fb user %@",fb_user);
             if (fb_user && [fb_user isKindOfClass:[NSDictionary class]] && [fb_user objectForKey:@"id"]) {
                 
                 dispatch_async(dispatch_get_main_queue(), ^(void)
                                {
                                    [self addUserToLibraryDataAndTestResponse:fb_user];
                                });
             }
             else{
                 dispatch_async(dispatch_get_main_queue(), ^(void)
                                {
                                });
             }
         }
         else {
             dispatch_async(dispatch_get_main_queue(), ^(void)
                            {
                            });
             
         }
         
     }];
}

/*Response handler method, Ideally this would be your success block from server response*/
- (void)addUserToLibraryDataAndTestResponse:(NSDictionary *)userDetails
{
    PFQuery *query = [PFQuery queryWithClassName:@"LibraryObject"];
    [query getObjectInBackgroundWithId:@"8sACuoN0iA" block:^(PFObject *library, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", library);
        
        NSDictionary *userDict = [[NSDictionary alloc]initWithObjectsAndKeys:[userDetails objectForKey:@"first_name"],@"name",[userDetails objectForKey:@"gender"],@"gender", nil];

        
        [library[@"details"] setObject:userDict forKey:@"readingUser"];
        [library saveInBackground];
        NSLog(@"%@", library);
        
        /* Iterate your response from server, go to the inner most level where response structure matches with your data model, Call this method before saving your response into Data model, If it returns YES, you are good to go, else there are one or more nil objects in your response */
       BOOL isSuccessResp = [[SNResponseHandler sharedInstance] isSuccessResponse:library[@"details"]];
        if(isSuccessResp)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Successful response!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            /*Server failed to respond so show this alert*/
            [[SNResponseHandler sharedInstance]showErrorAlert];
        }

    }];
}

@end

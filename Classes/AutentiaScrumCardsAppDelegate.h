//
//  AutentiaScrumCardsAppDelegate.h
//  AutentiaScrumCards
//
//  Created by rcanales on 06/02/10.
//  Copyright Autentia 2010. All rights reserved.
//

@class MainViewController;

@interface AutentiaScrumCardsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;

@end


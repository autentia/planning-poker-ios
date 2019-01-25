//
//  FlipsideViewController.h
//  AutentiaScrumCards
//
//  Created by rcanales on 06/02/10.
//  Copyright Autentia 2010. All rights reserved.
//

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController {
	IBOutlet UIImageView *miControlImagen;
}

@property (assign) NSString* nombreDibujo;
@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
- (IBAction)done;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end


//
//  FlipsideViewController.m
//  AutentiaScrumCards
//
//  Created by rcanales on 06/02/10.
//  Copyright Autentia 2010. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate;
@synthesize nombreDibujo;   // añadimos anotación para getter y setters automáticos


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];   
	
	UIImage* anterior = miControlImagen.image;					// cogemos referencia a imagen anterior
	miControlImagen.image = [UIImage imageNamed:nombreDibujo];	// creamos la nueva
}


- (IBAction)done {
	[self.delegate flipsideViewControllerDidFinish:self];	
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

@end

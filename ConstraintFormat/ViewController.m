//
//  ViewController.m
//  ConstraintFormat
//
//  Created by Stephan Müller on 17/12/15.
//  Copyright © 2015 Stephan Müller. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ConstraintFormat.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create some views
    UIView *background = [[UIView alloc] init];
    background.backgroundColor = [UIColor lightGrayColor];
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"label1";
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"label2";
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"label3";
    label3.backgroundColor = [UIColor yellowColor];
    
    // add views to superview and prepare for auto layout
    NSDictionary *views = NSDictionaryOfVariableBindings(background, label1, label2, label3);
    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:view];
    }
    
    // don't let background view cover the labels
    [self.view sendSubviewToBack:background];
    
    // show bottom bar and top bar
    self.title = @"Layout Test";
    [self.navigationController setToolbarHidden:NO animated:NO];
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    // add toggle function
    UIBarButtonItem *toggle = [[UIBarButtonItem alloc] initWithTitle:@"toggle"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(toggleBottomBar)];
    self.navigationItem.rightBarButtonItem = toggle;
    
    // layout views
    
    // fill space between the top bar and bottom bar with the background view
    [self.view addConstraintsForView:background toFillViewController:self];
    
    // center labels horizontally in their super view (using self keyword)
    [self.view addConstraintWithFormat:@"label1.centerX = self.centerX" views:views];
    [self.view addConstraintWithFormat:@"label2.centerX = self.centerX" views:views];
    [self.view addConstraintWithFormat:@"label3.centerX = self.centerX" views:views];
    
    // manually set width of label3
    [self.view addConstraintWithFormat:@"label3.width = 200" views:views];
    
    // position labels vertically
    [self.view addConstraintWithFormat:@"label1.centerY = background.centerY" views:views];
    [self.view addConstraintWithFormat:@"label2.top = label1.bottom + 10" views:views];
    [self.view addConstraintWithFormat:@"label3.bottom = background.bottom" views:views];
}

- (void)toggleBottomBar {
    [self.navigationController setToolbarHidden:!self.navigationController.toolbarHidden
                                       animated:YES];
}

@end

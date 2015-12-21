//
//  UIView+ConstraintFormat.h
//  Audit
//
//  Created by Stephan Müller on 28/10/14.
//  Copyright (c) 2014 Stephan Müller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ConstraintFormat)

- (void)addConstraintWithFormat:(NSString *)format views:(NSDictionary *)views;

- (void)addConstraintsForView:(UIView *)v1 toFillView:(UIView *)v2;
- (void)addConstraintsForView:(UIView *)view toFillViewController:(UIViewController *)vc;

@end

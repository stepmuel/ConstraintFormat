//
//  UIView+ConstraintFormat.m
//  Audit
//
//  Created by Stephan Müller on 28/10/14.
//  Copyright (c) 2014 Stephan Müller. All rights reserved.
//

#import "UIView+ConstraintFormat.h"

@implementation UIView (ConstraintFormat)

// add constraints with format "view1.attribute1 = multiplier * view2.attribute2 + constant"
// all elements on the right hand side are optional
// defaults: multiplier==1.0; constant==0.0;

- (void)addConstraintWithFormat:(NSString *)format views:(NSDictionary *)views
{
    format = [format stringByReplacingOccurrencesOfString:@"\\s" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, format.length)];
    NSString *pattern = @"(\\w+)\\.(\\w+)=([+-]?[\\d\\.]+\\*)?(([^\\W\\d]\\w*)\\.(\\w+))?([+-]?[\\d\\.]+)?";
    NSRegularExpression *expr = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSTextCheckingResult *match = [expr firstMatchInString:format options:0 range:NSMakeRange(0, format.length)];
    
    // debug regex expression
//    for (int i=0; i<match.numberOfRanges; i++) {
//        NSRange range = [match rangeAtIndex:i];
//        if (range.location==NSNotFound) {
//            NSLog(@"group %d: not found", i);
//        } else {
//            NSString *g = [format substringWithRange:range];
//            NSLog(@"group %d: %@", i, g);
//        }
//    }
//    return;
    
    UIView *item1 = [self viewForName:[format substringWithRange:[match rangeAtIndex:1]] views:views];
    NSLayoutAttribute attr1 = [self attributeForName:[format substringWithRange:[match rangeAtIndex:2]]];
    
    UIView *item2 = nil;
    NSLayoutAttribute attr2 = NSLayoutAttributeNotAnAttribute;
    
    if ([match rangeAtIndex:4].location!=NSNotFound) {
        item2 = [self viewForName:[format substringWithRange:[match rangeAtIndex:5]] views:views];
        attr2 = [self attributeForName:[format substringWithRange:[match rangeAtIndex:6]]];
    }
    
    NSLayoutRelation rel = NSLayoutRelationEqual;
    CGFloat a = [self floatForRange:[match rangeAtIndex:3] inString:format default:1.0];
    CGFloat b = [self floatForRange:[match rangeAtIndex:7] inString:format default:0.0];
    
    NSLayoutConstraint *constr = [NSLayoutConstraint constraintWithItem:item1 attribute:attr1 relatedBy:rel toItem:item2 attribute:attr2 multiplier:a constant:b];
    
    [self addConstraint:constr];
}

- (UIView *)viewForName:(NSString *)name views:(NSDictionary *)views
{
    if ([name isEqualToString:@"self"]) return self;
    return views[name];
}

- (NSLayoutAttribute)attributeForName:(NSString *)name
{
    // same (static) instance of dict will be used every time
    NSDictionary *attributes = @{
        @"notAnAttribute" : @(NSLayoutAttributeNotAnAttribute),
        @"left" : @(NSLayoutAttributeLeft),
        @"right" : @(NSLayoutAttributeRight),
        @"top" : @(NSLayoutAttributeTop),
        @"bottom" : @(NSLayoutAttributeBottom),
        @"leading" : @(NSLayoutAttributeLeading),
        @"trailing" : @(NSLayoutAttributeTrailing),
        @"width" : @(NSLayoutAttributeWidth),
        @"height" : @(NSLayoutAttributeHeight),
        @"centerX" : @(NSLayoutAttributeCenterX),
        @"centerY" : @(NSLayoutAttributeCenterY),
        @"baseline" : @(NSLayoutAttributeBaseline)
    };
    return [attributes[name] integerValue];
}

- (CGFloat)floatForRange:(NSRange)range inString:(NSString *)string default:(CGFloat)d
{
    if (range.location==NSNotFound) return d;
    else return [string substringWithRange:range].doubleValue;
}

// match frame of v1 to frame of v2
- (void)addConstraintsForView:(UIView *)v1 toFillView:(UIView *)v2 {
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v1
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:v2
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0];
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v1
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:v2
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0];
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:v1
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:v2
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0];
    NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v1
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:v2
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0];
    [self addConstraints:@[c1, c2, c3, c4]];
}

// make view use all available space within a view controller without being covered by
// the top- or bottom bar (using top- and bottom layout guides)
- (void)addConstraintsForView:(UIView *)view toFillViewController:(UIViewController *)vc {
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:vc.topLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0];
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:vc.bottomLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0];
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:vc.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0];
    NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:vc.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0];
    [self addConstraints:@[c1, c2, c3, c4]];
}

@end

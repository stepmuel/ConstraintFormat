# ConstraintFormat

A UIView category for convenient NSLayoutConstraint creation using a simple format language.

This repository was created for my [blog post](http://heap.ch/blog/2015/12/21/constraintformat-category/) which contains additional information.

# Usage

UIView+ConstraintFormat enables the creation of NSLayoutConstraints using the format `view1.attribute1 = multiplier * view2.attribute2 + constant`.

{% highlight objective-c %}
NSDictionary *views = NSDictionaryOfVariableBindings(v1, v2);
[self addConstraintWithFormat:@"v1.top = v2.top" views:views];
[self addConstraintWithFormat:@"v1.bottom = v2.bottom" views:views];
[self addConstraintWithFormat:@"v1.left = v2.left" views:views];
[self addConstraintWithFormat:@"v1.right = v2.right" views:views];
{% endhighlight %}

The following attributes are supported:

{% highlight objective-c %}
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

More examples can be found in the included example project (ViewController.m).


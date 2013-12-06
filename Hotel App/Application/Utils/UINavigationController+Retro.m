//
//  UINavigationController+Retro.m
//  Snapfish
//
//  Created by Ernesto Carrión on 11/24/13.
//  Copyright (c) 2013 hp. All rights reserved.
//

#import "UINavigationController+Retro.h"
#import <objc/runtime.h>


@implementation UINavigationController (Retro)

//overrides ios7 push and emulates ios6push because of transparent backgrounds
- (void)pushViewControllerRetro:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (animated) {
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromRight;
        [self.view.layer addAnimation:transition forKey:nil];
    }
    
    //Not a bug, not recursion, just swizzling!
    [self pushViewControllerRetro:viewController animated:NO];
}

//overrides ios7 push and emulates ios6push because of transparent backgrounds
- (void)popViewControllerRetroAnimated:(BOOL)animated{
    
    if (animated) {
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromLeft;
        [self.view.layer addAnimation:transition forKey:nil];
    }
    
    //Not a bug, not recursion, just swizzling!
    [self popViewControllerRetroAnimated:NO];
}

//Exchanges implementation for calling both viewDidLoads
+(void)load {
    
    Method original, swizzled;
    
    original = class_getInstanceMethod(self, @selector(pushViewController:animated:));
    swizzled = class_getInstanceMethod(self, @selector(pushViewControllerRetro:animated:));
    method_exchangeImplementations(original, swizzled);
    
    
    original = class_getInstanceMethod(self, @selector(popViewControllerAnimated:));
    swizzled = class_getInstanceMethod(self, @selector(popViewControllerRetroAnimated:));
    method_exchangeImplementations(original, swizzled);
}

@end

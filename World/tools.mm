//
//  tools.mm
//  World
//
//  Created by Jinwoo Kim on 11/26/23.
//  Copyright © 2023 Apple. All rights reserved.
//

#import "tools.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

extern "C" {
void activateSolarScene() {
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"com.example.apple-samplecode.World.openWindowByID"];
    userActivity.requiredUserInfoKeys = [NSSet setWithObject:@"com.apple.SwiftUI.sceneID"];
    userActivity.userInfo = @{
        @"com.apple.SwiftUI.sceneID": @"Solar"
    };
    
    id options = [NSClassFromString(@"MRUISceneRequestOptions") new];
    id specification = [NSClassFromString(@"MRUISharedApplicationFullscreenSceneSpecification_SwiftUI") new];
    reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(options, NSSelectorFromString(@"setDisableDefocusBehavior:"), YES);
    reinterpret_cast<void (*)(id, SEL, NSUInteger)>(objc_msgSend)(options, NSSelectorFromString(@"setPreferredImmersionStyle:"), 8);
    reinterpret_cast<void (*)(id, SEL, NSUInteger)>(objc_msgSend)(options, NSSelectorFromString(@"setAllowedImmersionStyles:"), 8);
    reinterpret_cast<void (*)(id, SEL, NSUInteger)>(objc_msgSend)(options, NSSelectorFromString(@"setSceneRequestIntent:"), 1002);
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(options, NSSelectorFromString(@"setSpecification:"), specification);
    [specification release];
    
    __kindof UIApplication *sharedApplication = reinterpret_cast<id (*)(Class, SEL)>(objc_msgSend)(NSClassFromString(@"_TtC7SwiftUIP33_ACC2C5639A7D76F611E170E831FCA49118SwiftUIApplication"), @selector(sharedApplication));
    reinterpret_cast<void (*)(id, SEL, id, id, id)>(objc_msgSend)(sharedApplication,
                                                                  NSSelectorFromString(@"mrui_requestSceneWithUserActivity:requestOptions:completionHandler:"),
                                                                  userActivity,
                                                                  options,
                                                                  ^void (NSError * _Nullable error) {
        assert(!error);
    });
    
    [userActivity release];
    [options release];
}
}

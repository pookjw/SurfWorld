//
//  UIApplication+mrui_requestSceneWrapper.mm
//  World
//
//  Created by Jinwoo Kim on 11/26/23.
//  Copyright © 2023 Apple. All rights reserved.
//

#import "UIApplication+mrui_requestSceneWrapper.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation UIApplication (mrui_requestSceneWrapper)

- (void)mruiw_requestVolumetricSceneWithUserActivity:(NSUserActivity *)userActivity completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    [self mruiw_requestSceneWithUserActivity:userActivity preferredImmersionStyle:0 sceneRequestIntent:1005 completionHandler:completionHandler];
}

- (void)mruiw_requestMixedImmersiveSceneWithUserActivity:(NSUserActivity *)userActivity completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    [self mruiw_requestSceneWithUserActivity:userActivity preferredImmersionStyle:2 sceneRequestIntent:1001 completionHandler:completionHandler];
}

- (void)mruiw_requestProgressiveImmersiveSceneWithUserActivity:(NSUserActivity *)userActivity completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    [self mruiw_requestSceneWithUserActivity:userActivity preferredImmersionStyle:4 sceneRequestIntent:1003 completionHandler:completionHandler];
}

- (void)mruiw_requestFullImmersiveSceneWithUserActivity:(NSUserActivity *)userActivity completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    [self mruiw_requestSceneWithUserActivity:userActivity preferredImmersionStyle:8 sceneRequestIntent:1002 completionHandler:completionHandler];
}

- (void)mruiw_requestSceneWithUserActivity:(NSUserActivity *)userActivity preferredImmersionStyle:(NSUInteger)preferredImmersionStyle sceneRequestIntent:(NSUInteger)sceneRequestIntent completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    id options = [NSClassFromString(@"MRUISceneRequestOptions") new];
    id specification = [NSClassFromString(@"MRUISharedApplicationFullscreenSceneSpecification_SwiftUI") new];
    reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(options, NSSelectorFromString(@"setDisableDefocusBehavior:"), YES);
    reinterpret_cast<void (*)(id, SEL, NSUInteger)>(objc_msgSend)(options, NSSelectorFromString(@"setPreferredImmersionStyle:"), preferredImmersionStyle);
    reinterpret_cast<void (*)(id, SEL, NSUInteger)>(objc_msgSend)(options, NSSelectorFromString(@"setAllowedImmersionStyles:"), preferredImmersionStyle);
    reinterpret_cast<void (*)(id, SEL, NSUInteger)>(objc_msgSend)(options, NSSelectorFromString(@"setSceneRequestIntent:"), sceneRequestIntent);
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(options, NSSelectorFromString(@"setSpecification:"), specification);
    [specification release];
    
    reinterpret_cast<void (*)(id, SEL, id, id, id)>(objc_msgSend)(self,
                                                                  NSSelectorFromString(@"mrui_requestSceneWithUserActivity:requestOptions:completionHandler:"),
                                                                  userActivity,
                                                                  options,
                                                                  completionHandler);
    
    [userActivity release];
    [options release];
}

@end

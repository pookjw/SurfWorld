//
//  tools.mm
//  World
//
//  Created by Jinwoo Kim on 11/26/23.
//  Copyright © 2023 Apple. All rights reserved.
//

#import "tools.h"
#import "UIApplication+mrui_requestSceneWrapper.hpp"

extern "C" {
void activateGlobeScene() {
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"com.example.apple-samplecode.World.openWindowByID"];
    userActivity.requiredUserInfoKeys = [NSSet setWithObject:@"com.apple.SwiftUI.sceneID"];
    userActivity.userInfo = @{
        @"com.apple.SwiftUI.sceneID": @"Globe"
    };
    
    [UIApplication.sharedApplication mruiw_requestVolumetricSceneWithUserActivity:userActivity completionHandler:^(NSError * _Nullable error) {
        assert(!error);
    }];
}

void activateOrbitScene() {
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"com.example.apple-samplecode.World.openWindowByID"];
    userActivity.requiredUserInfoKeys = [NSSet setWithObject:@"com.apple.SwiftUI.sceneID"];
    userActivity.userInfo = @{
        @"com.apple.SwiftUI.sceneID": @"Orbit"
    };
    
    [UIApplication.sharedApplication mruiw_requestMixedImmersiveSceneWithUserActivity:userActivity completionHandler:^(NSError * _Nullable error) {
        assert(!error);
    }];
}

void activateSolarScene() {
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"com.example.apple-samplecode.World.openWindowByID"];
    userActivity.requiredUserInfoKeys = [NSSet setWithObject:@"com.apple.SwiftUI.sceneID"];
    userActivity.userInfo = @{
        @"com.apple.SwiftUI.sceneID": @"Solar"
    };
    
    [UIApplication.sharedApplication mruiw_requestFullImmersiveSceneWithUserActivity:userActivity completionHandler:^(NSError * _Nullable error) {
        assert(!error);
    }];
}
}

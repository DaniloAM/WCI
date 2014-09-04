//
//  AppDelegate.m
//  App Teste
//
//  Created by Danilo Augusto Mative on 02/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // ******
    // ******
    // Atualizar a tela de espera
    // ******
    // ******
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}



-(void)application:(UIApplication *)applicationperformFetchWithCompletionHandler:
 (void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"Background fetch started...");
    
    ObjetoFila *fila = [ObjetoFila alloc];
    Json *jsonObject = [[Json alloc] init];
    
    int pessoasAtual = [jsonObject retornaPessoasNaFrente];
    
    BOOL downloadSuccessful = false;
    
    if(pessoasAtual != [fila numeroPessoasNaFrente]) {
        
        downloadSuccessful = true;
        
        [fila filaDiminuiu:pessoasAtual];
        
    }
    
    if (downloadSuccessful) {
        //---set the flag that data is successfully downloaded---
        completionHandler(UIBackgroundFetchResultNewData);
    } else {
        //---set the flag that download is not successful---
        completionHandler(UIBackgroundFetchResultNoData);
    }
    
    NSLog(@"Background fetch completed...");
}


@end

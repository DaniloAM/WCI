//
//  TelaSplash.m
//  App Teste
//
//  Created by Danilo Augusto Mative on 03/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "TelaSplash.h"

@interface TelaSplash ()

@end

@implementation TelaSplash


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSelector:@selector(iniciar) withObject:nil afterDelay:1.5f];
}

-(void)iniciar {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC = [storyboard instantiateViewControllerWithIdentifier:@"telaInicial"];
    [self presentViewController:myVC animated:true completion:NULL];
}



@end

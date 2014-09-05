//
//  TelaSuaVezViewController.m
//  App Teste
//
//  Created by Danilo Augusto Mative on 05/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "TelaSuaVezViewController.h"

@interface TelaSuaVezViewController ()

@end

@implementation TelaSuaVezViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ObjetoFila *fila = [ObjetoFila alloc];
    
    [[self senhaLabel] setText:[NSString stringWithFormat:@"%04d", [fila senhaUsuario]]];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC = [storyboard instantiateViewControllerWithIdentifier:@"telaInicial"];
    [self presentViewController:myVC animated:true completion:NULL];
    
}



@end

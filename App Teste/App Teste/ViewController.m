//
//  ViewController.m
//  App Teste
//
//  Created by Danilo Augusto Mative on 02/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)button {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Deletar" message:@"Tem certeza que deseja deletar o treino neste dia?" delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
    [alertView show];
}


@end

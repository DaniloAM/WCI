//
//  TelaInicialViewController.m
//  App Teste
//
//  Created by Danilo Augusto Mative on 02/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "TelaInicialViewController.h"

@interface TelaInicialViewController ()

@end

@implementation TelaInicialViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self senhaTextField] setDelegate:self];
    
//    Json *json = [[Json alloc] init ];
//    
//    NSArray *array = [json retornaPessoasNaFrente];
}


-(IBAction)entrarNaFila {
    int senha = [[[self senhaTextField] text] intValue];
    
    if(senha < 1 || senha > 9999) {
        NSLog(@"Erro. Senha invalida.");
        
        
        return;
    }
    
    ObjetoFila *fila = [ObjetoFila alloc];
    [fila setSenhaUsuario:senha];
    
    [self proximaTela];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self senhaTextField] resignFirstResponder];
}


-(void)proximaTela {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC = [storyboard instantiateViewControllerWithIdentifier:@"telaEspera"];
    [self presentViewController:myVC animated:true completion:NULL];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = textField.text;
    textField.text = @"";
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        textField.text = textField.placeholder;
    }
    textField.placeholder = @"";
    
    int valor = [textField.text intValue];
    
    if(valor < 1) {
        valor = 1;
    }
    
    if(valor > 9999) {
        valor = 9999;
    }
    
    textField.text = [NSString stringWithFormat:@"%04d", valor];
    
}

@end

//
//  TelaEsperaViewController.m
//  App Teste
//
//  Created by Danilo Augusto Mative on 02/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "TelaEsperaViewController.h"

@interface TelaEsperaViewController ()

@end

@implementation TelaEsperaViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self checaMudancaFila];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setFilaUsuario:[ObjetoFila alloc]];
    
    NSString *str = [NSString stringWithFormat:@"%04d", [[self filaUsuario] senhaUsuario]];
    
    [[self senhaLabel]setText:str];
    
    [[self filaUsuario] inserirNaFilaComSenha];
    
    [self atualizaTela];

}

-(void)sairDaFila {
    
    Json *jsonObject = [[Json alloc] init];
    
    [jsonObject enviarPedidoCancelar];
    
    [self mudarTela:@"telaInicial"];
}

-(void)mudarTela: (NSString *)nomeTela {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC = [storyboard instantiateViewControllerWithIdentifier:nomeTela];
    [self presentViewController:myVC animated:true completion:NULL];
    
}

-(void)atualizaTela {
    
    Json *jsonObject = [[Json alloc] init];
    
    int aux = [jsonObject retornaMediaTempo];
    
    int min = aux / 100;
    int hrs = min / 60;
    int seg = aux - (min * 100);
    
    min = min % 60;

    if(min <= 0 && seg > 1) {
        min = 1;
    }
    
    NSString *str = [NSString stringWithFormat:@"%dh %dmin", hrs, min];
    
    [[self tempoLabel] setText:str];
    
    [[self pessoasLabel] setText:[NSString stringWithFormat:@"%d", [[self filaUsuario] numeroPessoasNaFrente]]];
    
}

-(void)mudaTelaSuaVez {
    [self mudarTela:@"telaSuaVez"];
}

-(int)transformaSegundosEmMinutos : (int)seg {
    return seg / 60;
}

-(int)transformaMinutosEmHoras : (int)min {
    return min / 60;
}

-(void)checaMudancaFila {
    ObjetoFila *fila = [ObjetoFila alloc];
    Json *jsonObject = [[Json alloc] init];
    
    int novoValor = [jsonObject retornaPessoasNaFrente];
    
    if(novoValor != [fila numeroPessoasNaFrente]) {
        [fila filaDiminuiu:novoValor];
    }
    
    [self atualizaTela];
    
    if([fila suaVez] || [fila numeroPessoasNaFrente] == 0) {
        [self performSelector:@selector(mudaTelaSuaVez) withObject:nil afterDelay:6.0f];
    }
    
    else {
        [self performSelector:@selector(checaMudancaFila) withObject:nil afterDelay:20.0f];
    }
    
}

-(IBAction) cancelarFila {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sair" message:@"Tem certeza que deseja sair da fila?" delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        
        return;
    }
    if (buttonIndex == 1) {
        
        [self sairDaFila];
    }
    
}


@end

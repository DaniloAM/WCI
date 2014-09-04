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
    
    int min = [jsonObject retornaMediaTempo];
    int hrs = min / 60;
    
    min = min % 60;
    
    min *= [[self filaUsuario] numeroPessoasNaFrente];

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
    
    if([fila suaVez]) {
        [self mudaTelaSuaVez];
    }
    
    else {
        [self performSelector:@selector(checaMudancaFila) withObject:nil afterDelay:60.0f];
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

//-(IBAction)buttonForVideo {
//    _video++;
//    
//    if(_video > 5) {
//        _video = 1;
//    }
//    
//    switch (_video) {
//        case 1:
//            [[self pessoasLabel] setText:@"6"];
//            [[self tempoLabel] setText:@"1h45min"];
//            break;
//        case 2:
//            [[self pessoasLabel] setText:@"5"];
//            [[self tempoLabel] setText:@"1h25min"];
//            break;
//        case 3:
//            [[self pessoasLabel] setText:@"4"];
//            [[self tempoLabel] setText:@"50min"];
//            break;
//        case 4:
//            [[self pessoasLabel] setText:@"3"];
//            [[self tempoLabel] setText:@"40min"];
//            break;
//        case 5:
//            [[self pessoasLabel] setText:@"2"];
//            [[self tempoLabel] setText:@"20min"];
//            break;
//        default:
//            break;
//    }
//    
//    
//}

//-(IBAction)buttonForVideo2 {
//    [self executaAlarmeSuaVez];
//}


@end

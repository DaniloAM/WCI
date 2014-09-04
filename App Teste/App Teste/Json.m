//
//  Json.m
//  App Teste
//
//  Created by Danilo Augusto Mative on 04/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "Json.h"

@implementation Json

-(int)retornaMediaTempo {
    
    //Mudar a key para a projetada pelo php
    
    ObjetoFila *fila = [ObjetoFila alloc];
    
    NSString *url = [NSString stringWithFormat:@"http://172.246.16.27/danilo/usaBanco.php?tipofuncao=tempomedio&id_fila=%d", [fila senhaUsuario]];
    
    
    _dataJson = [[NSData alloc] initWithContentsOfURL:
                         [NSURL URLWithString:url]];
    
    
    NSError *error;
    
    NSMutableArray *array = [NSJSONSerialization
                             JSONObjectWithData:_dataJson
                             options:NSJSONReadingMutableContainers
                             error:&error];
    
    NSString *str = [[array objectAtIndex:0] objectForKey:@"tempomedio"];
    
    
    NSString *str2 = [str substringWithRange:NSMakeRange(3, 2)];
    
    int tempo = [str2 intValue];
    
    NSString *url2 = [NSString stringWithFormat:@"http://172.246.16.27/danilo/usaBanco.php?tipofuncao=numguiches&id_fila=%d", [fila senhaUsuario]];
    
    
    _dataJson = [[NSData alloc] initWithContentsOfURL:
                 [NSURL URLWithString:url2]];
    
    
    NSError *error2;
    
    NSMutableArray *array2 = [NSJSONSerialization
                             JSONObjectWithData:_dataJson
                             options:NSJSONReadingMutableContainers
                             error:&error2];
    
    NSString *str3 = [[array2 objectAtIndex:0] objectForKey:@"guiche"];
    
    return tempo / [str3 intValue];
    
}

-(int)retornaPessoasNaFrente {
    
    ObjetoFila *fila = [ObjetoFila alloc];
    
    //Ajeitar URL
    NSString *url = [NSString stringWithFormat:@"http://172.246.16.27/danilo/usaBanco.php?tipofuncao=localfila&id_fila=%d", [fila senhaUsuario]];
    
    
    _dataJson = [[NSData alloc] initWithContentsOfURL:
                 [NSURL URLWithString:url]];
    
    
    NSError *error;
    
    NSMutableArray *array = [NSJSONSerialization
                             JSONObjectWithData:_dataJson
                             options:NSJSONReadingMutableContainers
                             error:&error];
    
    NSString *str = [[array objectAtIndex:0] objectForKey:@"fila"];
    
    return [str intValue];
}

-(void)enviarPedidoCancelar {
    
    ObjetoFila *fila = [ObjetoFila alloc];
    
    NSString *url = [NSString stringWithFormat:@"http://172.246.16.27/danilo/usaBanco.php?tipofuncao=cancelarvez&id_fila=%d", [fila senhaUsuario]];
    
    
    _dataJson = [[NSData alloc] initWithContentsOfURL:
                 [NSURL URLWithString:url]];
    
}

@end

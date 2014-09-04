//
//  Json.h
//  App Teste
//
//  Created by Danilo Augusto Mative on 04/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjetoFila.h"

@interface Json : NSObject

@property NSData *dataJson;

-(void)enviarPedidoCancelar;
-(int)retornaPessoasNaFrente;
-(int)retornaMediaTempo;

@end

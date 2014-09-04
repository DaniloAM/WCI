//
//  ObjetoFila.h
//  App Teste
//
//  Created by Danilo Augusto Mative on 02/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Json.h"

@interface ObjetoFila : NSObject

@property int numeroParaAvisos;
@property int numeroPessoasNaFrente;
@property int senhaUsuario;
@property AVAudioPlayer *alarmPlayer;
@property BOOL suaVez;

+(ObjetoFila *)sharedStore;
-(void)filaDiminuiu: (int)numeroAtual;
-(void)inserirNaFilaComSenha;

@end

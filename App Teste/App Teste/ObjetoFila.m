//
//  ObjetoFila.m
//  App Teste
//
//  Created by Danilo Augusto Mative on 02/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "ObjetoFila.h"

@implementation ObjetoFila


-(void)inserirNaFilaComSenha {
    Json *jsonObject = [[Json alloc] init];
    
    _numeroPessoasNaFrente = [jsonObject retornaPessoasNaFrente];
    _numeroParaAvisos = _numeroPessoasNaFrente / 2;

}


-(void)filaDiminuiu: (int)numeroAtual {
    _numeroPessoasNaFrente = numeroAtual;
    
    int aux = [self verificaNecessidadeAlarme];
    
    if(aux == 1) {
        [self executaAlarmePerto];
        //alerta perto
    }
    
    else if(aux == 2) {
        [self executaAlarmeSuaVez];
        //alerta sua vez
    }
    
}


-(int)verificaNecessidadeAlarme {
    
    //Retorna 0 caso nao necessite nada, retorna 1 para alarme de perto
    //e 2 para alarme de sua vez
    
    int metade;
    
    
    //Executa Alerta Sua Vez
    if(_numeroPessoasNaFrente < 1) {
        return 2;
    }
    
    
    if(_numeroParaAvisos <= 3) {
        metade = _numeroParaAvisos - 1;
    }
    
    else metade = _numeroParaAvisos / 2;
    
    
    _numeroParaAvisos = metade;
    
    
    //Necessita Alerta de perto
    if(_numeroPessoasNaFrente <= metade) {
        return 1;
    }
    
    //Não necessita alarme
    return 0;
}


-(void)executaAlarmePerto {
    
    NSURL *sound = [[NSBundle mainBundle] URLForResource:@"blop" withExtension:@"mp3"];
    [self setAlarmPlayer:[[AVAudioPlayer alloc] initWithContentsOfURL:sound error:nil]];
    [[self alarmPlayer] setNumberOfLoops:2];
    [[self alarmPlayer]setVolume:1];
    [[self alarmPlayer] prepareToPlay];
    [[self alarmPlayer] play];
    
}

-(void)executaAlarmeSuaVez {
    
    NSURL *sound = [[NSBundle mainBundle] URLForResource:@"blop" withExtension:@"mp3"];
    [self setAlarmPlayer:[[AVAudioPlayer alloc] initWithContentsOfURL:sound error:nil]];
    [[self alarmPlayer] setNumberOfLoops:5];
    [[self alarmPlayer]setVolume:1];
    [[self alarmPlayer] prepareToPlay];
    [[self alarmPlayer] play];
    
    [self setSuaVez:true];
    
}


+(ObjetoFila *)sharedStore{
    static ObjetoFila *sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+(id) allocWithZone: (struct _NSZone *) zone{
    return [self sharedStore];
}


@end

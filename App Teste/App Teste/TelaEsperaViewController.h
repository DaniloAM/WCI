//
//  TelaEsperaViewController.h
//  App Teste
//
//  Created by Danilo Augusto Mative on 02/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ObjetoFila.h"
#import "Json.h"

@interface TelaEsperaViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *senhaLabel;
@property (weak, nonatomic) IBOutlet UILabel *pessoasLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempoLabel;
@property AVAudioPlayer *alarmPlayer;

@property int segundosEstimados;

@property int video;

@property ObjetoFila *filaUsuario;

@end

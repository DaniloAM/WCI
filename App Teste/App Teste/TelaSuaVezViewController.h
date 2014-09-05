//
//  TelaSuaVezViewController.h
//  App Teste
//
//  Created by Danilo Augusto Mative on 05/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ObjetoFila.h"


@interface TelaSuaVezViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *senhaLabel;
@property AVAudioPlayer  *alarmPlayer;

@end


#include <aJSON.h>
#include <LiquidCrystal.h> //Inclui a biblioteca do LCD
  
  //Jsons para receber e enviar
  aJsonObject *receiver, *sender;
  
  //LCD
  LiquidCrystal lcd(12, 11, 5, 4, 3, 2); //Configura os pinos do Arduino para se comunicar com o LCD
  
  //Pinos das chaves
  const int atd1 = 8;  //chave 3
  const int atd2 = 9;  //chave 4
  const int atd3 = 10; //chave 5
  const int atd4 = 13; //chave 6
  const int atd5 = A5; //analog A0
  const int atd6 = A4; //analog A1
  const int caixa1 = 7; //chave 1
  const int caixa2 = 6; //chave 2
  
  //buzzer e pino analogico 3 com divisor de tensoes
  const int buzzer = A2;
  const int leitura_botao = A3;
  
  int botao_pressionado; //variavel para checar botao pressionado
  int senha = 356; //senha para teste sem o servidor
  int antigo_numero;
  int atendente_geral;
  int atendente_caixa;
  
  //---------------------------------------------
  // void setup
  //---------------------------------------------
  
  void setup()
  {
  
    Serial.begin(9600);
    
    pinMode(atd1 , INPUT);
    pinMode(atd2 , INPUT);
    pinMode(atd3 , INPUT);
    pinMode(atd4 , INPUT);
    pinMode(atd5 , INPUT);
    pinMode(atd6 , INPUT);
    pinMode(caixa1 , INPUT);
    pinMode(caixa2 , INPUT);
    
    lcd.begin(16, 2); //Inicia o LCD com dimensões 16x2(Colunas x Linhas)
    lcd.setCursor(0, 0); 
    
    conta_atendentes();
    
    antigo_numero = atendente_geral + atendente_caixa;
    
  }
  
  //---------------------------------------------
  // Verifica qual botao foi pressionado
  //---------------------------------------------
  
  
void checa_botao() {
  int valor = analogRead(leitura_botao);
  
  if(valor > 1000 && digitalRead(caixa1)) {
    botao_pressionado = 1;
    //caixa 1
    mantem_botao(1000, 1100);
  }
  
  if(valor > 910 && valor < 940 && digitalRead(caixa2)) {
    botao_pressionado = 2;
    //caixa 2
    mantem_botao(910 , 940);
  }
  
  if(valor > 835 && valor < 870 && digitalRead(atd1)) {
    botao_pressionado = 3;
    //atende 1
    mantem_botao(835 , 870);
  }
  
  if(valor > 770 && valor < 805 && digitalRead(atd2)) {
    botao_pressionado = 4;
    //atende 2
    mantem_botao(770 , 805);
  }
  
  if(valor > 710 && valor < 740 && digitalRead(atd3)) {
    botao_pressionado = 5;
    //atende 3
    mantem_botao(710 , 740);
  }
  
  if(valor > 670 && valor < 695 && digitalRead(atd4)) {
    botao_pressionado = 6;
    //atende 4
    mantem_botao(670 , 695);
  }
  
  if(valor > 630 && valor < 650 && digitalRead(atd5)) {
    botao_pressionado = 7;
    //atende 5
    mantem_botao(630 , 650);
  }
  
  if(valor > 580 && valor < 615 && digitalRead(atd6)) {
    botao_pressionado = 8;
    //atende 6
    mantem_botao(580 , 615);
  }
  
}

  //------------------------------------------------------------
  // Trava a execucao da acao do botao para apenas quando o soltar
  //------------------------------------------------------------


 void mantem_botao(int minimo, int maximo) {
   
   Serial.println(botao_pressionado);
   
   while(analogRead(leitura_botao) > minimo && analogRead(leitura_botao) < maximo)  {
         
   }
   
   int a = 0, b = 0, c = 0, d = 0;
   
   while(1) {
     a = Serial.read();
     
     if(a > 0) {
       delay(50);
       b = Serial.read();
       delay(50);
       c = Serial.read();
       delay(50);
       d = Serial.read();
       break;
     }
     
   }

   
   a = (a - 48) * 1000;
   b = (b - 48) * 100;
   c = (c - 48) * 10;
   d = a + b + c + (d - 48);

   
   senha = d;
   imprime_caixa_e_senha();
   
 }
   
   
  //---------------------------------------------
  // Imprime a senha e o guiche chamado no LCD
  //---------------------------------------------
   
  void imprime_caixa_e_senha() {
  
    if(botao_pressionado == 0) {
      return;
    }
    
    lcd.setCursor(0, 0);
    lcd.print("Senha: ");
    
    lcd.setCursor(7, 0);
    
    if(senha < 1000) {
      lcd.print(0);
    }
    
    if(senha < 100) {
      lcd.print(0);
    }
    
    if(senha < 10) {
      lcd.print(0);
    }
    
    //Imprime senha do servidor
    lcd.print(senha);
    
    if(botao_pressionado > 2) {
      lcd.setCursor(0, 1);
      lcd.print("Guiche: ");
      lcd.setCursor(8, 1);
      lcd.print(botao_pressionado - 2);
    }
    
    else {
      lcd.setCursor(0, 1);
      lcd.print("Caixa: ");
      lcd.setCursor(8, 1);
      lcd.print(botao_pressionado);
    }
    
    sender = aJson.createObject();
    aJson.addNumberToObject(sender, "caixa", botao_pressionado);
    
    botao_pressionado = 0;
    senha++;
    toca_alarme();
    
  }
  
  //---------------------------------------------
  // Toca o alarme de proxima senha no buzzer
  //---------------------------------------------
  
  
void toca_alarme() {
    
    analogWrite(buzzer, 200);
    delay(800);
    
    analogWrite(buzzer, 0);
    
  }
   
  //---------------------------------------------
  // Conta os Atendentes dos Caixas e dos Guiches
  //---------------------------------------------
  
void conta_atendentes() {
    
    atendente_caixa = 0;
    atendente_geral = 0;
    
    int x;
    
    for(x = 8; x <= 10; x++) {
      if(digitalRead(x)) {
        atendente_geral++;
      }
    }
    
    if(digitalRead(atd4)) {
      atendente_geral++;
    }
    
    if(digitalRead(caixa1)) {
      atendente_caixa++;
    }
    
    if(digitalRead(caixa2)) {
      atendente_caixa++;
    }
    
    if(digitalRead(atd5)) {
      atendente_geral++;
    }
    
    if(digitalRead(atd6)) {
      atendente_geral++;
    }
    
  }
  
  
  
  //---------------------------------------------
  // void loop
  //---------------------------------------------
  
void loop() {
    
    conta_atendentes();
    
    int total = atendente_geral + atendente_caixa;
    
    if(total != antigo_numero) {
      antigo_numero = total;
      total = - total;
      Serial.println(total);
    }
    
    if(analogRead(leitura_botao) > 100) {
      checa_botao();
    }
    
    delay(50);
    
 }
 
 

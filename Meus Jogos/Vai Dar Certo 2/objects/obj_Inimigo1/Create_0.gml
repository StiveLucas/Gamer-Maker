/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

randomise();

#region Variáveis.

Estado_Inimigo_Debug = "";

VelDefinida_Inimigo = 1.5;
Vel_Inimigo = VelDefinida_Inimigo;

Sentido = 0;
Direcao_Escolhida = false;
Direcao_Inimigo = 0;

DistanciaMinima = 100;

///Times do Inimigo.
TempoDefinido_Parado_Inimigo = 60 * 2
Tempo_Parado_Inimigo = 0;

TempoDefinido_Movimento_Inimigo = 60 * 4;
Tempo_Movimento_Inimigo = 0;

#endregion

#region Estados do Inimigo

EstadoParado_Inimigo = function(){
    
    Estado_Inimigo_Debug = "Parado";
        
    if(Tempo_Parado_Inimigo < TempoDefinido_Parado_Inimigo) Tempo_Parado_Inimigo++;
        
    Vel_Inimigo = 0;
    
    if (Tempo_Parado_Inimigo >= TempoDefinido_Parado_Inimigo ) {
        Tempo_Movimento_Inimigo = 0;
        Estado_Inimigo = EstadoMovimento_Inimigo;   
    }
}

EstadoMovimento_Inimigo = function(){
    
    Estado_Inimigo_Debug = "Movimento";
    
    if(!instance_exists(obj_Player)) return;
    
    if(Tempo_Movimento_Inimigo < TempoDefinido_Movimento_Inimigo) Tempo_Movimento_Inimigo++;
    
    var _Player = obj_Player;
    var _Posicao_Player = point_direction(x, y, _Player.x, _Player.y);
    var _Distancia_Inimiga_Player = point_distance(x, y, _Player.x, _Player.y);
    
    //Escolhendo qual vai ser o Sentido, se vai ser aleatório ou o Player.
    if(Sentido == 0) Sentido = choose("Direcao_Player", "Direcao_Player");
    
    switch (Sentido) {
    	
        case "Direcao_Player":
            Direcao_Inimigo = _Posicao_Player;
            
            //Alterando Velocidade com base na distancia do Player.
            if(_Distancia_Inimiga_Player > DistanciaMinima){
                Vel_Inimigo = lerp(Vel_Inimigo, VelDefinida_Inimigo, 0.1);
            }else {
            	Vel_Inimigo = lerp(Vel_Inimigo, 0, 0.2);
            }
            
            //Guardando Posições do Inimigo na Grid.
            var _PosicaoX_Inimigo_Grid = (x - global.PosicaoX_Sala) div global.TamanhoCelula;
            var _PosicaoY_Inimigo_Grid = (y - global.PosicaoY_Sala) div global.TamanhoCelula;
            
            //Movimentação do Inimigo.
            var _VelX = lengthdir_x(Vel_Inimigo, Direcao_Inimigo);
            var _VelY = lengthdir_y(Vel_Inimigo, Direcao_Inimigo);
            
            //Direção da Sprites.
            var _DirecaoX_Sprite = sign(_VelX);
            var _DirecaoY_Sprite = sign(_VelY);
            
            //Calculando a futura Posição do inimigo.
            var _FuturoX_Inimigo = ((x + (sprite_width/2 * _DirecaoX_Sprite)) - global.PosicaoX_Sala) div global.TamanhoCelula;
            var _FuturoY_Inimigo = ((y + (sprite_height/2 * _DirecaoY_Sprite)) - global.PosicaoY_Sala) div global.TamanhoCelula;
                    
            ///Só Poderá Andar se não existir objetos na frente.
            if (global.Sala[# _FuturoX_Inimigo, _PosicaoY_Inimigo_Grid] != 2) {
                x += _VelX;
            }
            
            if (global.Sala[# _PosicaoX_Inimigo_Grid, _FuturoY_Inimigo] != 2) {

                y += _VelY;
            }
            
        break;
    
        case "Direcao_Aleatoria":
            
            if (!Direcao_Escolhida) {
            	Direcao_Inimigo = random(359);
                Direcao_Escolhida = true;
            }
            
            Vel_Inimigo = VelDefinida_Inimigo/2;
            
            x += lengthdir_x(Vel_Inimigo, Direcao_Inimigo);
            y += lengthdir_y(Vel_Inimigo, Direcao_Inimigo);
            
        break;
    }
    
    //Quando o tempo de Movimento acabar ele reseta tudo e volta para o estado de parado
    if (Tempo_Movimento_Inimigo >= TempoDefinido_Movimento_Inimigo) {
        Sentido = 0;
        Direcao_Escolhida = false;
        Tempo_Parado_Inimigo = 0;
        Estado_Inimigo = EstadoParado_Inimigo;
    }
}

Estado_Inimigo = EstadoParado_Inimigo;
#endregion

#region Métodos do Inimigo.

#endregion
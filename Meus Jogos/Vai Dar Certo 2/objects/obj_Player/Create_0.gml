/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region Variáveis.

Estado_Player_Debug = "";

VelDefinida_Player = 12;
Vel_Player = VelDefinida_Player;

Direcao_Sprite = 1;

Colisoes_Player = [tls_ParedeTeste];

#region Controles Debugs.
Debug_ExibirDirecao_Player = false;
Debug_ExibirPosicao_Player = false;

#endregion

#endregion

#region Inputs do Player.

//Movimentação
Left = false;
Right = false;
Up = false;
Down = false;

Inputs_Player = function(){

    Left = keyboard_check(ord("A")) || keyboard_check(vk_left);
    Right = keyboard_check(ord("D")) || keyboard_check(vk_right);
    Up = keyboard_check(ord("W")) || keyboard_check(vk_up);
    Down = keyboard_check(ord("S")) || keyboard_check(vk_down);
}

#endregion

#region Estados do Player.

EstadoParado_Player = function(){
    
    Estado_Player_Debug = "Parado";
    
    if (Vel_Player != 0) {
    	Estado_Player = EstadoMovimento_Player;
    }
}

EstadoMovimento_Player = function(){
    
    Estado_Player_Debug = "Movimento"
    
    if (Vel_Player == 0) {
    	Estado_Player = EstadoParado_Player;
    }
}

Estado_Player = EstadoParado_Player;

#endregion

#region Métodos do Player.

//Movimentação e Colisão do Player.
AplicandoVelocidade_Player = function(){
    
    if ((Left xor Right) || (Up xor Down)) {
        
        Vel_Player = VelDefinida_Player;
    	
        //Aqui faz o Sistema de Movimentacao.
        var _Direcao_Player = point_direction(0, 0, (Right - Left), (Down - Up));
        var _VelX = lengthdir_x(Vel_Player, _Direcao_Player);
        var _VelY = lengthdir_y(Vel_Player, _Direcao_Player);
        
        //Pegua a direcao que ele esta indo.
        DirecaoX_Sprite = sign(_VelX);
        DirecaoY_Sprite = sign(_VelY);
        
        if (DEBUG_MODE && Debug_ExibirDirecao_Player) {
        	show_debug_message("DireçãoX_Sprite: " + string(DirecaoX_Sprite));
            show_debug_message("DireçãoY_Sprite: " + string(DirecaoY_Sprite));
            show_debug_message("----------------------");
        }
        
        ///Sistema de Colisao e Movimentacao(Só irá se Movimentar se não for colidir com nehuma parede).
        var _PosicaoX_Player_Mapa = (x + ((sprite_width / 3)) * DirecaoX_Sprite) div global.Tamanho_Sala;
        var _PosicaoY_Player_Mapa = (y + ((sprite_height / 3)) * DirecaoY_Sprite) div global.Tamanho_Sala;
        
        // 1. Onde a sala atual começa no mundo em pixels:
        var _Sala_OffsetX = _PosicaoX_Player_Mapa * global.Tamanho_Sala;
        var _Sala_OffsetY = _PosicaoY_Player_Mapa * global.Tamanho_Sala;
        
        var _PosicaoX_Player_Sala = ((x + ((sprite_width / 3) * DirecaoX_Sprite)) - _Sala_OffsetX) div global.TamanhoCelula_Sala;
        var _PosicaoY_Player_Sala = ((y + ((sprite_height / 3) * DirecaoY_Sprite)) - _Sala_OffsetY) div global.TamanhoCelula_Sala;
        
        var _FuturaPosicaoX_Player_Sala = ((x + (((sprite_width / 3) + 12) * DirecaoX_Sprite)) - _Sala_OffsetX) div global.TamanhoCelula_Sala;
        var _FuturaPosicaoY_Player_Sala = ((y + (((sprite_height / 3) + 12) * DirecaoY_Sprite)) - _Sala_OffsetY) div global.TamanhoCelula_Sala;
        
        if (DEBUG_MODE && Debug_ExibirPosicao_Player) {
            show_debug_message("PosicaoX_Atual: " + string(_PosicaoX_Player_Sala));
            show_debug_message("PosicaoY_Atual: " + string(_PosicaoY_Player_Sala));
            show_debug_message("Futura_PosicaoX: " + string(_FuturaPosicaoX_Player_Sala));
            show_debug_message("Futura_PosicaoY: " + string(_FuturaPosicaoY_Player_Sala));
            show_debug_message("----------------------------");
        }
        
        //Sala atual onde o Player está.
        var _Atual_Grid_Sala = global.Grid_Mapa[# _PosicaoX_Player_Mapa, _PosicaoY_Player_Mapa].Grid_Sala;
        
        if (Vel_Player != 0) { 
            
            if (_Atual_Grid_Sala[# _FuturaPosicaoX_Player_Sala, _PosicaoY_Player_Sala] != 2) {
                x += _VelX;    	
            }   
             
            if (_Atual_Grid_Sala[# _PosicaoX_Player_Sala, _FuturaPosicaoY_Player_Sala] != 2) { 
                y += _VelY;
            }  
            
        }
        
    }else {
    	Vel_Player = 0;
    }
}

#endregion

AtivandoFuncoes_Player = function(){
    
    Inputs_Player();
    
    //Faz o Player se mover.
    AplicandoVelocidade_Player();
}
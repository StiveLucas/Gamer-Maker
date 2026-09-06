/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region Variáveis

global.Tamanho_Sala = 1200;
global.TamanhoCelula_Sala = 16;

Salas_Prontas = {
    
    Salas_Fase1: {
        
        Sala_Preenchimento:{
            
            Config_Sala: function(_DS_Grid_Sala, _PosicaoX_Mapa, _PosicaoY_Mapa){
                
                var _Largura_Grid = ds_grid_width(_DS_Grid_Sala);
                var _Altura_Grid = ds_grid_height(_DS_Grid_Sala);
                
                ds_grid_clear(_DS_Grid_Sala, 2);
                
                ///             Tabelas de Indeces
                    /* 
                     * 0 - Vazio.
                     * 1 - Chao.
                     * 2 - Parede.
                     * 3 - Player.
                    */
                
            },
            
            Desenho_Sala: function(_DS_Grid_Sala, _PosicaoX_Mapa, _PosicaoY_Mapa){
                    
                var _Largura_Grid = ds_grid_width(_DS_Grid_Sala);
                var _Altura_Grid = ds_grid_height(_DS_Grid_Sala);
                
                if(!DEBUG_MODE) return;
                    
            }
            
        },
        
        Spawm_Player: {
            
            Sala_1:{
                
                Config_Sala: function(_DS_Grid_Sala, _PosicaoX_Mapa, _PosicaoY_Mapa){
                    
                    var _Largura_Grid = ds_grid_width(_DS_Grid_Sala) - 1;
                    var _Altura_Grid = ds_grid_height(_DS_Grid_Sala) - 1;
                    
                    ///             Tabelas de Indices
                    /* 
                     * 0 - Vazio.
                     * 1 - Chao.
                     * 2 - Parede.
                     * 3 - Player.
                     * 4 - Porta.
                    */
                    
                    var _Grossura_Parede = 3;
                    
                    ds_grid_clear(_DS_Grid_Sala, 1);
                    
                    for (var i = 0; i <= _Largura_Grid; i++) {
                    	
                        for (var j = 0; j <= _Altura_Grid; j++) {
                            
                            var _X1, _Y1, _X2, _Y2, _Cor;
                            _X1 = _PosicaoX_Mapa + (i * global.TamanhoCelula_Sala);
                            _Y1 = _PosicaoY_Mapa + (j * global.TamanhoCelula_Sala);
                            _X2 = _PosicaoX_Mapa + ((i + 1) * global.TamanhoCelula_Sala);
                            _Y2 = _PosicaoY_Mapa + ((j + 1) * global.TamanhoCelula_Sala);
                            
                            #region Definindo Indices na Grid_Sala(Paredes, Chão, Buracos).
                            
                            //Colocando parede em volta da sala.
                            Indice_ParedeEmVolta_Sala(_DS_Grid_Sala, i, j, _Largura_Grid, _Altura_Grid, _Grossura_Parede, 2);
                            
                            #endregion

                            #region Definindo Indices na Grid_Sala(Objetos).
                            
                            ///             Tabelas de Indices
                            /* 
                            * 0 - Vazio.
                            * 1 - Chao.
                            * 2 - Parede.
                            * 3 - Player.
                             * 4 - Porta.
                            */
                            
                            //  Posicao do Player.
                            if (i == (_Largura_Grid div 2) && j == (_Altura_Grid div 2)) {
                                _DS_Grid_Sala[# i, j] = 3;
                            }
                            
                            //Criando Saidas.
                            
                            
                            #endregion
                            
                            //Gerando Player.
                            if (_DS_Grid_Sala[# i, j] == 3) {
                            	if(!instance_exists(obj_Player)) instance_create_layer(_X1, _Y1, "ins_Player", obj_Player);
                            }
                        }
                    }
                    
                },
                
                Desenho_Sala: function(_DS_Grid_Sala, _PosicaoX_Mapa, _PosicaoY_Mapa){
                    
                    var _Largura_Grid = ds_grid_width(_DS_Grid_Sala);
                    var _Altura_Grid = ds_grid_height(_DS_Grid_Sala);

                    for (var i = 0; i < _Largura_Grid; i++) {
                    	
                        for (var j = 0; j < _Altura_Grid; j++) {
                        	
                            var _X1, _Y1, _X2, _Y2, _Cor;
                            _X1 = _PosicaoX_Mapa + (i * global.TamanhoCelula_Sala);
                            _Y1 = _PosicaoY_Mapa + (j * global.TamanhoCelula_Sala);
                            _X2 = _PosicaoX_Mapa + ((i + 1) * global.TamanhoCelula_Sala);
                            _Y2 = _PosicaoY_Mapa + ((j + 1) * global.TamanhoCelula_Sala);

                            _Cor = c_green;
                            draw_rectangle_colour(_X1, _Y1, _X2, _Y2, _Cor, _Cor, _Cor, _Cor, false);
                            
                            _Cor = c_black
                            draw_rectangle_colour(_X1, _Y1, _X2, _Y2, _Cor, _Cor, _Cor, _Cor, true);
                            
                            draw_text(_X1, _Y1, _DS_Grid_Sala[# i, j]);
                        }
                    }
                }
            }
        },
        
        Salas_Inimigas: {
            
            SalaInimiga_1:{
                
                Config_Sala: function(_DS_Grid, _I, _J){
                    
                    var _Largura_Grid = ds_grid_width(_DS_Grid);
                    var _Altura_Grid = ds_grid_height(_DS_Grid);
                    show_message("KK")
                     for (var i = 0; i < _Largura_Grid; i++) {
                    	
                        for (var j = 0; j < _Altura_Grid; j++) {
                        	
                            
                        }
                    }
                },
                
                Desenho_Sala: function(_DS_Grid_Sala, _PosicaoX_Mapa, _PosicaoY_Mapa){
                    
                    var _Largura_Grid = ds_grid_width(_DS_Grid_Sala);
                    var _Altura_Grid = ds_grid_height(_DS_Grid_Sala);
                    
                    for (var i = 0; i < _Largura_Grid; i++) {
                    	
                        for (var j = 0; j < _Altura_Grid; j++) {
                        	
                            var _X1, _Y1, _X2, _Y2, _Cor;
                            _X1 = _PosicaoX_Mapa + (i * global.TamanhoCelula_Sala);
                            _Y1 = _PosicaoY_Mapa + (j * global.TamanhoCelula_Sala);
                            _X2 = _PosicaoX_Mapa + ((i + 1) * global.TamanhoCelula_Sala);
                            _Y2 = _PosicaoY_Mapa + ((j + 1) * global.TamanhoCelula_Sala);
                            
                            _Cor = c_green;
                            draw_rectangle_colour(_X1, _Y1, _X2, _Y2, _Cor, _Cor, _Cor, _Cor, false);
                            
                            _Cor = c_black
                            draw_rectangle_colour(_X1, _Y1, _X2, _Y2, _Cor, _Cor, _Cor, _Cor, true);
                            
                            //draw_text(_X1, _Y1, string(i) + "," + string(j));
                        }
                    }
                }
            }
        }
    }
}



#endregion
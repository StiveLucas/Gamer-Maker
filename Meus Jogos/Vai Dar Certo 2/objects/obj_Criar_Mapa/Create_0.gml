///// @description Inserir descrição aqui  
// Você pode escrever seu código neste editor

//Coloca o obj_Cria_Sala na room
if (!instance_exists(obj_Criar_Sala)) instance_create_layer(0, 0, "ins_CriaSalas", obj_Criar_Sala);

#region Variáveis

TamanhoCelula_Mapa = 0;
Colunas_Mapa = 0;
Linhas_Mapa = 0;

Direcao_NovaSala = 0;
Ultimo_I_Criado = 0;
Ultimo_J_Criado = 0;

#region Controles de Debugs

Debug_Criacao_Salas = false;
Debug_Exibir_GridMapa = false;
#endregion

//Controles do Jogo.
QuantidadeSalas_Escolhidas = false;

Direcao_Escolhida = false;
Resetando_Laco = false;

Fase_Preenchida_SalaPreenchimento = false;
Salas_Geradas = false;
Gerando_Portas = false;
Fase_Pronta = false;

SalaConstruida = false;
SalaConstruida_Player = false;
Player_Gerado = false;


#endregion


Configuracao_Mapa = function(_I, _J, _Largura_Grid_Mapa, _Altura_Grid_Mapa){
    
    //Cria o obj_Criar_Sala para evitar dar erro no codigo.
    if (!instance_exists(obj_Criar_Sala)) instance_create_layer(0, 0, "ins_CriaSalas", obj_Criar_Sala);

    var _Criar_Sala = obj_Criar_Sala;
    
    //Variaveis para criar a proxima sala.
    var _NovaSala = noone;
    var _Colunas_Mapa = _Largura_Grid_Mapa;
    var _Linhas_Mapa = _Altura_Grid_Mapa;
    
    
    if(!is_struct(global.Grid_Mapa[# _I, _J])) _NovaSala = _Criar_Sala.Salas_Prontas.Salas_Fase1.Sala_Preenchimento;

    //Criando a fase com base na fase.
    switch (global.Fase_Jogo) {
        
        //Fase1
        case 1:

            //Só ira criar as salas depois de preencher toda a fase com Salas de Preenchimento.
            if (Fase_Preenchida_SalaPreenchimento && !Salas_Geradas) {
                
                //Deixando tudo aléatorio.
                randomise();
               
                //Escolhendo a direção da próxima sala de forma aleatória.
                if(!Direcao_Escolhida){ 
                    Direcao_NovaSala = choose("Direita", "Cima", "Baixo", "Direita");
                   
                    Direcao_Escolhida = true;
                }
            	
                switch (Direcao_NovaSala) {
                
                    case "Direita":
                            
                        //Cria a Sala de Spawm do Player.
                        if (global.QuantidadeSalasCriadas == 0) {
                            
                            //Escolhendo Posicao Sala Spawm do Player.
                            if (_I == 0 && _J == (_Linhas_Mapa div 2)) {
                                _NovaSala = _Criar_Sala.Salas_Prontas.Salas_Fase1.Spawm_Player.Sala_1;
                                Ultimo_I_Criado = _I;
                                Ultimo_J_Criado = _J;
    
                                global.QuantidadeSalasCriadas++;
                                SalaConstruida = true;
                                SalaConstruida_Player = true;
                            }
                            
                        }else {
                        
                            //Aqui vai criar as salas: Inimigas.
                            if (global.QuantidadeSalasCriadas >= 1 && global.QuantidadeSalasCriadas < global.QuantidadeSalasDesejada) {
                            
                                //Impede de criar salas fora da tela.
                                if (Ultimo_I_Criado + 1 >= _Colunas_Mapa){
    
                                    Resetando_Laco = true;
                                }else {
                                	
                                    //Determina que a sala vai ser criada para Direita.
                                    if (_I == Ultimo_I_Criado + 1 && _J == Ultimo_J_Criado) {
     
                                        //Criando a Sala.
                                        _NovaSala = _Criar_Sala.Salas_Prontas.Salas_Fase1.Salas_Inimigas.SalaInimiga_1;
                                        Ultimo_I_Criado++;
                                        Ultimo_J_Criado = _J;
        
                                        global.QuantidadeSalasCriadas++;
                                        SalaConstruida = true;
                                    }
                                }
                            }
                        }
                    
                    break;
                
                    case "Cima":
                        
                        //Cria a Sala de Spawm do Player.
                        if (global.QuantidadeSalasCriadas == 0) {
                            
                            //Escolhendo Posicao Sala Spawm do Player.
                            if (_I == 0 && _J == (_Linhas_Mapa div 2)) {
                                _NovaSala = _Criar_Sala.Salas_Prontas.Salas_Fase1.Spawm_Player.Sala_1;
                                Ultimo_I_Criado = _I;
                                Ultimo_J_Criado = _J;
                                
                                global.QuantidadeSalasCriadas++;
                                SalaConstruida = true;
                                SalaConstruida_Player = true;
                            }
                        }else {
                            
                            //Aqui vai criar as salas: Inimigas.
                            if (global.QuantidadeSalasCriadas >= 1 && global.QuantidadeSalasCriadas < global.QuantidadeSalasDesejada) {
    
                                //Impede de criar salas fora da tela.
                                if (Ultimo_J_Criado - 1 < 0){
    
                                    Resetando_Laco = true;
                                }else {
                                    
                                    //Determina que a sala vai ser criada para Cima.
                                    if (_I == Ultimo_I_Criado && _J == Ultimo_J_Criado - 1) {
                                            
                                        //Verifica se na posição dessa Grid do mapa é uma Sala de Preenchimento, caso seja vai criar a nova sala, caso não seja rai resetar a escolha de Direção de sala.
                                        if (global.Grid_Mapa[# Ultimo_I_Criado, Ultimo_J_Criado - 1].Sala_Nova == _Criar_Sala.Salas_Prontas.Salas_Fase1.Sala_Preenchimento) {
                                            
                                            //Criando a Sala.
                                            _NovaSala = _Criar_Sala.Salas_Prontas.Salas_Fase1.Salas_Inimigas.SalaInimiga_1;
                                            Ultimo_I_Criado = _I;
                                            Ultimo_J_Criado--;
                                               
                                            global.QuantidadeSalasCriadas++;
                                            SalaConstruida = true;	
                                        }else {
                                        	Resetando_Laco = true;
                                        }
                                    }
                                }
                            }
                        }
                        
                    break;
                
                    case "Baixo":
                        
                        //Cria a Sala de Spawm do Player.
                        if (global.QuantidadeSalasCriadas == 0) {
                            
                            //Escolhendo Posicao Sala Spawm do Player.
                            if (_I == 0 && _J == (_Linhas_Mapa div 2)) {
                                _NovaSala = _Criar_Sala.Salas_Prontas.Salas_Fase1.Spawm_Player.Sala_1;
                                Ultimo_I_Criado = _I;
                                Ultimo_J_Criado = _J;
                                
                                global.QuantidadeSalasCriadas++;
                                SalaConstruida = true;
                                SalaConstruida_Player = true;
                            }
                        }else {
                            
                            //Aqui vai criar as salas: Inimigas.
                            if (global.QuantidadeSalasCriadas >= 1 && global.QuantidadeSalasCriadas < global.QuantidadeSalasDesejada) {
                                    
                                if (Ultimo_J_Criado + 1 >= _Linhas_Mapa){
    
                                    Resetando_Laco = true;
                                }else {
                                    
                                    //Determina que a sala vai ser criada para Baixo.
                                    if (_I == Ultimo_I_Criado && _J == Ultimo_J_Criado + 1) {
                                        
                                        //Verifica se na posição dessa Grid do mapa é uma Sala de Preenchimento, caso seja vai criar a nova sala, caso não seja rai resetar a escolha de Direção de sala.
                                        if (global.Grid_Mapa[# Ultimo_I_Criado, Ultimo_J_Criado + 1].Sala_Nova == _Criar_Sala.Salas_Prontas.Salas_Fase1.Sala_Preenchimento) {
                                            
                                            //Criando a Sala.
                                            _NovaSala = _Criar_Sala.Salas_Prontas.Salas_Fase1.Salas_Inimigas.SalaInimiga_1;
                                            Ultimo_I_Criado = _I;
                                            Ultimo_J_Criado++;
                                               
                                            global.QuantidadeSalasCriadas++;
                                            SalaConstruida = true;	
                                        }else {
                                        	Resetando_Laco = true;
                                        }
                                    }
                                }
                            }
                        }
                        
                    break;
                }
            }
            
            //Gerando Saidas nas salas.
            if (Salas_Geradas && !Gerando_Portas) {
                
                //Direita.
                if (_I >= _Colunas_Mapa) {
                    if (global.Grid_Mapa[# _I + 1, _J] != _Criar_Sala.Salas_Prontas.Salas_Fase1.Sala_Preenchimento) global.Grid_Mapa[# _I, _J].Saidas_Sala.Direita = true;
                }
                
                //Cima.
                if (_J >= _Linhas_Mapa) {
                    if (global.Grid_Mapa[# _I, _J + 1] != _Criar_Sala.Salas_Prontas.Salas_Fase1.Sala_Preenchimento) global.Grid_Mapa[# _I, _J].Saidas_Sala.Cima = true;
                }
                
                //Baixo.
                if (_J > 0) {
                    if (global.Grid_Mapa[# _I, _J - 1] != _Criar_Sala.Salas_Prontas.Salas_Fase1.Sala_Preenchimento) global.Grid_Mapa[# _I, _J].Saidas_Sala.Baixa = true;
                }
                
                if (_I >= _Colunas_Mapa - 1 && _J >= _Linhas_Mapa - 1) {
                    Gerando_Portas = true;
                    
                    Resetando_Laco = true;
                }
            }
            
            //Gerando Saidas.
            if (Gerando_Portas) {
            	
                
            }
            
        break;
    }

    // Debug para ver a criação das salas.
    if (DEBUG_MODE && Debug_Criacao_Salas) { 
        show_debug_message("Quantidades de Salas Desejadas: " + string(global.QuantidadeSalasDesejada));
        show_debug_message("DIRECAO: " + string(Direcao_NovaSala));
        show_debug_message("I = " + string(_I) + " Ultimo I = " + string(Ultimo_I_Criado));
        show_debug_message("j = " + string(_J) + " Ultimo j = " + string(Ultimo_J_Criado));
        show_debug_message("Quantidades de Salas Criadas: " + string(global.QuantidadeSalasCriadas));
        show_debug_message("-------------------------------------------------------------------");
    }
    
    //Para evitar dar erro no jogo.
    if(_NovaSala == noone) exit;
    
    //Cria a grid da nova sala gerada.
    var _Largura_Grid_Sala = global.Tamanho_Sala div global.TamanhoCelula_Sala;
    var _Altura_Grid_Sala = global.Tamanho_Sala div global.TamanhoCelula_Sala;
    
    var _Grid_NovaSala = ds_grid_create(_Largura_Grid_Sala, _Altura_Grid_Sala);
    
    //Salva tudo na grid especifica do Mapa.
    global.Grid_Mapa[# _I, _J] = {
        Grid_Sala: _Grid_NovaSala,
        Sala_Nova: _NovaSala,
        Saidas_Sala: {
            
            Esquerda: false,
            Direita: false,
            Cima: false,
            Baixo: false
        }
    }
    
    //Quando uma sala é contruida, ele salva os dados exatamente na grid onde foi designada.
    if (SalaConstruida) {
    	global.Grid_Mapa[# Ultimo_I_Criado, Ultimo_J_Criado] = {
            Grid_Sala: _Grid_NovaSala,
            Sala_Nova: _NovaSala,
            Saidas_Sala: {
            
                Esquerda: false,
                Direita: false,
                Cima: false,
                Baixo: false
            }
            
        }
    }
    
    //Gerando Sala com o Player para o jogo funcionar.
    if(SalaConstruida_Player && !Player_Gerado){
        
        for (var i = 0; i < _Colunas_Mapa; i++) {
           	
            for (var j = 0; j < _Linhas_Mapa; j++) {
               	
                
                var _X1, _Y1, _X2, _Y2, _Cor;
                       
                _X1 = i * global.Tamanho_Sala;
                _Y1 = j * global.Tamanho_Sala;
                _X2 = (i + 1) * global.Tamanho_Sala;
                _Y2 = (j + 1) * global.Tamanho_Sala;

                //Ativando a sala do Spaw Player.
                if ((i == Ultimo_I_Criado && j == Ultimo_J_Criado) && !Player_Gerado) {
                    _NovaSala.Config_Sala(global.Grid_Mapa[# Ultimo_I_Criado, Ultimo_J_Criado].Grid_Sala, _X1, _Y1);
                }
            }
        }
        
        Player_Gerado = true;
    }
    
    if (global.QuantidadeSalasCriadas >= global.QuantidadeSalasDesejada && !Salas_Geradas){
        Salas_Geradas = true;
        
        Resetando_Laco = true;
    }
}


Montando_Fase = function(){

    if (!instance_exists(obj_Criar_Sala)) instance_create_layer(0, 0, "ins_CriaSalas", obj_Criar_Sala);
        
    //Escolhendo a configuracao da fase.
    switch (global.Fase_Jogo) {
    	
        //Fase 1.
        case 1:
            
            global.Tamanho_Sala = 1200;
            
            TamanhoCelula_Mapa = global.Tamanho_Sala;
            Colunas_Mapa = 12;
            Linhas_Mapa = 9;

            room_width = Colunas_Mapa * global.Tamanho_Sala;
            room_height = Linhas_Mapa * global.Tamanho_Sala;
            
            if(!QuantidadeSalas_Escolhidas) {
                global.QuantidadeSalasDesejada = irandom_range(13, 19);
                
                QuantidadeSalas_Escolhidas = true;
            }
            
        break;
    }
    
    //Criando a ds_grid do Mapa.
    global.Grid_Mapa = ds_grid_create(Colunas_Mapa, Linhas_Mapa);

    //Definindo um valor para a ds_grid inteira.
    ds_grid_clear(global.Grid_Mapa, 0);
        
    var _Criar_Sala = obj_Criar_Sala;
        
    //Aqui é o construtor da fase.
    for (var i = 0; i < Colunas_Mapa; i++) {
    	
        for (var j = 0; j < Linhas_Mapa; j++) {
            
            Configuracao_Mapa(i, j, Colunas_Mapa, Linhas_Mapa);

            //if(Salas_Geradas) show_message(".")
            if (!Fase_Pronta) {
                
                //Reseta depois preencher o mapa com Salas de Preenchimento
                if ((i == Colunas_Mapa - 1 && j == Linhas_Mapa - 1) && !Fase_Preenchida_SalaPreenchimento) {
                    Fase_Preenchida_SalaPreenchimento = true;
                    Resetando_Laco = true;
                }
                
                //Reseja o contrutor para gerar as salas.
                if (SalaConstruida || Resetando_Laco) {
                    i = 0;
                    j = -1;
    
                    SalaConstruida = false;
                    Resetando_Laco = false;
                    Direcao_Escolhida = false;
                }
            }
        }
    }
}


Desenhando_Mapa = function(){

    //Pegando as Dimensôes da camera.
    var _Camera_X = camera_get_view_x(view_camera[0]);
    var _Camera_Y = camera_get_view_y(view_camera[0]);
    var _Camera_W = camera_get_view_width(view_camera[0]);
    var _Camera_H = camera_get_view_height(view_camera[0]);
    
    ///Convertendo os Valores da posicao das cameras em Celulas(Lembrese, É POSIÇÃO DA CAMERA).
    var _Coluna_Inicial = _Camera_X div global.Tamanho_Sala;
    var _Coluna_Final = (_Camera_X + _Camera_W) div global.Tamanho_Sala;
    
    var _Linha_Inicial = _Camera_Y div global.Tamanho_Sala;
    var _Linha_Final = (_Camera_Y + _Camera_H) div global.Tamanho_Sala;
    
    var _Largura_Grid = ds_grid_width(global.Grid_Mapa);
    var _Altura_Grid = ds_grid_height(global.Grid_Mapa);
    
    for (var i = _Coluna_Inicial; i <= _Coluna_Final; i++) {
    	
        for (var j = _Linha_Inicial; j <= _Linha_Final; j++) {
        	
            if ((i >= 0 && i < Colunas_Mapa) && (j >= 0 && j < Linhas_Mapa)) {
                
                var _X1, _Y1, _X2, _Y2, _Cor;
                
                _X1 = i * global.Tamanho_Sala;
                _Y1 = j * global.Tamanho_Sala;
                _X2 = (i + 1) * global.Tamanho_Sala;
                _Y2 = (j + 1) * global.Tamanho_Sala;
			
                //Debug para visualisar Ds_GridMapa.
                if (DEBUG_MODE && Debug_Exibir_GridMapa) {
                     _Cor = c_purple;
                    draw_rectangle_colour(_X1, _Y1, _X2, _Y2, _Cor, _Cor, _Cor, _Cor, false);
                
                    _Cor = c_black;
                    draw_rectangle_colour(_X1, _Y1, _X2, _Y2, _Cor, _Cor, _Cor, _Cor, true);	
                }
                
                global.Grid_Mapa[# i, j].Sala_Nova.Desenho_Sala(global.Grid_Mapa[# i, j].Grid_Sala, _X1, _Y1);
            }
        }
    }
}

Montando_Fase();
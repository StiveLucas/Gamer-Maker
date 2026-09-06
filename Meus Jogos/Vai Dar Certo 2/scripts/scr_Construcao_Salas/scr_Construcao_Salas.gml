
//Colocar Parede em volta da sala toda.
function Indice_ParedeEmVolta_Sala(_DS_Grid_Sala, _I, _J, _Largura_Grid_Sala, _Altura_Grid_Sala, _Grossura_Parede, _Indice_Sala){
    
    if (((_I <= (0 + _Grossura_Parede) || (_J <= 0 + _Grossura_Parede)) || (_I >= (_Largura_Grid_Sala - _Grossura_Parede) || _J >= (_Altura_Grid_Sala - _Grossura_Parede)))) {
        _DS_Grid_Sala[# _I, _J] = _Indice_Sala;
    }
}
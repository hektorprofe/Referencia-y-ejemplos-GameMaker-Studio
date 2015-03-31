/// Formatear cadena para eliminar caracteres especiales
// argument0 - string: cadena a formatear
// argument1 - int: longitud maxima
var i,s="";
for (i=1;i<=string_length(argument0);i+=1){
    val = ord(string_char_at(argument0,i));
    char = string_char_at(argument0,i);
    if ( val >= 65 && val<= 90 || val >= 97 && val <= 122 || val >= 48 && val <= 57) {
       s += char;
    }
    if (i>=argument1) return s;
}
//show_debug_message(s);
return s;

## Logic Challenge

Los logic challenge son unos ejercicios de análisis que me he propuesto hacer a lo largo de mi aprendizaje en el desarrollo de videojuegos. Se trata de observar, analizar e investigar un tipo de juego concreto, y determinar si se puede, o mejor dicho, soy capaz de crear un concepto similar en Game Maker. 

# Logic Challenge 4: Simple Fighter

Este cuarto logic challenge es muy especial para mí ya que desde siempre he tenido curiosidad acerca de como debe ser la lógica de un juego de lucha. Estoy seguro que el resultado final distará mucho de un juego de lucha de verdad, pero el objetivo de mis logic challenges es únicamente aprender así que con éso en mente voy a empezar ya.

### Creando un background animado

Esta vez realmente parto de cero y no sé exactamente por dónde comenzar, así que empezaré por crear un background animado a partir de algún sprite sacado de Internet.

He conseguido uno muy guay formado por 24 imágenes, con un tamaño de 800x336. Para crear la animación tengo la idea de 24 backgrounds, uno para cada animación y luego cambiar con una alarma el fondo cada pocas fracciones de segundo para recrear el efecto. 

Una vez tengo los backgrounds preparados creo el objeto para controlar la animación del escenario, obj_scenario_1 (de acuerdo con mi primer escenario):

```javascript
///obj_scenario_1: Create

frame[1]=G440000;
frame[2]=G440001;
frame[3]=G440002;
frame[4]=G440003;
frame[5]=G440004;
frame[6]=G440005;
frame[7]=G440006;
frame[8]=G440007;
frame[9]=G440008;
frame[10]=G440009;
frame[11]=G440010;
frame[12]=G440011;
frame[13]=G440012;
frame[14]=G440013;
frame[15]=G440014;
frame[16]=G440015;
frame[17]=G440016;
frame[18]=G440017;
frame[19]=G440018;
frame[20]=G440019;
frame[21]=G440020;
frame[22]=G440021;
frame[23]=G440022;
frame[24]=G440023;

current_frame=1;

alarm[0]=room_speed/7;
```

La alarma irá recorriendo el arreglo y otorgando el nuevo background, sépase que G44GEN es una copia de G440000 sobre la que iré substituyendo el fondo:

```javascript
///obj_scenario_1: Alarm 0
current_frame+=1;
if (current_frame==24) current_frame = 1;
background_assign(G44GEN,frame[current_frame]);
alarm[0]=room_speed/7;
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/04_simple_fighter.gmx/docs/img1.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/04_simple_fighter.gmx/docs/img1.png)
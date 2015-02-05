## Tutorial básico de GML
Para mover un objeto utilizamos eventos, por ejemplo capturando las teclas del teclado.
### Movimiento horizontal
* x+=n: Hacia la derecha n píxels
* x-=n: Hacia la izquierda n píxels
### Movimiento vertical
* y-=n: Hacia arriba n píxels
* y+=n: Hacia abajo n píxels
También podemos rotar objetos.
### Rotación de un objeto
* image_angle+=n: Rotación anti-horaria n grados
* image_angle-=n: Rotación horaria n grados

## Código
```delphi
x-=2;
x+=2;
image_angle+=1;
```
### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/01_movimiento_y_rotacion.gmx/captura.jpg)]()
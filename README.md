# 🎮 4 EN RAYA – Godot Edition
Proyecto profesional de un **4 en raya** desarrollado en **Godot Engine**, implementado con una arquitectura modular y orientado a la claridad, mantenibilidad y escalabilidad del código.

## 🧩 Descripción general
Este proyecto es una recreación del clásico juego **Connect Four**, donde dos jugadores compiten por alinear cuatro fichas consecutivas en un tablero vertical.  
La implementación está diseñada para ser **robusta, clara y fácilmente ampliable**, manteniendo buenas prácticas de desarrollo en Godot y GDScript.

El juego incluye:
- Lógica completa del tablero
- Detección de victoria en todas las direcciones
- Gestión de turnos
- Interfaz visual limpia y funcional
- Arquitectura modular para facilitar mejoras futuras

## ✨ Características principales
- 🎯 **Gameplay fiel al 4 en raya clásico**
- 🧠 **Sistema de detección de victoria optimizado**
- 🔄 **Turnos alternos totalmente automatizados**
- 🎨 **Interfaz construida con nodos de Godot**
- 🧩 **Código organizado y documentado**
- 🛠️ **Preparado para añadir IA, animaciones o modos extra**

## 🛠️ Tecnologías utilizadas
- **Motor:** Godot Engine  
- **Lenguaje:** GDScript  
- **Versión recomendada:** Godot 4.5

## 📁 Estructura del proyecto
/scenes Board.tscn Game.tscn UI.tscn
/scripts Board.gd Game.gd Cell.gd Utils.gd
/assets sprites/ fonts/
project.godot README.md


## ▶️ Ejecución
1. Abre **Godot Engine**.  
2. Selecciona **Import** y carga la carpeta del proyecto.  
3. Ejecuta la escena principal (`Game.tscn` o la que corresponda).

## 🎮 Cómo jugar
- Dos jugadores se turnan para colocar fichas en el tablero.  
- El primero en alinear **cuatro fichas consecutivas** (horizontal, vertical o diagonal) gana la partida.  
- Si el tablero se llena sin ganador, se declara **empate**.

## 🚀 Mejoras futuras
- 🤖 Implementación de IA con distintos niveles de dificultad  
- 🎞️ Animaciones de caída de fichas  
- 🌐 Modo online o multijugador local avanzado  
- 🎨 Temas visuales personalizables  
- 🧪 Sistema de tests automatizados para la lógica del tablero  

## 📄 Licencia
Este proyecto se distribuye bajo la licencia **MIT**, permitiendo su uso, modificación y distribución con libertad.

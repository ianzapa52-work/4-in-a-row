extends Node

# Reproductor de efectos
@onready var player = $SFXPlayer

# Reproduce un efecto
func reproducir_efecto(ruta):
	# Verificar que el nodo existe y está dentro de la escena
	if player and player.is_inside_tree():
		player.stream = load(ruta)
		player.play()
	else:
		push_error("SFXPlayer no está listo o no está en el árbol de la escena")

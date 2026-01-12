extends Control

# Botones y nodos
@onready var button_jugar = $ButtonJugar
@onready var button_salir = $ButtonSalir
@onready var win_label = $WinLabel
@onready var sfx_manager = $SFXManager
@onready var anim_player = $WinLabel/AnimationLabel
@onready var music_manager = $MusicManager

# Inicialización
func _ready() -> void:
	music_manager.reproducir_cancion_menu()
	
	button_jugar.connect("pressed", _on_jugar_pressed)
	button_salir.connect("pressed", _on_salir_pressed)
	
	# Mostrar mensaje de victoria si existe
	if Result.message != "":
		win_label.text = Result.message
	
	# Mostrar sonido de victoria
	if Result.message.to_lower().find("roja") != -1:
		anim_player.play("rgb_rojo")
		sfx_manager.reproducir_efecto("res://sonidos/winner_sound_j1.mp3")
		music_manager.detener_musica()
	elif Result.message.to_lower().find("azul") != -1:
		anim_player.play("rgb_azul")
		sfx_manager.reproducir_efecto("res://sonidos/winner_sound_j2.mp3")
		music_manager.detener_musica()
	elif Result.message.to_lower().find("empate") != -1:
		sfx_manager.reproducir_efecto("res://sonidos/tie_sound.mp3")
		music_manager.detener_musica()

# Botón jugar
func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://escenas/juego/game.tscn")

# Botón salir
func _on_salir_pressed():
	get_tree().quit()

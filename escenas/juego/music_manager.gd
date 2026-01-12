extends Node

# Reproductor de música
@onready var player = $MusicPlayer

# Lista de canciones
var canciones = [
	"res://musica/ghost_fight.mp3",
	"res://musica/home.mp3",
	"res://musica/sans.mp3",
	"res://musica/spider_dance.mp3",
	"res://musica/last_goodbye.mp3"
]

# Reproduce una canción aleatoria
func reproducir_cancion_aleatoria():
	var ruta = canciones.pick_random()
	player.stream = load(ruta)
	player.play()
	
# Reproduce la cancion del menú al iniciar el juego
func reproducir_cancion_menu():
	player.stream = load("res://musica/hotel.mp3")
	player.play()

# Detener música
func detener_musica():
	player.stop()

# Al terminar la canción, reproducir otra
func _on_MusicPlayer_finished():
	reproducir_cancion_aleatoria()

extends Control

# Referencias a nodos
@onready var columns = $Columns.get_children()         # Botones de columnas
@onready var cells = $Cells.get_children()             # Celdas del tablero
@onready var button_salir = $ButtonSalir              # Botón salir
@onready var button_reiniciar = $ButtonReiniciar      # Botón reiniciar
@onready var sfx_manager = $SFXManager
@onready var label_victorias_j1 = $LabelVictoriasJ1
@onready var label_victorias_j2 = $LabelVictoriasJ2
@onready var label_turno = $LabelTurno

# Constantes de juego
const CELL_EMPTY = ""
const PLAYER_RED = "ROJA"
const PLAYER_BLUE = "AZUL"

const COLOR_EMPTY = Color(1,1,1)    # Blanco para celda vacía
const COLOR_RED = Color(0.927, 0.251, 0.24, 1.0)    # Rojo jugador
const COLOR_BLUE = Color(0.131, 0.706, 0.795, 1.0)  # Azul jugador

const COLS = 7
const ROWS = 6
const CONNECT = 4   # Fichas consecutivas necesarias para ganar

# Variables de estado
var current_player         # Jugador actual (ROJO / AZUL)
var current_color          # Color del jugador actual
var board                  # Tablero lógico [col][fila]

# Inicialización
func _ready() -> void:
	button_salir.connect("pressed", _on_salir_pressed)
	button_reiniciar.connect("pressed", _on_reiniciar_pressed)
	
	# Conectar botones de columna con su índice
	var column_index = 0
	for button in columns:
		button.connect("pressed", _on_column_pressed.bind(column_index, button))
		column_index += 1
		
	# Mostrar victorias globales
	label_victorias_j1.text = "Victorias ROJA: " + str(Global.victorias_j1)
	label_victorias_j2.text = "Victorias AZUL: " + str(Global.victorias_j2)
	label_turno.text = "Turno actual: " + PLAYER_RED
	
	
	reset_game()  # Inicializar tablero
	
	# Reproducir música de fondo si hay MusicManager
	var music_manager = get_node_or_null("MusicManager")
	if music_manager:
		music_manager.reproducir_cancion_aleatoria()

# Devuelve la fila libre más baja de una columna
func get_free_row(col):
	for row in range(ROWS - 1, -1, -1):
		if board[col][row] == CELL_EMPTY:
			return row
	return -1

# Cuenta fichas consecutivas en una dirección dx, dy
func count_dir(col, row, dx, dy):
	var count = 0
	var x = col
	var y = row
	while x >= 0 and x < COLS and y >= 0 and y < ROWS and board[x][y] == current_player:
		count += 1
		x += dx
		y += dy
	return count

# Comprueba si el jugador actual ha ganado
func check_win(col, row):
	return (
		count_dir(col, row, 1, 0) + count_dir(col, row, -1, 0) - 1 >= CONNECT or
		count_dir(col, row, 0, 1) + count_dir(col, row, 0, -1) - 1 >= CONNECT or
		count_dir(col, row, 1, 1) + count_dir(col, row, -1, -1) - 1 >= CONNECT or
		count_dir(col, row, 1, -1) + count_dir(col, row, -1, 1) - 1 >= CONNECT
	)

# Comprueba si el tablero está lleno (empate)
func check_fullboard():
	for row in board:
		for col in row:
			if col == CELL_EMPTY:
				return false
	return true

# Finaliza el juego y actualiza victorias
func end_game(message, hay_ganador := true):
	# Actualizar victorias según color
	if hay_ganador:
		if current_player == PLAYER_RED:
			Global.victorias_j1 += 1
		elif current_player == PLAYER_BLUE:
			Global.victorias_j2 += 1
	
	# Actualizar etiquetas de victorias
	label_victorias_j1.text = "Victorias ROJA: " + str(Global.victorias_j1)
	label_victorias_j2.text = "Victorias AZUL: " + str(Global.victorias_j2)
	
	# Detener música
	var music_manager = get_node_or_null("MusicManager")
	if music_manager:
		music_manager.detener_musica()
	
	# Guardar mensaje para menú principal
	Result.message = message
	
	# Cambiar a menú principal
	get_tree().change_scene_to_file("res://escenas/menu_principal/MainMenu.tscn")

# Lógica al pulsar una columna
func _on_column_pressed(index, _button):
	sfx_manager.reproducir_efecto("res://sonidos/caida_ficha.mp3")
	
	var col = index % COLS
	var row = get_free_row(col)
	
	if row == -1:
		return  # Columna llena
	
	board[col][row] = current_player  # Marcar el tablero lógico
	var real_index = row * COLS + col
	var cell = cells[real_index]
	
	# Cambiar color de la celda visual
	if cell is Panel:
		cell.modulate = current_color
	
	# Comprobar victoria o empate
	if check_win(col, row):
		end_game("¡Ficha " + current_player + " gana!", true)
	elif check_fullboard():
		end_game("¡Empate!", false)
	else:
		# Alternar jugador y color
		current_player = PLAYER_BLUE if current_player == PLAYER_RED else PLAYER_RED
		current_color = COLOR_BLUE if current_player == PLAYER_BLUE else COLOR_RED
		
		# Actualizar turno en label
		label_turno.text = "Turno actual: " + current_player

# Reinicia el tablero
func reset_game():
	current_player = PLAYER_RED
	current_color = COLOR_RED
	board = []

	# Inicializar tablero lógico
	for c in range(COLS):
		board.append([])
		for r in range(ROWS):
			board[c].append(CELL_EMPTY)

	# Limpiar columnas (botones)
	for idx in range(len(columns)):
		columns[idx].text = CELL_EMPTY
		columns[idx].disabled = false

	# Limpiar celdas visualmente
	for cell in cells:
		if cell is Panel:
			cell.modulate = COLOR_EMPTY

# Botón salir
func _on_salir_pressed():
	get_tree().quit()

# Botón reiniciar
func _on_reiniciar_pressed():
	sfx_manager.reproducir_efecto("res://sonidos/recogida_fichas.mp3")
	reset_game()  # Limpia tablero y reinicia turno
	label_turno.text = "Turno actual: " + current_player

extends Node2D

signal saucercall
signal game_over
signal level_up

var timeBetweenMoves = 160
var lastMoveTime = OS.get_system_time_msecs()
var currentRow = 0
var xdir = 1
var desplazamientoAlienX = 6
var desplazamientoAlienY = 26
var saucer_called = false
var yStartSaucer = 500
var emptyRows = []
var xmax = 0
var xmin = 600
var ymax = 0

func _ready():
	var _void1 = connect("game_over", $"../GameOver", "_gameOver")
	var _void2 = connect("saucercall", $"../saucer", "_on_grid_saucercall")
	var _void3 = connect("level_up", $"../../game", "_on_grid_level_up")

func row_change():
	currentRow -= 1
	if currentRow < 0:
		currentRow = 4
		if xdir == 0:
			if xmin < 40:
				xdir = 1
			else:
				xdir = -1
		elif (xdir < 0 and xmin < 40) or (xdir > 0 and xmax > 560):
			xdir = 0
#			xdir = -xdir
		if ymax > yStartSaucer and !saucer_called:
			emit_signal("saucercall")
			saucer_called = true

func _process(_delta):
	if emptyRows.size() >= 5:
		emit_signal("level_up")
		set_process(false)
		emptyRows = []
		return
	
	if OS.get_system_time_msecs() - lastMoveTime < timeBetweenMoves:
		return
	else:
		lastMoveTime = OS.get_system_time_msecs()

	row_change()
#	var row0EmptyProtection = false
	while currentRow in emptyRows and emptyRows.size() < 5:
		row_change()

	xmax = 0
	xmin = 600
	ymax = 0

	var enemies = get_tree().get_nodes_in_group("enemies").size()
	
#	$timerMovimientoEnemigo.wait_time = 0.001 + enemies * 0.003
	timeBetweenMoves = 2.9 * enemies
	if timeBetweenMoves <= 0:
		timeBetweenMoves = 3
	var enemiesInRow = 0
	for i in get_tree().get_nodes_in_group("enemies"):
		if i.row == currentRow:
			enemiesInRow += 1
			if xdir != 0:
				i.position.x += xdir * desplazamientoAlienX
			else:
				i.position.y += desplazamientoAlienY
			i.changeFrame()
#		if currentRow == 0 or row0EmptyProtection:
		if i.position.x > xmax:
			xmax = i.position.x
		if i.position.x < xmin:
			xmin = i.position.x
		if i.position.y > ymax:
			ymax = i.position.y
			
	if enemiesInRow == 0:
		emptyRows.append(currentRow)
		
	if ymax >= 670:
		emit_signal("game_over")


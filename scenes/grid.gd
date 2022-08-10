extends Node2D

signal saucercall

var currentRow = 4
#var xtemp = 8
var xdir = 1
var desplazamientoAlienX = 6
var desplazamientoAlienY = 26
var saucer_called = false
var yStartSaucer = 500


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters thxdire scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_timerMovimientoEnemigo_timeout():
	var xmax = 0
	var xmin = 600
	var ymax = 0
	
	for i in get_tree().get_nodes_in_group("enemies"):
		if i.row == currentRow:
			if xdir != 0:
				i.position.x += xdir * desplazamientoAlienX
			else:
				i.position.y += desplazamientoAlienY
			i.changeFrame()
		if currentRow == 0:
			if i.position.x > xmax:
				xmax = i.position.x
			if i.position.x < xmin:
				xmin = i.position.x
			if i.position.y > ymax:
				ymax = i.position.y
	currentRow -= 1
	if currentRow < 0:
#		$timerMovimientoEnemigo.wait_time -= 0.02
		currentRow = 4
		if xdir == 0:
			if xmin < 40:
				xdir = 1
			else:
				xdir = -1
		elif (xdir < 0 and xmin < 40) or (xdir > 0 and xmax > 560):
			xdir = 0
		if ymax > yStartSaucer and !saucer_called:
			emit_signal("saucercall")
			saucer_called = true

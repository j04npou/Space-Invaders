extends Node2D

var currentRow = 0
var xtemp = 5
var xdir = 1


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_timerMovimientoEnemigo_timeout():
	for i in get_tree().get_nodes_in_group("enemies"):
		if i.row == currentRow:
			i.changeFrame()
			i.position.x += xdir * 10
	currentRow += 1
	if currentRow > 4:
#		$timerMovimientoEnemigo.wait_time -= 0.02
		currentRow = 0
		xtemp += 1
		if xtemp > 10:
			xdir = -xdir
			xtemp = 0

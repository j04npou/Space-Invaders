extends Node2D

export var alienType = 0
export var row = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	
	if alienType == 0:
		$calamar.visible = true
		$cangrejo.visible = false
		$medusa.visible = false
	elif alienType == 1:
		$calamar.visible = false
		$cangrejo.visible = true
		$medusa.visible = false
	elif alienType == 2:
		$calamar.visible = false
		$cangrejo.visible = false
		$medusa.visible = true
		
func changeFrame():
	var anim = null
	if alienType == 0:
		anim = $calamar
	elif alienType == 1:
		anim = $cangrejo
	elif alienType == 2:
		anim = $medusa
		
	if anim.frame == 0:
		anim.frame = 1
	else:
		anim.frame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

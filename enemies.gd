extends Node2D

export var alienType = 0
export var row = 0

var anim

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
		anim = $calamar
	elif alienType == 1:
		$calamar.visible = false
		$cangrejo.visible = true
		$medusa.visible = false
		anim = $cangrejo
	elif alienType == 2:
		$calamar.visible = false
		$cangrejo.visible = false
		$medusa.visible = true
		anim = $medusa
		
func changeFrame():
	if anim.frame == 0:
		anim.frame = 1
	else:
		anim.frame = 0
		
func die():
	anim.animation = "death"
	$alien.collision_layer = 0
	$alien.collision_mask = 0
	anim.play()


func _on_animation_finished():
	queue_free()

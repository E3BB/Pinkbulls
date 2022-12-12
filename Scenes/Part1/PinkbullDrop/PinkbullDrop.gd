extends KinematicBody2D

# Variables
var goDir : float # A rotation
var timeToDie : float = 5 # Time (Seconds) till disapear
var speed : float = 20 # Speed of drop

func _physics_process(delta):
	
	# Move it
	move_and_slide(Vector2(speed * 16, 0).rotated(goDir))
	
	# Dye it
	if timeToDie > 0:
		timeToDie -= delta
	else:
		queue_free()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

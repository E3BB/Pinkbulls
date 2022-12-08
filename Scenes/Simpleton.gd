extends Node2D

# Variables

# Physics Process
func _physics_process(delta):
	if Input.is_action_pressed("Esc"):
		get_tree().quit()

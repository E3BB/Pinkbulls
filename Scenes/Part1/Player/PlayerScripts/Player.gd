extends KinematicBody2D

# Variables
var vel : Vector2 # Velocity
var inputLR : float # Left/Right input, expressed from -1 to 1

# Physics Process Run
func _physics_process(delta):
	
	# Set Input
	inputLR = (Input.get_action_strength("Right") - Input.get_action_strength("Left")) * 96
	
	# Velocity Check and etc.
	vel.x += inputLR * delta
	
	vel.x = vel.x if vel.x < 64 else 64
	vel.x = vel.x if vel.x > -64 else -64
	
	# Move
	move_and_slide(vel, Vector2(0, -1))
	
	# Update Speed Label
	$"Camera2D/Label".text = "Vel.x = " + String(vel.x)
	

extends KinematicBody2D

# Variables

var vel : Vector2 # Velocity
var inputLR : float # Left/Right input, expressed from -1 to 1
var acc : float = 128 # Player Acceleration
var gravity : float = 30 * 16 # Gravity
var jump_strength : float = 256 # Jump Strength (How much speed you get when you jump)
var drag : float = 256 # Drag force, measured in pixels per second per second
var stopPower : float = 512 # Power of Stopping (When you move a different way than velocity)
var soleLeft : int = 50 # How many sole-jumps the player has in their sole
var bootsLocked : bool = false # Are the cloud-jumpers locked?


# On Ready
func _ready():
	
	# Double Jump Indicator
	$"LockBootsIndicator".position = $"/root/Node2D/LockBootsSpot".position
	

# Physics Process Run
func _physics_process(delta):
	
	# Set Input
	
	inputLR = (Input.get_action_strength("Right") - Input.get_action_strength("Left"))
	$"Sprite".flip_h = true if inputLR > 0 else false
	
	
	# Gravity
	
	vel.y += gravity * delta
	vel.y = 0 if is_on_floor() else vel.y
	
	
	# Velocity Check for Walls
	
	vel.x = 0 if is_on_wall() else vel.x
	
	
	# Drag Calculations & Opposite-Direction-Speed
	
	vel.x -= drag * delta if inputLR == 0 && vel.x > 0 and is_on_floor() else 0
	vel.x += drag * delta if inputLR == 0 && vel.x < 0 and is_on_floor() else 0
	vel.x = 0 if vel.x < drag * delta && vel.x > 0 && is_on_floor() && inputLR == 0 else vel.x
	vel.x = 0 if vel.x > drag * delta && vel.x < 0 && is_on_floor() && inputLR == 0 else vel.x
	
	vel.x -= abs(inputLR) * stopPower * delta if inputLR < 0 && vel.x > 0 else 0
	vel.x -= -abs(inputLR) * stopPower * delta if inputLR > 0 && vel.x < 0 else 0
	
	
	# Left-Right Input
	
	vel.x += inputLR * acc * delta
	
	
	# Jump & Double Jump & Wall Jump
	
	if Input.is_action_just_pressed("LockBoots"):
		bootsLocked = !bootsLocked
	
	if Input.is_action_pressed("Jump") && is_on_floor():
		vel.y -= jump_strength
	elif Input.is_action_just_pressed("Jump") && is_on_wall() && vel.x != 0:
		vel.x = jump_strength * (-vel.x / abs(vel.x)) / 3
		vel.y = -jump_strength
	elif Input.is_action_just_pressed("Jump") && soleLeft > 0 && bootsLocked == false:
		soleLeft -= 1
		vel.y -= jump_strength * 0.6 if vel.y < 0 else 0
		vel.y = -jump_strength * 0.8 if vel.y > 0 else vel.y
		vel.x += inputLR * acc * 0.4
	
	$"LockBootsIndicator".frame = 1 if bootsLocked == false else 0
	
	
	# Move
	
	move_and_slide(vel, Vector2(0, -1))
	
	
	# Update Speed & Cloud-Jumps Label
	
	$"%Camera2D/Label".text = "Vel.x = " + String(vel.x)
	$"%Camera2D/Label2".text = "You have " + String(soleLeft) + " Double Jumps"
	

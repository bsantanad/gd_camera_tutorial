extends "res://src/Player/PlayerState.gd"

export var max_speed: = 50.0
export var move_speed: = 25.0
export var gravity = -80.0
export var jump_impulse: = 25.0

var velocity: = Vector3.ZERO

func physics_process(delta: float) -> void:

	
	## Get the Direction
	var input_direction: = get_input_direction() 
	var move_direction = input_direction
	
	# If the player move diagonaly it would go faster, 
	# so we need to normalize the vector.
	if move_direction.length() > 1.0:
		move_direction = move_direction.normalized()
	move_direction.y = 0 # Makes sure our player is in the ground

	## Rotate Character 
	if move_direction: # Checks if the player is moving
		# We want to make him look in the direction his moving
		player.look_at(player.global_transform.origin + move_direction, Vector3.UP)
	## 
	
	## Move Character
	velocity = calculate_velocity(velocity, move_direction, delta)
	
	# This function will multiply our velocity times delta, so we 
	# don't have to worry about it. 
	# We make it equal to velocity, that way it will reset the Y movement
	# to zero. (When the player is falling and hits the ground)
	velocity = player.move_and_slide(velocity, Vector3.UP)

static func get_input_direction() -> Vector3:
	return Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0.0, 
		Input.get_action_strength("move_back") - Input.get_action_strength("move_front")
	)

func calculate_velocity(velocity_current: Vector3, move_direction: Vector3, delta: float) -> Vector3:
	
	var velocity_new = velocity_current
	velocity_new =  move_direction * move_speed # * delta
	
	if velocity_new.length() > max_speed:
		velocity_new = velocity_new.normalized() * max_speed
	velocity_new.y = velocity_current.y + gravity * delta
	
	return velocity_new
	

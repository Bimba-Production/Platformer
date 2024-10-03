class_name WalkingPlayerState extends PlayerMovementState

@export var SPEED: float = 140.0
@export var ACCELERATION: float = 12.0
@export var DECELERATION: float = 22.0

func enter(previous_state) -> void:
	ANIMATION.stop()
	ANIMATION.play("Run")

func update(delta: float) -> void:
	PLAYER.update_player_orientation()
	PLAYER.update_velocity(delta, SPEED, ACCELERATION, DECELERATION)
	PLAYER.move_and_slide()
	
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpingPlayerState")
	elif Input.is_action_just_pressed("crouch") and PLAYER.is_on_floor():
		transition.emit("CrouchingWalkingPlayerState")
	elif !PLAYER.is_on_floor():
		transition.emit("FallingPlayerState")
	elif PLAYER.direction == 0 and PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")

class_name CrouchingWalkingPlayerState extends PlayerMovementState

@export var SPEED: float = 70.0
@export var ACCELERATION: float = 10.0
@export var DECELERATION: float = 22.0

func enter(previous_state) -> void:
	ANIMATION.play("CrouchWalk")

func update(delta: float) -> void:
	PLAYER.update_player_orientation()
	PLAYER.update_velocity(delta, SPEED, ACCELERATION, DECELERATION)
	PLAYER.move_and_slide()
	
	if !Input.is_action_pressed("crouch"):
		transition.emit("IdlePlayerState")
	
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpingPlayerState")
	
	if Input.is_action_pressed("crouch") and PLAYER.direction == 0:
		transition.emit("CrouchingIdlePlayerState")
	
	if !PLAYER.is_on_floor():
		transition.emit("FallingPlayerState")

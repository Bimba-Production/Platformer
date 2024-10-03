class_name FallingPlayerState extends PlayerMovementState

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.2
@export var DECELERATION: float = 0.2

func enter(previous_state) -> void:
	ANIMATION.play("Fall")
	PLAYER.velocity.x /= 3

func update(delta: float) -> void:
	PLAYER.update_player_orientation()
	PLAYER.apply_gravity(delta)
	PLAYER.move_and_slide()
	PLAYER.position.x += lerp(0.0, SPEED * PLAYER.direction, ACCELERATION)
	
	if Input.is_action_pressed("crouch") and PLAYER.is_on_floor():
		transition.emit("CrouchingIdlePlayerState")
	elif PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
	elif PLAYER.is_on_wall() and !PLAYER.is_on_floor():
		transition.emit("GrabWallPlayerState")

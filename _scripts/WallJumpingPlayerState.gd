class_name WallJumpingPlayerState extends PlayerMovementState

@export var SPEED: float = 2.0
@export var ACCELERATION: float = 0.2
@export var DECELERATION: float = 0.2
@export var JUMP_VELOCITY: float = -380.0
@export var JUMP_VELOCITY_X: float = 150.0

func enter(previous_state) -> void:
	PLAYER.velocity.y += JUMP_VELOCITY
	PLAYER.velocity.x = JUMP_VELOCITY_X * -PLAYER.ORIENTATION
	ANIMATION.play("Jump")

func update(delta: float) -> void:
	PLAYER.update_player_orientation()
	PLAYER.apply_gravity(delta)
	PLAYER.move_and_slide()
	PLAYER.position.x += lerp(0.0, SPEED * PLAYER.direction, ACCELERATION)
	
	if Input.is_action_just_released("jump"):
		PLAYER.velocity.y /= 1.4
		PLAYER.velocity.x /= 1.4
	if Input.is_action_pressed("crouch") and PLAYER.is_on_floor():
		transition.emit("CrouchingIdlePlayerState")
	elif PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
	elif PLAYER.is_on_wall() and !PLAYER.is_on_floor():
		transition.emit("GrabWallPlayerState")

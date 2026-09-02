class_name Player extends CharacterBody2D

# Move speed of player
# @export var move_speed: float = 100.0

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
# var state: String = "idle"

@onready var player_anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

signal DirectionChanged(new_dir: Vector2)

func _ready() -> void:
	state_machine.Initialize(self)

func _process(_delta: float) -> void:
	# direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	# direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()

	# velocity = direction.normalized() * move_speed

	# if SetState() == true || SetDirection() == true:
	# 	UpdateAnimation()

func _physics_process(_delta: float) -> void:
	move_and_slide()


func SetDirection() -> bool:
	var new_dir: Vector2 = cardinal_direction

	if direction == Vector2.ZERO:
		return false

	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN

	if new_dir == cardinal_direction:
		return false

	cardinal_direction = new_dir

	DirectionChanged.emit(new_dir)

	# player_anim.flip_h = true if cardinal_direction == Vector2.LEFT else false
	player_anim.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1

	return true


# func SetState() -> bool:
# 	var new_state: String = "idle" if direction == Vector2.ZERO else "walk"
# 	if new_state == state:
# 		return false
# 	state = new_state
# 	return true

func UpdateAnimation(state: String) -> void:
	player_anim.play(state + "_" + AnimDirection())

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	if cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
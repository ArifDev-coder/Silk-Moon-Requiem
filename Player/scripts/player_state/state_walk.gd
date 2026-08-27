class_name State_Walk extends State

@export var move_speed: float = 100.0

@onready var idle: State = $"../Idle"


# ? Apa yang terjadi ketika player masuk ke State ini?
func Enter() -> void:
	player.UpdateAnimation("walk")

# ? Apa yang terjadi ketika player keluar dari State ini?
func Exit() -> void:
	pass

# ? Apa yang terjadi ketika update _process pada State ini?
func Process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle

	player.velocity = player.direction.normalized() * move_speed

	if player.SetDirection():
		player.UpdateAnimation("walk")

	return null


# ? Apa yang terjadi ketika _physics_process
func Physics(_delta: float) -> State:
	return null

# ? Apa yang terjadi pada input event pada State ini?
func HandleInput(_event: InputEvent) -> State:
	return null

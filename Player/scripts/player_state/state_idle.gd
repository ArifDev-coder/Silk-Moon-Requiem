class_name State_Idle extends State

@onready var walk: State = $"../Walk"

# ? Apa yang terjadi ketika player masuk ke State ini?
func Enter() -> void:
    player.UpdateAnimation("idle")


func Exit() -> void:
    pass


# ? Apa yang terjadi ketika update _process pada State ini?
func Process(_delta: float) -> State:
    if player.direction != Vector2.ZERO:
        return walk
    
    player.velocity = Vector2.ZERO

    return null


func Physics(_delta: float) -> State:
    return null


#? What happens with input event in this State?
func HandleInput(_event: InputEvent) -> State:
    return null
class_name  PlayerStateMachine extends Node

var states: Array[State]
var prev_state: State
var current_state: State

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
    pass

func _physics_process(delta: float) -> void:
    pass

func _unhand
extends CSGBox3D

@export var start_position: Node3D
@export var end_position: Node3D
@export var time_to_transition: float = 1.0

var _start_position: Vector3
var _end_position: Vector3


func _ready() -> void:
	self._start_position = self.start_position.global_position
	self._end_position = self.end_position.global_position

	var tween: Tween = self.create_tween()
	tween.tween_property(self, "position", self._end_position, time_to_transition)
	tween.tween_property(self, "position", self._start_position, time_to_transition)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_loops()

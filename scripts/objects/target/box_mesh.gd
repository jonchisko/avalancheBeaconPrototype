extends MeshInstance3D


@export var tween_time: float = 1.0
@export var height_offset: float = 1.0


func _ready() -> void:
	var tween: Tween = self.create_tween()
	var base_position: Vector3 = self.position

	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector3(base_position.x, base_position.y + self.height_offset, base_position.z), self.tween_time / 2.0)
	tween.tween_property(self, "position", Vector3(base_position.x, base_position.y, base_position.z), self.tween_time / 2.0)
	tween.set_loops(0)

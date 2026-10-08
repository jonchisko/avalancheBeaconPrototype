class_name Interactor extends Area3D


signal interactable_detected(interactable: Interactable)
signal interactable_gone


var _current_interactable: Interactable


func interact() -> void:
	if self._current_interactable == null:
		return

	self._current_interactable.interact()


func _ready() -> void:
	pass


func _on_interactable_detected(interactable: Interactable) -> void:
	self._current_interactable = interactable
	self.interactable_detected.emit(interactable)


func _on_interactable_area_left() -> void:
	self._current_interactable = null
	self.interactable_gone.emit()



func _on_area_exited(area: Area3D) -> void:
	var interactable: Interactable = area as Interactable
	if interactable == null:
		return

	if interactable != self._current_interactable:
		return

	self._current_interactable = null
	self.interactable_gone.emit()


func _on_area_entered(area: Area3D) -> void:
	var interactable: Interactable = area as Interactable
	if interactable == null:
		return

	if self._current_interactable != null:
		return

	self._current_interactable = interactable
	self.interactable_detected.emit(interactable)

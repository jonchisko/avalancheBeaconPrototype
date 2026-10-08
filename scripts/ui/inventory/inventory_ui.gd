class_name InventoryUi extends Control


# Key: Consumable, Value: Dict ("label": Label, "icon": TextureRect)
@export var consumable_to_label: Dictionary


var _tween_dictionary: Dictionary
var _old_icon_position: Dictionary

func _ready() -> void:
	for consumable in self.consumable_to_label.keys():
		var label_icon = self.consumable_to_label.get(consumable)
		var icon_node: TextureRect = self._get_node_at_nodepath(label_icon, "icon")
		self._old_icon_position[icon_node] = icon_node.position


func on_set_consumable_value(consumable: Consumable, value: int) -> void:
	var label_icon: Dictionary = self.consumable_to_label.get(consumable)

	if label_icon == null:
		push_error("Consumable not found in InventoryUi")
		return

	self._play_tween_animation_on_object(label_icon, value)


func _play_tween_animation_on_object(label_icon: Dictionary, value: int) -> void:
	var label: Label = self._get_node_at_nodepath(label_icon, "label")
	var icon: TextureRect = self._get_node_at_nodepath(label_icon, "icon")

	var label_tween: Tween = self._tween_dictionary.get(label)
	var icon_tween: Tween = self._tween_dictionary.get(icon)

	if label_tween != null && label_tween.is_valid():
		label_tween.kill()
		#self._tween_dictionary.erase(label_tween)
	if icon_tween != null && icon_tween.is_valid():
		icon_tween.kill()
		#self._tween_dictionary.erase(icon_tween)

	icon.scale = Vector2.ONE
	icon.position = self._old_icon_position[icon]

	label.scale = Vector2.ONE
	label.modulate = Color.WHITE

	icon.pivot_offset = icon.size / 2
	label.pivot_offset = label.size / 2

	var tween_icon = self.get_tree().create_tween()
	self._tween_dictionary[icon] = tween_icon

	tween_icon.set_parallel()
	tween_icon.tween_property(icon, "scale", Vector2.ONE * 1.4, 0.25)
	tween_icon.tween_property(icon, "position", self.position + Vector2(0.0, -20.0), 0.25)

	tween_icon.set_parallel(false)

	tween_icon.tween_property(icon, "scale", Vector2.ONE, 0.25)
	tween_icon.set_parallel()
	tween_icon.tween_property(icon, "position", self._old_icon_position[icon], 0.25)

	var tween_label = self.get_tree().create_tween()
	self._tween_dictionary[label] = tween_label

	tween_label.set_parallel()
	tween_label.set_trans(Tween.TRANS_CUBIC)
	tween_label.set_ease(Tween.EASE_OUT)
	tween_label.tween_property(label, "scale", Vector2.ZERO, 0.4)
	tween_label.tween_property(label, "modulate", Color.TRANSPARENT, 0.3)

	tween_label.set_parallel(false)
	tween_label.tween_property(label, "text", "X %d" % value, 0.0)

	tween_label.tween_property(label, "scale", Vector2.ONE, 0.4)
	tween_label.set_parallel()
	tween_label.tween_property(label, "modulate", Color.WHITE, 0.3)


func _get_node_at_nodepath(label_icon: Dictionary, key: String) -> Node:
	return self.get_node(label_icon[key] as NodePath)

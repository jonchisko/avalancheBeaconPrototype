class_name SignalLabelUi extends MarginContainer


@onready var _label: Label = $Label


func set_label(value: float) -> void:
	self._label.text = "%.2f" % value

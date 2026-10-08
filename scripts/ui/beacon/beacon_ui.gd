class_name BeaconUi extends Control


@export var beacon: Beacon


@onready var _signal_labels_container = %SignalLabelContainer


var _signal_label_scene: PackedScene = preload("res://scenes/ui/beacon/signal_label_ui.tscn")
var _signal_labels: Array[SignalLabelUi]


func _ready() -> void:
	self.beacon.beacon_calculation_update.connect(self._update_beacon_list)

	for _i in range(self.beacon.max_targets):
		var signal_label = self._signal_label_scene.instantiate() as SignalLabelUi
		self._signal_labels_container.add_child(signal_label)
		self._signal_labels.push_back(signal_label)
		signal_label.visible = false


func _update_beacon_list(beacon_signals: Array[float]) -> void:
	self._reset_signal_labels_visibility()

	for i in range(beacon_signals.size()):
		self._signal_labels[i].set_label(beacon_signals[i])
		if beacon_signals[i] <= 0.0:
			self._signal_labels[i].visible = false
		else:
			self._signal_labels[i].visible = true


func _reset_signal_labels_visibility() -> void:
	for label in self._signal_labels:
		label.visible = false

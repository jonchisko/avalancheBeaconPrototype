class_name SkillElementUi extends PanelContainer


signal skill_element_clicked
signal click_animation_finished


@onready var _skill_name_label: Label = %SkillNameLabel
@onready var _skill_rarity_label: Label = %SkillRarityLabel
@onready var _skill_value_label: Label = %SkillValueLabel

@onready var _animation_player: AnimationPlayer = $AnimationPlayer


var _element_clickable: bool = true


func _ready() -> void:
	self.modulate = Color.TRANSPARENT


func init_values(skill: Skill) -> void:
	self._skill_name_label.text = skill.skill_name
	self._skill_rarity_label.text = GlobalEnums.SkillRarity.keys()[skill.rarity]
	self._skill_value_label.text = "%.2f" % skill.value
	self._animation_player.play("pop_in")


func disable() -> void:
	self._element_clickable = false
	self._animation_player.play("disable")


func _gui_input(event: InputEvent) -> void:
	if !self._element_clickable:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			self._element_clickable = false
			self.skill_element_clicked.emit()

			self._animation_player.play("pop_out")
			await self._animation_player.animation_finished

			self.click_animation_finished.emit()


func _on_mouse_entered() -> void:
	if self._animation_player.is_playing():
		return
	self._animation_player.play("on_hover")

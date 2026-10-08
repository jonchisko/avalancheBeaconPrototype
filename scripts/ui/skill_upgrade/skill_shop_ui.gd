class_name SkillShopUi extends Control


signal skill_selected


@onready var skill_container: VBoxContainer = %SkillContainer


var _skill_element_scene: PackedScene = preload("res://scenes/ui/skill_upgrade/skill_element_ui.tscn")

var _skill_elements: Array[SkillElementUi] = []


func set_skill_choice(skill_choice: SkillChoice) -> void:
	for skill in skill_choice.skills:
		var instantiated_element: SkillElementUi = self._skill_element_scene.instantiate()

		self.skill_container.add_child(instantiated_element)
		self._skill_elements.push_back(instantiated_element)
		instantiated_element.init_values(skill)

		instantiated_element.skill_element_clicked.connect(self._on_skill_element_clicked.bind(instantiated_element))
		instantiated_element.click_animation_finished.connect(self._on_skill_click_animation_finished.bind(skill))


func clear_skill_choice() -> void:
	var element: SkillElementUi
	while !self._skill_elements.is_empty():
		element = self._skill_elements.pop_back()
		element.call_deferred("queue_free")


func _on_skill_element_clicked(clicked_skill: SkillElementUi) -> void:
	# Once the skill is selected, disable others
	for skill in self._skill_elements:
		if clicked_skill == skill:
			continue
		skill.disable()


func _on_skill_click_animation_finished(clicked_skill: Skill) -> void:
	self.skill_selected.emit(clicked_skill)

extends Area2D

onready var gpuParticles = $Particles2D
onready var cpuParticles = $CPUParticles2D

func _physics_process(delta):
	if Settings.cpuParticles == true:
		gpuParticles.set_process(false)
		cpuParticles.set_process(true)
	else:
		if Settings.cpuParticles == false:
			cpuParticles.set_process(false)
			gpuParticles.set_process(true)
		else:
			print("ERROR: Settings.cpuParticles is not true or false (Null).")

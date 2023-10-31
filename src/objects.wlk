
class Casa {
	const property habitaciones = #{}
	method estanOcupadas() = habitaciones.all({h => !h.ocupantes().isEmpty()})
	method responsable() = habitaciones.map({h=>h.ocupantes().max({p =>p.edad()})})
}

class Familia {
	const property integrantes = #{} 
	const property casa
}

class Habitacion {
	var property persona
	const property ocupantes = #{}
	method puedeEntrar(unaPersona)
	method confort() = 10
	method puedeIngresar() {
		return ocupantes.isEmpty() or self.puedeEntrar(persona)
	}
	method ingresarOcupante(unaPersona){
		if (!self.puedeIngresar()){
			throw new Exception(message = "No puede agregarse")
		}
		ocupantes.add(persona)	
		
	}
	
}

class General{
	method puedeEntrar(persona) = true
}

class Bano inherits Habitacion {
	override method confort() {
		if (persona.edad() >= 4)
			return super() + 2
		return super() + 4
	}
	override method puedeEntrar(unaPersona) = true
}

class Dormitorio inherits Habitacion {
	var property personaQueDuermen = #{}
	override method confort() {
		if (personaQueDuermen.any({dorm => persona ==dorm}))
			return super() + 10/personaQueDuermen.size()
		return super()
	} 
	override method puedeEntrar(unaPersona) = personaQueDuermen.contains(unaPersona)
}

class Cocina inherits Habitacion {
	const metrosCuadrados
	const property porcentaje
	override method confort() {
		if (persona.tieneHabilidadesCocina())
			return super() + porcentaje *100/metrosCuadrados
		return super()
	} 
	override method puedeEntrar(unaPersona) = unaPersona.tieneHabilidadesCocina() && not ocupantes.any({p => p.tieneHabilidadesCocina()})
}

object ariel {
	method tieneHabilidadesCocina() = false
	method edad() = 25
}
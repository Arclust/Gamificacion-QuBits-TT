extends StaticBody3D

#@onready var InventarioQbits: Array[Qbit] = []
#
#func _process(delta: float) -> void:
	#$"Entradas/EntradaX+/QbitsLabel".text = "i0:" + str(Contar_Qbits([0])) + "   y   i1:" + str(Contar_Qbits([1]))
	#$"Entradas/EntradaX-/QbitsLabel".text = "i0:" + str(Contar_Qbits([0])) + "   y   i1:" + str(Contar_Qbits([1]))
#
#func Contar_Qbits(valores_filtro):
	#for objeto in InventarioQbits:
		#if objeto.valores == valores_filtro:
			#return objeto.cant
	#return 0
	#
#func Existe_Qbit(valores_filtro) -> bool:
	#for objeto in InventarioQbits:
		#if objeto.valores == valores_filtro:
			#return true
	#return false
	#
	#
	#
#func Agregar_Qbit(valores_filtro, cantidad_agre) -> void:
	#if Existe_Qbit(valores_filtro):
		#for objeto in InventarioQbits:
			#if objeto.valores == valores_filtro:
				#objeto.cant += cantidad_agre
				#return
	#else:
			#var NuevoQbit = Qbit.new(1,valores_filtro,cantidad_agre)
			#InventarioQbits.append(NuevoQbit)
			#return
	#
	#
	#
#func Disminuir_Qbit(valores_filtro, cantidad_dism) -> void:
	#var i = 0
	#for objeto in InventarioQbits:
		#if objeto.valores == valores_filtro:
			#if objeto.cant > cantidad_dism:
				#objeto.cant -= cantidad_dism
				#return
			#else:
				#InventarioQbits.remove_at(i)
				#return
		#i += 1
		#
#func Datos_primero() -> Array:
	#for objeto in InventarioQbits:
		#return objeto.valores.duplicate()
	#return []

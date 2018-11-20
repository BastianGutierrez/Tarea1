require 'httparty'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
URL = 'http://sepa.utem.cl/rest/api/v1'
AUTH = {username: '2E5Vw7WUCm', password: '0754e0cbf6df85c40be0715e643c9f1c'}
ASIGNATURAS = '/docencia/asignaturas'
DOCENTES = '/academia/docentes'

respuestas =HTTParty.get(URL+ASIGNATURAS, basic_auth: AUTH)
respuestas1=HTTParty.get(URL+DOCENTES, basic_auth: AUTH)


inf = []
inf1 = []
inf2 = []

respuestas.each do |asignatura|
	nombre = asignatura['departamento']['nombre']
	fecha = asignatura["fechaCreacion"]
	 
	
	#puts fecha
	if nombre == "Informática y Computación"

		inf << asignatura["nombre"]

		if fecha.to_i == 2015

			inf1 << asignatura["nombre"]

		end
	end	
end


respuestas1.each do |docente|

	fechanaci = docente["fechaNacimiento"]

	#puts fechanaci.to_i

		if fechanaci.to_i < 1980

			inf2 << docente["nombres"]
		
		end
end

#puts "Lista de asignaturas de info", inf

#puts "Lista de asignaturas de info impartidas el 2015", inf1

#puts "Nomina de docentes que nacieron antes del 1980", inf2

File.open('GutierrezSerrano', 'w') do |file1|

	file1.puts'Lista de asignaturas de info: '
	file1.puts'/////////////////////////////////////////////////////'
	file1.puts inf
	file1.puts'/////////////////////////////////////////////////////'
	file1.puts 'Lista de asignaturas de info impartidas el 2015:'
	file1.puts inf1 
	file1.puts'/////////////////////////////////////////////////////'
	file1.puts 'Nomina de docentes que nacieron antes del 1980 : '
	file1.puts inf2
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = [{email: "bgaete@uc.cl", username: "Bea", password: "railsrails", tipo: 3},
	{email: "jnhasard@uc.cl", username: "jaxhei", password: "holahola", tipo: 1},
	 {email: "pepito@uc.cl",
	username: "pepe", password: "peperails", tipo: 1}, {email: "juanito@uc.cl", username: "John",
		password: "juanrails", tipo: 1}]
users.each do |u|
	new_user = User.new u
	new_user.save!
end
Forum.create(title: "Tiempo en Santiago", body: "¿Frío o calor? Comenta las últimas novedades del tiempo en Santiago ")
Forum.create(title: "Fútbol", body: "Goles, jugadas, equipos")
Forum.create(title: "Cultura", body: "Música, libros, deportes, etc")
Forum.create(title: "Cultura", body: "Música, libros, deportes, etc")
Forum.create(title: "Mundial Rusia 2018", body: "Resultados y fechas del mundial aquí ")

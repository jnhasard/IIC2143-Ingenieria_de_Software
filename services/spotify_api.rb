require 'HTTparty'
class Spotify
	include HTTParty
	base_uri 'https://api.spotify.com/v1'

	def initialize
		credentials =
		"#{ENV['SPOTIFY_CLINT_ID']}:#{{ENV['SPOTIFY_CLIENT_SECRET']}}"
		auth = 'Basic ' + Base64.encode64(credentials).chop.gsub('\n', '') #encriptando credenciales en base 64
		response = self.class.post('https://accounts.spotify.com/api/token'), {
				headers: { 'Authorization' => auth }, body: { grant_type: 'authorization_code' }
		} # esta es la primera request a la API
		@token = response['access_token']	# en esta variable guardamos el acces token que sirve para cierto periodo
	end
	def auth_header
		{ 'Autorization' => "Bearer #{@token}"} #esto se va a mandar
	end

	def search_artist(name)
		self.class.get(
			"/search?=#{name}&type=artist",
			headers: auth_header # los headers van a ser esta funcion que definimos antes
		).to_h['artists']['items'] # los get solo tiene headers
		# TAREA PARA LA CASA MANEJAR LOS ERRORES
	end
	def get_artist(id)
		self.class.get(
		"/artist/#{id}", headers: auth_header)
	end
end
# en el head que cosas estoy mandando
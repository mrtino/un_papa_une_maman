#!/usr/bin/env ruby
# coding: utf-8

# Chargement de la gem requise pour communiquer avec twitter
require 'twitter'

# Ne pas lancer le script s'il y a moins de trois arguments
abort "Merci de spécifier deux fichiers comportant respectivement des noms masculins et féminins séparés par des lignes." unless ARGV.size == 2

# Ne pas lancer le script si les fichiers spécifiés n'existent pas, sont des dossiers ou ne sont pas lisibles
ARGV.each do |arg|
  abort "Impossible d'ouvrir le fichier #{arg}." unless File.readable? arg
end

# Parsing du fichiers de clés afin de configurer le client
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

papa_maman = [ "papa", "maman" ]        # Définition des deux mots par défaut
rand_num = rand(2)                      # Choisit aléatoirement quel mot va se faire remplacer

words = File.open(ARGV[rand_num], "r")                                                                          # Ouverture du fichier de mots correspondant
(rand(`wc -l #{ARGV[rand_num]}`.strip.split(' ')[0].to_i) + 1).times { papa_maman[rand_num] = words.gets.strip }      # Remplace le mot par un mot aléatoire du fichier

# Fermeture du fichier de mots
words.close

# Envoi du tweet
client.update "Un #{papa_maman[0]}, une #{papa_maman[1]}, on ne ment pas aux enfants !"

# Fermeture de l'application si tout s'est bien passé
exit 0

# Be sure to restart your server when you modify this file.

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'regiao', 'regioes'
  inflect.irregular 'reclamacao', 'reclamacoes'
  inflect.irregular 'categoria', 'categorias'
end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end

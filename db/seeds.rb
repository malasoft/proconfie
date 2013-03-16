# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# https://github.com/zdennis/activerecord-import

require 'iconv'

class String
  def to_latin_and_split
    Iconv.conv('utf-8', 'latin1', self).strip.split(";")                              # Tratanto enconding devido a acentuacao
  end
end

def create_regions
  puts "Criando Regioes"
  regioes = []
  ["Norte", "Nordeste", "Sudeste", "Sul", "Centro-Oeste"].each do |nome|              # Mantendo ordem dos dados originais
    regioes << Regiao.new(:nome => nome)
  end
  Regiao.import(regioes, {:validate => false})
end

def create_states
  puts "Criando Estados"
  estados = []
  File.open(Rails.root.join("db", "estados.dat")).each do |line|
    # O arquivo estados.dat deve haver a primeira coloca em ordem crescente
    # Descarta a primeira coluna (o ID do estado), mas ela sera compensanda pelo autoincrement do banco
    sigla, nome, regiao_id = line.to_latin_and_split[1..3]
    estados << Estado.new(:sigla => sigla, :nome => nome, :regiao_id => regiao_id)
  end
  Estado.import(estados, {:validate => false})
end

def create_categories
  puts "Criando Categorias"
  categorias = []
  File.open(Rails.root.join("db", "categorias.dat")).each do |line|
    categoria_id, descricao = line.to_latin_and_split
    categorias << [categoria_id, descricao]
  end
  campos = [:categoria_id, :descricao]
  Categoria.import(campos, categorias, {:validate => false})
end

def create_radical_cnpjs
  puts "Criando Radical CNPJ"
  radical_cnpjs = []
  File.open(Rails.root.join("db", "radical_cnpjs.dat")).each do |line|
    radical_cnpj_id, descricao = line.to_latin_and_split
    radical_cnpjs << [radical_cnpj_id, descricao]
  end 
  campos = [:radical_cnpj_id, :descricao]
  RadicalCnpj.import(campos, radical_cnpjs, {:validate => false})
end

def create_empresas
  puts "Criando Empresas"
  empresas = []
  File.open(Rails.root.join("db", "empresas.dat")).each do |line|
    cnpj, razao_social, nome_fantasia, radical_cnpj_id, categoria_id,
    reclamacoes_menos_infinito_ate_tres_anos, reclamacoes_dois_anos_ate_tres_anos, reclamacoes_um_ano_ate_dois_anos,
    reclamacoes_seis_meses_ate_um_ano, reclamacoes_hoje_ate_seis_meses, percentual_reclamacoes_categoria_menos_infinito_ate_tres_anos,
    percentual_reclamacoes_categoria_dois_anos_ate_tres_anos, percentual_reclamacoes_categoria_um_ano_ate_dois_anos,
    percentual_reclamacoes_categoria_seis_meses_ate_um_ano, percentual_reclamacoes_categoria_hoje_ate_seis_meses, slope_pedro,
    numero_normalizado_reclamacoes_categoria, mediana_duracao_reclamacoes, media_duracao_reclamacoes, skewness_duracao_reclamacoes,
    data_primeira_reclamacao, total_reclamacoes_resolvidas, numero_proporcional_reclamacoes_res_hoje_ate_seis_meses,
    numero_proporcional_reclamacoes_res_seis_meses_ate_um_ano, numero_proporcional_reclamacoes_res_um_ano_ate_dois_anos,
    numero_proporcional_reclamacoes_res_dois_anos_ate_tres_anos, slope_pes, score, estado_id = line.to_latin_and_split
    
    # Empresa 33098658000137, FININVEST &#8722,  NEGOCIOS DE VAREJO LTDA, FININVEST nao tem RadicalCnpj nem Categoria encontrados
    if Categoria.exists?(categoria_id) and RadicalCnpj.exists?(radical_cnpj_id)
      empresas << [cnpj, categoria_id, radical_cnpj_id, razao_social, nome_fantasia,
            reclamacoes_menos_infinito_ate_tres_anos, reclamacoes_dois_anos_ate_tres_anos, reclamacoes_um_ano_ate_dois_anos,
            reclamacoes_seis_meses_ate_um_ano, reclamacoes_hoje_ate_seis_meses, percentual_reclamacoes_categoria_menos_infinito_ate_tres_anos,
            percentual_reclamacoes_categoria_dois_anos_ate_tres_anos, percentual_reclamacoes_categoria_um_ano_ate_dois_anos,
            percentual_reclamacoes_categoria_seis_meses_ate_um_ano, percentual_reclamacoes_categoria_hoje_ate_seis_meses, slope_pedro,
            numero_normalizado_reclamacoes_categoria, mediana_duracao_reclamacoes, media_duracao_reclamacoes, skewness_duracao_reclamacoes,
            Time.at(data_primeira_reclamacao.to_i).to_datetime, total_reclamacoes_resolvidas, numero_proporcional_reclamacoes_res_hoje_ate_seis_meses,
            numero_proporcional_reclamacoes_res_seis_meses_ate_um_ano, numero_proporcional_reclamacoes_res_um_ano_ate_dois_anos,
            numero_proporcional_reclamacoes_res_dois_anos_ate_tres_anos, slope_pes, score, estado_id]
    end
  end
  campos = [:cnpj, :categoria_id, :radical_cnpj_id, :razao_social, :nome_fantasia,
            :reclamacoes_menos_infinito_ate_tres_anos, :reclamacoes_dois_anos_ate_tres_anos, :reclamacoes_um_ano_ate_dois_anos,
            :reclamacoes_seis_meses_ate_um_ano, :reclamacoes_hoje_ate_seis_meses, :percentual_reclamacoes_categoria_menos_infinito_ate_tres_anos,
            :percentual_reclamacoes_categoria_dois_anos_ate_tres_anos, :percentual_reclamacoes_categoria_um_ano_ate_dois_anos,
            :percentual_reclamacoes_categoria_seis_meses_ate_um_ano, :percentual_reclamacoes_categoria_hoje_ate_seis_meses, :slope_pedro,
            :numero_normalizado_reclamacoes_categoria, :mediana_duracao_reclamacoes, :media_duracao_reclamacoes, :skewness_duracao_reclamacoes,
            :data_primeira_reclamacao, :total_reclamacoes_resolvidas, :numero_proporcional_reclamacoes_res_hoje_ate_seis_meses,
            :numero_proporcional_reclamacoes_res_seis_meses_ate_um_ano, :numero_proporcional_reclamacoes_res_um_ano_ate_dois_anos,
            :numero_proporcional_reclamacoes_res_dois_anos_ate_tres_anos, :slope_pes, :score, :estado_id]
  Empresa.import(campos, empresas, {:validate => false})
end

def create_idades
  puts "Criando Idades"
  idades = []
  File.open(Rails.root.join("db", "idades.dat")).each do |line|
    faixa = line.to_latin_and_split[1]
    idades << Idade.new(:faixa => faixa)
  end
  Idade.import(idades, {:validate => false})
end

def create_problemas
  puts "Criando Problemas (LOL)"
  problemas = []
  File.open(Rails.root.join("db", "problemas.dat")).each do |line|
    problema_id, descricao = line.to_latin_and_split
    problemas << [problema_id, descricao]
  end
  campos = [:problema_id, :descricao]
  Problema.import(campos, problemas, {:validate => false})
end

def create_assuntos
  puts "Criando Assuntos"
  assuntos = []
  File.open(Rails.root.join("db", "assuntos.dat")).each do |line|
    assunto_id, descricao = line.to_latin_and_split
    assuntos << [assunto_id.to_i, descricao]
  end
  campos = [:assunto_id, :descricao]
  Assunto.import(campos, assuntos, {:validate => false})
end

def create_reclamacoes
  puts "Criando Reclamacoes"
  dados = []
  # empresa_id == cnpj
  campos = [:ano, :data_cadastro, :data_arquivamento, :duracao, :estado_id, :regiao_id, :empresa_id, :radical_cnpj_id,
            :categoria_id, :assunto_id, :problema_id, :sexo, :resolvido, :idade_id, :cep]
  batch_size = 15000
  File.open(Rails.root.join("db", "reclamacoes.dat")).each do |line|
    ano, data_cadastro, data_arquivamento, duracao, estado_id, regiao_id, cnpj, radical_cnpj_id, categoria_id, assunto_id, problema_id, sexo, resolvido, idade_id, cep = line.to_latin_and_split
    # Incrementa 1 na idade, pois nao foi possivel comecar com 0 o valor da chave primaria na tabela Idades, apenas com 1.
    dados << [ano, Time.at(data_cadastro.to_i).to_datetime, Time.at(data_arquivamento.to_i).to_datetime, duracao, estado_id, regiao_id, cnpj, radical_cnpj_id, categoria_id, assunto_id, problema_id, sexo, resolvido, idade_id.to_i + 1, cep]
    if dados.size >= batch_size                                                        # Evita uso excessivo de memoria
      Reclamacao.import(campos, dados, {:validate => false})
      dados =[]
    end
  end
  Reclamacao.import(campos, dados, {:validate => false})                              # Importa os registros remanecentes, caso existam
end

# Counters cache
def create_cache_counters
  puts "Criando colunas para counter cache"
  connection = ActiveRecord::Base.connection();
  connection.execute "update regioes set reclamacoes_count=(select count(*) from reclamacoes where regiao_id=regioes.id)"
  connection.execute "update empresas set reclamacoes_count=(select count(*) from reclamacoes where empresa_id=empresas.cnpj)"
  connection.execute "update categorias set reclamacoes_count=(select count(*) from reclamacoes where categoria_id=categorias.categoria_id)"
  connection.execute "update estados set reclamacoes_count=(select count(*) from reclamacoes where estado_id=estados.id)"
  connection.execute "update radical_cnpjs set reclamacoes_count=(select count(*) from reclamacoes where radical_cnpj_id=radical_cnpjs.radical_cnpj_id)"
  connection.execute "update assuntos set reclamacoes_count=(select count(*) from reclamacoes where assunto_id=assuntos.assunto_id)"
  connection.execute "update problemas set reclamacoes_count=(select count(*) from reclamacoes where problema_id=problemas.problema_id)"
  connection.execute "update idades set reclamacoes_count=(select count(*) from reclamacoes where idade_id=idades.id)"
end

require 'benchmark'

time = Benchmark.measure do
  #create_regions
  #create_states
  #create_categories
  #create_radical_cnpjs
  create_empresas
#  create_idades
#  create_problemas
#  create_assuntos
#  create_reclamacoes
#  create_cache_counters
end

puts "Tempo #{time}"

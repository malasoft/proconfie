class Reclamacao < ActiveRecord::Base

  belongs_to :estado, :counter_cache => true
  belongs_to :regiao, :counter_cache => true     # http://railscasts.com/episodes/372-bullet
  belongs_to :radical_cnpj, :counter_cache => true
  belongs_to :categoria, :counter_cache => true
  belongs_to :assunto, :counter_cache => true
  belongs_to :problema, :counter_cache => true
  belongs_to :idade, :counter_cache => true
  belongs_to :empresa, :counter_cache => true

  attr_accessible :ano, :data_cadastro, :data_arquivamento, :duracao, :estado_id, :regiao_id, :empresa_id, :radical_cnpj_id,
                  :categoria_id, :assunto_id, :problema_id, :sexo, :resolvido, :idade_id, :cep
                  
  # Retorna array de JSON para renderizar o grafico de reclamacoes por regiao, e.g.,
  # [{:label => "Nordeste", :value => 87,056}, ...]
  def self.by_regiao
    dados = []
    Regiao.all.each do |regiao|
      dados << {:label => regiao.nome, :value => regiao.reclamacoes.size}
    end
    dados.to_json
  end
  
  # Retorna array de JSON para renderizar o grafico de reclamacoes por regiao distribuida pelos anos, e.g.,
  # [{"Sudeste":50179,"Sul":3775,"ano":"2011","Norte":6406,"Nordeste":46192,"Centro-Oeste":18294}, {...
  def self.by_regioes_ano
    anos = {}
    Regiao.all(:include => [:reclamacoes]).each do |regiao|
      regioes_ano = regiao.reclamacoes.group_by {|reclamacao| reclamacao.ano}
      # {"2009":{"Sudeste":8205,"Sul":1737,"Norte":13929,"Nordeste":15539,"Centro-Oeste":10999}, "2010": ...
      regioes_ano.each do |ano, reclamacoes|
        if anos.has_key?(ano)
          item = anos[ano]
          item[regiao.nome.to_sym] = reclamacoes.size
        else
          anos[ano] = {regiao.nome.to_sym => reclamacoes.size}
        end
      end
    end
    # Coloca a key (ano) de cada um dos hashes
    dados = {}
    anos.each do |ano, contadores|
      contadores["ano"] = ano.to_s
    end
    anos.values.to_json
  end
  
  def self.by_reclamacoes
    dados = []
    empresas = {}
    Empresa.all.each do |empresa|
      empresas[empresa.nome_fantasia] = empresa.reclamacoes.size
    end
    empresas.sort_by {|nome_fantasia, reclamacoes| reclamacoes}.reverse.first(8).each do |item|
      nome_fantasia, reclamacoes = item
      dados << {:label => nome_fantasia, :value => reclamacoes}
    end
    puts dados.to_json
    dados.to_json
  end
  
end

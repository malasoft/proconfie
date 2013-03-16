# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130109222917) do

  create_table "assuntos", :primary_key => "assunto_id", :force => true do |t|
    t.text     "descricao"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "reclamacoes_count", :default => 0, :null => false
  end

  create_table "categorias", :primary_key => "categoria_id", :force => true do |t|
    t.text     "descricao"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "reclamacoes_count", :default => 0, :null => false
  end

  create_table "empresas", :id => false, :force => true do |t|
    t.string   "cnpj",                                                                           :null => false
    t.integer  "categoria_id"
    t.integer  "radical_cnpj_id"
    t.string   "razao_social"
    t.string   "nome_fantasia"
    t.integer  "reclamacoes_menos_infinito_ate_tres_anos",                      :default => 0
    t.integer  "reclamacoes_dois_anos_ate_tres_anos",                           :default => 0
    t.integer  "reclamacoes_um_ano_ate_dois_anos",                              :default => 0
    t.integer  "reclamacoes_seis_meses_ate_um_ano",                             :default => 0
    t.integer  "reclamacoes_hoje_ate_seis_meses",                               :default => 0
    t.float    "percentual_reclamacoes_categoria_menos_infinito_ate_tres_anos", :default => 0.0
    t.float    "percentual_reclamacoes_categoria_dois_anos_ate_tres_anos",      :default => 0.0
    t.float    "percentual_reclamacoes_categoria_um_ano_ate_dois_anos",         :default => 0.0
    t.float    "percentual_reclamacoes_categoria_seis_meses_ate_um_ano",        :default => 0.0
    t.float    "percentual_reclamacoes_categoria_hoje_ate_seis_meses",          :default => 0.0
    t.float    "slope_pedro",                                                   :default => 0.0
    t.float    "numero_normalizado_reclamacoes_categoria",                      :default => 0.0
    t.float    "mediana_duracao_reclamacoes",                                   :default => 0.0
    t.float    "media_duracao_reclamacoes",                                     :default => 0.0
    t.float    "skewness_duracao_reclamacoes",                                  :default => 0.0
    t.datetime "data_primeira_reclamacao"
    t.integer  "total_reclamacoes_resolvidas",                                  :default => 0
    t.float    "numero_proporcional_reclamacoes_res_hoje_ate_seis_meses",       :default => 0.0
    t.float    "numero_proporcional_reclamacoes_res_seis_meses_ate_um_ano",     :default => 0.0
    t.float    "numero_proporcional_reclamacoes_res_um_ano_ate_dois_anos",      :default => 0.0
    t.float    "numero_proporcional_reclamacoes_res_dois_anos_ate_tres_anos",   :default => 0.0
    t.float    "slope_pes",                                                     :default => 0.0
    t.float    "score",                                                         :default => 0.0
    t.integer  "estado_id"
    t.datetime "created_at",                                                                     :null => false
    t.datetime "updated_at",                                                                     :null => false
  end

  add_index "empresas", ["cnpj"], :name => "index_empresas_on_cnpj", :unique => true

  create_table "estados", :force => true do |t|
    t.string   "sigla"
    t.string   "nome"
    t.integer  "regiao_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "reclamacoes_count", :default => 0, :null => false
  end

  create_table "idades", :force => true do |t|
    t.string   "faixa"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "reclamacoes_count", :default => 0, :null => false
  end

  create_table "problemas", :primary_key => "problema_id", :force => true do |t|
    t.text     "descricao"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "reclamacoes_count", :default => 0, :null => false
  end

  create_table "radical_cnpjs", :id => false, :force => true do |t|
    t.string   "radical_cnpj_id",                  :null => false
    t.text     "descricao"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "reclamacoes_count", :default => 0, :null => false
  end

  add_index "radical_cnpjs", ["radical_cnpj_id"], :name => "index_radical_cnpjs_on_radical_cnpj_id", :unique => true

  create_table "reclamacoes", :force => true do |t|
    t.integer  "ano"
    t.datetime "data_cadastro"
    t.datetime "data_arquivamento"
    t.integer  "duracao"
    t.integer  "estado_id"
    t.integer  "regiao_id"
    t.string   "empresa_id"
    t.integer  "radical_cnpj_id"
    t.integer  "categoria_id"
    t.integer  "assunto_id"
    t.integer  "problema_id"
    t.integer  "sexo"
    t.integer  "idade_id"
    t.boolean  "resolvido"
    t.string   "cep"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "regioes", :force => true do |t|
    t.text     "nome"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "reclamacoes_count", :default => 0, :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end

class CreateEmpresas < ActiveRecord::Migration
  def change
    # Primary key in Rails to be a String: http://stackoverflow.com/a/6714889/914874
    create_table :empresas, :id => false do |t|
      t.string :cnpj, :null => false
      t.references :categoria
      t.references :radical_cnpj
      t.string :razao_social
      t.string :nome_fantasia
      
      # Pedrao
      t.integer :reclamacoes_menos_infinito_ate_tres_anos, :default => 0 # f0. # de reclamações no intervalo [-infinito, 3 anos atrás]
      t.integer :reclamacoes_dois_anos_ate_tres_anos, :default => 0      # f1. # de reclamações no intervalo [2 anos atrás, 3 anos atrás]
      t.integer :reclamacoes_um_ano_ate_dois_anos, :default => 0         # f2. # de reclamações no intervalo [1 ano atrás, 2 anos atrás]
      t.integer :reclamacoes_seis_meses_ate_um_ano, :default => 0        # f3. # de reclamações no intervalo [seis meses atrás, 1 ano atrás]
      t.integer :reclamacoes_hoje_ate_seis_meses, :default => 0          # f4. # de reclamações no intervalo [hoje, seis meses atrás]
      
      t.float :percentual_reclamacoes_categoria_menos_infinito_ate_tres_anos, :default => 0.0 # f5. percentual de reclamações por categoria no intervalo [-infinito, 3 anos atrás]
      t.float :percentual_reclamacoes_categoria_dois_anos_ate_tres_anos, :default => 0.0      # f6. percentual de reclamações por categoria no intervalo [2 anos atrás, 3 anos atrás]
      t.float :percentual_reclamacoes_categoria_um_ano_ate_dois_anos, :default => 0.0         # f7. percentual de reclamações por categoria no intervalo [1 ano atrás, 2 anos atrás]
      t.float :percentual_reclamacoes_categoria_seis_meses_ate_um_ano, :default => 0.0         # f8. percentual de reclamações por categoria no intervalo [seis meses atrás, 1 ano atrás]
      t.float :percentual_reclamacoes_categoria_hoje_ate_seis_meses, :default => 0.0           # f9. percentual de reclamações por categoria no intervalo [hoje, seis meses atrás]
      
      t.float :slope_pedro, :default => 0.0                               # f10. slope da regressão linear considerando os pontos (1,f5),(2,f6),(1,f7),(3,2*f8),(4,2*f9)

      # Pes
      t.float :numero_normalizado_reclamacoes_categoria, :default => 0.0  # f11. normalizado de reclamacoes de uma empresa na sua categoria 
      
      t.float :mediana_duracao_reclamacoes, :default => 0.0               # f12. mediana duracao de reclamacoes
      t.float :media_duracao_reclamacoes, :default => 0.0                 # f13. media da duracao de reclamacoes
      t.float :skewness_duracao_reclamacoes, :default => 0.0              # f14. skewness da duracao de reclamacoes

      t.datetime :data_primeira_reclamacao                                # f15. data da primeira reclamacao
      t.integer :total_reclamacoes_resolvidas, :default => 0              # f16. # total de reclamacoes resolvidas

      t.float :numero_proporcional_reclamacoes_res_hoje_ate_seis_meses, :default => 0.0     # f17. # proporcional de reclamacoes resolvidas em relacao ao total de reclamacoes no intervalo [hoje, seis meses atrás]
      t.float :numero_proporcional_reclamacoes_res_seis_meses_ate_um_ano, :default => 0.0   # f18. # proporcional de reclamacoes resolvidas em relacao ao total de reclamacoes no intervalo [seis meses atrás, 1 ano atrás]
      t.float :numero_proporcional_reclamacoes_res_um_ano_ate_dois_anos, :default => 0.0    # f19. # proporcional de reclamacoes resolvidas em relacao ao total de reclamacoes no intervalo [1 ano atrás, 2 anos atrás]
      t.float :numero_proporcional_reclamacoes_res_dois_anos_ate_tres_anos, :default => 0.0 # f20. # proporcional de reclamacoes resolvidas em relacao ao total de reclamacoes no intervalo [2 anos atrás, 3 anos atrás]
      t.float :slope_pes, :default => 0.0                                                   # f21. slope da regressão linear considerando os pontos (1,f17),(2,f18),(3,f19),(4,f20)
      
      # Modelo inicial
      
      t.float :score, :default => 0.0                                                       # score = f9 * f17 * 2^(média(f10,f21))
      t.references :estado

      t.timestamps
    end
    add_index :empresas, :cnpj, :unique => true
  end
end

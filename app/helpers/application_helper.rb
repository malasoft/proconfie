#!/bin/env ruby
# encoding: utf-8

module ApplicationHelper
  def select_current_estado
    logger.info "SELECT TAGGGGGGGGGGgg = #{sigla_session.sigla}"
    select_tag(:estado, options_for_select(Estado.all.map { |estado| [estado.nome, estado.sigla, {"data-imagesrc" => asset_path("bandeiras/#{estado.sigla}.png"), "data-description" => "Dados de #{estado.nome}"}]}, sigla_session.sigla))
  end
  
  def risco(score, empresa=true)
    if empresa
      if (0..2).include?(score)
        "baixo"
      elsif (3..6).include?(score)
        "medio"
      elsif (7..8).include?(score)
        "alto"
      else
        "altissimo"
      end
    else # categorias
      if (0..8).include?(score)
        "baixo"
      elsif (9..66).include?(score)
        "medio"
      elsif (67..414).include?(score)
        "alto"
      else
        "altissimo"
      end
    end
  end
  
  def risco_header(score, empresa=true)
    risco = risco(score, empresa)
    if risco == "medio"
      "médio"
    elsif risco == "altissimo"
      "altíssimo"
    else
      risco
    end
  end
  
  def ranking(empresa)
    if empresa.ranking(sigla_session.estado) == 1
      ""
    else
      "#{empresa.ranking(sigla_session.estado)}<sup><u>a</u></sup>".html_safe
    end
  end
end

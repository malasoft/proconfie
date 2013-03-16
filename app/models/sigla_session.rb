class SiglaSession

  attr_accessor :estado

  def initialize(session)
    @session = session
  end
  
  def has_different_sigla?(sigla)
    sigla and @session[:sigla] != sigla
  end
  
  def has_not_sigla?
    not @session.has_key?(:sigla)
  end
  
  def sigla
    @session[:sigla]
  end
  
  def sigla=(val)
    @session[:sigla] = val
  end
  
end

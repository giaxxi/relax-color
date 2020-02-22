module Relax::String
  def is_numeric?
    true if Float(self) rescue false
  end
end

String.include Relax::String

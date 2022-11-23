module ApplicationHelper
  include Pagy::Frontend
  def prefix(ind)
    "DTSZN_#{ind}"
  end
end

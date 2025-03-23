module ApplicationHelper
  def user_in_current_council?
    current_user&.in? [
      "cschuijt", "avaliull", "llourens", "oriabenk", "amel-fou",
      "mshulgin", "kiwong", "aleseile", "mde-beer", "mnijsen", "roversch"
    ]
  end
end

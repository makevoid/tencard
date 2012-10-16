module AppHelpers
  def euro(value)
    "#{"%.2f" % value.to_f} &euro;"
  end

  def main_route
    request.path.split("/")[1]
  end
end
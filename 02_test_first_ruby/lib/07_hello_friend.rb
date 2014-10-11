class Friend
  def greeting(who = nil)
  	return who == nil ? "Hello!" : "Hello, #{who}!"
  end
end

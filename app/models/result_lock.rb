class ResultLock < Result
  # attr_accessible :title, :body

  def execute_result (client)
      client.lock = true
      client.save
    end
end

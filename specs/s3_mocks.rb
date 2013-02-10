class AWS::S3::S3Object
  cattr_accessor :store_call_args

  def self.store(*args)
    self.store_call_args = args
  end
end

class AWS::S3::Base
  cattr_accessor :establish_connection_call_args

  def self.establish_connection!(*args)
    self.establish_connection_call_args = args
  end
end

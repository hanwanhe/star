local Base = {}

function Base:construct()
  ngx.say('i am base constr'..self.request.ngx_var.uri)
end



return Base
local objects_2 = {}

Object = {objectProperty = "my object"}

function Object.test(self, propertyChanger)
  return self.objectProperty .. " " .. propertyChanger
end

function objects_2.test()
  print(Object.test(Object, "added this text"))
end
  
return objects_2
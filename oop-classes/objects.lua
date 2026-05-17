local objects = {}

-- https://www.lua.org/pil/16.html
-- tables as objects
Account = {balance = 0}

function Account.withdraw(self, v)
  
  self.balance = self.balance - v
  print("self.balance withdraw : " .. self.balance)
end

function Account:deposit(v) -- : allows to hide the self parameter in parenthesis
  self.balance = self.balance + v
  print("self.balance deposit : " .. self.balance)
end

a1 = Account

a2 = Account


-- new object test
MyObject = {test = 0}

function MyObject.analyse(self)
  self.test = self.test + 10
  print("self.test : " .. self.test)
end

testobj = MyObject

function objects.load()
  a1.withdraw(a1, 100.0) -- needs to add the table itself as the self param

  a1:withdraw(100.0) -- same as a1.withdraw(a1, 100.0) / semi colon let us hide the self table
  
  a2:withdraw(100.0)

  a1.deposit(Account, 100.0)
  
  testobj.analyse(testobj)
  testobj:analyse()

end





return objects
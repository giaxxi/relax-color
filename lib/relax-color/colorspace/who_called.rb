p ('a'..'z').to_a.rotate(10).zip(1..).to_h.invert
p [6,8,21,10,5,2,17,4,25].map { |n| (('a'..'z').to_a.rotate(10).zip(1..).to_h.invert)[n] }.join.capitalize


p (10...36).map{ |i| i.to_s(36)}



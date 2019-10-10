dice.select { |n| n == 1 }.length >= 4
dice - dice.select { |n| n == 1 }
 => [2] 
[1, 2, 1, 4].group_by(&:itself)
 => {1=>[1, 1], 2=>[2], 4=>[4]} 
2.6.3 :011 > [1, 2, 1, 4].group_by { |n| n }
 => {1=>[1, 1], 2=>[2], 4=>[4]} 
2.6.3 :012 > [1, 2, 1, 4].group_by(&:itself).select { |num, quantity| quantity.size > 3 }
 => {} 
2.6.3 :013 > [1, 2, 1, 4].group_by(&:itself).detect { |num, quantity| quantity.size > 3 }
 => nil 

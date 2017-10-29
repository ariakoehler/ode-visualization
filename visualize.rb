require './solver.rb'

lotka_volterra = proc {|x, y| [2*x-3*x*y, 1.5*x*y-2.5*y]}

puts lotka_volterra.call([5, 6])

sim = ODESimulator.new(p)

puts sim.points.inspect

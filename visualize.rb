require './solver.rb'

lotka_volterra = proc {|x, y| [2*x-3*x*y, 1.5*x*y-2.5*y]}

sim = ODESimulator.new(lotka_volterra)

h=0.05
sim.simulate(h)

# puts sim.points.inspect

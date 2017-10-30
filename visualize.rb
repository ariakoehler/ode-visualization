require './solver.rb'

lotka_volterra = proc {|x, y| [(2/3)*x-(4/3)*x*y, x*y-y]}


sim = ODESimulator.new(lotka_volterra, step_size=0.5, num_points=100)

h=0.5
sim.simulate(h)

# puts sim.points.inspect

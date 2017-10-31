require './solver.rb'

lotka_volterra = proc {|x, y| [x-x*y, x*y-y]}


sim = ODESimulator.new(lotka_volterra, step_size: 0.01, num_points: 100, x_lims: (0..5), y_lims: (0..5))

h=0.5
sim.simulate(h)

# puts sim.points.inspect

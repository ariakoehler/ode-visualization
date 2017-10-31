# require 'gnuplot'
require 'gnuplotrb'
require './array-math'
include GnuplotRB

class ODESimulator

  #==========================
  #INITIALIZERS AND ACCESSORS
  #==========================

  attr_accessor :points 	#access list of points
  attr_accessor :step_size 	#accessor for t stepsize

  def initialize (update_fn, step_size: 0.01,
                  x_lims: (-5.0..5.0), y_lims: (-5.0..5.0), t_lims: (0..1),
                  num_points: 20)
    @update_fn = update_fn	#set update functions
    @x_lims = x_lims 		#set bounds
    @y_lims = y_lims 		
    @t_lims = t_lims
    @num_points = num_points	#set number of points
    @step_size = step_size	#set step size
    @time_plots = []
    generate 			#generate
    
  end

  #==========
  #SIMULATING
  #==========

  #initialize num_points-many doubles to random values within x&y bounds
  def generate
    #create random number generator
    rng = Random.new
    @points = Array.new

    #num_points times, make random value in ranges 
    @num_points.times do
      @points << [rng.rand(@x_lims), rng.rand(@y_lims)]
    end
  end

  
  #returns rk4 weighted sum for updating
  def rk4_weight (h)
    weighted_sum = Array.new
    @points.each do |point|
      #terms in RK4 summation
      # puts point.inspect
      k0 = @update_fn.call(*point)
      k1 = @update_fn.call(point[0] + k0[0]/2.0, point[1] + h/2.0)
      k2 = @update_fn.call(point[0] + k1[0]/2.0, point[1] + h/2.0)
      k3 = @update_fn.call(point[0] + k2[0], point[1] + h)
      weighted_sum << [(k0[0] + 2*k1[0] + 2*k2[0] + k3[0])/6.0, (k0[1] + 2*k1[1] + 2*k2[1] + k3[1])/6.0]
    end
    # puts "\n\n"
    return weighted_sum
  end

  
  def update (h)
    #sets all points according to rk4 update function
    @points = @points.add(rk4_weight(h))
  end

  
  def animate
    # plot all x and y points
    trajectories = Animation.new(*@time_plots, xrange: @x_lims , yrange: @y_lims)
    trajectories.plot({term: 'gif', output: 'ode_animation.gif'})
  end

  def make_plot (step)
    points_ds = Dataset.new([@points.vert(0), @points.vert(1)], title: 'time = ' + step.round(3).to_s)
    state_plot = Plot.new(points_ds, xrange: @x_lims , yrange: @y_lims)
    # state_plot.plot
    @time_plots << state_plot
    # state_plot.show
    # state_plot.to_png
  end

  
  def simulate (h=0.05)
    make_plot(0)
    #for each t-steps
    @t_lims.step(@step_size) do |step|
      # update all the points
      update(h)
      # add plots to the animation
      make_plot(step)
    end
    animate
  end

end

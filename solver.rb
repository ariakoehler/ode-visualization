# require 'gnuplot'
require 'plotly'
require './array-math'

class ODESimulator

  #==========================
  #INITIALIZERS AND ACCESSORS
  #==========================

  attr_accessor :points 	#access list of points
  attr_accessor :step_size 	#accessor for t stepsize

  def initialize (update_fn, step_size=0.01,
                  x_lims=(-5.0..5.0), y_lims=(-5.0..5.0), t_lims=(0..1),
                  num_points=20)
    @update_fn = update_fn	#set update functions
    @x_lims = x_lims 		#set bounds
    @y_lims = y_lims 		
    @t_lims = t_lims
    @num_points = num_points	#set number of points
    @step_size = step_size	#set step size
    generate() 			#generate
  end

  #==========
  #SIMULATING
  #==========

  #initialize num_points-many doubles to random values within x&y bounds
  def generate ()
    #create random number generator
    rng = Random.new
    @points = Array.new

    #num_points times, set to random values
    @num_points.times do
      @points << [rng.rand(@x_lims), rng.rand(@y_lims)]
    end
  end

  
  #returns rk4 weighted sum for updating
  def rk4_weight (h)
    weighted_sum = Array.new
    @points.each do |point|
      #terms in RK4 summation
      k0 = @update_fn.call(*point)
      puts k0.inspect
      k1 = @update_fn.call(point[0] + k0[0]/2.0, point[1] + h/2.0)
      puts k1.inspect      
      k2 = @update_fn.call(point[0] + k1[0]/2.0, point[1] + h/2.0)
      puts k2.inspect      
      k3 = @update_fn.call(point[0] + k2[0], point[1] + h)
      puts k3.inspect      
      weighted_sum << [(k0[0] + 2*k1[0] + 2*k2[0] + k3[0])/6.0, (k0[1] + 2*k1[1] + 2*k2[1] + k3[1])/6.0]
    end
    return weighted_sum
  end

  
  def update (h)
    #sets all points according to rk4 update function
    points_prev = @points
    @points = @points.add(rk4_weight(h))
  end

  
  def plot ()
    #plot all x and y points
  end

  
  def simulate (h=0.05)
    #for each t-steps
    @t_lims.step(@step_size) do |step|
      #update then plot
      # print "\n\n\nStep at time %.2f : \n" % step.to_s.ljust(4, "0")
      # @points.each { |p| puts p.inspect;}
      update(h)
      # plot (maybe only do this 10 times during full run;
      # not sure of limitations of Plotly API)
    end
  end

end

require 'gnuplot'
require 'plotly'
require './array-math'

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
    points_prev = @points
    @points = @points.add(rk4_weight(h))
    # puts points_prev.inspect
    # puts @points.inspect
  end

  
  def plot (step)
    # plot all x and y points


    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|
        
        plot.xrange "[%.2f:%.2f]" % [@x_lims.min, @x_lims.max]
        plot.yrange "[%.2f:%.2f]" % [@y_lims.min, @y_lims.max]
   
        plot.title "Points at time %.4f" % step
        plot.xlabel "x"
        plot.ylabel "y"

        x = @points.vert(0)
        y = @points.vert(1)

        plot.data << Gnuplot::DataSet.new( [x,y] ) do |ds|
          ds.notitle
        end
      end
    end
  end

  
  def simulate (h=0.05)
    plot(0)
    #for each t-steps
    @t_lims.step(@step_size) do |step|
      #update all the points
      update(h)
      # plot (maybe only do this 10 times during full run)
      plot(step)
    end
  end

end

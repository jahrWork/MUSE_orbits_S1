

from numpy import arange, sin, pi
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider, Button, RadioButtons



def build_gui(): 

  def update_A(val):
    A = val
    f = S_f.val
    t, s = graph(A, f)
    l.set_ydata( s )
    fig.canvas.draw_idle()

  def update_f(val):
    f = val
    A = S_A.val
    t, s = graph(A, f)
    l.set_ydata( s )
    fig.canvas.draw_idle()

  def reset(event):
    S_f.reset()
    S_A.reset()

  def color(label):
    l.set_color(label)
    fig.canvas.draw_idle()

  def graph(A, f): 

    t = arange(0.0, 1.0, 0.001)
    s = A * sin( 2*pi*f*t )
    return t, s 

  fig, ax = plt.subplots()
  plt.subplots_adjust(left=0.25, bottom=0.25)
  A0 = 5;  f0 = 3
   
  t, s = graph(A0, f0)
  l, = plt.plot(t, s, lw=2, color='red')
  plt.axis([0, 1, -10, 10])

  axcolor = "yellow"
  axes_f = plt.axes([0.25, 0.1, 0.65, 0.03], facecolor=axcolor)
  axes_A = plt.axes([0.25, 0.15, 0.65, 0.03], facecolor=axcolor)

  S_f = Slider(axes_f, 'Freq', 0.1, 30.0, valinit = f0) 
  S_f.on_changed(update_f)

  S_A = Slider(axes_A, 'Amp', 0.1, 10.0, valinit = A0)
  S_A.on_changed(update_A)

  axes_reset = plt.axes([0.8, 0.025, 0.1, 0.04])
  B_reset = Button(axes_reset, 'Reset', color=axcolor, hovercolor='0.975')
  B_reset.on_clicked(reset)

  axes_color = plt.axes([0.025, 0.5, 0.15, 0.15], facecolor=axcolor)
  R_color = RadioButtons(axes_color, ('red', 'blue', 'green'), active=0)
  R_color.on_clicked(color)

  plt.show()

  

if __name__ == "__main__":
      
      build_gui()
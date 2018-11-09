/// @description Move


x+=(right-left)*5
y+=(down-up)*5

real_x+=(right-left)*5
real_y+=(down-up)*5


//jump when we are really off
if point_distance(x,y,real_x,real_y)>30{
	x=real_x
	y=real_y
}

x+=(real_x-x)/5
y+=(real_y-y)/5


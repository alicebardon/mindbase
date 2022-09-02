# Solve the quadratic equation ax**2 + bx + c = 0

#$ import complex math module
import cmath
#$$
a = 1
b = 5 # I do NOT want to see this comment on Mindbase
c = 6

# calculate the discriminant
d = (b**2) - (4*a*c)

# find two solutions
sol1 = (-b-cmath.sqrt(d))/(2*a) #$ a simple math operation $$
sol2 = (-b+cmath.sqrt(d))/(2*a)

#$ printing to the console
print('The solution are {0} and {1}'.format(sol1,sol2))
#$$

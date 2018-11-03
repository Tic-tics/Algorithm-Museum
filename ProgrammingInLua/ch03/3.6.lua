function coneVolumeRad(height, radius)
	return math.pi * math.pow(radius, 2) * height * (1/3)
end

function getRadius(height, angle)
	return height * math.tan(angle)
end

function degToRad(degrees)
	return degrees * math.pi / 180
end

function coneVolume(height, angle)
	return coneVolumeRad(height, getRadius(height, degToRad(angle)))
end

print("What is your cone's height?")
h = io.read("*n")
print("What is your cone's angle?")
r = io.read("*n")

print(coneVolume(h,r))

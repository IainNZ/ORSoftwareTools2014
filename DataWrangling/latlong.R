lat.long.dist = function(x) {
  return(gdist(x["lng.x"], x["lat.x"], x["lng.y"], x["lat.y"], units="km"))
}

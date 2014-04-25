get.top.2 = function(wdays) {
  tab = sort(table(wdays), decreasing=TRUE)
  return(as.numeric(names(tab[1:2])))
}

get.top.2.df = function(dat) {
  tab = sort(table(dat$start_date$wday), decreasing=TRUE)
  top2 = as.numeric(names(tab[1:2]))
  return(data.frame(start_station=dat$start_station[1], day1=top2[1],
                    day2=top2[2]))
}



nsegments<-39
autismCapacity<-50
nrings<-7
displayExponent<-2.5
totalCapacity<-nsegments*qnorm(0.5+autismCapacity/100/2)
autismExponent<-0.65

radius<-4

character<-abs(rnorm(nsegments))
character<-(character/radius)^(1-autismExponent)
character[character>1]<-1

hues<-mod(((1:nsegments)-1)/(nsegments-1),1)

g<-startPlot(xlim=c(-1,1)*radius,ylim=c(-1,1)*radius)
for (i in 1:nsegments) {
  arc<-i/nsegments*2*pi+seq(0,2*pi/nsegments,length.out=360/nsegments)
  for (ring in seq(0,1,length.out=nrings)) {
    if (ring<1) {
    x<-c(cos(arc)*(ring+1/(nrings-1)),rev(cos(arc))*ring)
    y<-c(sin(arc)*(ring+1/(nrings-1)),rev(sin(arc))*ring)
    g<-addG(g,dataPolygon(data.frame(x=x*radius,y=y*radius),
                          fill=hsv(hues[i],ring^displayExponent,0.75+ring*0.25),
                          colour="none"))
    }
  }
}

arc<-seq(0,2*pi,length.out=nsegments+1)[1:nsegments]

x<-y<-xp<-yp<-c()
for (i in 1:nsegments) {
  arc<-(i-1)/nsegments*2*pi+seq(0,2*pi/nsegments,length.out=360/nsegments)
  x<-c(x,cos(arc)*character[i])
  y<-c(y,sin(arc)*character[i])
  xp<-c(xp,mean(cos(arc)*character[i]))
  yp<-c(yp,mean(sin(arc)*character[i]))
}
profile<-data.frame(x=x*radius,y=y*radius)
points<-data.frame(x=xp*radius,y=yp*radius)
g<-addG(g,dataPolygon(profile,colour="black",fill=NA))

requiredCapacity<-sum(character)
capacity<-character*0+totalCapacity/nsegments
capacity[capacity>1]<-1
for (i in 1:nsegments) {
  arc<-(i-1)/nsegments*2*pi+seq(0,2*pi/nsegments,length.out=360/nsegments)
  x<-c(cos(arc)*capacity[i], cos(rev(arc))*character[i])
  y<-c(sin(arc)*capacity[i], sin(rev(arc))*character[i])

  if (character[i]>totalCapacity/nsegments) col<-"red"
  else                                      col<-"green"
  g<-addG(g,dataPolygon(data.frame(x=x*radius,y=y*radius),
                        colour=NA,fill=col,alpha=1))
}

fill<-hsv(hues,0,1)
colour<-hsv(hues,0,0.75-(character^displayExponent*0.75))
g<-addG(g,dataPoint(points,
                    size=5*character,
                    fill=fill,colour=colour,alpha=0.75+character*0.25))

print(g)

# h1<-cumsum(hist(character,breaks=seq(0,1,length.out=7),plot=FALSE)$counts)
# g<-dataGraph(data.frame(x=seq(0,1,length.out=6),y=h1/nsegments),
#              xlabel="ASD score",ylabel="cumulative",ylim=c(0,1.05))
# 
# print(g)

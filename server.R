
source('basicPlot.R')
source('brawOpts.R')
library('ggplot2')

server <- function(input, output) {
  
  observeEvent({c(input$New,input$autismExponent,input$autismSensitivity,input$autismCapacity,
                  input$autismBias,input$autismBiasGroups,input$autismBiasCost,
                  input$nsegments
                  )}, 
    {
      
      if (exists("braw.env")) {
        oldVals<-braw.env$oldVals
        changed<-all(c(
          input$autismCapacity==oldVals$autismCapacity,
          input$autismBias==oldVals$autismBias,
          input$autismBiasGroups==oldVals$autismBiasGroups,
          input$autismBiasCost==oldVals$autismBiasCost
        )
        )
      } else changed<-TRUE
      BrawOpts()

      useHTML<-TRUE
      radius<-4
      fullRadius<-4.75
      showpoints<-FALSE
      showG1<-FALSE
      
      # nsegments<-input$nsegments
      nsegments<-39
      groups<-c(7,3,4,3,4,3,4,3,4,4)
      labels<-c('basic\nsocial communication','affiliation','perspective taking','peer relations',
                'repetitive behaviour','sensory interests','insistance\non sameness','sensory\nsensitivities',
                'restricted interests','other')
      autismCapacity<-input$autismCapacity/100
      autismExponent<-input$autismExponent
      autismSD<-1
      autismBias<-input$autismBias
      autismBiasGroups<-input$autismBiasGroups
      autismBiasCost<-input$autismBiasCost*10
      autismSensitivity<-input$autismSensitivity
      nrings<-7
      displayExponent<-2.5
      totalCapacity<-nsegments*autismCapacity

      localCorr<-0.95
      if (changed) {
        character<-c()
        for (i in 1:length(groups)) {
          nextGroup<-rnorm(1)*localCorr+rnorm(groups[i])*sqrt(1-localCorr^2)
          character<-c(character,nextGroup)
        }
        character<-abs(character)*autismSD/radius
        # character<-abs(rbeta(nsegments,1,10-autismSD))
        character<-character^(1-autismExponent)
        character[character>1]<-1
      } else 
        character<-oldVals$character
      
      hues<-c()
      for (i in 1:length(groups)) {
        nextHue<-(i-0.5)/(length(groups)+0.5)+seq(-1,1,length.out=groups[i])*0.01
        # nextHue<-sum(groups[1:i])-groups[i]/2+seq(-1,1,length.out=groups[i])*0.01
        hues<-c(hues,nextHue)
      }

        if (useHTML) setBrawEnv("graphicsType","HTML")
        else         setBrawEnv("graphicsType","ggplot")
        setBrawEnv("graphBack","#DDDDDD")
        setBrawEnv('plotSize',c(1,1)*525)
        
      g<-startPlot(xlim=c(-1,1)*fullRadius,ylim=c(-1,1)*fullRadius,box="none",backC="white")
      for (i in 1:nsegments) {
        arc<-(i-1)/nsegments*2*pi+seq(0,2*pi/nsegments,length.out=360/nsegments)
        for (ring in seq(0,1,length.out=nrings)) {
          if (ring==1) width<-0.5 else width<-1
            x<-c(sin(arc)*(ring+width/(nrings-1)),rev(sin(arc))*ring)
            y<-c(cos(arc)*(ring+width/(nrings-1)),rev(cos(arc))*ring)
            g<-addG(g,dataPolygon(data.frame(x=x*radius,y=y*radius),
                                  fill=hsv(hues[i],ring^displayExponent,0.75+ring*0.25),
                                  colour="white"))
        }
      }
      for (i in 1:length(groups)) {
        x<-c(0,sin(sum(groups[1:i])/nsegments*2*pi))*(radius+0.5)
        y<-c(0,cos(sum(groups[1:i])/nsegments*2*pi))*(radius+0.5)
        g<-addG(g,dataLine(data.frame(x=x,y=y),colour="black"))
        
        a<-(sum(groups[1:i])-groups[i]/2)/nsegments*2*pi
        x<-sin(a)*radius*1.1
        y<-cos(a)*radius*1.1
        g<-addG(g,dataText(data.frame(x=x,y=y),label=labels[i],colour="black",
                           hjust=0.5,angle=pi/2-a*57.296,size=0.9))
      }
      
      
      arc<-seq(0,2*pi,length.out=nsegments+1)[1:nsegments]
      x<-y<-xp<-yp<-c()
      for (i in 1:nsegments) {
        arc<-(i-1)/nsegments*2*pi+seq(0,2*pi/nsegments,length.out=360/nsegments)
        x<-c(x,sin(arc)*character[i])
        y<-c(y,cos(arc)*character[i])
        xp<-c(xp,mean(sin(arc)*character[i]))
        yp<-c(yp,mean(cos(arc)*character[i]))
      }
      profile<-data.frame(x=x*radius,y=y*radius)
      points<-data.frame(x=xp*radius,y=yp*radius)
      g<-addG(g,dataPolygon(profile,colour="black",fill="#00FF00",alpha=0.5))
      
      requiredCapacity<-sum(character)
      if (totalCapacity>requiredCapacity) capacity<-character
      else {
        z<-unique(sort(character))
        za<-z*0
        for (j in 1:length(z)) 
          za[j]<-sum(character>=z[j])*z[j]+sum(character[character<z[j]])
        if (sum(!is.na(za))<2) capacityLimit<-totalCapacity/nsegments
        else capacityLimit<-approx(za,z,totalCapacity)$y
        if (is.na(capacityLimit)) capacityLimit<-totalCapacity/nsegments
        capacity<-character
        capacity[capacity>capacityLimit]<-capacityLimit
        
        if (autismBias>0) {
          missing<-character-capacity
          groupMissingCapacity<-c()
          for (i in 1:length(groups)) {
            index<-sum(groups[1:i])+1-(1:groups[i])
            groupMissingCapacity<-c(groupMissingCapacity,
                                    sum(missing[index]))
          }
          index<-c()
          for (j in 1:autismBiasGroups) {
          use<-which.max(groupMissingCapacity)
          index<-c(index,sum(groups[1:use])+1-(1:groups[use]))
          groupMissingCapacity[use]<-0
          }
          capacity[index]<-capacity[index]+missing[index]*autismBias
          gained<-sum(missing[index]*autismBias)
          index<-setdiff(1:nsegments,index)
          lost<-gained*autismBiasCost/sum(capacity[index])
          capacity[index]<-capacity[index]*(1-min(lost,1))
        }
        # capacity<-character*totalCapacity/requiredCapacity
      }
      # capacity[capacity>1]<-1
      for (i in 1:nsegments) {
        if (character[i]>capacity[i]) {
          arc<-(i-1)/nsegments*2*pi+seq(0,2*pi/nsegments,length.out=360/nsegments)
          x<-c(sin(arc)*capacity[i], sin(rev(arc))*character[i])
          y<-c(cos(arc)*capacity[i], cos(rev(arc))*character[i])
          g<-addG(g,dataPolygon(data.frame(x=x*radius,y=y*radius),
                                colour="none",fill="red",alpha=0.8))
        } 
      }
      
      if (showpoints) {
      fill<-hsv(hues,0,1)
      colour<-hsv(hues,0,0.75-(character^displayExponent*0.75))
      g<-addG(g,dataPoint(points,
                          size=5*character,
                          fill=fill,colour=colour,alpha=0.75+character*0.25))
      }
      
      # second figure
      
      z<-cumsum(character)

      setBrawEnv('plotSize',c(450,300))
      g1<-startPlot(xlim=c(0,nsegments+1),ylim=c(0,40),box="both",
                    xlabel="item",xticks=list(logScale=FALSE),ylabel="cumulative demand",yticks=list(logScale=FALSE))
      
      x<-1:nsegments
      g1<-addG(g1,dataPath(data.frame(x=x,y=z)))
      use<-z<totalCapacity
      g1<-addG(g1,dataPoint(data.frame(x=x[use],y=z[use]),fill="#00FF00"))
      g1<-addG(g1,dataPoint(data.frame(x=x[!use],y=z[!use]),fill="#FF0000"))
      if (useHTML) {
        output$spectrumHTML <- renderUI(HTML(g))
        if (showG1)
          output$autismHTML <- renderUI(HTML(g1))
      } else {
        output$spectrumPlot <- renderPlot({g})
        if (showG1)
        output$autismPlot <- renderPlot({g1})
      }
      
      oldVals<-list(autismCapacity=input$autismCapacity,
                    autismBias=input$autismBias,
                    autismBiasGroups=input$autismBiasGroups,
                    autismBiasCost==input$autismBiasCost,
                    character=character)
      setBrawEnv("oldVals",oldVals)
    })
  
}
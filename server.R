
source('basicPlot.R')
source('brawOpts.R')
library('ggplot2')
library('pracma')

server <- function(input, output) {
  
  
  
  observeEvent({c(input$New,input$autismExponent,input$autismSensitivity,input$generalCapacity,
                  input$autismBias,input$autismBiasGroups,input$autismBiasCost,
                  input$display
                  )}, 
    {
      
      # are we running for the first time?
      # if not, retrieve some useful variables from the last simulation
      if (exists("braw.env")) {
        oldVals<-braw.env$oldVals
        # see whether we need a new person, or are we just changing the
        # circumstances around the person
        changed<-all(c(
          input$generalCapacity==oldVals$generalCapacity,
          input$autismBias==oldVals$autismBias,
          input$autismBiasGroups==oldVals$autismBiasGroups,
          input$autismBiasCost==oldVals$autismBiasCost,
          input$display==oldVals$display
        )
        )
      } else changed<-TRUE

      # basic diagram structure
      BrawOpts()
      
      useHTML<-TRUE
      radius<-4
      fullRadius<-4.75
      showpoints<-FALSE
      doSecondFigure<-FALSE
      # OK<-"#00FF00"
      # notOK<-"#FF0000"      
      OK<-"#FFF"
      notOK<-"#000"      
      
      # ASDQ structure
      nsegments<-39
      groups<-c(7,3,4,3,4,3,4,3,4,4)
      betterSequence<-c(2,4,1,3,8,7,9,6,5,10) # see pathModel.R
      corrsSequence<-c(0.00,0.62,0.73,0.73,0.34,0.63,0.61,0.62,0.71,0)

      # colours for circle
      nrings<-7
      displayExponent<-2.5
      # hh<-sort(rgb2hsv(col2rgb(hcl.colors(1000)))[1,])
      groupHues<-rep(0,length(groups))
      nextHue<-0
      for (i in 1:length(groups)) {
        use<-which(betterSequence==i)
        nextHue<-nextHue+(1-pnorm(corrsSequence[i],0.5,0.2))
        groupHues[betterSequence[i]]<-nextHue
      }
      groupHues<-(groupHues-min(groupHues))/(max(groupHues)-min(groupHues))
      # groupHues<-hh[floor(groupHues*999)+1]
      hues<-c()
      for (i in 1:length(groups)) {
        huesAdd<-groupHues[i]+seq(-1,1,length.out=groups[i])*0.0
        hues<-c(hues,huesAdd)
      }
      hues<-hues-min(hues)
      hues<-hues/max(hues[1:35])*0.7
      hues<-hues^1.2
      
      # get the basic simulation parameters from the ui
      generalCapacity<-input$generalCapacity/100
      autismExponent<-input$autismExponent
      generalSensitivity<-1 # not used
      autismBias<-input$autismBias
      autismBiasGroups<-input$autismBiasGroups
      autismBiasCost<-input$autismBiasCost*10
      autismSensitivity<-input$autismSensitivity
      totalCapacity<-nsegments*generalCapacity
      
      # make the 39 ASDQ scores
      # this uses the observed correlations
      localCorr<-0.95
      if (changed) {
        v<-0
        group_v<-rep(0,10)
        for (i in 1:length(groups)) {
          group_v[betterSequence[i]]<-v*corrsSequence[i]+rnorm(1)*sqrt(1-corrsSequence[i]^2)
          v<-group_v[betterSequence[i]]
        }
        character<-c()
        for (i in 1:length(groups)) {
          nextv<-group_v[i]
          nextGroup<-nextv*localCorr+rnorm(groups[i])*sqrt(1-localCorr^2)
          character<-c(character,nextGroup)
        }
        character<-abs(character)*generalSensitivity/radius
        # character<-abs(rbeta(nsegments,1,10-generalSensitivity))
        character<-character^(1-autismExponent)
        character[character>1]<-1
      } else 
        character<-oldVals$character
      
      # update the local store of values
      oldVals<-list(generalCapacity=input$generalCapacity,
                    autismBias=input$autismBias,
                    autismBiasGroups=input$autismBiasGroups,
                    autismBiasCost=input$autismBiasCost,
                    display=input$display,
                    character=character)
      setBrawEnv("oldVals",oldVals)
      
      # are we using the original sequence of ASDQ
      # or the better one, including more positive labels
      switch (input$display,
              "original"={
                labels<-c('basic\nsocial communication','affiliation','perspective taking','peer relations',
                          'repetitive behaviour','sensory interests','insistance\non sameness','sensory\nsensitivities',
                          'restricted interests','other')
                useGroups<-1:10 
              },
              "positive"={
                labels<-c('people\nsensitivity','affiliation','perspective taking','peer relations',
                          'repetitive\nbehaviour','sensory\ninterests','preference\nfor predictability','sensory\nsensitivity',
                          'specialized\ninterests','other')
                useGroups<-betterSequence
              },
              {}
      )

      # resequence the sectors of the diagram
      useCharacter<-c()
      for (i in useGroups) {
        if (i==1) addC<-1:groups[i]
        else      addC<-sum(groups[1:(i-1)])+(1:groups[i])
        useCharacter<-c(useCharacter,addC)
      }
      character<-character[useCharacter]
      hues<-hues[useCharacter]
      groups<-groups[useGroups]
      labels<-labels[useGroups]
      
      # set up the graohics system
      if (useHTML) setBrawEnv("graphicsType","HTML")
      else         setBrawEnv("graphicsType","ggplot")
      setBrawEnv("graphBack","#DDDDDD")
      setBrawEnv('plotSize',c(1,1)*525)
      g<-startPlot(xlim=c(-1,1)*fullRadius,ylim=c(-1,1)*fullRadius,box="none",backC="white")
      
      # draw the circle
      for (i in 1:nsegments) {
        arc<-(i-1)/nsegments*2*pi+seq(0,2*pi/nsegments,length.out=360/nsegments)
        for (ring in seq(0,1,length.out=nrings)) {
          if (ring==1) width<-0.5 else width<-1
            x<-c(sin(arc)*(ring+width/(nrings-1)),rev(sin(arc))*ring)
            y<-c(cos(arc)*(ring+width/(nrings-1)),rev(cos(arc))*ring)
            if (i<36)  fill<-hsv(hues[i],ring^displayExponent,0.75+ring*0.25)
            else fill<-hsv(0,0,(0.85-ring*0.75)^(1/displayExponent))
            g<-addG(g,dataPolygon(data.frame(x=x*radius,y=y*radius),
                                  fill=fill,colour="white"))
        }
      }
      # add radiating lines between groups of the ASDQ
      # and the labels for each group
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
      # basic circle done
      
      # now we draw in the person
      # we use the fill colour specified in variable OK
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
      g<-addG(g,dataPolygon(profile,colour="black",fill=OK,alpha=0.5))
      
      # where the required capacity is more than available
      # we draw the missing capacity using the colour in variable notOK
      requiredCapacity<-sum(character)
      if (totalCapacity>requiredCapacity) capacity<-character
      else {
        # how much missing capacity?
        z<-unique(sort(character))
        za<-z*0
        for (j in 1:length(z)) 
          za[j]<-sum(character>=z[j])*z[j]+sum(character[character<z[j]])
        # how is this split between the 39 ASD (proportionately on those that need too much)
        if (sum(!is.na(za))<2) capacityLimit<-totalCapacity/nsegments
        else capacityLimit<-approx(za,z,totalCapacity)$y
        if (is.na(capacityLimit)) capacityLimit<-totalCapacity/nsegments
        capacity<-character
        capacity[capacity>capacityLimit]<-capacityLimit
        # end of capacity limits
        
        # are we doing masking
        # masking is done as giving priority to the ASDQ with the highest demands
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
        # end of masking calculations
      
        # now draw the missing capacity
        for (i in 1:nsegments) {
          if (character[i]>capacity[i]) {
            arc<-(i-1)/nsegments*2*pi+seq(0,2*pi/nsegments,length.out=360/nsegments)
            x<-c(sin(arc)*capacity[i], sin(rev(arc))*character[i])
            y<-c(cos(arc)*capacity[i], cos(rev(arc))*character[i])
            g<-addG(g,dataPolygon(data.frame(x=x*radius,y=y*radius),
                                  colour="none",fill=notOK,alpha=0.5))
          } 
        }
      }
      
      # are we wanting to draw some points as well?
      # probably not
      if (showpoints) {
      fill<-hsv(hues,0,1)
      colour<-hsv(hues,0,0.75-(character^displayExponent*0.75))
      g<-addG(g,dataPoint(points,
                          size=5*character,
                          fill=fill,colour=colour,alpha=0.75+character*0.25))
      }
      # and send the diagram to the ui
      if (useHTML)  output$spectrumHTML <- renderUI(HTML(g))
      else          output$spectrumPlot <- renderPlot({g})

      # second figure
      if (doSecondFigure) {
      z<-cumsum(character)

      setBrawEnv('plotSize',c(450,300))
      g1<-startPlot(xlim=c(0,nsegments+1),ylim=c(0,40),box="both",
                    xlabel="item",xticks=list(logScale=FALSE),ylabel="cumulative demand",yticks=list(logScale=FALSE))
      
      x<-1:nsegments
      g1<-addG(g1,dataPath(data.frame(x=x,y=z)))
      use<-z<totalCapacity
      g1<-addG(g1,dataPoint(data.frame(x=x[use],y=z[use]),fill=OK))
      g1<-addG(g1,dataPoint(data.frame(x=x[!use],y=z[!use]),fill=notOK))
      if (useHTML)  output$autismHTML <- renderUI(HTML(g1))
      else          output$autismPlot <- renderPlot({g1})
      }
    })
  
}

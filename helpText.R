
helpText<-function() {
  
  return(
    paste0(
    '<div style="font-size:9pt;">',
    "This is a demo to explore the idea of the autism spectrum.<br>
    <ol>
    <li>
    <b>Dimensions:</b> the spectrum has 10 broad dimensions of input, each split into several separate questions. Of these, 2 are not shown by default but can be shown by changing the dimensions control to 'original'.
    <ul>
    <li>The spectrum can be displayed as either the original format, or a more positive format</li>
    <li>The person\'s profile is shown as a polygon</li>
    <li>The further out from the middle, the more information is being retrieved from that category</li>
    </ul>
    </li>
    <li>
    <b>Demand:</b> the simulated person has an input demand score (ie 'autism score') which determines how much information they get from their environment.
    <ul>
    <li>The higher this is, the more information they extract from their environment</li>
    <li>Roughly, NT is less than 0.7 and ND is above 0.7</li>
    </li>
    </ul>
    <li>
    <b>Capacity:</b> everyone has the same information processing capacity.
    <ul>
    <li>This is set to mostly be ample for the information load for input demand scores of up to 0.5.</li>
    <li>But for higher 'autism score', there is more information </li>
    <li>And so they require more capacity and there will be unmet demand (shaded with saturated colours)</li>
    </ul>
    </li>
    <li>
    <b>Masking</b> is the process of transferring capacity towards higher demand dimensions.
    <ul>
    <li>Capacity transfer is set as a proportion of unmet demand on the highest dimensions</li>
    <li>Capacity available for other dimensions is reduced </li>
    <li>There is a cost in masking: overall capacity is reduced</li>
    </ul>
    </li>
    <li>
    <b>Stimming</b> reduces the amount of information acquired from the environment.
    <ul>
    <li>Stimming is set as a proportion of overall unmet demand</li>
    <li>Capacity itself is unaffected </li>
    <li>There is no cost in stimming</li>
    </ul>
    </li>
    </ol>
    </div>
    "
    )
  )
  
}

definitionText<-function() {
  
  return(
    paste0(
      '<div style="font-size:9pt;">',
      "There are three key concepts.
 <ol>
    <li>
    <b>Information:</b> the environment is information-rich.
    <ul>
    <li>Information is only what isn't known/expected in the environment</li>
    <li>Information is used to change ongoing/planned behaviour</li>
    <li></li>
    </ul>
    <li>
    <b>Capacity:</b> the person has a capacity for information processing
    <ul>
    <li>When the information load is reasonable, the capacity is adequate</li>
    <li>When the load exceeds capacity, then there is a problem</li>
    <li></li>
    </ul>
    <li>
    <b>Control:</b> the person has limited control on this process
    <ul>
    <li>Masking is to shift capacity towards socially expected responses</li>
    <li>Stimming is to reduce overall the incoming information </li>
    <li></li>
    </ul>

 </ol>
    </div>
      "
    )
  )
  
}


issuesText<-function() {
  
  return(
    paste0(
      '<div style="font-size:9pt;">',
      "The original dimensions are (i) negatively framed as deficits and (ii) are based on how autistic traits impact on neurotypical people.
      In this app, the intention is to move away from NT-based problems towards an ND-centred picture.
      <br><br>
      The basis of this, which may be completely wrong, is to reframe the issue as an inbalance between environmental load/demand and individual capacity.
      'Poor social communication' becomes 'Too much social information' and communication is slowed or abbreviated etc.
 <ol>
    <li>
    <b>Locus of control:</b> some dimensions are under the individual's control
    <ul>
    <li>Some dimensions are externally controlled such as 'Peer Relations' </li>
    <li>Some are internally controlled such as 'Restricted Interests'</li>
    <li></li>
    </ul>
    <li>
    <b>Purpose/Benefit:</b> some of the dimensions are simply adaptive behaviour
    <ul>
    <li>Some dimensions are beneficial to the individual such as 'Sensory Interests'<br>and, of course, stimming</li>
    <li>Some are harmful, such as the social ones</li>
    <li></li>
    </ul>
    <li>
    <b>Missing dimensions:</b> there are obvious gaps
    <ul>
    <li>How about interest in other people's specialized interests?</li>
    <li>Where is the double empathy problem?</li>
    <li></li>
    </ul>

 </ol>
    </div>
      "
    )
  )
  
}


helpText<-function() {
  
  return(
    paste0(
    '<div style="font-size:9pt;">',
    "This is a demo to explore the idea of the autism spectrum.<br>
    <ol>
    <li>
    <b>Dimensions:</b> the spectrum has 10 broad dimensions of input, each split into several separate questions.
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
    <li>And so they require more capacity and there will be unmet demand (shaded black)</li>
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
    <li>That structure is to a degree predictable.</li>
    <li></li>
    <li></li>
    </ul>
    <li>
    <b>Information:</b> the environment is information-rich.
    <ul>
    <li>That structure is to a degree predictable.</li>
    <li></li>
    <li></li>
    </ul>

 </ol>
      "
    )
  )
  
}

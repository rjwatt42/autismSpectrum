
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

questionsText<-function() {
  
  return(generate_tab(title="ASDQ:",titleWidth=50,
                               tabs=c("Basic social communication",
                                      "Affiliation",
                                      "Perspective taking",
                                      "Peer relations",
                                      "Repetitive",
                                      "Sensory interests",
                                      "Sameness",
                                      "Sensory sensitivities",
                                      "Restricted interests",
                                      "Other"
                               ),
                               tabContents=c(
       "
<br>1 Difficulty starting interactions with others without prompting
<br>2 Aversion to eye contact
<br>3 Lack of gestures (such as pointing) in communication
<br>4 Difficulty communicating feelings clearly to others
<br>5 Difficulty sharing enjoyment about interests or activities with other people
<br>6 Difficulty responding in socially accepted ways when approached by others 
<br>7 Preference for own interests and activities, rather than those of another person, as topics for back-and-forth conversation
","
<br>8 Preference for solitude rather than being with friends or family 
<br>9 Difficulty connecting physically and emotionally with family and friends
<br>10 Difficulty expressing importance of relationships
","
<br>11 Difficulty comforting others who are upset or sick
<br>12 Difficulty reading social cues
<br>13 Difficulty understanding expected behavior for different social situations 
<br>14 Difficulty understanding what others are thinking or feeling
","
<br>15 Difficulty engaging in back-and-forth play with same-age peers
<br>16 Apparent disinterest in playful interactions, playmates or friendships
<br>17 Difficulty engaging with two or more close friends
","
<br>18 Hand flapping or other atypical hand movements
<br>19 Repetitive jumping, rocking, spinning or other whole-body motions
<br>20 Repetition of sounds, words or lines from videos
<br>21 Tendency to play repetitively with objects or repeat actions without an obvious purpose
","
<br>22 Preference for engagement with specific parts of objects rather than the whole object
<br>23 Fascination with sensory experiences
<br>24 Preoccupation with visual patterns or sounds
","
<br>25 Insistence on a consistent daily schedule
<br>26 Difficulty transitioning from one activity to another
<br>27 Affinity for strict rules, rituals or sequences
<br>28 Difficulty changing mind and being flexible
","
<br>29 Sensitivity to loud noises
<br>30 Aversion to crowded or busy places
<br>31 Aversion to certain lights, sounds, textures, foods or smells
","
<br>32 Tendency to think or talk about the same topic over and over
<br>33 Strong fixation on a specific interest or activity
<br>34 Sustained engagement with specific games or subjects, irrespective of others' interests
<br>35 Strong focus on highly specific or narrow interests
","
<br>36 Affinity for making lists, memorizing facts or learning about technical subjects 
<br>37 Difficulty intuiting social norms such as personal space and body language
<br>38 Difficulty understanding sarcasm or other nonliteral communication
<br>39 Atypical volume, tone, rhythm or rate of speech
  "),
  open=1,width=500,height=350
  )
  )
}
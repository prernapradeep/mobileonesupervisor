
# Import file "MobileV1_fixed_copy_Prerna-1" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/MobileV1_fixed_copy_Prerna-1@2x")

# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Prerna Pradeep"
	twitter: ""
	description: ""

# Set up Firebase
{Firebase} = require 'firebase'

firebase = new Firebase
	projectID: "trial-c5080"
	secret: "3DN06qUHzHwAij8nSWcVJ3Tk1MWY9J2rauEDmqIc" 

header = {
	paddingTop: "5px",
	color: "#000",
	fontFamily: "Lato"
	fontSize: "48px"
	fontWeight: "400"
	textAlign : "left"
};

statusLabel = {
    paddingTop: "15px",
    color: "#000",
    fontFamily: "Lato"
    fontSize: "30px"
    fontWeight: "900"
    textAlign : "left"
};

val = {
	paddingTop: "20px",
	color: "#000",
	fontFamily: "Lato"
	fontSize: "72px"
	fontWeight: "900"
	textAlign : "left"
}
label = {
	paddingTop: "15px",
	color: "#757473",
	fontFamily: "Lato"
	fontSize: "28px"
	fontWeight: "400"
	textAlign : "left"
};

agentval = {
	paddingTop: "15px",
	color: "#000",
	fontFamily: "Lato"
	fontSize: "50px"
	fontWeight: "900"
	textAlign : "left"
};


servicesExpandedVal = {
	paddingTop: "25px",
	color: "#000",
	fontFamily: "Lato"
	fontSize: "32pt"
	fontWeight: "700"
	textAlign : "left"
};

servicesExpandedLabel = {
	paddingTop: "75px",
	color: "#757473",
	fontFamily: "Lato"
	fontSize: "20px"
	fontWeight: "400"
	textAlign : "left"
};



{TextLayer} = require 'TextLayer'

Framer.Defaults.Animation = 
	curve: "spring(300,30,0)"
	time: 0.4
	
gTension = 280 #250
gFriction = 40 #50
gVelocity = 0.2 #0.2
menuClosed = true

#Class for the Inbound services + counter/ticker animation
class InboundService extends Layer
	toggle=1
	idnumber = " "
	
	activate: ->
		@backgroundColor = "#C2D7EF"
		@borderWidth = 1
		this.toggle = 1
		
	deactivate: ->
		@backgroundColor = "#FFF"
		@borderWidth = 1
		this.toggle = 0
				
	constructor: (opts)->
		super opts
	
		@superLayer = inboundscroll.content
		@width = 672
		@height = 240
		@idnumber = opts.idnumber
		@name = opts.name
		@sla = opts.sla
		totalcall = _.toInteger(opts.longestcall)
		@deactivate()
		@borderWidth = 1
		@borderColor = "rgba(128,128,128,1)"
		@style = {
			backgroundColor: "#FFF"
		}
		
		sampleGraph = new Layer
			superLayer: this
			width: 358
			height: 120
			x: 262
			y: 82
			image: "images/sampleGraph.png"
			backgroundColor: "transparent"

		
		serviceNameField = new Layer
			superLayer: this
			width: 750
			height: 60
			y: 28
			html: opts.name
			style: header
			x: 32
			backgroundColor: "transparent"

		if opts.sla < 80 
			val.color = "red"
		else 
			val.color = "black"
			
		slaValue= new Layer
			superLayer: this
			width: 152
			height: 86
			y: 100
			html: opts.sla + "%"
			style: val
			x: 32
			backgroundColor: "transparent"
						
		sla = this.sla
				
		timer = Utils.interval Utils.randomNumber(1,10), -> 
			if sla > Utils.randomNumber(80,90)
				sla = sla + 1
				slaValue.html = "#{sla}" + "%"
			else
				sla = sla - 1 
				slaValue.html = "#{sla}" + "%"
				
			if sla < 80 
				slaValue.color = "red"
			else 
				slaValue.color = "black"
				
			if sla <= 67
				sla = sla + 1
				slaValue.html = "#{sla}" + "%"
			
			if sla == 100
				clearInterval timer

		slaLabel = new Layer
			superLayer: this
			width: 136
			height: 28
			style: label
			html: "SLA"
			x: 32
			y: 165
			backgroundColor: "transparent"
			
		servicesExpand = new Layer
			superLayer: this
			x: 0
			y: 240
			width: 672
			height: 264
			border: 1
			opacity: 0
			backgroundColor: "transparent"
			
		abandonRate = new Layer
			superLayer: servicesExpand 
			width: 134
			height: 118
			x: 55
			opacity: 0
			style: servicesExpandedVal
			html: opts.abandonrate
			backgroundColor: "transparent"
			
		abandonedRateLabel = new Layer
			superLayer: servicesExpand 
			width: 134
			height: 118
			x: 55
			opacity: 0
			style: servicesExpandedLabel
			html: "ABANDON RATE"
			backgroundColor: "transparent"
				
		liveCalls = new Layer
			superLayer: servicesExpand 
			width: 134
			height: 118	
			x: 200
			opacity: 0
			style: servicesExpandedVal
			html: opts.livecalls
			backgroundColor: "transparent"
			
			
		liveCallsLabel = new Layer
			superLayer: servicesExpand 
			width: 134
			height: 118	
			x: 200
			opacity: 0
			style: servicesExpandedLabel
			html: "LIVE CALLS"
			backgroundColor: "transparent"
			
		longestWait = new Layer
			superLayer: servicesExpand 
			width: 134
			height: 118	
			x: 365
			opacity: 0
			style: servicesExpandedVal
			html: opts.longestcall
			backgroundColor: "transparent"
			
		longestWaitLabel = new Layer
			superLayer: servicesExpand 
			width: 134
			height: 118	
			x: 365
			opacity: 0
			style: servicesExpandedLabel
			html: "LONGEST WAIT TIME"
			backgroundColor: "transparent"
			
		avgCallduration = new Layer		
			superLayer: servicesExpand 
			width: 134
			height: 118	
			x: 515		
			opacity: 0	
			style: servicesExpandedVal	
			html: opts.avgcall
			backgroundColor: "transparent"
			
		avgCalldurationLabel = new Layer		
			superLayer: servicesExpand 
			width: 134
			height: 118	
			x: 515	
			opacity: 0	
			style: servicesExpandedLabel
			backgroundColor: "transparent"	
			html: "AVG. CALL DURATION"
		
		
		min = Math.ceil(opts.longestcall/60)
		sec = Math.ceil(opts.longestcall % 60)
		if (sec/10) == 0
			sec = '0'+sec
					

		serviceDoubleClick = 0
		@on Events.DoubleClick, () ->
			if serviceDoubleClick == 0
				servicesExpand.opacity = 1
				avgCallduration.opacity = 1
				longestWait.opacity = 1
				liveCalls.opacity = 1
				abandonRate.opacity = 1
				avgCalldurationLabel.opacity = 1
				longestWaitLabel.opacity = 1
				liveCallsLabel.opacity = 1
				abandonedRateLabel.opacity = 1
				serviceDoubleClick = 1
				
				#length = this.siblings.length
				for sibling in this.siblings
					if sibling.index > this.index
						sibling.y = sibling.y + 144
						#sibling.height = sibling.y + 264
						print sibling.index
					print "hello"
			else 
				for sibling in this.siblings
					if sibling.index > this.index
						sibling.y = sibling.y - 144
					#sibling.height = sibling.y + 264			
				serviceDoubleClick = 0
				servicesExpand.opacity = 0
				avgCallduration.opacity = 0
				longestWait.opacity = 0
				liveCalls.opacity = 0
				abandonRate.opacity = 0
				avgCalldurationLabel.opacity = 0
				longestWaitLabel.opacity = 0
				liveCallsLabel.opacity = 0
				abandonedRateLabel.opacity = 0
				serviceDoubleClick = 0
				print "hi"
				
			
		@on Events.Click, () ->
			##if this layer has been clicked, change toggle to 1
			if this.toggle == 0
				for sibling in this.siblings
					sibling.deactivate()
				@activate()
				for layer in sketch.agentContent.subLayers #remove previous agents
					layer.destroy()
				id = this.idnumber	
				
				#get list of agents for the particular service		
				response = (messages) ->
					messagesArray = _.toArray(messages)
					for key, message of messages
						if id == message.id
							agents = _.toArray(message.agents)
							i=1
							for agent in agents
								ag = new Agent
									name: agent.name
									parent: sketch.agentContent
									currentcall: agent.currentcall
									status: agent.status
								ag.x = 0
								ag.y = (ag.height)*(i-1)
								i++

				firebase.get("/inboundservices",response,{orderBy: "$key"})
			else
				@deactivate()
				
				for layer in sketch.agentContent.subLayers #remove previous agents
					layer.destroy()
					
				agentsRef = firebase.get "/agents",(agents) ->
					agentsArray = _.toArray(agents)
					length = agentsArray
					for agent in agentsArray
						name=agent.name
						ag = new Agent
							name: agent.name
							parent: sketch.agentContent
							currentcall: agent.currentcall
							status: agent.status
						ag.x = 0
						ag.y = (ag.height)*(agent.id-1)
						
						
			

			

#Class for the Outbound services + counter/ticker animation
class OutboundService extends Layer
	toggle=1
	idnumber = " "
	
	activate: ->
		@backgroundColor = "#C2D7EF"
		@borderWidth = 1
		this.toggle = 1
		
	deactivate: ->
		@backgroundColor = "#FFF"
		@borderWidth = 1
		this.toggle = 0
				
	constructor: (opts)->
		super opts
	
		@superLayer = outboundscroll.content
		@width = 704
		@height = 240
		@idnumber = opts.idnumber
		@name = opts.name
		@sla = opts.sla
		totalcall = _.toInteger(opts.longestcall)
		@deactivate()
		@borderWidth = 1
		@borderColor = "rgba(128,128,128,1)"
		@style = {
			backgroundColor: "#FFF"
		}
		
		sampleGraph = new Layer
			superLayer: this
			width: 358
			height: 120
			x: 262
			y: 82
			image: "images/sampleGraph.png"
			backgroundColor: "transparent"

		
		serviceNameField = new Layer
			superLayer: this
			width: 750
			height: 60
			y: 28
			html: opts.name
			style: header
			x: 32
			backgroundColor: "transparent"
	
		slaValue= new Layer
			superLayer: this
			width: 152
			height: 86
			y: 100
			html: opts.sla + "%"
			style: val
			x: 32
			backgroundColor: "transparent"
						
		sla = this.sla
				
		timer = Utils.interval Utils.randomNumber(1,10), -> 
			if sla > Utils.randomNumber(80,90)
				sla = sla + 1
				slaValue.html = "#{sla}" + "%"
			if sla == 100
				clearInterval timer

		slaLabel = new Layer
			superLayer: this
			width: 136
			height: 28
			style: label
			html: "SLA"
			x: 32
			y: 165
			backgroundColor: "transparent"
		
		min = Math.ceil(opts.longestcall/60)
		sec = Math.ceil(opts.longestcall % 60)
		if (sec/10) == 0
			sec = '0'+sec
			
		@on Events.Click, () ->
			##if this layer has been clicked, change toggle to 1
			if this.toggle == 0
				for sibling in this.siblings
					sibling.deactivate()
				@activate()
				for layer in sketch.agentContent.subLayers #remove previous agents
					layer.destroy()
				id = this.idnumber	
				
				#get list of agents for the particular service		
				response = (messages) ->
					messagesArray = _.toArray(messages)
					for key, message of messages
						if id == message.id
							agents = _.toArray(message.agents)
							i=1
							for agent in agents
								ag = new Agent
									name: agent.name
									parent: sketch.agentContent
									currentcall: agent.currentcall
									status: agent.status
								ag.x = 0
								ag.y = (ag.height)*(i-1)
								i++

				firebase.get("/outboundservices",response,{orderBy: "$key"})
			else
				@deactivate()
				
				for layer in sketch.agentContent.subLayers #remove previous agents
					layer.destroy()
					
				agentsRef = firebase.get "/agents",(agents) ->
					agentsArray = _.toArray(agents)
					length = agentsArray
					for agent in agentsArray
						name=agent.name
						ag = new Agent
							name: agent.name
							parent: sketch.agentContent
							currentcall: agent.currentcall
							status: agent.status
						ag.x = 0
						ag.y = (ag.height)*(agent.id-1)

#Overview metrics section
overviewscroll = new ScrollComponent
	width: 512	
	height: Screen.height
	scrollHorizontal: false
	parent: sketch.overviewContent
	
overviewscroll.contentInset=
	bottom: 40

metricSLACard = new Layer
	width: 256*2
	height: 192
	superLayer: overviewscroll.content
	x: 0
	y: 0
	backgroundColor: "transparent"
	borderWidth: 1
	borderColor: "rgba(128,128,128,1)"
	
metricSLAImage = new Layer
	superLayer: metricSLACard
	width: 288
	height: 96
	image: "images/sampleGraph.png"
	x: 200
	y: 50
	backgroundColor: "transparent"
	
metricSLALabel = new Layer
	superLayer: metricSLACard
	width: 150
	height: 34
	style: label
	html: "SLA"
	x: 32
	y: 100
	backgroundColor: "transparent"
		
metricSLAval = 92
metricSLAValue = new Layer
	superLayer: metricSLACard
	width: 150
	height: 86
	style: val
	html: metricSLAval + "%"
	x: 32
	y: 42
	backgroundColor: "transparent"

metricSLAtimer = Utils.interval Utils.randomNumber(1,10), -> 
	if metricSLAval > Utils.randomNumber(80,90)
		metricSLAval = metricSLAval + 1
		metricSLAValue.html = "#{metricSLAval}" + "%"
	if metricSLAval == 98
		clearInterval metricSLAtimer

metricAbandonRateCard = new Layer
	width: 512
	height: 192
	superLayer: overviewscroll.content
	x: 0
	y: 0 + 192*1
	backgroundColor: "transparent"
	borderWidth: 1
	borderColor: "rgba(128,128,128,1)"
		
metricAbandonRateImage = new Layer
	superLayer: metricAbandonRateCard
	width: 288
	height: 96
	image: "images/sampleGraph.png"
	x: 200
	y: 50
	backgroundColor: "transparent"
		
metricAbandonRateLabel = new Layer
	superLayer: metricAbandonRateCard
	width: 150
	height: 34
	style: label
	html: "ABANDON RATE"
	x: 32
	y: 100
	backgroundColor: "transparent"	

metricAbandonRateval = 3
metricAbandonRateValue = new Layer
	superLayer: metricAbandonRateCard
	width: 150
	height: 86
	style: val
	html: metricAbandonRateval + "%"
	x: 32
	y: 42
	backgroundColor: "transparent"

metricAbandonRatetimer = Utils.interval Utils.randomNumber(1,10), -> 
	if metricAbandonRateval > Utils.randomNumber(2,8)
		metricAbandonRateval = metricAbandonRateval - 1
		metricAbandonRateValue.html = "#{metricAbandonRateval}" + "%"
	if metricSLAval == 2
		clearInterval metricAbandonRatetimer
		
metricCallsWaitingCard = new Layer
	width: 512
	height: 192
	superLayer: overviewscroll.content
	x: 0
	y: 0 + 192*2
	backgroundColor: "transparent"
	borderWidth: 1
	borderColor: "rgba(128,128,128,1)"
	
metricCallsWaitingImage = new Layer
	superLayer: metricCallsWaitingCard
	width: 288
	height: 96
	image: "images/sampleGraph.png"
	x: 200
	y: 50
	backgroundColor: "transparent"
	
metricCallsWaitingLabel = new Layer
	superLayer: metricCallsWaitingCard
	width: 150
	height: 28
	style: label
	html: "CALLS WAITING"
	x: 32
	y: 100 
	backgroundColor: "transparent"
	
metricCallsWaitingval = 24
metricCallsWaitingValue = new Layer
	superLayer: metricCallsWaitingCard
	width: 150
	height: 86
	style: val
	html: metricCallsWaitingval
	x: 32
	y: 42
	backgroundColor: "transparent"
	
metricCallsWaitingtimer = Utils.interval Utils.randomNumber(1,10), -> 
	metricCallsWaitingval = metricCallsWaitingval + 1
	metricCallsWaitingValue.html = metricCallsWaitingval
	if metricCallsWaitingval == 27
		clearInterval metricCallsWaitingtimer
		
metricLiveCallsCard = new Layer
	width: 512
	height: 192
	superLayer: overviewscroll.content
	x: 0
	y: 0 + 192*3
	backgroundColor: "transparent"
	borderWidth: 1
	borderColor: "rgba(128,128,128,1)"
	
metricLiveCallsImage = new Layer
	superLayer: metricLiveCallsCard
	width: 288
	height: 96
	image: "images/sampleGraph.png"
	x: 200
	y: 50
	backgroundColor: "transparent"
	
metricLiveCallsLabel = new Layer
	superLayer: metricLiveCallsCard
	width: 150
	height: 28
	style: label
	html: "LIVE CALLS"
	x: 32
	y: 100
	backgroundColor: "transparent"
	
metricLiveCallsval = 23
metricLiveCallsValue = new Layer
	superLayer: metricLiveCallsCard
	width: 150
	height: 86
	style: val
	html: metricLiveCallsval
	x: 32
	y: 42
	backgroundColor: "transparent"

metricLiveCallstimer = Utils.interval Utils.randomNumber(1,10), -> 
	metricLiveCallsval = metricLiveCallsval + 1
	metricLiveCallsValue.html = metricLiveCallsval
	if metricLiveCallsval == 27
		clearInterval metricLiveCallstimer
		
metricAgentActiveCard = new Layer
	width: 512
	height: 192
	superLayer: overviewscroll.content
	x: 0
	y: 0 + 192*4
	backgroundColor: "transparent"
	borderWidth: 1
	borderColor: "rgba(128,128,128,1)"
	
metricAgentActiveImage = new Layer
	superLayer: metricAgentActiveCard
	width: 288
	height: 96
	image: "images/sampleGraph.png"
	x: 200
	y: 50
	backgroundColor: "transparent"
	
metricAgentActiveLabel = new Layer
	superLayer: metricAgentActiveCard
	width: 150
	height: 28
	style: label
	html: "AGENTS ACTIVE"
	x: 32
	y: 100
	backgroundColor: "transparent"
	
metricAgentActiveval = 32
metricAgentActiveValue = new Layer
	superLayer: metricAgentActiveCard
	width: 150
	height: 86
	style: val
	html: metricAgentActiveval
	x: 32
	y: 42 
	backgroundColor: "transparent"

metricAgentActivetimer = Utils.interval Utils.randomNumber(1,10), -> 
	metricAgentActiveval = metricAgentActiveval - 1
	metricAgentActiveValue.html = metricAgentActiveval
	if metricAgentActiveval == 30
		clearInterval metricAgentActivetimer
		
metricWaitTimeCard = new Layer
	width: 512
	height: 192
	superLayer: overviewscroll.content
	x: 0
	y: 0 + 192*5
	backgroundColor: "transparent"
	borderWidth: 1
	borderColor: "rgba(128,128,128,1)"

metricWaitTimeImage = new Layer
	superLayer: metricWaitTimeCard
	width: 288
	height: 96
	image: "images/sampleGraph.png"
	x: 200
	y: 50
	backgroundColor: "transparent"
	
metricWaitTimeLabel = new Layer
	superLayer: metricWaitTimeCard
	width: 150
	height: 28
	style: label
	html: "AVG. WAIT TIME"
	x: 32
	y: 100
	backgroundColor: "transparent"
		
metricWaitTimeval = 75
min=0
sec=0	
min = Math.ceil(metricWaitTimeval/60)
sec = metricWaitTimeval  % 60

metricWaitTimeValue = new Layer
	superLayer: metricWaitTimeCard
	width: 150
	height: 86
	style: val
	html: min + ":" + sec
	x: 32
	y: 42
	backgroundColor: "transparent"
	
metricCallTimeCard = new Layer
	width: 512
	height: 192
	superLayer: overviewscroll.content
	x: 0
	y: 0 + 192*6
	backgroundColor: "transparent"
	borderWidth: 1
	borderColor: "rgba(128,128,128,1)"
	
metricCallTimeImage = new Layer
	superLayer: metricCallTimeCard
	width: 288
	height: 96
	image: "images/sampleGraph.png"
	x: 200
	y: 50
	backgroundColor: "transparent"
	
metricCallTimeLabel = new Layer
	superLayer: metricCallTimeCard
	width: 150
	height: 28
	style: label
	html: "AVG. CALL TIME"
	x: 32
	y: 100
	backgroundColor: "transparent"
	
metricCallTimeval = 234
min=0
sec=0	
metricCallTimeval  = metricCallTimeval  + 1
min = Math.ceil(metricCallTimeval /60)
sec = metricCallTimeval  % 60
if sec == 60
	min = min + 1
	sec = 0
else
	if Math.ceil(sec/10) == 0
		sec = '0' + sec
		
metricCallTimeValue = new Layer
	superLayer: metricCallTimeCard
	width: 150
	height: 86
	style: val
	html: metricCallTimeval
	x: 32
	y: 42
	backgroundColor: "transparent"
		
sketch.homeicon.backgroundColor = "#ffffff"

inboundscroll = new ScrollComponent
	width: 672
	height: Screen.height
	scrollHorizontal: false
	parent: sketch.servicesContainerInbound

inboundscroll.contentInset=
	bottom: 240
	
outboundscroll = new ScrollComponent
	width: 672
	height: Screen.height
	scrollHorizontal: false
	parent: sketch.servicesContainerOutbound
	
inboundServicesRef = firebase.get "/inboundservices",(services) ->
	servicesArray =  _.toArray(services) 
	length = servicesArray.length
	for service in servicesArray
		sla = service.sla
		ser = new InboundService
			name: service.name
			idnumber: service.id
			sla: sla
			longestcall: service.longestcall
			abandonrate: service.abandonrate
			livecalls: service.livecalls
			avgcall: service.avgcall
		ser.x = 0
		ser.y = (ser.height)*(service.id-1)
		#ser.y = (384)*(service.id-1)		
	
outboundServicesRef = firebase.get "/outboundservices",(services) ->
	servicesArray =  _.toArray(services) 
	length = servicesArray.length
	for service in servicesArray
		sla = service.sla
		ser = new OutboundService
			name: service.name
			idnumber: service.id
			sla: sla
			longestcall: service.longestcall
		ser.x = 0
		ser.y = (240)*(service.id-1)
		

# To load more options on screen - add service, add agent, screenshot
###
sketch.home_more.superLayer = null
screenshotButton = sketch.Circle0

addServiceButton = sketch.Circle1

addAgentButton = sketch.Circle2

addKPIButton = sketch.Circle3

menuBackground = new Layer
	x: 0
	y: 0
	width: 2048
	height: 1580
	backgroundColor:"#000"
	opacity: 0.7
	visible: false
menuBackground.placeBehind(sketch.home_more)

screenshotButton.states.add
	Home: 
		opacity: 0
		y: sketch.fab.y
		
	Onboard: 
		x: sketch.fab.x
		y: sketch.fab.y - 200
		style : label
		opacity: 1
		
addServiceButton.states.add
	Home: 
		opacity: 0
		y: sketch.fab.y
		
	Onboard: 
		x: sketch.fab.x
		y: sketch.fab.y - 400
		opacity: 1
		
addAgentButton.states.add
	Home: 
		opacity: 0
		y: sketch.fab.y
		
	Onboard: 
		x: sketch.fab.x
		y: sketch.fab.y - 600
		opacity: 1
		
addKPIButton.states.add
	Home: 
		opacity: 0
		y: sketch.fab.y
		
	Onboard: 
		x: sketch.fab.x
		y: sketch.fab.y - 800
		opacity: 1

menuBackground.states.add
	Home: 
		visible: false
	Onboard:
		visible: true

sketch.fab.on Events.Click, ->
	if menuClosed
		menuBackground.states.switch "Onboard", delay: 0.04
		screenshotButton.states.switch "Onboard", delay: 0.06
		addServiceButton.states.switch "Onboard", delay: 0.10
		addAgentButton.states.switch "Onboard", delay: 0.14
		addKPIButton.states.switch "Onboard", delay: 0.18
		sketch.screenshotText.visible = true
		sketch.ServicesText.visible = true
		sketch.AgentsText.visible = true
		sketch.KPIText.visible = true
		menuClosed = false
		sketch.Closed.visible = false
		sketch.Open.visible = true
		
	else
		menuBackground.states.switch "Home", delay: 0.04
		screenshotButton.states.switch "Home", delay: 0.06
		addServiceButton.states.switch "Home", delay: 0.10
		addAgentButton.states.switch "Home", delay: 0.14
		addKPIButton.states.switch "Home", delay: 0.18
		menuClosed = true
		sketch.Closed.visible = true
		sketch.Open.visible = false
		
homeMoreScreenshotSelected = new Layer
	superLayer: menuBackground
	width: 572
	height: 669
	image: "images/homeMoreScreenshotSelected.png"
	x: 1261
	y: 687
	opacity: 0
    
exithomeMoreScreenshotSelected = new Layer
    superLayer: homeMoreScreenshotSelected
    x:500
    y:0
    width:75
    height:75
    backgroundColor: "transparent"
    
homeMoreAddAgentError = new Layer
	superLayer: menuBackground
	image: "images/homeMoreAddAgentError.png"
	opacity: 0
	width: 770
	height: 480
	x: 600
	y: 600
	
homeMoreAddAgentNoSelection = new Layer
	superLayer: menuBackground
	image: "images/SelectAgentNoSelection.png"
	opacity: 0
	width: 960
	height: 720
	x: 600
	y: 400
	
homeMoreAddAgentSelected = new Layer
	superLayer: menuBackground
	image: "images/SelectAgentSelected.png"
	visible: false
	width: 960
	height: 720
	x: 600
	y: 400
	
selectAgent = new Layer
	superLayer: homeMoreAddAgentNoSelection
	height: 200
	width: 200
	x: 400
	y: 200
	visible: false
	backgroundColor: "transparent"
	
exithomeAgentSelected = new Layer
    superLayer: homeMoreAddAgentNoSelection
    x:30
    y:600
    width: 252
    height: 80
    backgroundColor: "transparent"
	
homeMoreAddAgentErrorButton = new Layer
	superLayer: homeMoreAddAgentError
	opacity:1
	width: 770
	height: 150
	y: 350
	backgroundColor: "transparent"
	visible = false

confirmAgentSelection = new Layer
	superLayer: homeMoreAddAgentSelected
	x:750
	y:600
	width:200
	height:100
	backgroundColor: "transparent"
	
confirmationAddAgentModal = new Layer
	width: 770
	height: 480
	x: 600
	y: 600
	image: "images/NotificationAgentAssigned.png"
	visible: false
confirmationAddAgentModal.placeBefore(confirmAgentSelection)

confirmationAddAgentButton = new Layer
	superLayer: confirmationAddAgentModal
	opacity:1
	width: 750
	height: 150
	y: 320
	x: 20
	backgroundColor: "transparent"


addAgentButton.on Events.Click, -> 
	flag = 0	
	for child in sketch.servicesContainerInbound.children
		if child.toggle == 1
			flag = 1
	for child in sketch.servicesContainerOutbound.children
		if child.toggle == 1	
			flag = 1
			
	exithomeAgentSelected.on Events.Click, ->
		homeMoreAddAgentNoSelection.opacity = 0	
		homeMoreAddAgentSelected.visible = false
			
	if flag == 0
		homeMoreAddAgentError.opacity = 1
		homeMoreAddAgentErrorButton.on Events.Click, -> 
			homeMoreAddAgentError.opacity = 0
			menuClosed = 1
			menuBackground.states.switch "Home", delay: 0.04
			screenshotButton.states.switch "Home", delay: 0.06
			addServiceButton.states.switch "Home", delay: 0.10
			addAgentButton.states.switch "Home", delay: 0.14
			addKPIButton.states.switch "Home", delay: 0.18
			menuClosed = true
			sketch.Closed.visible = true
			sketch.Open.visible = false
	else
		homeMoreAddAgentNoSelection.opacity = 1
		selectAgent.visible = true
		selectAgent.on Events.Click, -> 
			homeMoreAddAgentNoSelection.opacity = 0
			homeMoreAddAgentSelected.visible = true
			confirmAgentSelection.visible = true
			confirmAgentSelection.on Events.Click, -> 
				homeMoreAddAgentSelected.visible = false
				confirmAgentSelection.visible = false
				confirmationAddAgentModal.visible = true
				confirmationAddAgentButton.on Events.Click, ->
					confirmationAddAgentModal.visible = false
					menuClosed = 1
					menuBackground.states.switch "Home", delay: 0.04
					screenshotButton.states.switch "Home", delay: 0.06
					addServiceButton.states.switch "Home", delay: 0.10
					addAgentButton.states.switch "Home", delay: 0.14
					addKPIButton.states.switch "Home", delay: 0.18
					menuClosed = true
					sketch.Closed.visible = true
					sketch.Open.visible = false	
	 
screenshotButton.on Events.Click, ->
	homeMoreScreenshotSelected.opacity = 1
	homeMoreScreenshotSelected.animate    
	options:
		curve: "spring"
	
	exithomeMoreScreenshotSelected.on Events.Click, ->
		homeMoreScreenshotSelected.opacity = 0
		
notificationScreenshotSent = new Layer
	width: 800
	height: 512
	image: "images/notificationScreenshotSent.png"
	opacity: 0
	x: 675
	y: 500
	#shadowColor: "#FFFDFA"
	#shadowBlur: 20
	
notificationScreenshotSent_ok = new Layer
	superLayer: notificationScreenshotSent 
	x: 625
	y: 355
	width: 150
	height: 100
	opacity: 0

sendScreenshot = new Layer
    superLayer: homeMoreScreenshotSelected
    x: 440
    y: 575
    width: 75
    height: 75
    backgroundColor: "transparent"
    	
screenshotButton.on Events.Click, ->
	homeMoreScreenshotSelected.opacity = 1
	homeMoreScreenshotSelected.animate    
		properties:
			curve: "spring"
	exithomeMoreScreenshotSelected.on Events.Click, ->
		homeMoreScreenshotSelected.opacity = 0
	sendScreenshot.on Events.Click, ->
		homeMoreScreenshotSelected.opacity = 0
		notificationScreenshotSent.opacity = 1
	notificationScreenshotSent_ok.on Events.Click, ->
		notificationScreenshotSent.opacity = 0
###

# To toggle between inbound and outbound services
showContent = (content, direction) ->
	content.visible = true
	content.opacity = 0
	if direction is "left"
		content.x = -20
	else if direction is "right"
		content.x = 20
	content.animate
		properties:
			x: 0
			opacity: 1
		curve: "spring"
		curveOptions:
			tension: gTension
			friction: gFriction
			velocity: gVelocity

hideContent = (content) ->
	content.opacity = 0
	content.visible = false
	#
	#content.animate
	#	properties:
	#		x: -20
	#		opacity: 0
	#		visibile: false
	#	curve: "spring"
	#	curveOptions:
	#		tension: gTension
	#		friction: gFriction
	#		velocity: gVelocity

hideContent(sketch.servicesContainerOutbound)

serviceToggle = new Layer
	superLayer: sketch.servicesHeader
	width:100
	height:50
	borderRadius: 30
	backgroundColor:"#b5b5b5"
	x: 520	
	y: 78
	index: 2
	
serviceToggleButton = new Layer
	x: 5
	y: 0
	index: 1
	width:40
	height:40
	borderRadius: 50
	backgroundColor:"#fff"
	superLayer:serviceToggle	
	shadowSpread:3
	shadowBlur:5
	shadowColor:'rgba(0,0,0,0.2)'
	shadowX:2
	
serviceToggleButton.centerY()

serviceToggleButton.states.add
	Inbound: 
		x: serviceToggleButton.minX
		
	Outbound: 
		x: serviceToggleButton.maxX + 10
		
serviceToggleInitial = 1
##turn to 'on' state when clicking on circle
serviceToggle.on Events.Click, ->
	if serviceToggleInitial
		serviceToggleButton.states.switch "Outbound"
		serviceToggleInitial = 0
		hideContent(sketch.servicesContainerInbound)
		showContent(sketch.servicesContainerOutbound,"left")
		
	else
		serviceToggleButton.states.switch "Inbound"
		serviceToggleInitial = 1
		hideContent(sketch.servicesContainerOutbound)
		showContent(sketch.servicesContainerInbound, "left")
	
notification_alert = new Layer
	superLayer: sketch.notification_icon
	width: 60
	height: 60
	borderRadius: 100
	backgroundColor: "red"
	x: 108
	y: 85
	visible: false
	
notification_count = new Layer
	superLayer: notification_alert
	color: "#fff"
	html: "<p align = 'center'><b>+1<b></p>"
	width: 54
	height: 78
	y: 14
	x: 3
	backgroundColor: "transparent"
	
# for the alert notification to come in
alert_animation = ->
	notification_alert.visible = true
	notification_animation = new Animation
		layer: notification_alert
		properties: 
			scale: 0.8
		time: 0.5
		repeat: 2
	
	notification_animation.start()
	
Utils.delay(5,alert_animation)

###notificationLabel = new Layer
	superLayer: sketch.homeContent
	width: 225
	height: 50
	x: 890
	y: 230
	borderRadius: 40
	backgroundColor: "red"
	color: "#fff"
	visible: false
	
notificationText = new Layer
	superLayer: notificationLabel
	width: 300
	height: 50
	x: 25
	y: 10
	borderRadius: 40
	backgroundColor: "transparent"
	color: "#fff"
	html: "5 calls waiting"

alertLabel_animation = ->
	notificationLabel.visible = true
Utils.delay(3, alertLabel_animation)###

showViewContent = (content, direction) ->
	content.visible = true
	content.opacity = 0
	if direction is "up"
		content.y = 66
	else if direction is "down"
		content.y = 28
	content.animate
		properties:
			y: 48
			opacity: 1
		curve: "spring"
		curveOptions:
			tension: gTension
			friction: gFriction
			velocity: gVelocity

hideViewContent = (content) ->
	content.opacity = 0
	content.visible = false

hideMenuOptions = -> 
	sketch.Circle3.visible = false
	sketch.Circle2.visible = false
	sketch.Circle1.visible = false
	
showMenuOptions = -> 
	sketch.Circle3.visible = true
	sketch.Circle2.visible = true
	sketch.Circle1.visible = true
	
sketch.notification_icon.on Events.Click, ->
	sketch.notification_icon.backgroundColor = "#fff"
	for sibling in sketch.notification_icon.siblings
		sibling.backgroundColor = "transparent"
	showViewContent(sketch.notificationContent,"up")
	hideViewContent(sketch.message)
	hideViewContent(sketch.homeContent)
	notification_alert.visible = false
	hideMenuOptions()
	
sketch.homeicon.on Events.Click, ->
	sketch.homeicon.backgroundColor = "#fff"
	for sibling in sketch.homeicon.siblings
		sibling.backgroundColor = "transparent"
	showViewContent(sketch.homeContent,"up")
	hideViewContent(sketch.message)
	hideViewContent(sketch.notificationContent)
	showMenuOptions()
	
sketch.chat_icon.on Events.Click, ->
	sketch.chat_icon.backgroundColor = "#fff"
	for sibling in sketch.chat_icon.siblings
		sibling.backgroundColor = "transparent"
	showViewContent(sketch.message,"up")
	hideViewContent(sketch.homeContent)
	hideViewContent(sketch.notificationContent)
	hideMenuOptions()
	

# Everything related to the Notification Screen
class Notification extends Layer
	toggle=1
	
	activate: ->
		@opacity = 0.7
		this.toggle = 1
		
	deactivate: ->
		@opacity = 1
		this.toggle = 0
		
	constructor: (opts) ->
		super opts
		
		@superLayer = sketch.notificationContent1 
		@width =  512
		@height = 200
		@backgroundColor = "#fff"
		@borderWidth = 1
		@borderColor = "rgba(128,128,128,1)"
		@deactivate()
		
		notifNew = new Layer
			superLayer: this
			width: 30
			height: 30
			borderRadius: 100
			backgroundColor: "red"
			x: 36
			y: 27
			visible: false
		
		if opts.newFlag
			notifNew.visible = true
			
		notifTitle = new Layer
			superLayer: this
			width: 282
			height: 90
			html: opts.title
			x: 94
			y: 5
			style: {
				paddingTop: "25px",
				color: "#000",
				fontFamily: "Lato",
				fontSize: "45px",
				fontWeight: "500",
				textAlign : "left",
				backgroundColor: "transparent"
			}
			
		notifService = new Layer
			superLayer: this
			width: 282
			height: 90
			html: opts.servicename
			x: 94		
			y: 60
			style: {
				paddingTop: "25px",
				color: "#999",
				fontFamily: "Lato",
				fontSize: "45px",
				fontWeight: "500",
				textAlign : "left",
				backgroundColor: "transparent"
			}
		
		notifTime = new Layer
			superLayer: this
			width: 446
			height: 95
			html: opts.time
			x: 94
			y: 124
			style: {
				paddingTop: "25px",
				color: "#999",
				fontFamily: "Proxima Nova",
				fontSize: "35px",
				fontWeight: "500",
				textAlign : "left",
				backgroundColor: "transparent"
			}
			
		@on Events.Click, () ->
			##if this layer has been clicked, change toggle to 1
			if this.toggle == 0
				for sibling in this.siblings
					sibling.deactivate()
				@activate()
				notifNew.visible = false
			else
				@deactivate()
				
selectAll = new Layer
	superLayer: sketch.notificationDetail
	width: 200
	height: 100
	x: 40
	y: 300
	html: "SELECT ALL"
	style: statusLabel
	backgroundColor: "transparent"
	
selectAllToggle = 0
selectAll.on Events.Click, () ->
	if selectAllToggle == 0 
		for child in sketch.superAgents.children
			child.activate()
		selectAllToggle = 1
		selectAll.html = "CLEAR ALL"
	else
		for child in sketch.superAgents.children
			child.deactivate()
		selectAllToggle = 0
		selectAll.html = "SELECT ALL"

assignButton = new Layer
	superLayer: sketch.notificationDetail
	width: 200
	height: 100
	x: 1170
	y: 300
	html: "ASSIGN"
	style: statusLabel
	backgroundColor: "transparent"
	
confirmationModal = new Layer
	width: 560
	height: 384
	x: 800
	y: 500
	image: "images/Notification.png"
	visible: false
confirmationModal.placeBefore(assignButton)

confirmationButton = new Layer
	superLayer: confirmationModal
	opacity:1
	width: 550
	height: 100
	y: 270
	x: 10
	backgroundColor: "transparent"
	
###	
confirmationText = new Layer
	superLayer: confirmationModal
	width: 500
	height: 400
	x: 60
	y: 50
	html: "You have assigned agents to Service A"
	style: statusLabel
	backgroundColor: "transparent"
###
assignButton.on Events.Click, () -> 
	menuBackground.states.switch "Onboard", delay: 0.04
	confirmationModal.visible = true
	confirmationButton.on Events.Click, () ->
		confirmationModal.visible = false
		menuBackground.states.switch "Home", delay: 0.04
			
notifRef = firebase.get "/notifications",(notifs) ->
	notifArray =  _.toArray(notifs) 
	length = notifArray.length
	for notif in notifArray
		ser = new Notification
			name: notif.title
			title: notif.title
			serviceid: notif.serviceid
			servicename: notif.servicename
			time: notif.time
			message: notif.message
			newFlag: notif.newFlag
		ser.x = 0
		ser.y = (200)*(notif.id-1)

###
agentFlag = 0
agentsRef = firebase.get "/notifagents",(agents) ->
	agentsArray = _.toArray(agents)
	length = agentsArray
	for agent in agentsArray
		name = agent.name
		ag = new Agent
			name: agent.name
			parent: sketch.superAgents
			currentcall: agent.currentcall
			status: agent.status
		ag.width = 700
		ag.x = 0
		ag.y = (ag.height)*(agent.id-1)
###

# Everything related to the Agents
class Agent extends Layer
	sketch.agentAction.opacity = 0
	sketch.agentActionDropdownServices.opacity = 0
	sketch.phone_in_talk.opacity = 0

	toggle=1
	
	activate: ->
		@shadowBlur = 20
		this.toggle = 1
		
	deactivate: ->
		@shadowBlye = 0
		this.toggle = 0
		
	constructor: (opts)->
		super opts
		
		@width= 672
		@height=192
		@x = 1110
		@superLayer = sketch.agentContent
		@style = label
		@borderWidth = 1
		@borderColor = "rgba(128,128,128,1)"
		@backgroundColor = "#FFFDFA"
		@deactivate()
				
		usernameField = new Layer
			superLayer: this
			width: 500
			height: 110
			y: 29
			html: opts.name
			style: label
			x: 151
			backgroundColor: "transparent"
	
		min = Math.ceil(opts.currentcall/60)
		sec = Math.ceil(opts.currentcall % 60)
		if Math.floor(sec/10) == 0
			sec = '0'+sec
			
		if min > 8
			agentval.color = "red"
		else 
			agentval.color = "black"
			
		longestCallVal = new Layer
			superLayer: this
			width: 152
			height: 78
			y: 31
			html: min + ":" + sec
			style: agentval
			x: 407
			backgroundColor: "transparent"
		
		ProgressBar = new Layer 
			superLayer: this
			width: 400
			height: 50
			originX: 35
			originY: 410
			backgroundColor:'transparent'
			image: "images/Listen-in widget_play.png"
			x: 151
			y: 125
			
		ProgressBar_pause = new Layer
			superLayer: this
			width: 400
			height: 50
			originX: 35
			originY: 410
			backgroundColor:'transparent'
			image: "images/Listen-in widget_pause.png"
			x: 151
			y: 125
			opacity: 0
		
		listenIn_click = new Layer
			superLayer: this
			width: 60
			height: 50
			originX: 35
			originY: 410
			x: 151
			y: 134
			backgroundColor:'transparent'
							
		Shape = new Layer
			superLayer: this 
			width: 96
			height: 96
			image: "images/Shape.png"
			x: 30
			y: 43
		
		status = new Layer
			superLayer: this
			x: 155
			y: 70
			html: opts.status
			style: statusLabel
			width: 185
			height: 45
			backgroundColor: "transparent"

		totalcurrentcall = opts.currentcall
		if status.html == "busy"
			currentCalltimer = Utils.interval 1, -> 
				totalcurrentcall = totalcurrentcall + 1
				min = Math.floor(totalcurrentcall/60)
				sec = totalcurrentcall % 60
				if sec == 60
					min = min + 1
					sec = 0
				else
					if Math.floor(sec/10) == 0
						sec = '0' + sec
				if min > 8
					longestCallVal.color = "red"
					
				longestCallVal.html =  min + ":" + sec
				
				if totalcurrentcall > 1000
					clearInterval (currentCalltimer)

		possibleActions = new Layer
			superLayer: this
			x: 0
			y: 192
			width: 672
			height: 192
			image: "images/agentAction.png"
			backgroundColor: "transparent"
			opacity: 0
			
			
		actionDisplay = new Layer
			superLayer: possibleActions
			y: 192
			x: 0
			width: 672
			height: 384
			opacity: 0 
			image: "images/agentActionDropdownServices.png"
			
		agentClick = 0
		@on Events.Click, () ->
			if agentClick == 0 
				possibleActions.opacity = 1
				actionDisplay.opacity = 1
				agentClick = 1
				for sibling in this.siblings
					if sibling.index > this.index
						sibling.y = sibling.y + 576
			else
				for sibling in this.siblings
					if sibling.index > this.index
						sibling.y = sibling.y - 576
				possibleActions.opacity = 0
				actionDisplay.opacity = 0
				agentClick = 0
					

		###ProgressBar_pause.states.add
			agentInfoOn:
				#ProgressBar_pause.placeBefore(this)
				opacity: 1
				visible: true
			agentInfoOff:
				opacity: 0
				visible: false	
			
		listenIn_click.on Events.Click, ->
			ProgressBar_pause.states.switch "agentInfoOn"
	
		listenIn_click.on Events.Click, ->
			ProgressBar_pause.states.switch "agentInfoOff"###

agentNames = []
agentsRef = firebase.get "/agents",(agents) ->
	agentsArray = _.toArray(agents)
	length = agentsArray
	for agent in agentsArray
		name = agent.name
		ag = new Agent
			name: agent.name
			parent: sketch.agentContent
			currentcall: agent.currentcall
			status: agent.status
			#dropdown1: this.dropdown1
			#dropdown2: this.dropdown2
		ag.x = 0
		ag.y = (ag.height)*(agent.id-1)


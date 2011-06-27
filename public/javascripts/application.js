// Setup the Flow [University Web] Namespace
var Flow = Flow || new Object();

Flow.setupNamespace = function(namespace){
	if(Flow[namespace] == undefined)
		Flow[namespace] = {}
}

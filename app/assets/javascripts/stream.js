// Setup the Stream Namespace
var Stream = Stream || new Object();

Stream.setupNamespace = function(namespace){
	if(Stream[namespace] == undefined)
		Stream[namespace] = {}
}

s.options.numBuffers = 1026*2;
s.options.memSize = (512*1024);
s.options.numOutputBusChannels = 16;
o = Server.local.options;
o.device = "JackRouter";
s.waitForBoot {
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
	~dirt.loadSoundFiles("/Users/morganvisnesky/Library/Application Support/SuperCollider/downloaded-quarks/Dirt-Samples/*");   // load samples (path containing a wildcard can be passed in)
	~dirt.start(57120, [0,2]);   // start listening on port 57120, create N busses each sending audio to channel 0
	MIDIClient.init;
	//MIDIClient.destinations;
	~midiOut = MIDIOut.newByName("IAC Driver", "Bus 1"); // substitute your own device here
	~midiOut.latency = 0.0;
	~dirt.soundLibrary.addMIDI(\midi, ~midiOut);
};

//Quarks.gui
//~midiOut = MIDIOut.newByName("Scarlett 2i4 USB", "Scarlett 2i4 USB");
//~midiOut.latency = 0.0;




//https://github.com/jackaudio/jackaudio.github.com/releases/download/1.9.11/JackOSX.0.92_b3.zip .
// correct version of jack for macosx

// DO NOT USE THIS AS YOUR STARTUP.SCD FILE.
// NOTE: Before changing any of the settings manually and executing them (without using code from this in your startup sequence)
// Be sure to execute ("shift-enter") SuperDirt.start, certain lines of code will not work unless this has been executed first.

// first, initialize your midi device.
(
MIDIClient.init;
MIDIClient.list;
// to check, which are there, you can query them
)

// create a midi out connection
~midiOut = MIDIOut.newByName("Scarlett 2i4 USB","Scarlett 2i4 USB");
// substitute your own device here
 // you may want to adjust the latency here
~midiOut.latency = 0.8;
// define one instrument called "midi" (you may call it what you like)
// it uses the built in event type "midi" (this is predefined).
~dirt.soundLibrary.addMIDI(\midi, ~midiOut);
// note: parameter names may change in the future!


// DigitalOhms audio and midi Setup
s.options.numBuffers = 1026*2;
s.options.memSize = (512*1024);
s.options.device = "Soundflower (64ch)";
s.options.numOutputBusChannels = 16;
//s.options.maxLogins = 50;
s.waitForBoot {
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
	~dirt.loadSoundFiles("/Users/morgantics/samples/*");   // load samples (path containing a wildcard can be passed in)
	// for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
	s.sync; // wait for samples to be read
	~dirt.start(57120, [0,2,4,6,8,10,12,14]);   // start listening on port 57120, create N busses each sending audio to channel 0
	MIDIClient.init;
	//MIDIClient.destinations;
	~midiOut = MIDIOut.newByName("IAC Driver", "Bus 1"); // substitute your own device here
	~midiOut.latency = 0.0;
	~dirt.soundLibrary.addMIDI(\midi, ~midiOut); // for this command to work superdirt has to have been started already hence it being in the waitforboot{} block
};



SuperDirt.start

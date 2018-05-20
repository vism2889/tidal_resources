ServerOptions.outDevices

o = Server.local.options;
o.device = "Scarlett 2i4 USB"
SuperDirt.start


MIDIClient.init;

~midiOut = MIDIOut.newByName("Scarlett 2i4 USB", "Scarlett 2i4 USB");
~midiOut.latency = 0.0;
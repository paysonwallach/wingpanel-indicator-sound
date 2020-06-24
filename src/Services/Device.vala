public class Sound.Services.Device : Object {
    public class Port {
        public string name;
        public string description;
        public uint32 priority;
    }

    public signal void removed ();

    public bool input { get; set; default = true; }
    public string id { get; construct; }
    public string card_name { get; set; }
    public uint32 card_index { get; construct; }
    public string port_name { get; construct; }
    public string display_name { get; set; }
    public string form_factor { get; set; }
    public Gee.ArrayList<string> profiles { get; set; }
    public string card_active_profile_name { get; set; }

    public string? sink_name { get; set; }
    public int sink_index { get; set; }
    public string? card_sink_name { get; set; }
    public string? card_sink_port_name { get; set; }
    public int card_sink_index { get; set; }

    public string? source_name { get; set; }
    public int source_index { get; set; }
    public string? card_source_name { get; set; }
    public string? card_source_port_name { get; set; }
    public int card_source_index { get; set; }

    public bool is_default { get; set; default = false; }
    public bool is_muted { get; set; default = false; }
    public PulseAudio.CVolume cvolume { get; set; }
    public double volume { get; set; default = 0; }
    public float balance { get; set; default = 0; }
    public PulseAudio.ChannelMap channel_map { get; set; }
    public Gee.LinkedList<PulseAudio.Operation> volume_operations;

    public Device (string id, uint32 card_index, string port_name) {
        Object (id: id, card_index: card_index, port_name: port_name);
    }

    construct {
        volume_operations = new Gee.LinkedList<PulseAudio.Operation> ();
        profiles = new Gee.ArrayList<string> ();
    }

    public string? get_matching_profile (Device other_device) {
        foreach (var profile in profiles) {
            if (other_device.profiles.contains (profile))
                return profile;
        }

        return null;
    }
}

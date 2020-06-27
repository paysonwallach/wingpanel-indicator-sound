public class Sound.Widgets.DeviceListMenuItem : Wingpanel.Widgets.Container {
    private DeviceListType device_list_type;
    private Gtk.Label device_list_label;
    private Gtk.Label default_device_label;
    private Gtk.Revealer device_list_revealer;
    private Sound.Services.PulseAudioManager pam;
    private string label;
    private string list_label;

    public DeviceListMenuItem (
        Gtk.Revealer device_list_revealer, Gtk.ListBox list, DeviceListType device_list_type,
        string label, string list_label, Sound.Services.PulseAudioManager pam
    ) {
        this.device_list_revealer = device_list_revealer;
        this.device_list_type = device_list_type;
        this.pam = pam;
        this.label = label;
        this.list_label = list_label;

        var device_list_container = get_content_widget ();
        var device_list_label_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

        device_list_label = new Gtk.Label (label);
        default_device_label = new Gtk.Label (
            (device_list_type == DeviceListType.INPUT ?
                pam.default_input : pam.default_output).display_name);

        device_list_label_box.pack_start (device_list_label, false);
        device_list_label_box.pack_start (default_device_label, false);

        device_list_label.get_style_context ()
            .add_class (Granite.STYLE_CLASS_H4_LABEL);

        device_list_revealer.set_reveal_child (false);

        this.clicked.connect (() => { this.toggle_visible (); });

        list.activate_on_single_click = true;
        list.row_activated.connect ((menuitem) => {
            pam.set_default_device.begin (((Sound.Widgets.DeviceMenuItem) menuitem).device);
        });

        var scrolled_box = new Gtk.ScrolledWindow (null, null);

        scrolled_box.hscrollbar_policy = Gtk.PolicyType.NEVER;
        scrolled_box.max_content_height = 512;
        scrolled_box.propagate_natural_height = true;
        scrolled_box.add (list);

        device_list_revealer.add (scrolled_box);

        device_list_container.margin_start = 6;
        device_list_container.margin_end = 6;
        device_list_container.attach (device_list_label_box, 0, 0);
    }

    public bool is_visible () {
        return device_list_revealer.reveal_child;
    }

    public void toggle_visible () {
        device_list_revealer.set_reveal_child (!device_list_revealer.reveal_child);

        if (device_list_revealer.reveal_child) {
            device_list_label.set_label (list_label);
            default_device_label.set_label ("");
        } else {
            device_list_label.set_label (label);
            default_device_label.set_label (
                (device_list_type == DeviceListType.INPUT ?
                    pam.default_input : pam.default_output).display_name);
        }
    }
}

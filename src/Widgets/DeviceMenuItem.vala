public class Sound.Widgets.DeviceMenuItem : Gtk.ListBoxRow {
    public signal void set_as_default ();

    public Sound.Services.Device device { get; construct; }
    private Gtk.Label name_label;
    private Gtk.RadioButton activate_radio;
    private bool ignore_default = false;

    public DeviceMenuItem (Sound.Services.Device device) {
        Object (device: device);
    }

    public void link_to_menuitem (DeviceMenuItem menuitem) {
        activate_radio.join_group (menuitem.activate_radio);
        activate_radio.active = device.is_default;
    }

    construct {
        var grid = new Gtk.Grid ();
        grid.margin = 6;
        grid.column_spacing = 12;
        grid.orientation = Gtk.Orientation.HORIZONTAL;

        name_label = new Gtk.Label (device.display_name);
        name_label.hexpand = true;
        name_label.xalign = 0;

        activate_radio = new Gtk.RadioButton (null);

        grid.add (activate_radio);
        grid.add (name_label);

        add (grid);
        get_style_context ().add_class ("menuitem");

        activate.connect (() => {
            activate_radio.active = true;
        });
        activate_radio.toggled.connect (() => {
            if (activate_radio.active && !ignore_default)
                set_as_default ();
        });

        device.bind_property ("display-name", name_label, "label");
        device.removed.connect (() => destroy ());
        device.notify["is-default"].connect (() => {
            ignore_default = true;
            activate_radio.active = device.is_default;
            ignore_default = false;
        });
    }

    public void link_to_row (DeviceMenuItem row) {
        activate_radio.join_group (row.activate_radio);
        activate_radio.active = device.is_default;
    }
}

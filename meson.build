project(
    'sound',
    'vala', 'c',
    version: '2.1.8'
)

gettext_name = meson.project_name() + '-indicator'
gnome = import('gnome')
i18n = import('i18n')

prefix = get_option('prefix')
datadir = join_paths(prefix, get_option('datadir'))
libdir = join_paths(prefix, get_option('libdir'))

wingpanel_dep = dependency('wingpanel-2.0', version: '>=2.1.0')
wingpanel_indicatorsdir = wingpanel_dep.get_pkgconfig_variable('indicatorsdir', define_variable: ['libdir', libdir]

asresources = gnome.compile_resources(
    'as-resources', 'data/mask.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

add_project_arguments([
    '-DG_LOG_DOMAIN="@0@"'.format(meson.project_name())
    '-DGETTEXT_PACKAGE="@0@"'.format(gettext_name),
  ],
  language:'c'
)

add_project_arguments(
    ['--vapidir', join_paths(meson.current_source_dir(), 'vapi')],
    language: 'vala'
)

shared_module(
    meson.project_name(),
    'src/Indicator.vala',
    'src/Widgets/DeviceListMenuItem.vala',
    'src/Widgets/DeviceMenuItem.vala',
    'src/Widgets/DisplayWidget.vala',
    'src/Widgets/Scale.vala',
    'src/Widgets/PlayerRow.vala',
    'src/Widgets/PlayerList.vala',
    'src/Services/MprisClient.vala',
    'src/Services/VolumeControl.vala',
    'src/Services/Manager.vala',
    'src/Services/BluezDevice.vala',
    'src/Services/MediaPlayer.vala',
    'src/Services/PulseAudioManager.vala',
    asresources,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        dependency('libpulse'),
        dependency('libpulse-mainloop-glib'),
        dependency('libnotify'),
        dependency('libcanberra'),
        dependency('libcanberra-gtk3'),
        meson.get_compiler('vala').find_library('libpulse-ext', dirs: join_paths(meson.source_root(), 'vapi')),
        wingpanel_dep
    ],
    install: true,
    install_dir : wingpanel_indicatorsdir,
)

subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')

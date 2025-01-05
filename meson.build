project(
  'libvazzy',
  ['c', 'vala'],
  version: '1.5',
  meson_version: '>= 1.0.0',
  license: 'GPL-3.0-or-later',
)

api_version = '1'
glib_min_version = '2.76'

name = 'vazzy'
gir_name = 'Vazzy'

versioned_name = name + '-' + api_version
versioned_lib_name = meson.project_name() + '-' + api_version
versioned_gir_name = gir_name + '-' + api_version

deps_name = versioned_lib_name + '.deps'
header_name = versioned_lib_name + '.h'
vapi_name = versioned_lib_name + '.vapi'
gir_name = versioned_gir_name + '.gir'
typelib_name = versioned_gir_name + '.typelib'

pkgconfig = import('pkgconfig')
gnome = import('gnome')

deps_pkgs = [
  'gee-0.8',
]

gee_dep = dependency('gee-0.8')

dependencies = [
  gee_dep,
]

gee_girdir = gee_dep.get_variable('datadir') / 'gir-1.0'

add_project_arguments(
  '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
  # GCC14 COMPILE ERROR
  '-Wno-int-conversion',
  language: ['c'],
)

add_project_arguments(
  '--abi-stability',
  '--hide-internal',
  '--target-glib', glib_min_version,
  '--vapidir', meson.current_source_dir(),
  language: ['vala'],
)

subdir('lib')
subdir('tests')

if get_option('documentation')
  subdir('doc')
endif

gnome.post_install()

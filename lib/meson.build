vapi_sources = files(
  
)

vala_sources = files(
  'main.vala',
)

libvazzy_sources = [
  vapi_sources,
  vala_sources,
]

libvazzy = shared_library(
  'alt-repo',
  libvazzy_sources,
  dependencies: libvazzy_dependencies,
  vala_header: libvazzy_header,
  vala_vapi: libvazzy_vapi,
  vala_gir: libvazzy_gir,
  version: meson.project_version(),
  install: true,
  install_dir: [ true, true, true, true ],
)

libvazzy_dep = declare_dependency(
  link_with: libvazzy,
  include_directories: include_directories('.'),
  dependencies: libvazzy_dependencies
)

deps_conf = configuration_data()
deps_conf.set ('DEPS',  '\n'.join (deps_pkgs))

configure_file(
  input: 'libvazzy.deps.in',
  output: libvazzy_deps,
  configuration: deps_conf,
  install: true,
  install_dir: get_option('datadir') / 'vala' / 'vapi',
)

if get_option('introspection')
  g_ir_compiler = find_program('g-ir-compiler')
  custom_target(
    'typelib',
    command: [
      g_ir_compiler,
      '--shared-library', '@PLAINNAME@',
      '--output', '@OUTPUT@',
      '--includedir', gee_girdir,
      meson.current_build_dir() / libvazzy_gir,
    ],
    input: libvazzy,
    output: libvazzy_typelib,
    depends: libvazzy,
    install: true,
    install_dir: get_option('libdir') / 'girepository-1.0',
  )
endif

pkgconfig.generate(
  libvazzy,
  name: versioned_name,
  requires: libvazzy_dependencies,
  subdirs: [ versioned_name ],
  description: 'Base objects for API libraries',
  version: meson.project_version(),
  url: 'https://github.com/Rirusha/libvazzy',
)

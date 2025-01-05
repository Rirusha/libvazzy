%define _unpackaged_files_terminate_build 1

%define api_version 1
%define glib2_ver 2.74
%define gir_name Vazzy-%api_version

Name: libvazzy-%api_version
Version: @LAST@
Release: alt1

Summary: Library for Vala with fuzzy search functions
License: GPL-3.0-or-later
Group: System/Libraries
Url: https://github.com/Rirusha/libvazzy
VCS: https://github.com/Rirusha/libvazzy.git

Source0: %name-%version.tar

BuildRequires(pre): rpm-macros-meson rpm-build-vala rpm-build-gir
BuildRequires: meson
BuildRequires: vala
BuildRequires: pkgconfig(glib-2.0) >= %glib2_ver
BuildRequires: pkgconfig(gee-0.8)
BuildRequires: gobject-introspection-devel

%description
Library for Vala with fuzzy search functions

Currently, the library contains:
- Damerau-Levenstein distance

%package devel
Group: Development/C
Summary: Development files for %name

Requires: %name = %EVR

%description devel
%summary.

%package devel-vala
Summary: Development vapi files for %name
Group: System/Libraries
BuildArch: noarch

Requires: %name = %EVR

%description devel-vala
%summary.

%package gir
Summary: Typelib files for %name
Group: System/Libraries

Requires: %name = %EVR

%description gir
%summary.

%package gir-devel
Summary: Development gir files for %name for various bindings
Group: Development/Other
BuildArch: noarch

Requires: %name = %EVR

%description gir-devel
%summary.

%prep
%setup

%build
%meson
%meson_build

%install
%meson_install

%check
%meson_test

%files
%_libdir/%name.so.*
%doc README.md

%files devel
%_libdir/%name.so
%_includedir/%name.h
%_pkgconfigdir/%name.pc

%files devel-vala
%_vapidir/%name.vapi
%_vapidir/%name.deps

%files gir
%_typelibdir/%gir_name.typelib

%files gir-devel
%_girdir/%gir_name.gir

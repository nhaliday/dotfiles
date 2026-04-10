# Oils development shell — Fish equivalent of build/dev-shell.sh.
# Usage: oils-dev-shell

function oils-dev-shell
    set -l oils_root ~/Documents/src/oils
    set -l deps_root ~/Documents/src/oils.DEPS

    set -l _MYPY_VERSION 0.780
    set -l _PY3_LIBS_VERSION 2023-03-04
    set -l _SITE_PACKAGES lib/python3.10/site-packages

    # PATH
    if test -d $deps_root/bin
        fish_add_path $deps_root/bin
    end

    # PYTHONPATH
    set -gx PYTHONPATH $oils_root

    set -l wedge_dir $deps_root/wedge

    set -l py3_libs $wedge_dir/py3-libs/$_PY3_LIBS_VERSION/$_SITE_PACKAGES
    if test -d $py3_libs
        set -gx PYTHONPATH $py3_libs $PYTHONPATH
    end

    set -l mypy_wedge $wedge_dir/mypy/$_MYPY_VERSION
    if test -d $mypy_wedge
        set -gx PYTHONPATH $mypy_wedge $PYTHONPATH
    end

    # R_LIBS_USER
    if test -d $wedge_dir/R-libs
        set -gx R_LIBS_USER $wedge_dir/R-libs/2023-04-18
    end
end

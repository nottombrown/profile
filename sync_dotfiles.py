import sys, os, os.path, shutil

# Key is name in home directory (path_name); value is name in dotfiles
# directory (target_name).  If target_name is None, it is
# automatically filled in by stripping off the dot and adding the
# prefix specified below.
DOTFILES = {
    '.emacs': None,
    '.emacs.d/modes': None,
    '.emacs.d/themes': None,
    '.emacs.d/color-theme.el': None,
    '.fluxbox': None,
    '.ssh/config': None,
    '.ssh/authorized_keys': None,
    '.ssh/id_rsa.pub': None,
    '.js': None,
    '.gitignore_global': None,
    '.gitconfig': None,
    '.git-meld.pl': None,
    '.bashrc': None,
    '.Xdefaults': None,
}

prefix = '_'
debug = '--debug' in sys.argv[1:] or '-d' in sys.argv[1:]
testrun = '--test' in sys.argv[1:] or '-t' in sys.argv[1:]
force = '--force' in sys.argv[1:] or '-f' in sys.argv[1:]
home = os.path.abspath(os.path.expanduser('~/'))
dotfiledir = os.path.abspath(os.path.dirname(os.path.realpath(__file__))+'/dotfiles')

if debug:
    print 'Home:\t'+home
    print 'Dotfiles:\t'+dotfiledir
    print

# With inspiration from
# https://github.com/jbernard/dotfiles/blob/develop/dotfiles/core.py

def create_link(target, path):
    path_dir = os.path.dirname(path)
    if not os.path.lexists(path_dir):
        os.makedirs(path_dir)
    os.symlink(target, path)

error = False
for path_name, target_name in DOTFILES.items():
    result = None
    if target_name is None:
        target_name = prefix + path_name.lstrip('.')

    path = path_name
    if not path.startswith('/'):
        path = os.path.abspath(home + '/' + path_name)
    target = os.path.abspath(dotfiledir + '/' + target_name)

    if debug:
        print '\tPath:\t'+path
        print '\tTarget:\t'+target

    if not os.path.lexists(target):
        status = 'DOTFILE NOT FOUND'
        error = True
    elif not os.path.lexists(path):
        status = 'missing'
        if not testrun:
            create_link(target, path)
            result = 'synced'
    elif os.path.realpath(path) != os.path.realpath(target):
        status = 'unmanaged'
        if not testrun:
            if not force:
                result = 'skipping'
            else:
                if os.path.isdir(path) and not os.path.islink(path):
                    shutil.rmtree(path)
                else:
                    os.remove(path)
                create_link(target, path)
                result = 'removed; synced'
    else:
        status = 'ok'

    if result is None:
        print '{0} -> {1}'.format(path_name, status)
    else:
        print '{0} -> {1} ... {2}'.format(path_name, status, result)

sys.exit(1 if error else 0)

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from pathlib import Path
import os
import io
import shutil
import jinja2
from subprocess import check_call

env = jinja2.Environment(
    loader=jinja2.FileSystemLoader('template')
)

CLOCK_NAMES = '''
simple
colors
colors2
'''.split()


def generate_flowlist():
    template = env.get_template('flowlist.html')

    clocks = []
    for clock_name in CLOCK_NAMES:
        clocks.append(dict(
            url = '/clocks/{}/clock.html'.format(clock_name)
        ))

    context = dict(clocks=clocks)

    with open('output/flowlist.html', 'w') as fp:
        fp.write(template.render(context))


# def generate_index(): for clock in clocks: clock_dir = Path('clocks') / clock



def main():
    check_call('mkdir -p output; rm -rf output/*', shell=True)
    for clock_name in CLOCK_NAMES:
        src = Path('clocks') / clock_name
        output = Path('output') / 'clocks' / clock_name
        shutil.copytree(str(src), str(output))

        coffee = src / 'coffee'
        js = output / 'js'

        coffee_scripts = list(coffee.glob('*.coffee'))
        if coffee_scripts:
            if not js.exists():
                js.mkdir()
            check_call(['coffee', '-c', '-o', str(js)] + list(map(str, coffee_scripts)))

    Path('output/css').symlink_to('../css', True)
    Path('output/js').symlink_to('../js', True)
    generate_flowlist()


if __name__ == '__main__':
    main()

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
simple2
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
        shutil.copytree(
            'clocks/{}'.format(clock_name),
            'output/clocks/{}'.format(clock_name)
        )
    generate_flowlist()


if __name__ == '__main__':
    main()

import subprocess
import time
import argparse


def downshift(minutes=90, end_temp=2500):
    steps = (6500 - end_temp) / 100
    intvl = (minutes * 60) / steps
    current_temp = 6500
    while current_temp > end_temp:
        current_temp -= 100
        subprocess.run(['sct', str(current_temp)])
        print('Temp:', current_temp, end='\r')
        time.sleep(intvl)
    print('\n\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(prog='downshift')
    parser.add_argument('minutes', type=float, default=90, nargs='?',
                    help='time over which to shift color temperature; default 90')
    parser.add_argument('end_temp', type=int, default=2500, nargs='?',
                    help='Ending color temperature, from 1000-6500; default 2500')
    args = parser.parse_args()

    downshift(args.minutes, args.end_temp)


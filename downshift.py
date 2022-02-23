import sys
import subprocess
import time


def downshift(minutes=90, end_temp=2500):
    steps = (6500 - end_temp) / 100
    intvl = (minutes * 60) / steps
    current_temp = 6500
    while current_temp > end_temp:
        current_temp -= 100
        subprocess.run(['sct', str(current_temp)])
        time.sleep(intvl)


if __name__ == '__main__':
    if len(sys.argv) == 1:
        downshift()
    elif len(sys.argv) == 2:
        downshift(float(sys.argv[1]))
    elif len(sys.argv) == 3:
        downshift(float(sys.argv[1]), float(sys.argv[2]))
    else:
        print('usage: python downshift.py [MINUTES] [END TEMP]')


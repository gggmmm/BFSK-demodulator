# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2014-2018, Lars Asplund lars.anders.asplund@gmail.com
import sys
sys.path.append("/local/home/s1873164/vunit")
import vunit
from os.path import join, dirname
from vunit import VUnit
from itertools import product

def generate_tests(obj, packets_range, ebn_range):
    """
    Generate test by varying the size generic
    """

    for packet, ebn in product(packets_range, ebn_range):
        directory = "/local/home/s1873164/modelsim/vunit_tb_demodultor/stimuli/STIMULI_TB_COMPLETE_SYS_q"+str(packet)+"j"+str(ebn)+".txt"
        ss = len(directory)
    
        # This configuration name is added as a suffix to the test bench name
        config_name = "packet_num=%i,ebn_num=%i,ss=%i" % (packet, ebn, ss)

        # Add the configuration with a post check function to verify the output
        obj.add_config(
                        name=config_name,
                        generics=dict(
                            packet_num=packet,
                            ebn_num=ebn,
                            string_size=ss
                        )
                      )

root = dirname(__file__)

ui = VUnit.from_argv()
lib = ui.add_library("lib")
lib.add_source_files(join(root, "*.vhdl"))
lib.add_source_files(join(root, "data_acquisition", "*.vhdl"))
lib.add_source_files(join(root, "data_detection", "*.vhdl"))
lib.add_source_files(join(root, "demodulator", "*.vhdl"))
# lib.add_source_files(join(root, "demodulator", "*.vho"))
lib.add_source_files(join(root, "fft_zp", "*.vhdl"))
lib.add_source_files(join(root, "goertzel", "*.vhdl"))
lib.add_source_files(join(root, "IP", "*.vhd"))
lib.add_source_files(join(root, "preamble_detector", "*.vhdl"))
tb_dir = join(root, "demodulator", "tb", "vunit_tb")
lib.add_source_files(join(tb_dir, "*.vhdl"))

tb_sum_of_square = lib.test_bench("tb_dem_vunit")

for test in tb_sum_of_square.get_tests():
    # whe nusing range(x,y) the output is a list between x and y with y EXCLUDED
    generate_tests(test, range(1,10+1), range(1,14+1)) # PACKET | EBN 


ui.main()

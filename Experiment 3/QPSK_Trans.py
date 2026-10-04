#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#
# SPDX-License-Identifier: GPL-3.0
#
# GNU Radio Python Flow Graph
# Title: Group 1
# Author: harsh
# GNU Radio version: 3.10.12.0

from PyQt5 import Qt
from gnuradio import qtgui
from PyQt5 import QtCore
from gnuradio import blocks
from gnuradio import digital
from gnuradio import gr
from gnuradio.filter import firdes
from gnuradio.fft import window
import sys
import signal
from PyQt5 import Qt
from argparse import ArgumentParser
from gnuradio.eng_arg import eng_float, intx
from gnuradio import eng_notation
from gnuradio import iio
import threading



class QPSK_Trans(gr.top_block, Qt.QWidget):

    def __init__(self):
        gr.top_block.__init__(self, "Group 1", catch_exceptions=True)
        Qt.QWidget.__init__(self)
        self.setWindowTitle("Group 1")
        qtgui.util.check_set_qss()
        try:
            self.setWindowIcon(Qt.QIcon.fromTheme('gnuradio-grc'))
        except BaseException as exc:
            print(f"Qt GUI: Could not set Icon: {str(exc)}", file=sys.stderr)
        self.top_scroll_layout = Qt.QVBoxLayout()
        self.setLayout(self.top_scroll_layout)
        self.top_scroll = Qt.QScrollArea()
        self.top_scroll.setFrameStyle(Qt.QFrame.NoFrame)
        self.top_scroll_layout.addWidget(self.top_scroll)
        self.top_scroll.setWidgetResizable(True)
        self.top_widget = Qt.QWidget()
        self.top_scroll.setWidget(self.top_widget)
        self.top_layout = Qt.QVBoxLayout(self.top_widget)
        self.top_grid_layout = Qt.QGridLayout()
        self.top_layout.addLayout(self.top_grid_layout)

        self.settings = Qt.QSettings("gnuradio/flowgraphs", "QPSK_Trans")

        try:
            geometry = self.settings.value("geometry")
            if geometry:
                self.restoreGeometry(geometry)
        except BaseException as exc:
            print(f"Qt GUI: Could not restore geometry: {str(exc)}", file=sys.stderr)
        self.flowgraph_started = threading.Event()

        ##################################################
        # Variables
        ##################################################
        self.constellation_pts = constellation_pts = (0,0.5,1,1.5,2)
        self.variable_constellation = variable_constellation = digital.constellation_calcdist(constellation_pts, [0, 1, 2,3,4],
        4, 1, digital.constellation.AMPLITUDE_NORMALIZATION).base()
        self.variable_constellation.set_npwr(1.0)
        self.tx_attenuation = tx_attenuation = 10
        self.transmit_signal_freq = transmit_signal_freq = 40000
        self.symbols = symbols = [-1-1j, -1+1j, 1+1j, 1-1j]
        self.sps = sps = 100
        self.samp_rate = samp_rate = 1000000
        self.rx_gain = rx_gain = 40
        self.center_freq = center_freq = 915000000

        ##################################################
        # Blocks
        ##################################################

        self._tx_attenuation_range = qtgui.Range(0, 89, 1, 10, 200)
        self._tx_attenuation_win = qtgui.RangeWidget(self._tx_attenuation_range, self.set_tx_attenuation, "'tx_attenuation'", "counter_slider", float, QtCore.Qt.Horizontal)
        self.top_layout.addWidget(self._tx_attenuation_win)
        self._transmit_signal_freq_range = qtgui.Range(-100000, 100000, 1, 40000, 200)
        self._transmit_signal_freq_win = qtgui.RangeWidget(self._transmit_signal_freq_range, self.set_transmit_signal_freq, "'transmit_signal_freq'", "counter_slider", float, QtCore.Qt.Horizontal)
        self.top_layout.addWidget(self._transmit_signal_freq_win)
        self._rx_gain_range = qtgui.Range(0, 70, 1, 40, 200)
        self._rx_gain_win = qtgui.RangeWidget(self._rx_gain_range, self.set_rx_gain, "'rx_gain'", "counter_slider", float, QtCore.Qt.Horizontal)
        self.top_layout.addWidget(self._rx_gain_win)
        self.iio_pluto_sink_0_0 = iio.fmcomms2_sink_fc32('192.168.99.1' if '192.168.99.1' else iio.get_pluto_uri(), [True, True], 32768, False)
        self.iio_pluto_sink_0_0.set_len_tag_key('')
        self.iio_pluto_sink_0_0.set_bandwidth(int(samp_rate))
        self.iio_pluto_sink_0_0.set_frequency(int(center_freq))
        self.iio_pluto_sink_0_0.set_samplerate(int(samp_rate))
        self.iio_pluto_sink_0_0.set_attenuation(0, tx_attenuation)
        self.iio_pluto_sink_0_0.set_filter_params('Auto', '', 0, 0)
        self.digital_chunks_to_symbols_xx_0 = digital.chunks_to_symbols_bc(symbols, 1)
        self.blocks_vector_source_x_0 = blocks.vector_source_b([0,1,2,3,0,3,0,3], True, 1, [])
        self.blocks_repeat_0 = blocks.repeat(gr.sizeof_gr_complex*1, sps)


        ##################################################
        # Connections
        ##################################################
        self.connect((self.blocks_repeat_0, 0), (self.iio_pluto_sink_0_0, 0))
        self.connect((self.blocks_vector_source_x_0, 0), (self.digital_chunks_to_symbols_xx_0, 0))
        self.connect((self.digital_chunks_to_symbols_xx_0, 0), (self.blocks_repeat_0, 0))


    def closeEvent(self, event):
        self.settings = Qt.QSettings("gnuradio/flowgraphs", "QPSK_Trans")
        self.settings.setValue("geometry", self.saveGeometry())
        self.stop()
        self.wait()

        event.accept()

    def get_constellation_pts(self):
        return self.constellation_pts

    def set_constellation_pts(self, constellation_pts):
        self.constellation_pts = constellation_pts

    def get_variable_constellation(self):
        return self.variable_constellation

    def set_variable_constellation(self, variable_constellation):
        self.variable_constellation = variable_constellation

    def get_tx_attenuation(self):
        return self.tx_attenuation

    def set_tx_attenuation(self, tx_attenuation):
        self.tx_attenuation = tx_attenuation
        self.iio_pluto_sink_0_0.set_attenuation(0,self.tx_attenuation)

    def get_transmit_signal_freq(self):
        return self.transmit_signal_freq

    def set_transmit_signal_freq(self, transmit_signal_freq):
        self.transmit_signal_freq = transmit_signal_freq

    def get_symbols(self):
        return self.symbols

    def set_symbols(self, symbols):
        self.symbols = symbols
        self.digital_chunks_to_symbols_xx_0.set_symbol_table(self.symbols)

    def get_sps(self):
        return self.sps

    def set_sps(self, sps):
        self.sps = sps
        self.blocks_repeat_0.set_interpolation(self.sps)

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate
        self.iio_pluto_sink_0_0.set_bandwidth(int(self.samp_rate))
        self.iio_pluto_sink_0_0.set_samplerate(int(self.samp_rate))

    def get_rx_gain(self):
        return self.rx_gain

    def set_rx_gain(self, rx_gain):
        self.rx_gain = rx_gain

    def get_center_freq(self):
        return self.center_freq

    def set_center_freq(self, center_freq):
        self.center_freq = center_freq
        self.iio_pluto_sink_0_0.set_frequency(int(self.center_freq))




def main(top_block_cls=QPSK_Trans, options=None):

    qapp = Qt.QApplication(sys.argv)

    tb = top_block_cls()

    tb.start()
    tb.flowgraph_started.set()

    tb.show()

    def sig_handler(sig=None, frame=None):
        tb.stop()
        tb.wait()

        Qt.QApplication.quit()

    signal.signal(signal.SIGINT, sig_handler)
    signal.signal(signal.SIGTERM, sig_handler)

    timer = Qt.QTimer()
    timer.start(500)
    timer.timeout.connect(lambda: None)

    qapp.exec_()

if __name__ == '__main__':
    main()

fid = fopen('j20_rx.bin');
if fid < 0
  printf("[ERROR] j20_rx.bin does not exist in working directory - run opencpi app on target hardware and copy over j20_rx.bin to this directory before running this script")
  exit(1)
end
tmp = fread(fid, 'int16');
fclose(fid);
iq = tmp(1:2:end) + 1i*tmp(2:2:end);
graphics_toolkit('gnuplot')
figure
subplot(2,1,1)
plot(real(iq(1:512)))
%hold on
%plot(imag(iq(1:512)), 'r')
legend('I')%, 'Q')
xlabel('Sample No')
ylabel('Amplitude')
title('Time Domain Plot of j20\_rx')
subplot(2,1,2)
fs = 90; % in kHz
plot(0:fs/512:fs*511/512,abs(fft(iq(1:512))))
xlabel('Freq (kHz)')
ylabel('Amplitude')
title('FFT of j20\_rx')
set(gca,'xtick',0:5:fs)

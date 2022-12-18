import librosa, librosa.display
import numpy as np
import matplotlib.pyplot as plt
import sys

if(sys.argv[1] == "" ):
    print("NO INPUT FILE")
    print("USAGE: ")
    print("     sys.argv[1] = filename")
    print("     sys.argv[2] = [wave/spectrogram]")


signal, sr = librosa.load(sys.argv[1])

if(sys.argv[2]== "wave"):
    librosa.display.waveshow(signal, sr=sr)
    plt.title('Waveplot', fontdict=dict(size=18))
    plt.xlabel('Time', fontdict=dict(size=15))
    plt.ylabel('Amplitude', fontdict=dict(size=15))
    #plt.xlim(0, 1)
    plt.show()
elif(sys.argv[2]== "spectrogram"):
    audio_stft = np.abs(librosa.core.stft(signal, hop_length=512, n_fft=2048))                      # Valor absolut de la STFT
    log_spectro = librosa.amplitude_to_db(audio_stft)                                               # Log de la
    plt.figure(figsize=(10,5))
    librosa.display.specshow(log_spectro, sr=sr, x_axis='time',y_axis='hz', hop_length=512, cmap='magma')
    plt.colorbar(label='Decibels')
    plt.title('Spectrogram (amp)', fontdict=dict(size=15))
    plt.xlabel('Time', fontdict=dict(size=15))
    plt.ylabel('Frequency', fontdict=dict(size=15))
    plt.ylim(0, 8000)
    #plt.xlim(0, 0.5)
    plt.show()


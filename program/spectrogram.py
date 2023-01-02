import librosa, librosa.display
import numpy as np
import matplotlib.pyplot as plt
import sys
import matplotlib.ticker as ticker
import matplotlib.font_manager



#plt.rc('font', **{'family': 'serif', 'serif': ['Computer Modern']})

#hfont = {'fontname':'Helvetica'}
#csfont = {'fontname':'Comic Sans MS'}

if(sys.argv[1] == "" ):
    print("NO INPUT FILE")
    print("USAGE: ")
    print("     sys.argv[1] = filename")
    print("     sys.argv[2] = [wave/spectrogram]")


signal, sr = librosa.load(sys.argv[1])

if(sys.argv[2]== "wave"):
    fig,ax=plt.subplots()
    tickspacing = 1
    #fig.set_size_inches(600,600)

    librosa.display.waveshow(signal, sr=sr, color='blue')
    plt.title('Waveplot',fontsize=12)
    plt.xlabel('Time',fontsize=10)   
    plt.ylabel('Amplitude', fontsize=10)
    #plt.xlim(0, 1)
    ax.xaxis.set_minor_locator(ticker.MultipleLocator(0.1)) 
    ax.xaxis.set_major_locator(ticker.MultipleLocator(1)) 
    ax.yaxis.set_minor_locator(ticker.MultipleLocator(0.05)) 
    ax.yaxis.set_major_locator(ticker.MultipleLocator(0.25)) 

    plt.axvspan(0, 1.5, facecolor='c', alpha=0.15)
    plt.axvspan(1.5,2.3, facecolor='m', alpha=0.15)
    plt.axvspan(2.3, 7.6, facecolor='c', alpha=0.15)
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


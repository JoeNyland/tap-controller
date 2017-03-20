# Tap Controller

A PICAXE program in BASIC for my "tap controller" project which I built for A Level Systems and Control at [Lymm 6th Form College](http://www.lymmhigh6thform.org.uk).

I had to produce a model of a device that helped people with a physical disability in some way. The device I produced helped people run a bath by presetting a temperature that they wanted the water to be, then the device would open the taps and maintain the temperature of the water flowing out of the tap using a thermistor to keep to the requested water temperature. This meant that a user could run a bath without running the risk of scalding themselves if the water was too hot, but also made sure (as best as it could) that the water did not run cold.

Obviously, this is purely a model of the device, showing the two taps either side and it provides sound confirmation and an LED confirmation of the selected temperature.

###### Update 16/10/2015
I recently found this model whilst clearing out at home.

At the time of making this device (when I was working on my A Levels back in 2007-2009), the device was fully programmed, apart from the ability to detect the water temperature and adjust the taps accordingly. I no longer have access to the source code of the program that I wrote at that time, therefore I had to completely rewrite the program for the model, back up to the level of functionality that I left it in back in 2009. Hence, this repo was thrown together to store it for safe keeping.

Now I have the program for this model completely rewritten, I decided that I would add the remaining functionality to the program. Now, this device is fully functional!

### Demo
![Demo gif](assets/demo.gif)

### Installation

macOS:
```
brew cask install caskroom/drivers/ftdi-vcp-driver
brew cask install picaxe-compilers
```

### I/O
The following outlines which I/O pins are used for which component on the PCB.

###### Inputs
<table>
    <tr>
        <td>0</td><td>Thermistor</td>
    </tr>
    <tr>
        <td>1</td><td>Potentiometer</td>
    </tr>
    <tr>
        <td>2</td><td>N/A</td>
    </tr>
    <tr>
        <td>6</td><td>"Stop Filling" button</td>
    </tr>
    <tr>
        <td>7</td><td>"Start Filling" button</td>
    </tr>
</table>

###### Outputs
<table>
    <tr>
        <td>0</td><td>Red LED</td>
    </tr>
    <tr>
        <td>1</td><td>Amber LED</td>
    </tr>
    <tr>
        <td>2</td><td>Blue LED</td>
    </tr>
    <tr>
        <td>3</td><td>Piezo</td>
    </tr>
    <tr>
        <td>4</td><td>"Hot Tap" servo</td>
    </tr>
    <tr>
        <td>5</td><td>"Cold Tap" servo</td>
    </tr>
    <tr>
        <td>6</td><td>N/A</td>
    </tr>
    <tr>
        <td>7</td><td>N/A</td>
    </tr>
</table>

### Pinout
![Pinout of a PICAXE18a chip](assets/pinout.png)

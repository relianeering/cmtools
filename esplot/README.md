# sE Spectrum Plot

## Dependecies
- [gnuplot](http://www.gnuplot.info)

## Usage
To run
```sh
./esplot  [-r <rpm>] [-s <startF>] [-e <endF>] FILENAME
```
- `<rpm>` - the speed of the shat in rpm (default 60)
- `<startF>` - start frequency (default 0)
- `<endF>` - start frequency (default 500)
- `FILENAME` - CM Point export from ReSES.net platfrom (`.env` format)

A PDF file will be created for each input file.

For example:
```sh
./esplot -r 333.0 -s 10 -e 1000 *.vel
```
Reads all `.env` files in the directory and generates polar plots in PDF format using the parameters.

Use the file data333.env to test the tool.
```sh
./esplot -r 333.0 -s 0 -e 200 data333.env
```

![Example of bearing fault](./esplot_screenshot.png)

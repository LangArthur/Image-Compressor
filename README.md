# Image-Compressor

Haskell Image Compressor

### Prerequisites

To use these Image Compressor, you need to install stack : https://docs.haskellstack.org/en/stable/README/.

### Installing

First, run make

```
make
```

And launch application

There are two versions of my Image Compressor.

Final image compressor : 
    
```
./CompresseIt path n
```

path : path to the image to convert
n : number of color in the final image


ImageCompressor for Epitech Projet : 
```
./imageCompressor n e IN
```
       
n : number of color in the final image
e : convergence limit
IN : path to the file containing the colors of the pixel

Annexe about file Grammar : 

IN ::= POINT COLOR ( ’\n ’ POINT COLOR ) *
POINT ::= ’( ’ int ’,’ int ’) ’
COLOR ::= ’( ’ SHORT ’,’ SHORT ’,’ SHORT ’) ’
SHORT ::= ’0 ’.. ’255 ’


## Running the tests

For running all tests, use the make tests_run command
```
make tests_run
```

WARNING !
By default, tests will be open in firefox window.
If you don't have firefox on your computer, you can modifiy the Makefile command l.29 (It will be correct in futur version)

## Built With

* [Stack](https://docs.haskellstack.org/en/stable/README/) - The Haskell Tool Stack

## Authors

* **Arthur LANG** - *Initial work* - [LangArthur](https://github.com/LangArthur)

See also the list of [contributors](https://github.com/LangArthur/Image-Compressor/graphs/contributors) who participated in this project
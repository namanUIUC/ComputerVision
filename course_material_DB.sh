#!bin/bash

# Teminal Text Color Scheme
TEXT_RESET='\e[0m'

TEXT_BLACK='\e[0;30m'
TEXT_RED='\e[0;31m'
TEXT_GREEN='\e[0;32m'
TEXT_YELLOW='\e[0;33m'
TEXT_BLUE='\e[0;34m'
TEXT_PURPLE='\e[0;35m'
TEXT_CYAN='\e[0;36m'
TEXT_WHITE='\e[0;37m'

BTEXT_BLACK='\e[1;30m'
BTEXT_RED='\e[1;31m'
BTEXT_GREEN='\e[1;32m'
BTEXT_YELLOW='\e[1;33m'
BTEXT_BLUE='\e[1;34m'
BTEXT_PURPLE='\e[1;35m'
BTEXT_CYAN='\e[1;36m'
BTEXT_WHITE='\e[1;37m'

echo -e $BTEXT_CYAN
echo "COMPUTER VISION @ UIUC - Database"
echo -e $TEXT_RESET "Refer to http://slazebni.cs.illinois.edu/spring18/"
echo 'Instructor: Svetlana Lazebnik  (slazebni -at- illinois.edu)'
echo 'Prerequisites: Basic knowledge of probability, linear algebra, and calculus. 
MATLAB programming experience and previous exposure to image processing are highly desirable.'
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -                                                       
# --------------------------------------------------------------------------------------------------------

download_zip() {
    echo -e $TEXT_YELLOW
    echo 'connecting server..'
    echo -e $TEXT_RESET
    wget $1 -O dataset.zip
    unzip dataset.zip
    rm dataset.zip
    echo -e $TEXT_YELLOW
    echo 'download finished!'
    echo -e $TEXT_RESET
}


(
 echo -e $BTEXT_BLUE
 printf 'ID\tTOPIC\tSIZE'
 echo -e $TEXT_RESET
 printf '%s\t%s\t%s\n' "1" "Introduction" "51.5 (MB)"
 printf '%s\t%s\t%s\n' "2" "Perspective Projection" "14.1 (MB)"
 printf '%s\t%s\t%s\n' "3" "Cameras" "21.2 (MB)"
 printf '%s\t%s\t%s\n' "4" "Light and Shading" "19.0 (MB)"
 printf '%s\t%s\t%s\n' "5" "Color" "22.1 (MB)"
 printf '%s\t%s\t%s\n' "6" "Linear Filtering" "10.0 (MB)"
 printf '%s\t%s\t%s\n' "7" "Edge Detection" "11.4 (MB)"
 printf '%s\t%s\t%s\n' "8" "Corner Detection" "13.4 (MB)"
 printf '%s\t%s\t%s\n' "9" "SIFT" "26.3 (MB)"
 printf '%s\t%s\t%s\n' "10" "Optical Flow" "8.80 (MB)"
 printf '%s\t%s\t%s\n' "11" "Fitting" "4.60 (MB)"
 printf '%s\t%s\t%s\n' "12" "Hough Transform" "7.00 (MB)"
 printf '%s\t%s\t%s\n' "13" "Alignment" "23.9 (MB)"
 printf '%s\t%s\t%s\n' "14" "Caliberation" "10.5 (MB)"
 printf '%s\t%s\t%s\n' "15" "Single View Modeling" "29.5 (MB)"
 printf '%s\t%s\t%s\n' "16" "Epipolar Geometry" "9.00 (MB)"
 printf '%s\t%s\t%s\n' "17" "Binocular Sterio" "34.1 (MB)"
 printf '%s\t%s\t%s\n' "18" "Multiview Sterio" "35.7 (MB)"
 printf '%s\t%s\t%s\n' "19" "Structure from Motion" "14.2 (MB)"
 printf '%s\t%s\t%s\n' "20" "Intro to Recognition" "23.5 (MB)"
 printf '%s\t%s\t%s\n' "21" "Deep Learning" "992 (MB)"
 printf '%s\t%s\t%s\n' "22" "Detection" "39.8 (MB)"
 printf '%s\t%s\t%s\n' "23" "Segementaion" "22.8 (MB)"
 printf '%s\t%s\t%s\n' "24" "CNN" "55.1 (MB)"
 printf '%s\t%s\t%s\n' "25" "full course material" "1.50 (GB)"
 
) | column -t -s $'\t'


echo -e $TEXT_GREEN
echo 'Enter the lecture ID to download : '
echo -e $TEXT_RESET
read opt

case $opt in
    1)
        download_zip 'https://drive.google.com/uc?export=download&id=1-3lblPHAFDNl4vIRxQMrBCUCXVjQM7Xh'
        ;;    
    2)
        download_zip 'https://drive.google.com/uc?export=download&id=1mxYJWLDP91IdxP3eFL9d503Z35Ali5u_'
        ;;
    3)
        download_zip 'https://drive.google.com/uc?export=download&id=1QDL7rWkIJyAK3r4AcPGWiDFuMGAc5mtl'
        ;;
    4)
        download_zip 'https://drive.google.com/uc?export=download&id=1eZLCP2wKHXGOdpiqjLS5oC4FsJhup2jx'
        ;;
    5)
        download_zip 'https://drive.google.com/uc?export=download&id=1-BKmI62g8usVsHQcShnDw5flTgDVP9PC'
        ;;
    6)
        download_zip 'https://drive.google.com/uc?export=download&id=1jCR-iMikymkP-tswDUk5HHS3sM-fi-Nd'
        ;;
    7)
        download_zip 'https://drive.google.com/uc?export=download&id=1kTdCX_8TbsjjR8JZ04AbJJHWvWc2k9at'
        ;;
    8)
        download_zip 'https://drive.google.com/uc?export=download&id=1Pb2oJD8uX4OUWdKgwYgYZUCTw__qRMMu'
        ;;
    9)
        download_zip 'https://drive.google.com/uc?export=download&id=16RlssgmnajN9OuXMwBUb_fbiyER_Hofm'
        ;;
    10)
        download_zip 'https://drive.google.com/uc?export=download&id=1o3EwfKyg6tzTiQE5MWxW2RN-JWGldSvm'
        ;;
    11)
        download_zip 'https://drive.google.com/uc?export=download&id=1ELJeaD2Gf7DELZFlPW0j1oiv0OyH6kY5'
        ;;
    12)
        download_zip 'https://drive.google.com/uc?export=download&id=1zSWyq508_DL33o8n7qaQfRCmlvlfEVa4'
        ;;
    13)
        download_zip 'https://drive.google.com/uc?export=download&id=1aaPEppCczSu5RE9BFufmw6l6tDDafrb1'
        ;;
    14)
        download_zip 'https://drive.google.com/uc?export=download&id=1mNCSZMe5J9LwyMAEJM5MwbHLsViLrSkY'
        ;;
    15)
        download_zip 'https://drive.google.com/uc?export=download&id=1Si7K78Ev7-mPa4o-Y-0GR5CFIw7bpcmg'
        ;;
    16)
        download_zip 'https://drive.google.com/uc?export=download&id=1v4aGWl1ZiOUEt6ePRx3YYKCbS5mdwiop'
        ;;
    17)
        download_zip 'https://drive.google.com/uc?export=download&id=1e47qQJC7NZC6mh9ROlp2iLwP826OF_H5'
        ;;
    18)
        download_zip 'https://drive.google.com/uc?export=download&id=1X9Z-pUAif_y35pwc368oRWTLmgvyeTw2'
        ;;
    19)
        download_zip 'https://drive.google.com/uc?export=download&id=16epWrxGVJc5xyJI44BoKDRtJWe7PyBKI'
        ;;
    20)
        download_zip 'https://drive.google.com/uc?export=download&id=1ZT1nEgnk6cI6yDDivYPR7Yqj7spV0eYN'
        ;;
    21)
        download_zip 'https://drive.google.com/uc?export=download&id=13-J82M5c-dECrQj_iQQMO2dGZZB3IrLc'
        ;;
    22)
        download_zip 'https://drive.google.com/uc?export=download&id=1Gukh2AfWq0gR2clqZrwJWmQOD7bcr-QL'
        ;;
    23)
        download_zip 'https://drive.google.com/uc?export=download&id=1WjnAELzvhFHIWhkMuC-zX4tfB3HCoTIS'
        ;;
    24)
        download_zip 'https://drive.google.com/uc?export=download&id=1TitqMD4CsHtvK3Envygp6PvZC1f_x0ux'
        ;;
    25)
        download_zip 'https://drive.google.com/uc?export=download&id=16WTp85PcpOkKk2-VFhS32ALnyyt-NOR-'
        ;;
    
    *) echo "invalid option";;
esac
# Example for building a lite system
echo "IMG_NAME='Actioncam'" > config
touch ./stage3/SKIP ./stage4/SKIP ./stage5/SKIP
touch ./stage4/SKIP_IMAGES ./stage5/SKIP_IMAGES
sudo ./build.sh  # or ./build-docker.sh

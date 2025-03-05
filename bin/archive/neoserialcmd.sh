
if [ -z $neolib ]; then
  neolib="$PWD/../neolib"
fi

if [ ! -d "$neolib" ]; then
  echo "Error: Execute this script from within /pancam/hardware/neoscripts"
  exit 1;
fi

if [ ! -d "$neolib/$buildversion/cmdLine" ]; then
  echo "Error: Command line util directory not found, run ./buildnow.sh from your neolib directory!"
  exit 1;
fi


#delay after executing command before switching back to customusb
DELAY=1 

MODULE=-1

#delay after switching USB to serial before 

if [[ $# == 0 ]]; then
  printf "example 1) run command 't jaunt status' on phyiscal module 2, with 1 \n"
  printf "second delay after sending command before switching back to customusb:\n\n"
  printf "$ neoserialcmd.sh -m 2 \"t jaunt status\"\n\n\n"

  printf "example 2) run command 't jaunt status' on phyiscal module 4, with 2 \n"
  printf "second delay after sending command before switching back to customusb:\n\n"
  printf "$ neoserialcmd.sh --module 4 --delay 2 \"t jaunt status\"\n\n\n"

  printf "example 3) run command 't jaunt mode mov' on physical module 1 with \n"
  printf "an 8 second delay after sending command before switching back to customusb:\n\n"
  printf "$ neoserialcmd.sh -m 1 -d 8 \"t jaunt mode mov\"\n\n\n"
  exit 1
fi

while [[ $# > 1 ]]; do
  key="$1"
  case $key in
      -m|--module)
      MODULE="$2"
      shift 
      ;;
      -d|--delay)
      DELAY="$2"
      shift
      ;;
      *)
      # unknown option
      ;;
  esac
  shift
done

COMMAND=$1

if [ "$MODULE" == "-1" ]; then
  echo "need to specify module with '-m X'"
  exit 1;
fi

devicenumber=`printf "%02d" $MODULE`

if [ "$MODULE" == "1" ]; then
  rolename=Mas1
else
  rolename=Sla1
fi

callupname=/dev/cu.usbmodem$devicenumber$rolename


set -e # enable auto exit of script on SwitchUsb command error 
$neolib/build/cmdLine/SwitchUsb serial $MODULE 1

# wait for callup device to appear
while [[ ! -e "$callupname" ]];
do
    sleep 1;
done;
sleep 1;



echo -ne "$COMMAND\n" > $callupname

sleep $DELAY

echo -ne 't jaunt customusbstart\n' > $callupname 

if [ "$MODULE" == "1" ]; then
  echo " allow custom USB to reappear before moving to subsequent commands"
  sleep 5
fi


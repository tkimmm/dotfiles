
# Check if flux is running
if ! pgrep -f "Flux" > /dev/null 2>&1; then
    echo "disabled"
    exit 0
fi

# Get current flux color temperature (this is an approximation)
# Flux doesn't provide easy CLI access, so we'll estimate based on time
current_hour=$(date +%H)
current_minute=$(date +%M)
current_time=$((current_hour * 100 + current_minute))

# Approximate flux schedule (adjust these times based on your settings)
sunrise=700   # 7:00 AM
sunset=1900   # 7:00 PM

if [ $current_time -ge $sunrise ] && [ $current_time -lt $sunset ]; then
    echo "day"
elif [ $current_time -ge $((sunset - 100)) ] && [ $current_time -lt $((sunset + 100)) ]; then
    echo "transition"
else
    echo "night"
fi
EOF

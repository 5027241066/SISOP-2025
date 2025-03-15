#!/bin/bash

# Fungsi untuk menampilkan help screen (F)
show_help() {
    echo "=================================================="
    echo "                     POKEMON"
    echo "=================================================="
    echo "Usage: ./pokemon_analysis.sh <input_file> <option> [arguments]"
    echo ""
    echo "Options:"
    echo "  --info               : Show summary of Pokemon usage (Usage% and RawUsage)"
    echo "  --sort <column>      : Sort Pokemon by column (usage, rawusage, name, hp, atk, def, spatk, spdef, speed)"
    echo "  --grep <name>        : Search Pokemon by name"
    echo "  --filter <type>      : Filter Pokemon by type (e.g., Dark, Fire)"
    echo "  -h, --help           : Show this help screen"
    echo ""
    echo "Examples:"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --info"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --sort usage"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --grep Rotom"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --filter Dark"
    echo "=================================================="
}

# Fungsi untuk menampilkan summary (A)
show_summary() {
    input_file=$1

    # Cek apakah file ada
    if [[ ! -f "$input_file" ]]; then
        echo "Error: File '$input_file' not found!"
        exit 1
    fi

    # Menentukan Pokémon dengan Usage% tertinggi
    highest_usage=$(sed 1d "$input_file" | awk -F',' 'BEGIN {max=0} {if ($2+0 > max) {max=$2+0; name=$1}} END {print name, max"%"}')

    # Menentukan Pokémon dengan Raw Usage tertinggi
    highest_raw=$(sed 1d "$input_file" | awk -F',' 'BEGIN {max=0} {if ($3+0 > max) {max=$3+0; name=$1}} END {print name, max" uses"}')

    # Output
    echo "📊 Summary of $input_file"
    echo "🔥 Highest Adjusted Usage: $highest_usage"
    echo "⚔  Highest Raw Usage: $highest_raw"
}

# Fungsi untuk mengurutkan Pokemon (B)
sort_pokemon() {
    input_file=$1
    sort_by=$2

    case $sort_by in
        "usage")
            sort -t, -k2,2nr "$input_file"
            ;;
        "rawusage")
            sort -t, -k3,3nr "$input_file"
            ;;
        "name")
            sort -t, -k1,1 "$input_file"
            ;;
        "hp")
            sort -t, -k6,6nr "$input_file"
            ;;
        "atk")
            sort -t, -k7,7nr "$input_file"
            ;;
        "def")
            sort -t, -k8,8nr "$input_file"
            ;;
        "spatk")
            sort -t, -k9,9nr "$input_file"
            ;;
        "spdef")
            sort -t, -k10,10nr "$input_file"
            ;;
        "speed")
            sort -t, -k11,11nr "$input_file"
            ;;
        *)
            echo "Error: Invalid sort option"
            echo "Use -h or --help for more information"
            exit 1
            ;;
    esac
}

# Fungsi untuk mencari Pokemon berdasarkan nama (C)
search_pokemon() {
    input_file=$1
    search_term=$2

    grep -i "$search_term" "$input_file" | sort -t, -k2,2nr
}

# Fungsi untuk memfilter Pokemon berdasarkan type (D)
filter_by_type() {
    input_file=$1
    filter_type=$2

    awk -F, -v type="$filter_type" 'NR>1 && ($4 == type || $5 == type)' "$input_file" | sort -t, -k2,2nr
}

# Main script
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <pokemon_usage.csv> <option> [arguments]"
    echo "Use -h or --help for more information."
    exit 1
fi

# Cek opsi -h atau --help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

# Cek jumlah argumen
if [[ $# -lt 2 ]]; then
    echo "Error: Insufficient arguments"
    show_help
    exit 1
fi

input_file=$1
option=$2

# Cek apakah file ada
if [[ ! -f "$input_file" ]]; then
    echo "Error: File '$input_file' not found!"
    exit 1
fi

if [ "$option" == "--info" ]; then
    show_summary "$input_file"
elif [ "$option" == "--sort" ]; then
    if [ $# -lt 3 ]; then
        echo "Error: No sort option provided"
        show_help
        exit 1
    fi
    echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
    sort_pokemon "$input_file" "$3"
elif [ "$option" == "--grep" ]; then
    if [ $# -lt 3 ]; then
        echo "Error: No search term provided"
        show_help
        exit 1
    fi
    echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
    search_pokemon "$input_file" "$3"
elif [ "$option" == "--filter" ]; then
    if [ $# -lt 3 ]; then
        echo "Error: No filter option provided"
        show_help
        exit 1
    fi
    echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
    filter_by_type "$input_file" "$3"
else
    echo "Error: Invalid option '$option'. Use -h or --help for more information."
    show_help
    exit 1
fi

for i in {1..6} 
do
    echo ============ PROBLEMA $i ============
    ../fast_downward/fast-downward.py --alias seq-opt-lmcut --plan-file ./outputs/salida-problema-$i.txt ./domain.pddl ./problems/problema-$i.pddl
    echo ==================================
    echo
    echo
    echo
    echo
done
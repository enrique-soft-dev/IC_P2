echo Select a problem to run:
read i
../fast_downward/fast-downward.py --alias seq-opt-lmcut --sas-file ./outputs/sas-problema-$i.txt --plan-file ./sas/salida-problema-$i.txt ./domain.pddl ./problems/problema-$i.pddl
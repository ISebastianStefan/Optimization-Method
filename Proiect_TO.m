otelproblema = optimproblem;%optimproblem= creaza o problema de optimizare
% cu proprietatile implcitite
% variabilele lingoului sunt întregi și sunt binare, deoarece există doar 
% una din fiecare lingou disponibilă
%optimvar=pentru a crea o variabila binara;creează o variabilă de optimizare scalară. 
% O variabilă de optimizare este un obiect simbolic care ne permite să 
% cream expresii pentru funcția obiectivă și constrângerile problemei în ceea ce privește variabila.
lingouri = optimvar('lingouri',4,'Type','integer','LowerBound',0,'UpperBound',1);
%celelalte varibile sunt nonegative
aliaje = optimvar('aliaje',3,'LowerBound',0); %varibilele pozitive au doar limita inferioara
resturi = optimvar('resturi','LowerBound',0);
% Cream expresii pentru costurile asociate variabilelor.
greutatea_lingourilor = [5,3,4,6];
pretul_lingourilor = greutatea_lingourilor.*[350,330,310,280];
pretul_aliajelor = [500,450,400];
pretul_resturilor = 100;
pret = pretul_lingourilor*lingouri + pretul_aliajelor*aliaje + pretul_resturilor*resturi;
% Includem costul ca funcție obiectivă în problemă.
otelproblema.Objective = pret;
% Problema are trei constrângeri de egalitate. 
% Prima constrângere este că greutatea totală este de 25 de tone. 
% Calculam greutatea oțelului.
greutatea_totala = greutatea_lingourilor*lingouri + sum(aliaje) + resturi;
% A doua constrângere este că greutatea carbonului este de 5% din 25 de tone, sau 1,25 tone. 
% Calculam greutatea carbonului din oțel.
lingou_de_carbon = [5,4,5,3]/100;
aliaj_de_carbon = [8,7,6]/100;
rest_de_carbon = 3/100;
carbonul_total = (greutatea_lingourilor.*lingou_de_carbon)*lingouri + aliaj_de_carbon*aliaje + rest_de_carbon*resturi;
% A treia constrângere este că greutatea molibdenului este de 1,25 tone. 
% Calculam greutatea molibdenului în oțel.
lingou_de_molyb = [3,3,4,4]/100;
aliaj_de_molyb = [6,7,8]/100;
rest_de_molyb = 9/100;
totalul_molybului = (greutatea_lingourilor.*lingou_de_molyb)*lingouri + aliaj_de_molyb*aliaje + rest_de_molyb*resturi;
% Includem constrângerile în problemă.
otelproblema.Constraints.consgr = greutatea_totala == 25;
otelproblema.Constraints.conscarb = carbonul_total == 1.25;
otelproblema.Constraints.consmolyb = totalul_molybului == 1.25;
Tabelullingourilor=table(greutatea_lingourilor,pretul_lingourilor,lingou_de_carbon,lingou_de_molyb)
Tabelulaliajelor=table(pretul_aliajelor,aliaj_de_carbon,aliaj_de_molyb)
Tabelulresturilor=table(pretul_resturilor,rest_de_carbon,rest_de_molyb)
showproblem(otelproblema)
% Acum că avem toate intrările, apelam soluția
[sol,fval] = solve(otelproblema); %solve-rezolva problema de optimizare sau problema ecuației
sol.lingouri %sol-variabila de tip struct
sol.aliaje
sol.resturi
fval %fval-este o variabilă de tip double
clear; clc; close all;
load('provinces');

prov_norm = zscore(provinces);

diss = squareform(pdist(prov_norm));

names = {'South Holland', 'North Holland', 'Utrecht', 'Limburg', 'North Brabant', 'Gelderland', 'Overijssel', 'Flevoland', 'Groningen', 'Zeeland', 'Friesland', 'Drenthe'};

g = find(strcmp('Groningen',names));

[v, i] = sort(diss(:,g))
i(2)

most_similar_value = v(2);
most_similar = names(i(2))

[v, i] = sort(diss(:,g), 'descend')
i(1)

most_dissimilar_value = v(1);
most_dissimilar = names(i(1))

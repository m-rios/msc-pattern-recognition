clear;clc;

keySet = {'Anti-aging', 'Customers', 'Fun', 'Groningen', 'Lecture', 'Money', 'Vacation', 'Viagra', 'Watches'};
valueSet = {[0.00062	0.000000035],[0.005	0.0001],[0.00015	0.0007],[0.00001	0.001],[0.000015	0.0008],[0.002	0.0005],[0.00025	0.00014],[0.001	0.0000003],[0.0003	0.000004]};

spamPrior = 0.9;
nospamPrior = 0.1;

spam = @(x) x(1);
nospam = @(x) x(2);

db = containers.Map(keySet, valueSet);

q1 = (spam(db('Customers')) * spam(db('Watches')) * spamPrior)/(nospam(db('Customers')) * nospam(db('Watches')) * nospamPrior);
isSpam = q1 > 1

q2 = (spam(db('Fun')) * spam(db('Vacation')) * spamPrior)/(nospam(db('Fun')) * nospam(db('Vacation')) * nospamPrior);
isSpam2 = q2 > 1
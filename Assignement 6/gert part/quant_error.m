function [ J ] = quant_error( X, ps)
ds = pdist2(X, ps);
m_ds = min(ds, [], 2);

J = 0.5 * sum(m_ds);
end
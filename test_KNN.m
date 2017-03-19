function c_rate = test_KNN(td, tl, ttd, ttl)
for i= 1:1:2
    [c_rate(i),~,~,~ ] = KNN(td, tl, ttd, ttl, i);
end
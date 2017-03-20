function a = Normal(mu, sigma, sigma_1, X)
assert(size(mu)*[0, 1]' == 1, 'Input mu wrong!');
assert(size(mu)*[1, 0]' > 1, 'Input mu wrong!');
assert(size(sigma)*[1,1]' == size(sigma_1)*[1,1]', 'Input sigma wrong!');
assert(size(sigma)*[1,0]' > 1, 'Input sigma wrong!');
assert(size(X)*[0, 1]' == 1, 'Input X error!');
assert(size(X)*[1, 0]' > 1, 'Input X error!');
%a = (1/sqrt(2*pi*det(sigma)) * exp(-1/2*(X-mu)'*sigma_1*(X-mu)));
a = log(1/sqrt(2*pi*det(sigma))) + (-1/2*(X-mu)'*sigma_1*(X-mu));
function [ probs ] = init_probs(labels ,p)
% INITIALIZE_PROBABILITIES Initialize relaxation labeling .
% PROBS = INITIALIZE_PROBABILITIES ( LABELS , P ) Initialize the
% probability values for relaxation labeling . LABELS is an
% indexed image holding region labels . P is the probability
% that should initially be assigned to the given labels .
% PROBS is a three dimension array of size
% SIZE ( LABELS ) x NUMBER_OF_LABELS , holding the initial
% probabilities for every label .

% get a list of all labels
labelList  = listLabels(labels);
num_labels = size(labelList,2);

% PROBS = PIC SIZE(+FRAME) x NUMBER_OF_LABELS
probs = zeros(size(labels,1),size(labels,2),num_labels);
q = 1-p;

IDXlist    = 1;
% iterate through all valid labels [1,3,4,...]
for IDXlab = labelList
    probs(:,:,IDXlist) = labels==IDXlab;
    probs(:,:,IDXlist) = probs(:,:,IDXlist)*(p-q);
    IDXlist = IDXlist +1;
end

probs = probs + q;

% We have
% sum(sum(initial_prob(:,:,4) == 0.8)) IS 0 so there are empty labels!
% and 
% sum(sum(initial_prob(:,:,2) == 0.8)) IS 6 so it works
% Try to assign 3rd dim only if necessary


end
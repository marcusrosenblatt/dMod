# Define some parameter names
parameters <- c("A", "B", "k1", "k2")
# Define a covariate table
covtable <- data.frame(dose = c(1, 1, 10), 
                       inhibitor = c("no", "inh", "no"), 
                       row.names = c("Low_noInh", "Low_Inh", "High_noInh"))

# Start with an empty transformation
trans <- NULL

# Generate the identity transformation for parameters
trans <- define(trans, "x ~ x", x = parameters); print(trans)

# Insert exp(x) wherever you find x
trans <- insert(trans, "x ~ exp(x)", x = parameters); print(trans)

# Some new expressions instead of k1 and k2
trans <- insert(trans, "x ~ y", x = c("k1", "k2"), y = c("q1 + q2", "q1 - q2")); print(trans)

# Define some parameters as 0
trans <- define(trans, "x ~ 0", x = "B"); print(trans)

# The parameter name can also be directly used in the formula
trans <- insert(trans, "q1 ~ Q"); print(trans)

# Replicate the transformation 3 times with the rownames of covtable as list names
trans <- branch(trans, table = covtable); print(trans)

# Insert the rhs wherever the lhs is found in the transformation
# column names of covtable can be used to perform specific replacements
# for each transformation
trans <- insert(trans, "x ~ x_inh", x = c("Q", "q2"), inh = inhibitor); print(trans)

# Also numbers can be inserted
trans <- define(trans, "A ~ dose", dose = dose); print(trans)


# Turn that into a parameter transformation function
p <- P(trans)
parnames <- getParameters(p)
pars <- rnorm(length(parnames))
names(pars) <- parnames

p(pars)


# Advanced tricks exploiting the quoting-mechanism when capturing "..."

mydataframe <- data.frame(
  name = rep(letters[1:2], each = 3),
  value = 1:6,
  time = rep(1:3, 2),
  sigma = 0.1,
  par1 = rep(0:1, each = 3),
  par2 = rep(9:10, each = 3),
  par3 = rep(1:3, each = 2),
  stringsAsFactors = F
)

parameters <- c("a", "b", "par1", "par2", "par3")
pars_to_insert <- c("par1", "par2")
# pars_to_insert <- intersect(getParameters(g*x), names(data)) # this would be the usual way when setting up a model

trafo <- define(NULL, "x~x", x = parameters) 
trafo <- branch(trafo, covariates(as.datalist(mydataframe)))

# Trick 1: Access values from covariates()-Table with get/mget. 
    # The names of the parameters which are supplied in the covariates()-table have to be supplied manually.
trafo <- insert(trafo, "name ~ value", value = unlist(mget(pars_to_insert)), name = pars_to_insert)

# Apply reparametrization only for specific conditions using Regular Expressions for the conditionMatch argument
trafo <- insert(trafo, "x~x_par3", x = "a", conditionMatch = "^0_9", par3 = par3)  # Conditions starting with 0_9
trafo <- insert(trafo, "x~0", x = "a", conditionMatch = "^(?!0_9)")                # Conditions NOT starting with 0_9

# Trick 2: Access symbols from current condition-specific trafo
    # The input passed by the dots is "quoted" (substituted) and eval()'ed in the environment of the lapply(1:length(conditions), function(i) {})
    # mytrafo[[i]] is just the condition specific trafo
trafo <- insert(trafo, "x~exp(X)", x = getSymbols(mytrafo[[i]]), X = toupper(getSymbols(mytrafo[[i]])))












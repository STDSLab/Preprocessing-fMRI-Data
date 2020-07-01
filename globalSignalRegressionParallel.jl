function globalSignalRegression(array::SharedArray{F,2}) where {F<:AbstractFloat}
    nrow, ncol = size(array)
    g = vec(reduce(+, array, dims=2)) / ncol

    @sync @distributed for col=1:ncol
        beta = (g'*g)^(-1)*g'*array[:,col]
        array[:,col] = array[:,col] - g*beta
    end

    return nothing
end

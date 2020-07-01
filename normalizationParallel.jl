using Statistics
function normalizeArray(array::SharedArray{F,2}) where {F<:AbstractFloat}
    nrow, ncol = size(array)

    @sync @distributed for col=1:ncol
        var_x = var(array[:,col])
        mean_x = mean(array[:,col])
        array[:,col] = (array[:,col] .- mean_x)/sqrt(var_x)
    end

    return nothing
end

## define the pomp class
setClass(
  'pomp',
  slots=c(
    data = 'array',
    times = 'numeric',
    t0 = 'numeric',
    rprocess = 'pompPlugin',
    dprocess = 'pomp.fun',
    dmeasure = 'pomp.fun',
    rmeasure = 'pomp.fun',
    dprior = 'pomp.fun',
    rprior = 'pomp.fun',
    skeleton.type = 'character',
    skeleton = 'pomp.fun',
    skelmap.delta.t = 'numeric',
    default.init = 'logical',
    initializer = 'pomp.fun',
    states = 'array',
    params = 'numeric',
    covar = 'matrix',
    tcovar = 'numeric',
    zeronames = 'character',
    has.trans = 'logical',
    from.trans = 'pomp.fun',
    to.trans = 'pomp.fun',
    solibs = 'list',
    userdata = 'list'
  ),
  prototype=prototype(
    data=array(data=numeric(0),dim=c(0,0)),
    times=numeric(0),
    t0=numeric(0),
    rprocess=plugin(),
    dprocess=pomp.fun(slotname="dprocess"),
    dmeasure=pomp.fun(slotname="dmeasure"),
    rmeasure=pomp.fun(slotname="rmeasure"),
    dprior=pomp.fun(slotname="dprior"),
    rprior=pomp.fun(slotname="rprior"),
    skeleton.type="map",
    skeleton=pomp.fun(slotname="skeleton"),
    skelmap.delta.t=as.numeric(NA),
    default.init=TRUE,
    initializer=pomp.fun(slotname="initializer"),
    states=array(data=numeric(0),dim=c(0,0)),
    params=numeric(0),
    covar=array(data=numeric(0),dim=c(0,0)),
    tcovar=numeric(0),
    zeronames=character(0),
    has.trans=FALSE,
    from.trans=pomp.fun(slotname="fromEstimationScale"),
    to.trans=pomp.fun(slotname="toEstimationScale"),
    solibs=list(),
    userdata=list()
  ),
  validity=function (object) {
    retval <- character(0)
    if (length(object@data)<1)
      retval <- append(retval,paste(sQuote("data"),"is a required argument"))
    if (length(object@times)<1)
      retval <- append(retval,paste(sQuote("times"),"is a required argument"))
    if (!is.numeric(object@params) || (length(object@params)>0 && is.null(names(object@params))))
      retval <- append(retval,paste(sQuote("params"),"must be a named numeric vector"))
    if (ncol(object@data)!=length(object@times))
      retval <- append(retval,paste("the length of",sQuote("times"),"should match the number of observations"))
    if (length(object@t0)<1)
      retval <- append(retval,paste(sQuote("t0"),"is a required argument"))
    if (length(object@t0)>1)
      retval <- append(retval,paste(sQuote("t0"),"must be a single number"))
    if (object@t0 > object@times[1])
      retval <- append(retval,paste("the zero-time",sQuote("t0"),
                                    "must occur no later than the first observation"))
    if (object@skelmap.delta.t <= 0)
      retval <- append(retval,paste(sQuote("skelmap.delta.t"),"must be positive"))
    if (length(object@tcovar)!=nrow(object@covar)) {
      retval <- append(
        retval,
        paste(
          "the length of",sQuote("tcovar"),
          "should match the number of rows of",sQuote("covar")
        )
      )
    }
    if (!is.numeric(object@tcovar))
      retval <- append(
        retval,
        paste(
          sQuote("tcovar"),
          "must either be a numeric vector or must name a numeric vector in the data frame",
          sQuote("covar")
        )
      )

    if (length(retval)==0) TRUE else retval
  }
)

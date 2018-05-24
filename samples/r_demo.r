'cat("\014")'
'rm(list=ls())'
'library(piwebapi)'
'help(package="piwebapi")'



piWebApiService <- piwebapi$new("https://devdata.osisoft.com/piwebapi/", FALSE, "webapiuser", "!try3.14webapi!", FALSE, FALSE)
response1 = piWebApiService$home$get()





response2 = piWebApiService$dataServer$getByPath("\\\\PISRV1", "WebId")

response3a = piWebApiService$point$getByPath("\\\\PISRV1\\sinusoidu")
response3b = piWebApiService$point$getByPath("\\\\PISRV1\\cdt158")
response3c = piWebApiService$point$getByPath("\\\\PISRV1\\sinusoid")

webIds <- c(response3a$WebId, response3b$WebId, response3c$WebId)
response4 = piWebApiService$streamSet$getValuesAdHoc(webIds)


newPoint <- PIPoint(NULL, NULL, "SINUSOIDRNov8", NULL, "12 Hour Sine Wave", "classic", "Float32", NULL, NULL, NULL, NULL, NULL)
response5 = piWebApiService$dataServer$createPoint(response2$WebId, newPoint)

timedValue1 <- PITimedValue(timestamp = "2017-04-26T17:40:54Z", value = 30)
timedValue2 <- PITimedValue(timestamp = "2017-04-27T17:40:54Z", value = 31)
timedValue3 <- PITimedValue(timestamp = "2017-04-26T17:40:54Z", value = 32)
timedValue4 <- PITimedValue(timestamp = "2017-04-27T17:40:54Z", value = 33)
t1 <- list(timedValue1, timedValue2)
t2 <- list(timedValue3, timedValue4)
s1 <- PIStreamValues(webId = webIds[1], items = t1);
s2 <- PIStreamValues(webId = webIds[2], items = t2);
values <- list(s1, s2)
response6 <- piWebApiService$streamSet$updateValuesAdHoc(values, "BufferIfPossible", "Replace");


getSinReq <- list(Method = "GET", Resource = "https://devdata.osisoft.int/piwebapi/points?path=\\\\PISRV1\\sinusoid")
getCdtReq <- list(Method = "GET", Resource = "https://devdata.osisoft.int/piwebapi/points?path=\\\\PISRV1\\cdt158")
getData <- list(Method = "GET", Resource = "https://devdata.osisoft.int/piwebapi/streamsets/value?webid={0}&webid={1}")
getData$Parameters <- c("$.sinu.Content.WebId", "$.cdt.Content.WebId")
getData$ParentIds <- c("sinu", "cdt")
batch <- list(sinu = getSinReq, cdt = getCdtReq, data = getData);
response7 <- piWebApiService$batch$execute(batch)
res7 = content(response7)
res7$data$Content$Items[[2]]$Value

paths = c("pi:\\\\PISRV1\\sinusoid", "pi:\\\\PISRV1\\sinusoidu", "pi:\\\\PISRV1\\cdt158")


response8 <- piWebApiService$data$getRecordedValues(path = "pi:\\\\PISRV1\\sinusoid", startTime = "y-200d", endTime = "t")
response9 <- piWebApiService$data$getInterpolatedValues(path = "pi:\\\\PISRV1\\sinusoid", startTime = "y-2d", endTime = "t", interval = "1h")
response10 <- piWebApiService$data$getPlotValues(path = "pi:\\\\PISRV1\\sinusoid", startTime = "y-2d", endTime = "t", intervals = 30)


response11 <- piWebApiService$data$getMultipleRecordedValues(paths = paths, startTime = "y-200d", endTime = "t")
response12 <- piWebApiService$data$getMultipleInterpolatedValues(paths = paths, startTime = "y-200d", endTime = "t", interval = "1h")
response13 <- piWebApiService$data$getMultiplePlotValues(paths = paths, startTime = "y-200d", endTime = "t", intervals = 30)






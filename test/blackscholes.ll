; ModuleID = 'blackscholes.c'
source_filename = "blackscholes.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.OptionData_ = type { float, float, float, float, float, float, i8, float, float }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@numError = dso_local global i32 0, align 4
@numOptions = dso_local global i32 0, align 4
@nThreads = dso_local global i32 0, align 4
@sptprice = dso_local global float* null, align 8
@strike = dso_local global float* null, align 8
@rate = dso_local global float* null, align 8
@volatility = dso_local global float* null, align 8
@otime = dso_local global float* null, align 8
@otype = dso_local global i32* null, align 8
@prices = dso_local global float* null, align 8
@.str = private unnamed_addr constant [24 x i8] c"PARSEC Benchmark Suite\0A\00", align 1
@.str.1 = private unnamed_addr constant [48 x i8] c"Usage:\0A\09%s <nthreads> <inputFile> <outputFile>\0A\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.3 = private unnamed_addr constant [34 x i8] c"ERROR: Unable to open file `%s'.\0A\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"%i\00", align 1
@.str.5 = private unnamed_addr constant [39 x i8] c"ERROR: Unable to read from file `%s'.\0A\00", align 1
@.str.6 = private unnamed_addr constant [82 x i8] c"WARNING: Not enough work, reducing number of threads to match number of options.\0A\00", align 1
@.str.7 = private unnamed_addr constant [46 x i8] c"Error: <nthreads> must be 1 (serial version)\0A\00", align 1
@data = dso_local global %struct.OptionData_* null, align 8
@.str.8 = private unnamed_addr constant [27 x i8] c"%f %f %f %f %f %f %c %f %f\00", align 1
@.str.9 = private unnamed_addr constant [35 x i8] c"ERROR: Unable to close file `%s'.\0A\00", align 1
@.str.10 = private unnamed_addr constant [20 x i8] c"Num of Options: %d\0A\00", align 1
@.str.11 = private unnamed_addr constant [17 x i8] c"Num of Runs: %d\0A\00", align 1
@.str.12 = private unnamed_addr constant [18 x i8] c"Size of data: %d\0A\00", align 1
@.str.13 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.14 = private unnamed_addr constant [4 x i8] c"%i\0A\00", align 1
@.str.15 = private unnamed_addr constant [38 x i8] c"ERROR: Unable to write to file `%s'.\0A\00", align 1
@.str.16 = private unnamed_addr constant [7 x i8] c"%.18f\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local float @CNDF(float %InputX) #0 {
entry:
  %InputX.addr = alloca float, align 4
  %sign = alloca i32, align 4
  %OutputX = alloca float, align 4
  %xInput = alloca float, align 4
  %xNPrimeofX = alloca float, align 4
  %expValues = alloca float, align 4
  %xK2 = alloca float, align 4
  %xK2_2 = alloca float, align 4
  %xK2_3 = alloca float, align 4
  %xK2_4 = alloca float, align 4
  %xK2_5 = alloca float, align 4
  %xLocal = alloca float, align 4
  %xLocal_1 = alloca float, align 4
  %xLocal_2 = alloca float, align 4
  %xLocal_3 = alloca float, align 4
  store float %InputX, float* %InputX.addr, align 4
  %0 = load float, float* %InputX.addr, align 4
  %conv = fpext float %0 to double
  %cmp = fcmp olt double %conv, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load float, float* %InputX.addr, align 4
  %fneg = fneg float %1
  store float %fneg, float* %InputX.addr, align 4
  store i32 1, i32* %sign, align 4
  br label %if.end

if.else:                                          ; preds = %entry
  store i32 0, i32* %sign, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %2 = load float, float* %InputX.addr, align 4
  store float %2, float* %xInput, align 4
  %3 = load float, float* %InputX.addr, align 4
  %mul = fmul float -5.000000e-01, %3
  %4 = load float, float* %InputX.addr, align 4
  %mul2 = fmul float %mul, %4
  %conv3 = fpext float %mul2 to double
  %call = call double @exp(double %conv3) #5
  %conv4 = fptrunc double %call to float
  store float %conv4, float* %expValues, align 4
  %5 = load float, float* %expValues, align 4
  store float %5, float* %xNPrimeofX, align 4
  %6 = load float, float* %xNPrimeofX, align 4
  %conv5 = fpext float %6 to double
  %mul6 = fmul double %conv5, 0x3FD9884533D43651
  %conv7 = fptrunc double %mul6 to float
  store float %conv7, float* %xNPrimeofX, align 4
  %7 = load float, float* %xInput, align 4
  %conv8 = fpext float %7 to double
  %mul9 = fmul double 0x3FCDA6711871100E, %conv8
  %conv10 = fptrunc double %mul9 to float
  store float %conv10, float* %xK2, align 4
  %8 = load float, float* %xK2, align 4
  %conv11 = fpext float %8 to double
  %add = fadd double 1.000000e+00, %conv11
  %conv12 = fptrunc double %add to float
  store float %conv12, float* %xK2, align 4
  %9 = load float, float* %xK2, align 4
  %conv13 = fpext float %9 to double
  %div = fdiv double 1.000000e+00, %conv13
  %conv14 = fptrunc double %div to float
  store float %conv14, float* %xK2, align 4
  %10 = load float, float* %xK2, align 4
  %11 = load float, float* %xK2, align 4
  %mul15 = fmul float %10, %11
  store float %mul15, float* %xK2_2, align 4
  %12 = load float, float* %xK2_2, align 4
  %13 = load float, float* %xK2, align 4
  %mul16 = fmul float %12, %13
  store float %mul16, float* %xK2_3, align 4
  %14 = load float, float* %xK2_3, align 4
  %15 = load float, float* %xK2, align 4
  %mul17 = fmul float %14, %15
  store float %mul17, float* %xK2_4, align 4
  %16 = load float, float* %xK2_4, align 4
  %17 = load float, float* %xK2, align 4
  %mul18 = fmul float %16, %17
  store float %mul18, float* %xK2_5, align 4
  %18 = load float, float* %xK2, align 4
  %conv19 = fpext float %18 to double
  %mul20 = fmul double %conv19, 0x3FD470BF3A92F8EC
  %conv21 = fptrunc double %mul20 to float
  store float %conv21, float* %xLocal_1, align 4
  %19 = load float, float* %xK2_2, align 4
  %conv22 = fpext float %19 to double
  %mul23 = fmul double %conv22, 0xBFD6D1F0E5A8325B
  %conv24 = fptrunc double %mul23 to float
  store float %conv24, float* %xLocal_2, align 4
  %20 = load float, float* %xK2_3, align 4
  %conv25 = fpext float %20 to double
  %mul26 = fmul double %conv25, 0x3FFC80EF025F5E68
  %conv27 = fptrunc double %mul26 to float
  store float %conv27, float* %xLocal_3, align 4
  %21 = load float, float* %xLocal_2, align 4
  %22 = load float, float* %xLocal_3, align 4
  %add28 = fadd float %21, %22
  store float %add28, float* %xLocal_2, align 4
  %23 = load float, float* %xK2_4, align 4
  %conv29 = fpext float %23 to double
  %mul30 = fmul double %conv29, 0xBFFD23DD4EF278D0
  %conv31 = fptrunc double %mul30 to float
  store float %conv31, float* %xLocal_3, align 4
  %24 = load float, float* %xLocal_2, align 4
  %25 = load float, float* %xLocal_3, align 4
  %add32 = fadd float %24, %25
  store float %add32, float* %xLocal_2, align 4
  %26 = load float, float* %xK2_5, align 4
  %conv33 = fpext float %26 to double
  %mul34 = fmul double %conv33, 0x3FF548CDD6F42943
  %conv35 = fptrunc double %mul34 to float
  store float %conv35, float* %xLocal_3, align 4
  %27 = load float, float* %xLocal_2, align 4
  %28 = load float, float* %xLocal_3, align 4
  %add36 = fadd float %27, %28
  store float %add36, float* %xLocal_2, align 4
  %29 = load float, float* %xLocal_2, align 4
  %30 = load float, float* %xLocal_1, align 4
  %add37 = fadd float %29, %30
  store float %add37, float* %xLocal_1, align 4
  %31 = load float, float* %xLocal_1, align 4
  %32 = load float, float* %xNPrimeofX, align 4
  %mul38 = fmul float %31, %32
  store float %mul38, float* %xLocal, align 4
  %33 = load float, float* %xLocal, align 4
  %conv39 = fpext float %33 to double
  %sub = fsub double 1.000000e+00, %conv39
  %conv40 = fptrunc double %sub to float
  store float %conv40, float* %xLocal, align 4
  %34 = load float, float* %xLocal, align 4
  store float %34, float* %OutputX, align 4
  %35 = load i32, i32* %sign, align 4
  %tobool = icmp ne i32 %35, 0
  br i1 %tobool, label %if.then41, label %if.end45

if.then41:                                        ; preds = %if.end
  %36 = load float, float* %OutputX, align 4
  %conv42 = fpext float %36 to double
  %sub43 = fsub double 1.000000e+00, %conv42
  %conv44 = fptrunc double %sub43 to float
  store float %conv44, float* %OutputX, align 4
  br label %if.end45

if.end45:                                         ; preds = %if.then41, %if.end
  %37 = load float, float* %OutputX, align 4
  ret float %37
}

; Function Attrs: nounwind
declare dso_local double @exp(double) #1

; Function Attrs: noinline nounwind uwtable
define dso_local float @BlkSchlsEqEuroNoDiv(float %sptprice, float %strike, float %rate, float %volatility, float %time, i32 %otype, float %timet) #0 {
entry:
  %sptprice.addr = alloca float, align 4
  %strike.addr = alloca float, align 4
  %rate.addr = alloca float, align 4
  %volatility.addr = alloca float, align 4
  %time.addr = alloca float, align 4
  %otype.addr = alloca i32, align 4
  %timet.addr = alloca float, align 4
  %OptionPrice = alloca float, align 4
  %xStockPrice = alloca float, align 4
  %xStrikePrice = alloca float, align 4
  %xRiskFreeRate = alloca float, align 4
  %xVolatility = alloca float, align 4
  %xTime = alloca float, align 4
  %xSqrtTime = alloca float, align 4
  %logValues = alloca float, align 4
  %xLogTerm = alloca float, align 4
  %xD1 = alloca float, align 4
  %xD2 = alloca float, align 4
  %xPowerTerm = alloca float, align 4
  %xDen = alloca float, align 4
  %d1 = alloca float, align 4
  %d2 = alloca float, align 4
  %FutureValueX = alloca float, align 4
  %NofXd1 = alloca float, align 4
  %NofXd2 = alloca float, align 4
  %NegNofXd1 = alloca float, align 4
  %NegNofXd2 = alloca float, align 4
  store float %sptprice, float* %sptprice.addr, align 4
  store float %strike, float* %strike.addr, align 4
  store float %rate, float* %rate.addr, align 4
  store float %volatility, float* %volatility.addr, align 4
  store float %time, float* %time.addr, align 4
  store i32 %otype, i32* %otype.addr, align 4
  store float %timet, float* %timet.addr, align 4
  %0 = load float, float* %sptprice.addr, align 4
  store float %0, float* %xStockPrice, align 4
  %1 = load float, float* %strike.addr, align 4
  store float %1, float* %xStrikePrice, align 4
  %2 = load float, float* %rate.addr, align 4
  store float %2, float* %xRiskFreeRate, align 4
  %3 = load float, float* %volatility.addr, align 4
  store float %3, float* %xVolatility, align 4
  %4 = load float, float* %time.addr, align 4
  store float %4, float* %xTime, align 4
  %5 = load float, float* %xTime, align 4
  %conv = fpext float %5 to double
  %call = call double @sqrt(double %conv) #5
  %conv1 = fptrunc double %call to float
  store float %conv1, float* %xSqrtTime, align 4
  %6 = load float, float* %sptprice.addr, align 4
  %7 = load float, float* %strike.addr, align 4
  %div = fdiv float %6, %7
  %conv2 = fpext float %div to double
  %call3 = call double @log(double %conv2) #5
  %conv4 = fptrunc double %call3 to float
  store float %conv4, float* %logValues, align 4
  %8 = load float, float* %logValues, align 4
  store float %8, float* %xLogTerm, align 4
  %9 = load float, float* %xVolatility, align 4
  %10 = load float, float* %xVolatility, align 4
  %mul = fmul float %9, %10
  store float %mul, float* %xPowerTerm, align 4
  %11 = load float, float* %xPowerTerm, align 4
  %conv5 = fpext float %11 to double
  %mul6 = fmul double %conv5, 5.000000e-01
  %conv7 = fptrunc double %mul6 to float
  store float %conv7, float* %xPowerTerm, align 4
  %12 = load float, float* %xRiskFreeRate, align 4
  %13 = load float, float* %xPowerTerm, align 4
  %add = fadd float %12, %13
  store float %add, float* %xD1, align 4
  %14 = load float, float* %xD1, align 4
  %15 = load float, float* %xTime, align 4
  %mul8 = fmul float %14, %15
  store float %mul8, float* %xD1, align 4
  %16 = load float, float* %xD1, align 4
  %17 = load float, float* %xLogTerm, align 4
  %add9 = fadd float %16, %17
  store float %add9, float* %xD1, align 4
  %18 = load float, float* %xVolatility, align 4
  %19 = load float, float* %xSqrtTime, align 4
  %mul10 = fmul float %18, %19
  store float %mul10, float* %xDen, align 4
  %20 = load float, float* %xD1, align 4
  %21 = load float, float* %xDen, align 4
  %div11 = fdiv float %20, %21
  store float %div11, float* %xD1, align 4
  %22 = load float, float* %xD1, align 4
  %23 = load float, float* %xDen, align 4
  %sub = fsub float %22, %23
  store float %sub, float* %xD2, align 4
  %24 = load float, float* %xD1, align 4
  store float %24, float* %d1, align 4
  %25 = load float, float* %xD2, align 4
  store float %25, float* %d2, align 4
  %26 = load float, float* %d1, align 4
  %call12 = call float @CNDF(float %26)
  store float %call12, float* %NofXd1, align 4
  %27 = load float, float* %d2, align 4
  %call13 = call float @CNDF(float %27)
  store float %call13, float* %NofXd2, align 4
  %28 = load float, float* %strike.addr, align 4
  %conv14 = fpext float %28 to double
  %29 = load float, float* %rate.addr, align 4
  %fneg = fneg float %29
  %30 = load float, float* %time.addr, align 4
  %mul15 = fmul float %fneg, %30
  %conv16 = fpext float %mul15 to double
  %call17 = call double @exp(double %conv16) #5
  %mul18 = fmul double %conv14, %call17
  %conv19 = fptrunc double %mul18 to float
  store float %conv19, float* %FutureValueX, align 4
  %31 = load i32, i32* %otype.addr, align 4
  %cmp = icmp eq i32 %31, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %32 = load float, float* %sptprice.addr, align 4
  %33 = load float, float* %NofXd1, align 4
  %mul21 = fmul float %32, %33
  %34 = load float, float* %FutureValueX, align 4
  %35 = load float, float* %NofXd2, align 4
  %mul22 = fmul float %34, %35
  %sub23 = fsub float %mul21, %mul22
  store float %sub23, float* %OptionPrice, align 4
  br label %if.end

if.else:                                          ; preds = %entry
  %36 = load float, float* %NofXd1, align 4
  %conv24 = fpext float %36 to double
  %sub25 = fsub double 1.000000e+00, %conv24
  %conv26 = fptrunc double %sub25 to float
  store float %conv26, float* %NegNofXd1, align 4
  %37 = load float, float* %NofXd2, align 4
  %conv27 = fpext float %37 to double
  %sub28 = fsub double 1.000000e+00, %conv27
  %conv29 = fptrunc double %sub28 to float
  store float %conv29, float* %NegNofXd2, align 4
  %38 = load float, float* %FutureValueX, align 4
  %39 = load float, float* %NegNofXd2, align 4
  %mul30 = fmul float %38, %39
  %40 = load float, float* %sptprice.addr, align 4
  %41 = load float, float* %NegNofXd1, align 4
  %mul31 = fmul float %40, %41
  %sub32 = fsub float %mul30, %mul31
  store float %sub32, float* %OptionPrice, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %42 = load float, float* %OptionPrice, align 4
  ret float %42
}

; Function Attrs: nounwind
declare dso_local double @sqrt(double) #1

; Function Attrs: nounwind
declare dso_local double @log(double) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @bs_thread(i8* %tid_ptr) #0 {
entry:
  %tid_ptr.addr = alloca i8*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %price = alloca float, align 4
  %priceDelta = alloca float, align 4
  %tid = alloca i32, align 4
  %start = alloca i32, align 4
  %end = alloca i32, align 4
  store i8* %tid_ptr, i8** %tid_ptr.addr, align 8
  %0 = load i8*, i8** %tid_ptr.addr, align 8
  %1 = bitcast i8* %0 to i32*
  %2 = load i32, i32* %1, align 4
  store i32 %2, i32* %tid, align 4
  %3 = load i32, i32* %tid, align 4
  %4 = load i32, i32* @numOptions, align 4
  %5 = load i32, i32* @nThreads, align 4
  %div = sdiv i32 %4, %5
  %mul = mul nsw i32 %3, %div
  store i32 %mul, i32* %start, align 4
  %6 = load i32, i32* %start, align 4
  %7 = load i32, i32* @numOptions, align 4
  %8 = load i32, i32* @nThreads, align 4
  %div1 = sdiv i32 %7, %8
  %add = add nsw i32 %6, %div1
  store i32 %add, i32* %end, align 4
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc17, %entry
  %9 = load i32, i32* %j, align 4
  %cmp = icmp slt i32 %9, 100
  br i1 %cmp, label %for.body, label %for.end19

for.body:                                         ; preds = %for.cond
  %10 = load i32, i32* %start, align 4
  store i32 %10, i32* %i, align 4
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc, %for.body
  %11 = load i32, i32* %i, align 4
  %12 = load i32, i32* %end, align 4
  %cmp3 = icmp slt i32 %11, %12
  br i1 %cmp3, label %for.body4, label %for.end

for.body4:                                        ; preds = %for.cond2
  %13 = load float*, float** @sptprice, align 8
  %14 = load i32, i32* %i, align 4
  %idxprom = sext i32 %14 to i64
  %arrayidx = getelementptr inbounds float, float* %13, i64 %idxprom
  %15 = load float, float* %arrayidx, align 4
  %16 = load float*, float** @strike, align 8
  %17 = load i32, i32* %i, align 4
  %idxprom5 = sext i32 %17 to i64
  %arrayidx6 = getelementptr inbounds float, float* %16, i64 %idxprom5
  %18 = load float, float* %arrayidx6, align 4
  %19 = load float*, float** @rate, align 8
  %20 = load i32, i32* %i, align 4
  %idxprom7 = sext i32 %20 to i64
  %arrayidx8 = getelementptr inbounds float, float* %19, i64 %idxprom7
  %21 = load float, float* %arrayidx8, align 4
  %22 = load float*, float** @volatility, align 8
  %23 = load i32, i32* %i, align 4
  %idxprom9 = sext i32 %23 to i64
  %arrayidx10 = getelementptr inbounds float, float* %22, i64 %idxprom9
  %24 = load float, float* %arrayidx10, align 4
  %25 = load float*, float** @otime, align 8
  %26 = load i32, i32* %i, align 4
  %idxprom11 = sext i32 %26 to i64
  %arrayidx12 = getelementptr inbounds float, float* %25, i64 %idxprom11
  %27 = load float, float* %arrayidx12, align 4
  %28 = load i32*, i32** @otype, align 8
  %29 = load i32, i32* %i, align 4
  %idxprom13 = sext i32 %29 to i64
  %arrayidx14 = getelementptr inbounds i32, i32* %28, i64 %idxprom13
  %30 = load i32, i32* %arrayidx14, align 4
  %call = call float @BlkSchlsEqEuroNoDiv(float %15, float %18, float %21, float %24, float %27, i32 %30, float 0.000000e+00)
  store float %call, float* %price, align 4
  %31 = load float, float* %price, align 4
  %32 = load float*, float** @prices, align 8
  %33 = load i32, i32* %i, align 4
  %idxprom15 = sext i32 %33 to i64
  %arrayidx16 = getelementptr inbounds float, float* %32, i64 %idxprom15
  store float %31, float* %arrayidx16, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body4
  %34 = load i32, i32* %i, align 4
  %inc = add nsw i32 %34, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond2

for.end:                                          ; preds = %for.cond2
  br label %for.inc17

for.inc17:                                        ; preds = %for.end
  %35 = load i32, i32* %j, align 4
  %inc18 = add nsw i32 %35, 1
  store i32 %inc18, i32* %j, align 4
  br label %for.cond

for.end19:                                        ; preds = %for.cond
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %file = alloca %struct._IO_FILE*, align 8
  %i = alloca i32, align 4
  %loopnum = alloca i32, align 4
  %buffer = alloca float*, align 8
  %buffer2 = alloca i32*, align 8
  %rv = alloca i32, align 4
  %inputFile = alloca i8*, align 8
  %outputFile = alloca i8*, align 8
  %tid = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str, i64 0, i64 0))
  %call1 = call i32 @fflush(%struct._IO_FILE* null)
  %0 = load i32, i32* %argc.addr, align 4
  %cmp = icmp ne i32 %0, 4
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load i8**, i8*** %argv.addr, align 8
  %arrayidx = getelementptr inbounds i8*, i8** %1, i64 0
  %2 = load i8*, i8** %arrayidx, align 8
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.1, i64 0, i64 0), i8* %2)
  call void @exit(i32 1) #6
  unreachable

if.end:                                           ; preds = %entry
  %3 = load i8**, i8*** %argv.addr, align 8
  %arrayidx3 = getelementptr inbounds i8*, i8** %3, i64 1
  %4 = load i8*, i8** %arrayidx3, align 8
  %call4 = call i32 @atoi(i8* %4) #7
  store i32 %call4, i32* @nThreads, align 4
  %5 = load i8**, i8*** %argv.addr, align 8
  %arrayidx5 = getelementptr inbounds i8*, i8** %5, i64 2
  %6 = load i8*, i8** %arrayidx5, align 8
  store i8* %6, i8** %inputFile, align 8
  %7 = load i8**, i8*** %argv.addr, align 8
  %arrayidx6 = getelementptr inbounds i8*, i8** %7, i64 3
  %8 = load i8*, i8** %arrayidx6, align 8
  store i8* %8, i8** %outputFile, align 8
  %9 = load i8*, i8** %inputFile, align 8
  %call7 = call %struct._IO_FILE* @fopen(i8* %9, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
  store %struct._IO_FILE* %call7, %struct._IO_FILE** %file, align 8
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %cmp8 = icmp eq %struct._IO_FILE* %10, null
  br i1 %cmp8, label %if.then9, label %if.end11

if.then9:                                         ; preds = %if.end
  %11 = load i8*, i8** %inputFile, align 8
  %call10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.3, i64 0, i64 0), i8* %11)
  call void @exit(i32 1) #6
  unreachable

if.end11:                                         ; preds = %if.end
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %call12 = call i32 (%struct._IO_FILE*, i8*, ...) @__isoc99_fscanf(%struct._IO_FILE* %12, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i64 0, i64 0), i32* @numOptions)
  store i32 %call12, i32* %rv, align 4
  %13 = load i32, i32* %rv, align 4
  %cmp13 = icmp ne i32 %13, 1
  br i1 %cmp13, label %if.then14, label %if.end17

if.then14:                                        ; preds = %if.end11
  %14 = load i8*, i8** %inputFile, align 8
  %call15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i64 0, i64 0), i8* %14)
  %15 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %call16 = call i32 @fclose(%struct._IO_FILE* %15)
  call void @exit(i32 1) #6
  unreachable

if.end17:                                         ; preds = %if.end11
  %16 = load i32, i32* @nThreads, align 4
  %17 = load i32, i32* @numOptions, align 4
  %cmp18 = icmp sgt i32 %16, %17
  br i1 %cmp18, label %if.then19, label %if.end21

if.then19:                                        ; preds = %if.end17
  %call20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([82 x i8], [82 x i8]* @.str.6, i64 0, i64 0))
  %18 = load i32, i32* @numOptions, align 4
  store i32 %18, i32* @nThreads, align 4
  br label %if.end21

if.end21:                                         ; preds = %if.then19, %if.end17
  %19 = load i32, i32* @nThreads, align 4
  %cmp22 = icmp ne i32 %19, 1
  br i1 %cmp22, label %if.then23, label %if.end25

if.then23:                                        ; preds = %if.end21
  %call24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.7, i64 0, i64 0))
  call void @exit(i32 1) #6
  unreachable

if.end25:                                         ; preds = %if.end21
  %20 = load i32, i32* @numOptions, align 4
  %conv = sext i32 %20 to i64
  %mul = mul i64 %conv, 36
  %call26 = call noalias i8* @malloc(i64 %mul) #5
  %21 = bitcast i8* %call26 to %struct.OptionData_*
  store %struct.OptionData_* %21, %struct.OptionData_** @data, align 8
  %22 = load i32, i32* @numOptions, align 4
  %conv27 = sext i32 %22 to i64
  %mul28 = mul i64 %conv27, 4
  %call29 = call noalias i8* @malloc(i64 %mul28) #5
  %23 = bitcast i8* %call29 to float*
  store float* %23, float** @prices, align 8
  store i32 0, i32* %loopnum, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end25
  %24 = load i32, i32* %loopnum, align 4
  %25 = load i32, i32* @numOptions, align 4
  %cmp30 = icmp slt i32 %24, %25
  br i1 %cmp30, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %26 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %27 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %28 = load i32, i32* %loopnum, align 4
  %idxprom = sext i32 %28 to i64
  %arrayidx32 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %27, i64 %idxprom
  %s = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx32, i32 0, i32 0
  %29 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %30 = load i32, i32* %loopnum, align 4
  %idxprom33 = sext i32 %30 to i64
  %arrayidx34 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %29, i64 %idxprom33
  %strike = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx34, i32 0, i32 1
  %31 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %32 = load i32, i32* %loopnum, align 4
  %idxprom35 = sext i32 %32 to i64
  %arrayidx36 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %31, i64 %idxprom35
  %r = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx36, i32 0, i32 2
  %33 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %34 = load i32, i32* %loopnum, align 4
  %idxprom37 = sext i32 %34 to i64
  %arrayidx38 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %33, i64 %idxprom37
  %divq = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx38, i32 0, i32 3
  %35 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %36 = load i32, i32* %loopnum, align 4
  %idxprom39 = sext i32 %36 to i64
  %arrayidx40 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %35, i64 %idxprom39
  %v = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx40, i32 0, i32 4
  %37 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %38 = load i32, i32* %loopnum, align 4
  %idxprom41 = sext i32 %38 to i64
  %arrayidx42 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %37, i64 %idxprom41
  %t = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx42, i32 0, i32 5
  %39 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %40 = load i32, i32* %loopnum, align 4
  %idxprom43 = sext i32 %40 to i64
  %arrayidx44 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %39, i64 %idxprom43
  %OptionType = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx44, i32 0, i32 6
  %41 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %42 = load i32, i32* %loopnum, align 4
  %idxprom45 = sext i32 %42 to i64
  %arrayidx46 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %41, i64 %idxprom45
  %divs = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx46, i32 0, i32 7
  %43 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %44 = load i32, i32* %loopnum, align 4
  %idxprom47 = sext i32 %44 to i64
  %arrayidx48 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %43, i64 %idxprom47
  %DGrefval = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx48, i32 0, i32 8
  %call49 = call i32 (%struct._IO_FILE*, i8*, ...) @__isoc99_fscanf(%struct._IO_FILE* %26, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.8, i64 0, i64 0), float* %s, float* %strike, float* %r, float* %divq, float* %v, float* %t, i8* %OptionType, float* %divs, float* %DGrefval)
  store i32 %call49, i32* %rv, align 4
  %45 = load i32, i32* %rv, align 4
  %cmp50 = icmp ne i32 %45, 9
  br i1 %cmp50, label %if.then52, label %if.end55

if.then52:                                        ; preds = %for.body
  %46 = load i8*, i8** %inputFile, align 8
  %call53 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i64 0, i64 0), i8* %46)
  %47 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %call54 = call i32 @fclose(%struct._IO_FILE* %47)
  call void @exit(i32 1) #6
  unreachable

if.end55:                                         ; preds = %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end55
  %48 = load i32, i32* %loopnum, align 4
  %inc = add nsw i32 %48, 1
  store i32 %inc, i32* %loopnum, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %49 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %call56 = call i32 @fclose(%struct._IO_FILE* %49)
  store i32 %call56, i32* %rv, align 4
  %50 = load i32, i32* %rv, align 4
  %cmp57 = icmp ne i32 %50, 0
  br i1 %cmp57, label %if.then59, label %if.end61

if.then59:                                        ; preds = %for.end
  %51 = load i8*, i8** %inputFile, align 8
  %call60 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.9, i64 0, i64 0), i8* %51)
  call void @exit(i32 1) #6
  unreachable

if.end61:                                         ; preds = %for.end
  %52 = load i32, i32* @numOptions, align 4
  %call62 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.10, i64 0, i64 0), i32 %52)
  %call63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.11, i64 0, i64 0), i32 100)
  %53 = load i32, i32* @numOptions, align 4
  %mul64 = mul nsw i32 5, %53
  %conv65 = sext i32 %mul64 to i64
  %mul66 = mul i64 %conv65, 4
  %add = add i64 %mul66, 256
  %call67 = call noalias i8* @malloc(i64 %add) #5
  %54 = bitcast i8* %call67 to float*
  store float* %54, float** %buffer, align 8
  %55 = load float*, float** %buffer, align 8
  %56 = ptrtoint float* %55 to i64
  %add68 = add i64 %56, 256
  %and = and i64 %add68, -64
  %57 = inttoptr i64 %and to float*
  store float* %57, float** @sptprice, align 8
  %58 = load float*, float** @sptprice, align 8
  %59 = load i32, i32* @numOptions, align 4
  %idx.ext = sext i32 %59 to i64
  %add.ptr = getelementptr inbounds float, float* %58, i64 %idx.ext
  store float* %add.ptr, float** @strike, align 8
  %60 = load float*, float** @strike, align 8
  %61 = load i32, i32* @numOptions, align 4
  %idx.ext69 = sext i32 %61 to i64
  %add.ptr70 = getelementptr inbounds float, float* %60, i64 %idx.ext69
  store float* %add.ptr70, float** @rate, align 8
  %62 = load float*, float** @rate, align 8
  %63 = load i32, i32* @numOptions, align 4
  %idx.ext71 = sext i32 %63 to i64
  %add.ptr72 = getelementptr inbounds float, float* %62, i64 %idx.ext71
  store float* %add.ptr72, float** @volatility, align 8
  %64 = load float*, float** @volatility, align 8
  %65 = load i32, i32* @numOptions, align 4
  %idx.ext73 = sext i32 %65 to i64
  %add.ptr74 = getelementptr inbounds float, float* %64, i64 %idx.ext73
  store float* %add.ptr74, float** @otime, align 8
  %66 = load i32, i32* @numOptions, align 4
  %conv75 = sext i32 %66 to i64
  %mul76 = mul i64 %conv75, 4
  %add77 = add i64 %mul76, 256
  %call78 = call noalias i8* @malloc(i64 %add77) #5
  %67 = bitcast i8* %call78 to i32*
  store i32* %67, i32** %buffer2, align 8
  %68 = load i32*, i32** %buffer2, align 8
  %69 = ptrtoint i32* %68 to i64
  %add79 = add i64 %69, 256
  %and80 = and i64 %add79, -64
  %70 = inttoptr i64 %and80 to i32*
  store i32* %70, i32** @otype, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond81

for.cond81:                                       ; preds = %for.inc118, %if.end61
  %71 = load i32, i32* %i, align 4
  %72 = load i32, i32* @numOptions, align 4
  %cmp82 = icmp slt i32 %71, %72
  br i1 %cmp82, label %for.body84, label %for.end120

for.body84:                                       ; preds = %for.cond81
  %73 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %74 = load i32, i32* %i, align 4
  %idxprom85 = sext i32 %74 to i64
  %arrayidx86 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %73, i64 %idxprom85
  %OptionType87 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx86, i32 0, i32 6
  %75 = load i8, i8* %OptionType87, align 4
  %conv88 = sext i8 %75 to i32
  %cmp89 = icmp eq i32 %conv88, 80
  %76 = zext i1 %cmp89 to i64
  %cond = select i1 %cmp89, i32 1, i32 0
  %77 = load i32*, i32** @otype, align 8
  %78 = load i32, i32* %i, align 4
  %idxprom91 = sext i32 %78 to i64
  %arrayidx92 = getelementptr inbounds i32, i32* %77, i64 %idxprom91
  store i32 %cond, i32* %arrayidx92, align 4
  %79 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %80 = load i32, i32* %i, align 4
  %idxprom93 = sext i32 %80 to i64
  %arrayidx94 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %79, i64 %idxprom93
  %s95 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx94, i32 0, i32 0
  %81 = load float, float* %s95, align 4
  %82 = load float*, float** @sptprice, align 8
  %83 = load i32, i32* %i, align 4
  %idxprom96 = sext i32 %83 to i64
  %arrayidx97 = getelementptr inbounds float, float* %82, i64 %idxprom96
  store float %81, float* %arrayidx97, align 4
  %84 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %85 = load i32, i32* %i, align 4
  %idxprom98 = sext i32 %85 to i64
  %arrayidx99 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %84, i64 %idxprom98
  %strike100 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx99, i32 0, i32 1
  %86 = load float, float* %strike100, align 4
  %87 = load float*, float** @strike, align 8
  %88 = load i32, i32* %i, align 4
  %idxprom101 = sext i32 %88 to i64
  %arrayidx102 = getelementptr inbounds float, float* %87, i64 %idxprom101
  store float %86, float* %arrayidx102, align 4
  %89 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %90 = load i32, i32* %i, align 4
  %idxprom103 = sext i32 %90 to i64
  %arrayidx104 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %89, i64 %idxprom103
  %r105 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx104, i32 0, i32 2
  %91 = load float, float* %r105, align 4
  %92 = load float*, float** @rate, align 8
  %93 = load i32, i32* %i, align 4
  %idxprom106 = sext i32 %93 to i64
  %arrayidx107 = getelementptr inbounds float, float* %92, i64 %idxprom106
  store float %91, float* %arrayidx107, align 4
  %94 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %95 = load i32, i32* %i, align 4
  %idxprom108 = sext i32 %95 to i64
  %arrayidx109 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %94, i64 %idxprom108
  %v110 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx109, i32 0, i32 4
  %96 = load float, float* %v110, align 4
  %97 = load float*, float** @volatility, align 8
  %98 = load i32, i32* %i, align 4
  %idxprom111 = sext i32 %98 to i64
  %arrayidx112 = getelementptr inbounds float, float* %97, i64 %idxprom111
  store float %96, float* %arrayidx112, align 4
  %99 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %100 = load i32, i32* %i, align 4
  %idxprom113 = sext i32 %100 to i64
  %arrayidx114 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %99, i64 %idxprom113
  %t115 = getelementptr inbounds %struct.OptionData_, %struct.OptionData_* %arrayidx114, i32 0, i32 5
  %101 = load float, float* %t115, align 4
  %102 = load float*, float** @otime, align 8
  %103 = load i32, i32* %i, align 4
  %idxprom116 = sext i32 %103 to i64
  %arrayidx117 = getelementptr inbounds float, float* %102, i64 %idxprom116
  store float %101, float* %arrayidx117, align 4
  br label %for.inc118

for.inc118:                                       ; preds = %for.body84
  %104 = load i32, i32* %i, align 4
  %inc119 = add nsw i32 %104, 1
  store i32 %inc119, i32* %i, align 4
  br label %for.cond81

for.end120:                                       ; preds = %for.cond81
  %105 = load i32, i32* @numOptions, align 4
  %conv121 = sext i32 %105 to i64
  %mul122 = mul i64 %conv121, 40
  %call123 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.12, i64 0, i64 0), i64 %mul122)
  store i32 0, i32* %tid, align 4
  %106 = bitcast i32* %tid to i8*
  %call124 = call i32 @bs_thread(i8* %106)
  %107 = load i8*, i8** %outputFile, align 8
  %call125 = call %struct._IO_FILE* @fopen(i8* %107, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.13, i64 0, i64 0))
  store %struct._IO_FILE* %call125, %struct._IO_FILE** %file, align 8
  %108 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %cmp126 = icmp eq %struct._IO_FILE* %108, null
  br i1 %cmp126, label %if.then128, label %if.end130

if.then128:                                       ; preds = %for.end120
  %109 = load i8*, i8** %outputFile, align 8
  %call129 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.3, i64 0, i64 0), i8* %109)
  call void @exit(i32 1) #6
  unreachable

if.end130:                                        ; preds = %for.end120
  %110 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %111 = load i32, i32* @numOptions, align 4
  %call131 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %110, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.14, i64 0, i64 0), i32 %111)
  store i32 %call131, i32* %rv, align 4
  %112 = load i32, i32* %rv, align 4
  %cmp132 = icmp slt i32 %112, 0
  br i1 %cmp132, label %if.then134, label %if.end137

if.then134:                                       ; preds = %if.end130
  %113 = load i8*, i8** %outputFile, align 8
  %call135 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.15, i64 0, i64 0), i8* %113)
  %114 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %call136 = call i32 @fclose(%struct._IO_FILE* %114)
  call void @exit(i32 1) #6
  unreachable

if.end137:                                        ; preds = %if.end130
  store i32 0, i32* %i, align 4
  br label %for.cond138

for.cond138:                                      ; preds = %for.inc152, %if.end137
  %115 = load i32, i32* %i, align 4
  %116 = load i32, i32* @numOptions, align 4
  %cmp139 = icmp slt i32 %115, %116
  br i1 %cmp139, label %for.body141, label %for.end154

for.body141:                                      ; preds = %for.cond138
  %117 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %118 = load float*, float** @prices, align 8
  %119 = load i32, i32* %i, align 4
  %idxprom142 = sext i32 %119 to i64
  %arrayidx143 = getelementptr inbounds float, float* %118, i64 %idxprom142
  %120 = load float, float* %arrayidx143, align 4
  %conv144 = fpext float %120 to double
  %call145 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %117, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.16, i64 0, i64 0), double %conv144)
  store i32 %call145, i32* %rv, align 4
  %121 = load i32, i32* %rv, align 4
  %cmp146 = icmp slt i32 %121, 0
  br i1 %cmp146, label %if.then148, label %if.end151

if.then148:                                       ; preds = %for.body141
  %122 = load i8*, i8** %outputFile, align 8
  %call149 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.15, i64 0, i64 0), i8* %122)
  %123 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %call150 = call i32 @fclose(%struct._IO_FILE* %123)
  call void @exit(i32 1) #6
  unreachable

if.end151:                                        ; preds = %for.body141
  br label %for.inc152

for.inc152:                                       ; preds = %if.end151
  %124 = load i32, i32* %i, align 4
  %inc153 = add nsw i32 %124, 1
  store i32 %inc153, i32* %i, align 4
  br label %for.cond138

for.end154:                                       ; preds = %for.cond138
  %125 = load %struct._IO_FILE*, %struct._IO_FILE** %file, align 8
  %call155 = call i32 @fclose(%struct._IO_FILE* %125)
  store i32 %call155, i32* %rv, align 4
  %126 = load i32, i32* %rv, align 4
  %cmp156 = icmp ne i32 %126, 0
  br i1 %cmp156, label %if.then158, label %if.end160

if.then158:                                       ; preds = %for.end154
  %127 = load i8*, i8** %outputFile, align 8
  %call159 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.9, i64 0, i64 0), i8* %127)
  call void @exit(i32 1) #6
  unreachable

if.end160:                                        ; preds = %for.end154
  %128 = load %struct.OptionData_*, %struct.OptionData_** @data, align 8
  %129 = bitcast %struct.OptionData_* %128 to i8*
  call void @free(i8* %129) #5
  %130 = load float*, float** @prices, align 8
  %131 = bitcast float* %130 to i8*
  call void @free(i8* %131) #5
  ret i32 0
}

declare dso_local i32 @printf(i8*, ...) #2

declare dso_local i32 @fflush(%struct._IO_FILE*) #2

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #3

; Function Attrs: nounwind readonly
declare dso_local i32 @atoi(i8*) #4

declare dso_local %struct._IO_FILE* @fopen(i8*, i8*) #2

declare dso_local i32 @__isoc99_fscanf(%struct._IO_FILE*, i8*, ...) #2

declare dso_local i32 @fclose(%struct._IO_FILE*) #2

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

declare dso_local i32 @fprintf(%struct._IO_FILE*, i8*, ...) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind readonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 11.0.0 (/home/ywshin/llvm-project/clang 578fb2501a66e407187ec0ac4da20995265f91c8)"}

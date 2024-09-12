; ModuleID = 'trans.c'
source_filename = "trans.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"Transpose submission\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"Basic transpose\00", align 1
@.str.2 = private unnamed_addr constant [36 x i8] c"Transpose using the temporary array\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @registerFunctions() local_unnamed_addr #0 !dbg !9 {
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* noundef nonnull @transpose_submit, i8* noundef getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0)) #4, !dbg !13
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* noundef nonnull @trans_basic, i8* noundef getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i64 0, i64 0)) #4, !dbg !14
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* noundef nonnull @trans_tmp, i8* noundef getelementptr inbounds ([36 x i8], [36 x i8]* @.str.2, i64 0, i64 0)) #4, !dbg !15
  ret void, !dbg !16
}

declare !dbg !17 void @registerTransFunction(void (i64, i64, double*, double*, double*)* noundef, i8* noundef) local_unnamed_addr #1

; Function Attrs: nofree norecurse nosync nounwind uwtable
define internal void @transpose_submit(i64 noundef %0, i64 noundef %1, double* nocapture noundef readonly %2, double* noundef %3, double* nocapture noundef readnone %4) #2 !dbg !36 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !38, metadata !DIExpression()), !dbg !43
  call void @llvm.dbg.value(metadata i64 %1, metadata !39, metadata !DIExpression()), !dbg !43
  call void @llvm.dbg.value(metadata double* %2, metadata !40, metadata !DIExpression()), !dbg !43
  call void @llvm.dbg.value(metadata double* %3, metadata !41, metadata !DIExpression()), !dbg !43
  call void @llvm.dbg.value(metadata double* %4, metadata !42, metadata !DIExpression()), !dbg !43
  tail call void @trans_basic(i64 noundef %0, i64 noundef %1, double* noundef %2, double* noundef %3, double* noundef %4), !dbg !44
  ret void, !dbg !45
}

; Function Attrs: nofree norecurse nosync nounwind uwtable
define internal void @trans_basic(i64 noundef %0, i64 noundef %1, double* nocapture noundef readonly %2, double* noundef writeonly %3, double* nocapture noundef readnone %4) #2 !dbg !46 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !48, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata i64 %1, metadata !49, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata double* %2, metadata !50, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata double* %3, metadata !51, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata double* %4, metadata !52, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata i64 0, metadata !53, metadata !DIExpression()), !dbg !118
  %6 = icmp eq i64 %1, 0, !dbg !119
  br i1 %6, label %195, label %7, !dbg !120

7:                                                ; preds = %5
  %8 = icmp eq i64 %0, 0
  br i1 %8, label %191, label %9, !dbg !121

9:                                                ; preds = %7, %17
  %10 = phi i64 [ %11, %17 ], [ 0, %7 ]
  call void @llvm.dbg.value(metadata i64 %10, metadata !53, metadata !DIExpression()), !dbg !118
  call void @llvm.dbg.value(metadata i64 0, metadata !55, metadata !DIExpression()), !dbg !122
  %11 = add i64 %10, 8
  %12 = icmp eq i64 %10, -8
  br i1 %12, label %13, label %19, !dbg !123

13:                                               ; preds = %9, %13
  %14 = phi i64 [ %15, %13 ], [ 0, %9 ]
  call void @llvm.dbg.value(metadata i64 %14, metadata !55, metadata !DIExpression()), !dbg !122
  call void @llvm.dbg.value(metadata i64 %10, metadata !59, metadata !DIExpression()), !dbg !124
  %15 = add i64 %14, 8, !dbg !125
  call void @llvm.dbg.value(metadata i64 %15, metadata !55, metadata !DIExpression()), !dbg !122
  %16 = icmp ult i64 %15, %0, !dbg !126
  br i1 %16, label %13, label %17, !dbg !121, !llvm.loop !127

17:                                               ; preds = %156, %13
  call void @llvm.dbg.value(metadata i64 %11, metadata !53, metadata !DIExpression()), !dbg !118
  %18 = icmp ult i64 %11, %1, !dbg !119
  br i1 %18, label %9, label %195, !dbg !120, !llvm.loop !130

19:                                               ; preds = %9, %156
  %20 = phi i64 [ %157, %156 ], [ 0, %9 ]
  call void @llvm.dbg.value(metadata i64 %20, metadata !55, metadata !DIExpression()), !dbg !122
  call void @llvm.dbg.value(metadata i64 %10, metadata !59, metadata !DIExpression()), !dbg !124
  %21 = sub i64 %0, %20
  %22 = icmp ugt i64 %21, 7
  %23 = mul nsw i64 %20, %1
  %24 = getelementptr inbounds double, double* %3, i64 %23
  %25 = or i64 %20, 1
  %26 = mul nsw i64 %25, %1
  %27 = getelementptr inbounds double, double* %3, i64 %26
  %28 = or i64 %20, 2
  %29 = mul nsw i64 %28, %1
  %30 = getelementptr inbounds double, double* %3, i64 %29
  %31 = or i64 %20, 3
  %32 = mul nsw i64 %31, %1
  %33 = getelementptr inbounds double, double* %3, i64 %32
  %34 = or i64 %20, 4
  %35 = mul nsw i64 %34, %1
  %36 = getelementptr inbounds double, double* %3, i64 %35
  %37 = or i64 %20, 5
  %38 = mul nsw i64 %37, %1
  %39 = getelementptr inbounds double, double* %3, i64 %38
  %40 = or i64 %20, 6
  %41 = mul nsw i64 %40, %1
  %42 = getelementptr inbounds double, double* %3, i64 %41
  %43 = or i64 %20, 7
  %44 = mul nsw i64 %43, %1
  %45 = getelementptr inbounds double, double* %3, i64 %44
  br i1 %22, label %159, label %46, !dbg !132

46:                                               ; preds = %19
  %47 = getelementptr inbounds double, double* %2, i64 %20
  br label %48, !dbg !123

48:                                               ; preds = %46, %151
  %49 = phi i64 [ %152, %151 ], [ %10, %46 ]
  call void @llvm.dbg.value(metadata i64 %49, metadata !59, metadata !DIExpression()), !dbg !124
  switch i64 %21, label %151 [
    i64 7, label %124
    i64 6, label %104
    i64 5, label %87
    i64 4, label %73
    i64 3, label %62
    i64 2, label %54
    i64 1, label %50
  ], !dbg !133

50:                                               ; preds = %48
  %51 = mul nsw i64 %49, %0, !dbg !134
  %52 = getelementptr inbounds double, double* %47, i64 %51, !dbg !134
  %53 = load double, double* %52, align 8, !dbg !134, !tbaa !135
  call void @llvm.dbg.value(metadata double %53, metadata !114, metadata !DIExpression()), !dbg !139
  br label %147, !dbg !140

54:                                               ; preds = %48
  %55 = mul nsw i64 %49, %0, !dbg !141
  %56 = getelementptr inbounds double, double* %2, i64 %55, !dbg !141
  %57 = getelementptr inbounds double, double* %56, i64 %20, !dbg !141
  %58 = load double, double* %57, align 8, !dbg !141, !tbaa !135
  call void @llvm.dbg.value(metadata double %58, metadata !110, metadata !DIExpression()), !dbg !142
  %59 = getelementptr inbounds double, double* %56, i64 %25, !dbg !143
  %60 = load double, double* %59, align 8, !dbg !143, !tbaa !135
  call void @llvm.dbg.value(metadata double %60, metadata !113, metadata !DIExpression()), !dbg !142
  %61 = getelementptr inbounds double, double* %24, i64 %49, !dbg !144
  store double %58, double* %61, align 8, !dbg !145, !tbaa !135
  br label %147, !dbg !146

62:                                               ; preds = %48
  %63 = mul nsw i64 %49, %0, !dbg !147
  %64 = getelementptr inbounds double, double* %2, i64 %63, !dbg !147
  %65 = getelementptr inbounds double, double* %64, i64 %20, !dbg !147
  %66 = load double, double* %65, align 8, !dbg !147, !tbaa !135
  call void @llvm.dbg.value(metadata double %66, metadata !105, metadata !DIExpression()), !dbg !148
  %67 = getelementptr inbounds double, double* %64, i64 %25, !dbg !149
  %68 = load double, double* %67, align 8, !dbg !149, !tbaa !135
  call void @llvm.dbg.value(metadata double %68, metadata !108, metadata !DIExpression()), !dbg !148
  %69 = getelementptr inbounds double, double* %64, i64 %28, !dbg !150
  %70 = load double, double* %69, align 8, !dbg !150, !tbaa !135
  call void @llvm.dbg.value(metadata double %70, metadata !109, metadata !DIExpression()), !dbg !148
  %71 = getelementptr inbounds double, double* %24, i64 %49, !dbg !151
  store double %66, double* %71, align 8, !dbg !152, !tbaa !135
  %72 = getelementptr inbounds double, double* %27, i64 %49, !dbg !153
  store double %68, double* %72, align 8, !dbg !154, !tbaa !135
  br label %147, !dbg !155

73:                                               ; preds = %48
  %74 = mul nsw i64 %49, %0, !dbg !156
  %75 = getelementptr inbounds double, double* %2, i64 %74, !dbg !156
  %76 = getelementptr inbounds double, double* %75, i64 %20, !dbg !156
  %77 = load double, double* %76, align 8, !dbg !156, !tbaa !135
  call void @llvm.dbg.value(metadata double %77, metadata !99, metadata !DIExpression()), !dbg !157
  %78 = getelementptr inbounds double, double* %75, i64 %25, !dbg !158
  %79 = load double, double* %78, align 8, !dbg !158, !tbaa !135
  call void @llvm.dbg.value(metadata double %79, metadata !102, metadata !DIExpression()), !dbg !157
  %80 = getelementptr inbounds double, double* %75, i64 %28, !dbg !159
  %81 = load double, double* %80, align 8, !dbg !159, !tbaa !135
  call void @llvm.dbg.value(metadata double %81, metadata !103, metadata !DIExpression()), !dbg !157
  %82 = getelementptr inbounds double, double* %75, i64 %31, !dbg !160
  %83 = load double, double* %82, align 8, !dbg !160, !tbaa !135
  call void @llvm.dbg.value(metadata double %83, metadata !104, metadata !DIExpression()), !dbg !157
  %84 = getelementptr inbounds double, double* %24, i64 %49, !dbg !161
  store double %77, double* %84, align 8, !dbg !162, !tbaa !135
  %85 = getelementptr inbounds double, double* %27, i64 %49, !dbg !163
  store double %79, double* %85, align 8, !dbg !164, !tbaa !135
  %86 = getelementptr inbounds double, double* %30, i64 %49, !dbg !165
  store double %81, double* %86, align 8, !dbg !166, !tbaa !135
  br label %147, !dbg !167

87:                                               ; preds = %48
  %88 = mul nsw i64 %49, %0, !dbg !168
  %89 = getelementptr inbounds double, double* %2, i64 %88, !dbg !168
  %90 = getelementptr inbounds double, double* %89, i64 %20, !dbg !168
  %91 = load double, double* %90, align 8, !dbg !168, !tbaa !135
  call void @llvm.dbg.value(metadata double %91, metadata !92, metadata !DIExpression()), !dbg !169
  %92 = getelementptr inbounds double, double* %89, i64 %25, !dbg !170
  %93 = load double, double* %92, align 8, !dbg !170, !tbaa !135
  call void @llvm.dbg.value(metadata double %93, metadata !95, metadata !DIExpression()), !dbg !169
  %94 = getelementptr inbounds double, double* %89, i64 %28, !dbg !171
  %95 = load double, double* %94, align 8, !dbg !171, !tbaa !135
  call void @llvm.dbg.value(metadata double %95, metadata !96, metadata !DIExpression()), !dbg !169
  %96 = getelementptr inbounds double, double* %89, i64 %31, !dbg !172
  %97 = load double, double* %96, align 8, !dbg !172, !tbaa !135
  call void @llvm.dbg.value(metadata double %97, metadata !97, metadata !DIExpression()), !dbg !169
  %98 = getelementptr inbounds double, double* %89, i64 %34, !dbg !173
  %99 = load double, double* %98, align 8, !dbg !173, !tbaa !135
  call void @llvm.dbg.value(metadata double %99, metadata !98, metadata !DIExpression()), !dbg !169
  %100 = getelementptr inbounds double, double* %24, i64 %49, !dbg !174
  store double %91, double* %100, align 8, !dbg !175, !tbaa !135
  %101 = getelementptr inbounds double, double* %27, i64 %49, !dbg !176
  store double %93, double* %101, align 8, !dbg !177, !tbaa !135
  %102 = getelementptr inbounds double, double* %30, i64 %49, !dbg !178
  store double %95, double* %102, align 8, !dbg !179, !tbaa !135
  %103 = getelementptr inbounds double, double* %33, i64 %49, !dbg !180
  store double %97, double* %103, align 8, !dbg !181, !tbaa !135
  br label %147, !dbg !182

104:                                              ; preds = %48
  %105 = mul nsw i64 %49, %0, !dbg !183
  %106 = getelementptr inbounds double, double* %2, i64 %105, !dbg !183
  %107 = getelementptr inbounds double, double* %106, i64 %20, !dbg !183
  %108 = load double, double* %107, align 8, !dbg !183, !tbaa !135
  call void @llvm.dbg.value(metadata double %108, metadata !84, metadata !DIExpression()), !dbg !184
  %109 = getelementptr inbounds double, double* %106, i64 %25, !dbg !185
  %110 = load double, double* %109, align 8, !dbg !185, !tbaa !135
  call void @llvm.dbg.value(metadata double %110, metadata !87, metadata !DIExpression()), !dbg !184
  %111 = getelementptr inbounds double, double* %106, i64 %28, !dbg !186
  %112 = load double, double* %111, align 8, !dbg !186, !tbaa !135
  call void @llvm.dbg.value(metadata double %112, metadata !88, metadata !DIExpression()), !dbg !184
  %113 = getelementptr inbounds double, double* %106, i64 %31, !dbg !187
  %114 = load double, double* %113, align 8, !dbg !187, !tbaa !135
  call void @llvm.dbg.value(metadata double %114, metadata !89, metadata !DIExpression()), !dbg !184
  %115 = getelementptr inbounds double, double* %106, i64 %34, !dbg !188
  %116 = load double, double* %115, align 8, !dbg !188, !tbaa !135
  call void @llvm.dbg.value(metadata double %116, metadata !90, metadata !DIExpression()), !dbg !184
  %117 = getelementptr inbounds double, double* %106, i64 %37, !dbg !189
  %118 = load double, double* %117, align 8, !dbg !189, !tbaa !135
  call void @llvm.dbg.value(metadata double %118, metadata !91, metadata !DIExpression()), !dbg !184
  %119 = getelementptr inbounds double, double* %24, i64 %49, !dbg !190
  store double %108, double* %119, align 8, !dbg !191, !tbaa !135
  %120 = getelementptr inbounds double, double* %27, i64 %49, !dbg !192
  store double %110, double* %120, align 8, !dbg !193, !tbaa !135
  %121 = getelementptr inbounds double, double* %30, i64 %49, !dbg !194
  store double %112, double* %121, align 8, !dbg !195, !tbaa !135
  %122 = getelementptr inbounds double, double* %33, i64 %49, !dbg !196
  store double %114, double* %122, align 8, !dbg !197, !tbaa !135
  %123 = getelementptr inbounds double, double* %36, i64 %49, !dbg !198
  store double %116, double* %123, align 8, !dbg !199, !tbaa !135
  br label %147, !dbg !200

124:                                              ; preds = %48
  %125 = mul nsw i64 %49, %0, !dbg !201
  %126 = getelementptr inbounds double, double* %2, i64 %125, !dbg !201
  %127 = getelementptr inbounds double, double* %126, i64 %20, !dbg !201
  %128 = load double, double* %127, align 8, !dbg !201, !tbaa !135
  call void @llvm.dbg.value(metadata double %128, metadata !75, metadata !DIExpression()), !dbg !202
  %129 = getelementptr inbounds double, double* %126, i64 %25, !dbg !203
  %130 = load double, double* %129, align 8, !dbg !203, !tbaa !135
  call void @llvm.dbg.value(metadata double %130, metadata !78, metadata !DIExpression()), !dbg !202
  %131 = getelementptr inbounds double, double* %126, i64 %28, !dbg !204
  %132 = load double, double* %131, align 8, !dbg !204, !tbaa !135
  call void @llvm.dbg.value(metadata double %132, metadata !79, metadata !DIExpression()), !dbg !202
  %133 = getelementptr inbounds double, double* %126, i64 %31, !dbg !205
  %134 = load double, double* %133, align 8, !dbg !205, !tbaa !135
  call void @llvm.dbg.value(metadata double %134, metadata !80, metadata !DIExpression()), !dbg !202
  %135 = getelementptr inbounds double, double* %126, i64 %34, !dbg !206
  %136 = load double, double* %135, align 8, !dbg !206, !tbaa !135
  call void @llvm.dbg.value(metadata double %136, metadata !81, metadata !DIExpression()), !dbg !202
  %137 = getelementptr inbounds double, double* %126, i64 %37, !dbg !207
  %138 = load double, double* %137, align 8, !dbg !207, !tbaa !135
  call void @llvm.dbg.value(metadata double %138, metadata !82, metadata !DIExpression()), !dbg !202
  %139 = getelementptr inbounds double, double* %126, i64 %40, !dbg !208
  %140 = load double, double* %139, align 8, !dbg !208, !tbaa !135
  call void @llvm.dbg.value(metadata double %140, metadata !83, metadata !DIExpression()), !dbg !202
  %141 = getelementptr inbounds double, double* %24, i64 %49, !dbg !209
  store double %128, double* %141, align 8, !dbg !210, !tbaa !135
  %142 = getelementptr inbounds double, double* %27, i64 %49, !dbg !211
  store double %130, double* %142, align 8, !dbg !212, !tbaa !135
  %143 = getelementptr inbounds double, double* %30, i64 %49, !dbg !213
  store double %132, double* %143, align 8, !dbg !214, !tbaa !135
  %144 = getelementptr inbounds double, double* %33, i64 %49, !dbg !215
  store double %134, double* %144, align 8, !dbg !216, !tbaa !135
  %145 = getelementptr inbounds double, double* %36, i64 %49, !dbg !217
  store double %136, double* %145, align 8, !dbg !218, !tbaa !135
  %146 = getelementptr inbounds double, double* %39, i64 %49, !dbg !219
  store double %138, double* %146, align 8, !dbg !220, !tbaa !135
  br label %147, !dbg !221

147:                                              ; preds = %50, %54, %62, %73, %87, %104, %124
  %148 = phi double* [ %42, %124 ], [ %39, %104 ], [ %36, %87 ], [ %33, %73 ], [ %30, %62 ], [ %27, %54 ], [ %24, %50 ]
  %149 = phi double [ %140, %124 ], [ %118, %104 ], [ %99, %87 ], [ %83, %73 ], [ %70, %62 ], [ %60, %54 ], [ %53, %50 ]
  %150 = getelementptr inbounds double, double* %148, i64 %49, !dbg !222
  store double %149, double* %150, align 8, !dbg !222, !tbaa !135
  br label %151, !dbg !223

151:                                              ; preds = %147, %48
  %152 = add nuw i64 %49, 1, !dbg !223
  call void @llvm.dbg.value(metadata i64 %152, metadata !59, metadata !DIExpression()), !dbg !124
  %153 = icmp ult i64 %152, %11, !dbg !224
  %154 = icmp ult i64 %152, %1, !dbg !225
  %155 = and i1 %153, %154, !dbg !225
  br i1 %155, label %48, label %156, !dbg !123, !llvm.loop !226

156:                                              ; preds = %151, %159
  %157 = add i64 %20, 8, !dbg !125
  call void @llvm.dbg.value(metadata i64 %157, metadata !55, metadata !DIExpression()), !dbg !122
  %158 = icmp ult i64 %157, %0, !dbg !126
  br i1 %158, label %19, label %17, !dbg !121, !llvm.loop !127

159:                                              ; preds = %19, %159
  %160 = phi i64 [ %187, %159 ], [ %10, %19 ]
  call void @llvm.dbg.value(metadata i64 %160, metadata !59, metadata !DIExpression()), !dbg !124
  %161 = mul nsw i64 %160, %0, !dbg !228
  %162 = getelementptr inbounds double, double* %2, i64 %161, !dbg !228
  %163 = getelementptr inbounds double, double* %162, i64 %20, !dbg !228
  %164 = load double, double* %163, align 8, !dbg !228, !tbaa !135
  call void @llvm.dbg.value(metadata double %164, metadata !63, metadata !DIExpression()), !dbg !229
  %165 = getelementptr inbounds double, double* %162, i64 %25, !dbg !230
  %166 = load double, double* %165, align 8, !dbg !230, !tbaa !135
  call void @llvm.dbg.value(metadata double %166, metadata !68, metadata !DIExpression()), !dbg !229
  %167 = getelementptr inbounds double, double* %162, i64 %28, !dbg !231
  %168 = load double, double* %167, align 8, !dbg !231, !tbaa !135
  call void @llvm.dbg.value(metadata double %168, metadata !69, metadata !DIExpression()), !dbg !229
  %169 = getelementptr inbounds double, double* %162, i64 %31, !dbg !232
  %170 = load double, double* %169, align 8, !dbg !232, !tbaa !135
  call void @llvm.dbg.value(metadata double %170, metadata !70, metadata !DIExpression()), !dbg !229
  %171 = getelementptr inbounds double, double* %162, i64 %34, !dbg !233
  %172 = load double, double* %171, align 8, !dbg !233, !tbaa !135
  call void @llvm.dbg.value(metadata double %172, metadata !71, metadata !DIExpression()), !dbg !229
  %173 = getelementptr inbounds double, double* %162, i64 %37, !dbg !234
  %174 = load double, double* %173, align 8, !dbg !234, !tbaa !135
  call void @llvm.dbg.value(metadata double %174, metadata !72, metadata !DIExpression()), !dbg !229
  %175 = getelementptr inbounds double, double* %162, i64 %40, !dbg !235
  %176 = load double, double* %175, align 8, !dbg !235, !tbaa !135
  call void @llvm.dbg.value(metadata double %176, metadata !73, metadata !DIExpression()), !dbg !229
  %177 = getelementptr inbounds double, double* %162, i64 %43, !dbg !236
  %178 = load double, double* %177, align 8, !dbg !236, !tbaa !135
  call void @llvm.dbg.value(metadata double %178, metadata !74, metadata !DIExpression()), !dbg !229
  %179 = getelementptr inbounds double, double* %24, i64 %160, !dbg !237
  store double %164, double* %179, align 8, !dbg !238, !tbaa !135
  %180 = getelementptr inbounds double, double* %27, i64 %160, !dbg !239
  store double %166, double* %180, align 8, !dbg !240, !tbaa !135
  %181 = getelementptr inbounds double, double* %30, i64 %160, !dbg !241
  store double %168, double* %181, align 8, !dbg !242, !tbaa !135
  %182 = getelementptr inbounds double, double* %33, i64 %160, !dbg !243
  store double %170, double* %182, align 8, !dbg !244, !tbaa !135
  %183 = getelementptr inbounds double, double* %36, i64 %160, !dbg !245
  store double %172, double* %183, align 8, !dbg !246, !tbaa !135
  %184 = getelementptr inbounds double, double* %39, i64 %160, !dbg !247
  store double %174, double* %184, align 8, !dbg !248, !tbaa !135
  %185 = getelementptr inbounds double, double* %42, i64 %160, !dbg !249
  store double %176, double* %185, align 8, !dbg !250, !tbaa !135
  %186 = getelementptr inbounds double, double* %45, i64 %160, !dbg !251
  store double %178, double* %186, align 8, !dbg !252, !tbaa !135
  %187 = add nuw i64 %160, 1, !dbg !223
  call void @llvm.dbg.value(metadata i64 %187, metadata !59, metadata !DIExpression()), !dbg !124
  %188 = icmp ult i64 %187, %11, !dbg !224
  %189 = icmp ult i64 %187, %1, !dbg !225
  %190 = and i1 %188, %189, !dbg !225
  br i1 %190, label %159, label %156, !dbg !123, !llvm.loop !226

191:                                              ; preds = %7, %191
  %192 = phi i64 [ %193, %191 ], [ 0, %7 ]
  call void @llvm.dbg.value(metadata i64 %192, metadata !53, metadata !DIExpression()), !dbg !118
  call void @llvm.dbg.value(metadata i64 0, metadata !55, metadata !DIExpression()), !dbg !122
  %193 = add i64 %192, 8, !dbg !253
  call void @llvm.dbg.value(metadata i64 %193, metadata !53, metadata !DIExpression()), !dbg !118
  %194 = icmp ult i64 %193, %1, !dbg !119
  br i1 %194, label %191, label %195, !dbg !120, !llvm.loop !130

195:                                              ; preds = %17, %191, %5
  ret void, !dbg !254
}

; Function Attrs: nofree norecurse nosync nounwind uwtable
define internal void @trans_tmp(i64 noundef %0, i64 noundef %1, double* nocapture noundef readonly %2, double* nocapture noundef writeonly %3, double* nocapture noundef %4) #2 !dbg !255 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !257, metadata !DIExpression()), !dbg !276
  call void @llvm.dbg.value(metadata i64 %1, metadata !258, metadata !DIExpression()), !dbg !276
  call void @llvm.dbg.value(metadata double* %2, metadata !259, metadata !DIExpression()), !dbg !276
  call void @llvm.dbg.value(metadata double* %3, metadata !260, metadata !DIExpression()), !dbg !276
  call void @llvm.dbg.value(metadata double* %4, metadata !261, metadata !DIExpression()), !dbg !276
  call void @llvm.dbg.value(metadata i64 0, metadata !262, metadata !DIExpression()), !dbg !277
  %6 = icmp eq i64 %1, 0, !dbg !278
  br i1 %6, label %105, label %7, !dbg !279

7:                                                ; preds = %5
  %8 = icmp eq i64 %0, 0
  br i1 %8, label %101, label %9, !dbg !280

9:                                                ; preds = %7, %17
  %10 = phi i64 [ %11, %17 ], [ 0, %7 ]
  call void @llvm.dbg.value(metadata i64 %10, metadata !262, metadata !DIExpression()), !dbg !277
  call void @llvm.dbg.value(metadata i64 0, metadata !264, metadata !DIExpression()), !dbg !281
  %11 = add i64 %10, 8
  %12 = icmp eq i64 %10, -8
  br i1 %12, label %13, label %19, !dbg !282

13:                                               ; preds = %9, %13
  %14 = phi i64 [ %15, %13 ], [ 0, %9 ]
  call void @llvm.dbg.value(metadata i64 %14, metadata !264, metadata !DIExpression()), !dbg !281
  call void @llvm.dbg.value(metadata i64 %10, metadata !268, metadata !DIExpression()), !dbg !283
  %15 = add i64 %14, 8, !dbg !284
  call void @llvm.dbg.value(metadata i64 %15, metadata !264, metadata !DIExpression()), !dbg !281
  %16 = icmp ult i64 %15, %0, !dbg !285
  br i1 %16, label %13, label %17, !dbg !280, !llvm.loop !286

17:                                               ; preds = %98, %13
  call void @llvm.dbg.value(metadata i64 %11, metadata !262, metadata !DIExpression()), !dbg !277
  %18 = icmp ult i64 %11, %1, !dbg !278
  br i1 %18, label %9, label %105, !dbg !279, !llvm.loop !288

19:                                               ; preds = %9, %98
  %20 = phi i64 [ %99, %98 ], [ 0, %9 ]
  call void @llvm.dbg.value(metadata i64 %20, metadata !264, metadata !DIExpression()), !dbg !281
  call void @llvm.dbg.value(metadata i64 %10, metadata !268, metadata !DIExpression()), !dbg !283
  %21 = or i64 %20, 1
  %22 = or i64 %20, 2
  %23 = or i64 %20, 3
  %24 = or i64 %20, 4
  %25 = or i64 %20, 5
  %26 = or i64 %20, 6
  %27 = or i64 %20, 7
  %28 = mul nsw i64 %20, %1
  %29 = getelementptr inbounds double, double* %3, i64 %28
  %30 = mul nsw i64 %21, %1
  %31 = getelementptr inbounds double, double* %3, i64 %30
  %32 = mul nsw i64 %22, %1
  %33 = getelementptr inbounds double, double* %3, i64 %32
  %34 = mul nsw i64 %23, %1
  %35 = getelementptr inbounds double, double* %3, i64 %34
  %36 = mul nsw i64 %24, %1
  %37 = getelementptr inbounds double, double* %3, i64 %36
  %38 = mul nsw i64 %25, %1
  %39 = getelementptr inbounds double, double* %3, i64 %38
  %40 = mul nsw i64 %26, %1
  %41 = getelementptr inbounds double, double* %3, i64 %40
  %42 = mul nsw i64 %27, %1
  %43 = getelementptr inbounds double, double* %3, i64 %42
  br label %44, !dbg !282

44:                                               ; preds = %44, %19
  %45 = phi i64 [ %10, %19 ], [ %96, %44 ]
  call void @llvm.dbg.value(metadata i64 %45, metadata !268, metadata !DIExpression()), !dbg !283
  call void @llvm.dbg.value(metadata i64 %45, metadata !272, metadata !DIExpression(DW_OP_constu, 7, DW_OP_and, DW_OP_stack_value)), !dbg !290
  %46 = shl i64 %45, 3, !dbg !291
  %47 = and i64 %46, 56, !dbg !291
  call void @llvm.dbg.value(metadata i64 %47, metadata !275, metadata !DIExpression()), !dbg !290
  %48 = mul nsw i64 %45, %0, !dbg !292
  %49 = getelementptr inbounds double, double* %2, i64 %48, !dbg !292
  %50 = getelementptr inbounds double, double* %49, i64 %20, !dbg !292
  %51 = load double, double* %50, align 8, !dbg !292, !tbaa !135
  %52 = getelementptr inbounds double, double* %4, i64 %47, !dbg !293
  store double %51, double* %52, align 8, !dbg !294, !tbaa !135
  %53 = getelementptr inbounds double, double* %49, i64 %21, !dbg !295
  %54 = load double, double* %53, align 8, !dbg !295, !tbaa !135
  %55 = or i64 %47, 1, !dbg !296
  %56 = getelementptr inbounds double, double* %4, i64 %55, !dbg !297
  store double %54, double* %56, align 8, !dbg !298, !tbaa !135
  %57 = getelementptr inbounds double, double* %49, i64 %22, !dbg !299
  %58 = load double, double* %57, align 8, !dbg !299, !tbaa !135
  %59 = or i64 %47, 2, !dbg !300
  %60 = getelementptr inbounds double, double* %4, i64 %59, !dbg !301
  store double %58, double* %60, align 8, !dbg !302, !tbaa !135
  %61 = getelementptr inbounds double, double* %49, i64 %23, !dbg !303
  %62 = load double, double* %61, align 8, !dbg !303, !tbaa !135
  %63 = or i64 %47, 3, !dbg !304
  %64 = getelementptr inbounds double, double* %4, i64 %63, !dbg !305
  store double %62, double* %64, align 8, !dbg !306, !tbaa !135
  %65 = getelementptr inbounds double, double* %49, i64 %24, !dbg !307
  %66 = load double, double* %65, align 8, !dbg !307, !tbaa !135
  %67 = or i64 %47, 4, !dbg !308
  %68 = getelementptr inbounds double, double* %4, i64 %67, !dbg !309
  store double %66, double* %68, align 8, !dbg !310, !tbaa !135
  %69 = getelementptr inbounds double, double* %49, i64 %25, !dbg !311
  %70 = load double, double* %69, align 8, !dbg !311, !tbaa !135
  %71 = or i64 %47, 5, !dbg !312
  %72 = getelementptr inbounds double, double* %4, i64 %71, !dbg !313
  store double %70, double* %72, align 8, !dbg !314, !tbaa !135
  %73 = getelementptr inbounds double, double* %49, i64 %26, !dbg !315
  %74 = load double, double* %73, align 8, !dbg !315, !tbaa !135
  %75 = or i64 %47, 6, !dbg !316
  %76 = getelementptr inbounds double, double* %4, i64 %75, !dbg !317
  store double %74, double* %76, align 8, !dbg !318, !tbaa !135
  %77 = getelementptr inbounds double, double* %49, i64 %27, !dbg !319
  %78 = load double, double* %77, align 8, !dbg !319, !tbaa !135
  %79 = or i64 %47, 7, !dbg !320
  %80 = getelementptr inbounds double, double* %4, i64 %79, !dbg !321
  store double %78, double* %80, align 8, !dbg !322, !tbaa !135
  %81 = getelementptr inbounds double, double* %29, i64 %45, !dbg !323
  store double %51, double* %81, align 8, !dbg !324, !tbaa !135
  %82 = load double, double* %56, align 8, !dbg !325, !tbaa !135
  %83 = getelementptr inbounds double, double* %31, i64 %45, !dbg !326
  store double %82, double* %83, align 8, !dbg !327, !tbaa !135
  %84 = load double, double* %60, align 8, !dbg !328, !tbaa !135
  %85 = getelementptr inbounds double, double* %33, i64 %45, !dbg !329
  store double %84, double* %85, align 8, !dbg !330, !tbaa !135
  %86 = load double, double* %64, align 8, !dbg !331, !tbaa !135
  %87 = getelementptr inbounds double, double* %35, i64 %45, !dbg !332
  store double %86, double* %87, align 8, !dbg !333, !tbaa !135
  %88 = load double, double* %68, align 8, !dbg !334, !tbaa !135
  %89 = getelementptr inbounds double, double* %37, i64 %45, !dbg !335
  store double %88, double* %89, align 8, !dbg !336, !tbaa !135
  %90 = load double, double* %72, align 8, !dbg !337, !tbaa !135
  %91 = getelementptr inbounds double, double* %39, i64 %45, !dbg !338
  store double %90, double* %91, align 8, !dbg !339, !tbaa !135
  %92 = load double, double* %76, align 8, !dbg !340, !tbaa !135
  %93 = getelementptr inbounds double, double* %41, i64 %45, !dbg !341
  store double %92, double* %93, align 8, !dbg !342, !tbaa !135
  %94 = load double, double* %80, align 8, !dbg !343, !tbaa !135
  %95 = getelementptr inbounds double, double* %43, i64 %45, !dbg !344
  store double %94, double* %95, align 8, !dbg !345, !tbaa !135
  %96 = add nuw i64 %45, 1, !dbg !346
  call void @llvm.dbg.value(metadata i64 %96, metadata !268, metadata !DIExpression()), !dbg !283
  %97 = icmp ult i64 %96, %11, !dbg !347
  br i1 %97, label %44, label %98, !dbg !282, !llvm.loop !348

98:                                               ; preds = %44
  %99 = add i64 %20, 8, !dbg !284
  call void @llvm.dbg.value(metadata i64 %99, metadata !264, metadata !DIExpression()), !dbg !281
  %100 = icmp ult i64 %99, %0, !dbg !285
  br i1 %100, label %19, label %17, !dbg !280, !llvm.loop !286

101:                                              ; preds = %7, %101
  %102 = phi i64 [ %103, %101 ], [ 0, %7 ]
  call void @llvm.dbg.value(metadata i64 %102, metadata !262, metadata !DIExpression()), !dbg !277
  call void @llvm.dbg.value(metadata i64 0, metadata !264, metadata !DIExpression()), !dbg !281
  %103 = add i64 %102, 8, !dbg !350
  call void @llvm.dbg.value(metadata i64 %103, metadata !262, metadata !DIExpression()), !dbg !277
  %104 = icmp ult i64 %103, %1, !dbg !278
  br i1 %104, label %101, label %105, !dbg !279, !llvm.loop !288

105:                                              ; preds = %17, %101, %5
  ret void, !dbg !351
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree norecurse nosync nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "trans.c", directory: "/afs/andrew.cmu.edu/usr7/hanningw/private/18213/cachelab4-Nonsens77")
!2 = !{i32 7, !"Dwarf Version", i32 4}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{!"Ubuntu clang version 14.0.0-1ubuntu1"}
!9 = distinct !DISubprogram(name: "registerFunctions", scope: !1, file: !1, line: 249, type: !10, scopeLine: 249, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !12)
!10 = !DISubroutineType(types: !11)
!11 = !{null}
!12 = !{}
!13 = !DILocation(line: 251, column: 5, scope: !9)
!14 = !DILocation(line: 254, column: 5, scope: !9)
!15 = !DILocation(line: 255, column: 5, scope: !9)
!16 = !DILocation(line: 256, column: 1, scope: !9)
!17 = !DISubprogram(name: "registerTransFunction", scope: !18, file: !18, line: 99, type: !19, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !12)
!18 = !DIFile(filename: "./cachelab.h", directory: "/afs/andrew.cmu.edu/usr7/hanningw/private/18213/cachelab4-Nonsens77")
!19 = !DISubroutineType(types: !20)
!20 = !{null, !21, !33}
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DISubroutineType(types: !23)
!23 = !{null, !24, !24, !27, !27, !32}
!24 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !25, line: 46, baseType: !26)
!25 = !DIFile(filename: "/usr/lib/llvm-14/lib/clang/14.0.0/include/stddef.h", directory: "")
!26 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, elements: !30)
!29 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!30 = !{!31}
!31 = !DISubrange(count: -1)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !35)
!35 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!36 = distinct !DISubprogram(name: "transpose_submit", scope: !1, file: !1, line: 233, type: !22, scopeLine: 234, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !37)
!37 = !{!38, !39, !40, !41, !42}
!38 = !DILocalVariable(name: "M", arg: 1, scope: !36, file: !1, line: 233, type: !24)
!39 = !DILocalVariable(name: "N", arg: 2, scope: !36, file: !1, line: 233, type: !24)
!40 = !DILocalVariable(name: "A", arg: 3, scope: !36, file: !1, line: 233, type: !27)
!41 = !DILocalVariable(name: "B", arg: 4, scope: !36, file: !1, line: 233, type: !27)
!42 = !DILocalVariable(name: "tmp", arg: 5, scope: !36, file: !1, line: 234, type: !32)
!43 = !DILocation(line: 0, scope: !36)
!44 = !DILocation(line: 239, column: 5, scope: !36)
!45 = !DILocation(line: 240, column: 1, scope: !36)
!46 = distinct !DISubprogram(name: "trans_basic", scope: !1, file: !1, line: 81, type: !22, scopeLine: 82, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !47)
!47 = !{!48, !49, !50, !51, !52, !53, !55, !59, !63, !68, !69, !70, !71, !72, !73, !74, !75, !78, !79, !80, !81, !82, !83, !84, !87, !88, !89, !90, !91, !92, !95, !96, !97, !98, !99, !102, !103, !104, !105, !108, !109, !110, !113, !114}
!48 = !DILocalVariable(name: "M", arg: 1, scope: !46, file: !1, line: 81, type: !24)
!49 = !DILocalVariable(name: "N", arg: 2, scope: !46, file: !1, line: 81, type: !24)
!50 = !DILocalVariable(name: "A", arg: 3, scope: !46, file: !1, line: 81, type: !27)
!51 = !DILocalVariable(name: "B", arg: 4, scope: !46, file: !1, line: 81, type: !27)
!52 = !DILocalVariable(name: "tmp", arg: 5, scope: !46, file: !1, line: 82, type: !32)
!53 = !DILocalVariable(name: "i", scope: !54, file: !1, line: 86, type: !24)
!54 = distinct !DILexicalBlock(scope: !46, file: !1, line: 86, column: 5)
!55 = !DILocalVariable(name: "j", scope: !56, file: !1, line: 87, type: !24)
!56 = distinct !DILexicalBlock(scope: !57, file: !1, line: 87, column: 9)
!57 = distinct !DILexicalBlock(scope: !58, file: !1, line: 86, column: 39)
!58 = distinct !DILexicalBlock(scope: !54, file: !1, line: 86, column: 5)
!59 = !DILocalVariable(name: "k", scope: !60, file: !1, line: 88, type: !24)
!60 = distinct !DILexicalBlock(scope: !61, file: !1, line: 88, column: 13)
!61 = distinct !DILexicalBlock(scope: !62, file: !1, line: 87, column: 43)
!62 = distinct !DILexicalBlock(scope: !56, file: !1, line: 87, column: 9)
!63 = !DILocalVariable(name: "a0", scope: !64, file: !1, line: 90, type: !29)
!64 = distinct !DILexicalBlock(scope: !65, file: !1, line: 89, column: 35)
!65 = distinct !DILexicalBlock(scope: !66, file: !1, line: 89, column: 21)
!66 = distinct !DILexicalBlock(scope: !67, file: !1, line: 88, column: 57)
!67 = distinct !DILexicalBlock(scope: !60, file: !1, line: 88, column: 13)
!68 = !DILocalVariable(name: "a1", scope: !64, file: !1, line: 91, type: !29)
!69 = !DILocalVariable(name: "a2", scope: !64, file: !1, line: 92, type: !29)
!70 = !DILocalVariable(name: "a3", scope: !64, file: !1, line: 93, type: !29)
!71 = !DILocalVariable(name: "a4", scope: !64, file: !1, line: 94, type: !29)
!72 = !DILocalVariable(name: "a5", scope: !64, file: !1, line: 95, type: !29)
!73 = !DILocalVariable(name: "a6", scope: !64, file: !1, line: 96, type: !29)
!74 = !DILocalVariable(name: "a7", scope: !64, file: !1, line: 97, type: !29)
!75 = !DILocalVariable(name: "a0", scope: !76, file: !1, line: 108, type: !29)
!76 = distinct !DILexicalBlock(scope: !77, file: !1, line: 107, column: 42)
!77 = distinct !DILexicalBlock(scope: !65, file: !1, line: 107, column: 28)
!78 = !DILocalVariable(name: "a1", scope: !76, file: !1, line: 109, type: !29)
!79 = !DILocalVariable(name: "a2", scope: !76, file: !1, line: 110, type: !29)
!80 = !DILocalVariable(name: "a3", scope: !76, file: !1, line: 111, type: !29)
!81 = !DILocalVariable(name: "a4", scope: !76, file: !1, line: 112, type: !29)
!82 = !DILocalVariable(name: "a5", scope: !76, file: !1, line: 113, type: !29)
!83 = !DILocalVariable(name: "a6", scope: !76, file: !1, line: 114, type: !29)
!84 = !DILocalVariable(name: "a0", scope: !85, file: !1, line: 124, type: !29)
!85 = distinct !DILexicalBlock(scope: !86, file: !1, line: 123, column: 42)
!86 = distinct !DILexicalBlock(scope: !77, file: !1, line: 123, column: 28)
!87 = !DILocalVariable(name: "a1", scope: !85, file: !1, line: 125, type: !29)
!88 = !DILocalVariable(name: "a2", scope: !85, file: !1, line: 126, type: !29)
!89 = !DILocalVariable(name: "a3", scope: !85, file: !1, line: 127, type: !29)
!90 = !DILocalVariable(name: "a4", scope: !85, file: !1, line: 128, type: !29)
!91 = !DILocalVariable(name: "a5", scope: !85, file: !1, line: 129, type: !29)
!92 = !DILocalVariable(name: "a0", scope: !93, file: !1, line: 138, type: !29)
!93 = distinct !DILexicalBlock(scope: !94, file: !1, line: 137, column: 42)
!94 = distinct !DILexicalBlock(scope: !86, file: !1, line: 137, column: 28)
!95 = !DILocalVariable(name: "a1", scope: !93, file: !1, line: 139, type: !29)
!96 = !DILocalVariable(name: "a2", scope: !93, file: !1, line: 140, type: !29)
!97 = !DILocalVariable(name: "a3", scope: !93, file: !1, line: 141, type: !29)
!98 = !DILocalVariable(name: "a4", scope: !93, file: !1, line: 142, type: !29)
!99 = !DILocalVariable(name: "a0", scope: !100, file: !1, line: 150, type: !29)
!100 = distinct !DILexicalBlock(scope: !101, file: !1, line: 149, column: 42)
!101 = distinct !DILexicalBlock(scope: !94, file: !1, line: 149, column: 28)
!102 = !DILocalVariable(name: "a1", scope: !100, file: !1, line: 151, type: !29)
!103 = !DILocalVariable(name: "a2", scope: !100, file: !1, line: 152, type: !29)
!104 = !DILocalVariable(name: "a3", scope: !100, file: !1, line: 153, type: !29)
!105 = !DILocalVariable(name: "a0", scope: !106, file: !1, line: 160, type: !29)
!106 = distinct !DILexicalBlock(scope: !107, file: !1, line: 159, column: 42)
!107 = distinct !DILexicalBlock(scope: !101, file: !1, line: 159, column: 28)
!108 = !DILocalVariable(name: "a1", scope: !106, file: !1, line: 161, type: !29)
!109 = !DILocalVariable(name: "a2", scope: !106, file: !1, line: 162, type: !29)
!110 = !DILocalVariable(name: "a0", scope: !111, file: !1, line: 168, type: !29)
!111 = distinct !DILexicalBlock(scope: !112, file: !1, line: 167, column: 42)
!112 = distinct !DILexicalBlock(scope: !107, file: !1, line: 167, column: 28)
!113 = !DILocalVariable(name: "a1", scope: !111, file: !1, line: 169, type: !29)
!114 = !DILocalVariable(name: "a0", scope: !115, file: !1, line: 174, type: !29)
!115 = distinct !DILexicalBlock(scope: !116, file: !1, line: 173, column: 42)
!116 = distinct !DILexicalBlock(scope: !112, file: !1, line: 173, column: 28)
!117 = !DILocation(line: 0, scope: !46)
!118 = !DILocation(line: 0, scope: !54)
!119 = !DILocation(line: 86, column: 26, scope: !58)
!120 = !DILocation(line: 86, column: 5, scope: !54)
!121 = !DILocation(line: 87, column: 9, scope: !56)
!122 = !DILocation(line: 0, scope: !56)
!123 = !DILocation(line: 88, column: 13, scope: !60)
!124 = !DILocation(line: 0, scope: !60)
!125 = !DILocation(line: 87, column: 37, scope: !62)
!126 = !DILocation(line: 87, column: 30, scope: !62)
!127 = distinct !{!127, !121, !128, !129}
!128 = !DILocation(line: 179, column: 9, scope: !56)
!129 = !{!"llvm.loop.unroll.disable"}
!130 = distinct !{!130, !120, !131, !129}
!131 = !DILocation(line: 180, column: 5, scope: !54)
!132 = !DILocation(line: 89, column: 21, scope: !66)
!133 = !DILocation(line: 107, column: 28, scope: !65)
!134 = !DILocation(line: 174, column: 33, scope: !115)
!135 = !{!136, !136, i64 0}
!136 = !{!"double", !137, i64 0}
!137 = !{!"omnipotent char", !138, i64 0}
!138 = !{!"Simple C/C++ TBAA"}
!139 = !DILocation(line: 0, scope: !115)
!140 = !DILocation(line: 177, column: 17, scope: !115)
!141 = !DILocation(line: 168, column: 33, scope: !111)
!142 = !DILocation(line: 0, scope: !111)
!143 = !DILocation(line: 169, column: 33, scope: !111)
!144 = !DILocation(line: 171, column: 21, scope: !111)
!145 = !DILocation(line: 171, column: 29, scope: !111)
!146 = !DILocation(line: 173, column: 17, scope: !111)
!147 = !DILocation(line: 160, column: 33, scope: !106)
!148 = !DILocation(line: 0, scope: !106)
!149 = !DILocation(line: 161, column: 33, scope: !106)
!150 = !DILocation(line: 162, column: 33, scope: !106)
!151 = !DILocation(line: 164, column: 21, scope: !106)
!152 = !DILocation(line: 164, column: 29, scope: !106)
!153 = !DILocation(line: 165, column: 21, scope: !106)
!154 = !DILocation(line: 165, column: 33, scope: !106)
!155 = !DILocation(line: 167, column: 17, scope: !106)
!156 = !DILocation(line: 150, column: 33, scope: !100)
!157 = !DILocation(line: 0, scope: !100)
!158 = !DILocation(line: 151, column: 33, scope: !100)
!159 = !DILocation(line: 152, column: 33, scope: !100)
!160 = !DILocation(line: 153, column: 33, scope: !100)
!161 = !DILocation(line: 155, column: 21, scope: !100)
!162 = !DILocation(line: 155, column: 29, scope: !100)
!163 = !DILocation(line: 156, column: 21, scope: !100)
!164 = !DILocation(line: 156, column: 33, scope: !100)
!165 = !DILocation(line: 157, column: 21, scope: !100)
!166 = !DILocation(line: 157, column: 33, scope: !100)
!167 = !DILocation(line: 159, column: 17, scope: !100)
!168 = !DILocation(line: 138, column: 33, scope: !93)
!169 = !DILocation(line: 0, scope: !93)
!170 = !DILocation(line: 139, column: 33, scope: !93)
!171 = !DILocation(line: 140, column: 33, scope: !93)
!172 = !DILocation(line: 141, column: 33, scope: !93)
!173 = !DILocation(line: 142, column: 33, scope: !93)
!174 = !DILocation(line: 144, column: 21, scope: !93)
!175 = !DILocation(line: 144, column: 29, scope: !93)
!176 = !DILocation(line: 145, column: 21, scope: !93)
!177 = !DILocation(line: 145, column: 33, scope: !93)
!178 = !DILocation(line: 146, column: 21, scope: !93)
!179 = !DILocation(line: 146, column: 33, scope: !93)
!180 = !DILocation(line: 147, column: 21, scope: !93)
!181 = !DILocation(line: 147, column: 33, scope: !93)
!182 = !DILocation(line: 149, column: 17, scope: !93)
!183 = !DILocation(line: 124, column: 33, scope: !85)
!184 = !DILocation(line: 0, scope: !85)
!185 = !DILocation(line: 125, column: 33, scope: !85)
!186 = !DILocation(line: 126, column: 33, scope: !85)
!187 = !DILocation(line: 127, column: 33, scope: !85)
!188 = !DILocation(line: 128, column: 33, scope: !85)
!189 = !DILocation(line: 129, column: 33, scope: !85)
!190 = !DILocation(line: 131, column: 21, scope: !85)
!191 = !DILocation(line: 131, column: 29, scope: !85)
!192 = !DILocation(line: 132, column: 21, scope: !85)
!193 = !DILocation(line: 132, column: 33, scope: !85)
!194 = !DILocation(line: 133, column: 21, scope: !85)
!195 = !DILocation(line: 133, column: 33, scope: !85)
!196 = !DILocation(line: 134, column: 21, scope: !85)
!197 = !DILocation(line: 134, column: 33, scope: !85)
!198 = !DILocation(line: 135, column: 21, scope: !85)
!199 = !DILocation(line: 135, column: 33, scope: !85)
!200 = !DILocation(line: 137, column: 17, scope: !85)
!201 = !DILocation(line: 108, column: 33, scope: !76)
!202 = !DILocation(line: 0, scope: !76)
!203 = !DILocation(line: 109, column: 33, scope: !76)
!204 = !DILocation(line: 110, column: 33, scope: !76)
!205 = !DILocation(line: 111, column: 33, scope: !76)
!206 = !DILocation(line: 112, column: 33, scope: !76)
!207 = !DILocation(line: 113, column: 33, scope: !76)
!208 = !DILocation(line: 114, column: 33, scope: !76)
!209 = !DILocation(line: 116, column: 21, scope: !76)
!210 = !DILocation(line: 116, column: 29, scope: !76)
!211 = !DILocation(line: 117, column: 21, scope: !76)
!212 = !DILocation(line: 117, column: 33, scope: !76)
!213 = !DILocation(line: 118, column: 21, scope: !76)
!214 = !DILocation(line: 118, column: 33, scope: !76)
!215 = !DILocation(line: 119, column: 21, scope: !76)
!216 = !DILocation(line: 119, column: 33, scope: !76)
!217 = !DILocation(line: 120, column: 21, scope: !76)
!218 = !DILocation(line: 120, column: 33, scope: !76)
!219 = !DILocation(line: 121, column: 21, scope: !76)
!220 = !DILocation(line: 121, column: 33, scope: !76)
!221 = !DILocation(line: 123, column: 17, scope: !76)
!222 = !DILocation(line: 0, scope: !77)
!223 = !DILocation(line: 88, column: 53, scope: !67)
!224 = !DILocation(line: 88, column: 34, scope: !67)
!225 = !DILocation(line: 88, column: 42, scope: !67)
!226 = distinct !{!226, !123, !227, !129}
!227 = !DILocation(line: 178, column: 13, scope: !60)
!228 = !DILocation(line: 90, column: 33, scope: !64)
!229 = !DILocation(line: 0, scope: !64)
!230 = !DILocation(line: 91, column: 33, scope: !64)
!231 = !DILocation(line: 92, column: 33, scope: !64)
!232 = !DILocation(line: 93, column: 33, scope: !64)
!233 = !DILocation(line: 94, column: 33, scope: !64)
!234 = !DILocation(line: 95, column: 33, scope: !64)
!235 = !DILocation(line: 96, column: 33, scope: !64)
!236 = !DILocation(line: 97, column: 33, scope: !64)
!237 = !DILocation(line: 99, column: 21, scope: !64)
!238 = !DILocation(line: 99, column: 29, scope: !64)
!239 = !DILocation(line: 100, column: 21, scope: !64)
!240 = !DILocation(line: 100, column: 33, scope: !64)
!241 = !DILocation(line: 101, column: 21, scope: !64)
!242 = !DILocation(line: 101, column: 33, scope: !64)
!243 = !DILocation(line: 102, column: 21, scope: !64)
!244 = !DILocation(line: 102, column: 33, scope: !64)
!245 = !DILocation(line: 103, column: 21, scope: !64)
!246 = !DILocation(line: 103, column: 33, scope: !64)
!247 = !DILocation(line: 104, column: 21, scope: !64)
!248 = !DILocation(line: 104, column: 33, scope: !64)
!249 = !DILocation(line: 105, column: 21, scope: !64)
!250 = !DILocation(line: 105, column: 33, scope: !64)
!251 = !DILocation(line: 106, column: 21, scope: !64)
!252 = !DILocation(line: 106, column: 33, scope: !64)
!253 = !DILocation(line: 86, column: 33, scope: !58)
!254 = !DILocation(line: 183, column: 1, scope: !46)
!255 = distinct !DISubprogram(name: "trans_tmp", scope: !1, file: !1, line: 191, type: !22, scopeLine: 192, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !256)
!256 = !{!257, !258, !259, !260, !261, !262, !264, !268, !272, !275}
!257 = !DILocalVariable(name: "M", arg: 1, scope: !255, file: !1, line: 191, type: !24)
!258 = !DILocalVariable(name: "N", arg: 2, scope: !255, file: !1, line: 191, type: !24)
!259 = !DILocalVariable(name: "A", arg: 3, scope: !255, file: !1, line: 191, type: !27)
!260 = !DILocalVariable(name: "B", arg: 4, scope: !255, file: !1, line: 191, type: !27)
!261 = !DILocalVariable(name: "tmp", arg: 5, scope: !255, file: !1, line: 192, type: !32)
!262 = !DILocalVariable(name: "i", scope: !263, file: !1, line: 196, type: !24)
!263 = distinct !DILexicalBlock(scope: !255, file: !1, line: 196, column: 5)
!264 = !DILocalVariable(name: "j", scope: !265, file: !1, line: 197, type: !24)
!265 = distinct !DILexicalBlock(scope: !266, file: !1, line: 197, column: 9)
!266 = distinct !DILexicalBlock(scope: !267, file: !1, line: 196, column: 39)
!267 = distinct !DILexicalBlock(scope: !263, file: !1, line: 196, column: 5)
!268 = !DILocalVariable(name: "k", scope: !269, file: !1, line: 198, type: !24)
!269 = distinct !DILexicalBlock(scope: !270, file: !1, line: 198, column: 13)
!270 = distinct !DILexicalBlock(scope: !271, file: !1, line: 197, column: 43)
!271 = distinct !DILexicalBlock(scope: !265, file: !1, line: 197, column: 9)
!272 = !DILocalVariable(name: "dk", scope: !273, file: !1, line: 199, type: !24)
!273 = distinct !DILexicalBlock(scope: !274, file: !1, line: 198, column: 48)
!274 = distinct !DILexicalBlock(scope: !269, file: !1, line: 198, column: 13)
!275 = !DILocalVariable(name: "index", scope: !273, file: !1, line: 200, type: !24)
!276 = !DILocation(line: 0, scope: !255)
!277 = !DILocation(line: 0, scope: !263)
!278 = !DILocation(line: 196, column: 26, scope: !267)
!279 = !DILocation(line: 196, column: 5, scope: !263)
!280 = !DILocation(line: 197, column: 9, scope: !265)
!281 = !DILocation(line: 0, scope: !265)
!282 = !DILocation(line: 198, column: 13, scope: !269)
!283 = !DILocation(line: 0, scope: !269)
!284 = !DILocation(line: 197, column: 37, scope: !271)
!285 = !DILocation(line: 197, column: 30, scope: !271)
!286 = distinct !{!286, !280, !287, !129}
!287 = !DILocation(line: 220, column: 9, scope: !265)
!288 = distinct !{!288, !279, !289, !129}
!289 = !DILocation(line: 221, column: 5, scope: !263)
!290 = !DILocation(line: 0, scope: !273)
!291 = !DILocation(line: 200, column: 35, scope: !273)
!292 = !DILocation(line: 202, column: 30, scope: !273)
!293 = !DILocation(line: 202, column: 17, scope: !273)
!294 = !DILocation(line: 202, column: 28, scope: !273)
!295 = !DILocation(line: 203, column: 34, scope: !273)
!296 = !DILocation(line: 203, column: 27, scope: !273)
!297 = !DILocation(line: 203, column: 17, scope: !273)
!298 = !DILocation(line: 203, column: 32, scope: !273)
!299 = !DILocation(line: 204, column: 34, scope: !273)
!300 = !DILocation(line: 204, column: 27, scope: !273)
!301 = !DILocation(line: 204, column: 17, scope: !273)
!302 = !DILocation(line: 204, column: 32, scope: !273)
!303 = !DILocation(line: 205, column: 34, scope: !273)
!304 = !DILocation(line: 205, column: 27, scope: !273)
!305 = !DILocation(line: 205, column: 17, scope: !273)
!306 = !DILocation(line: 205, column: 32, scope: !273)
!307 = !DILocation(line: 206, column: 34, scope: !273)
!308 = !DILocation(line: 206, column: 27, scope: !273)
!309 = !DILocation(line: 206, column: 17, scope: !273)
!310 = !DILocation(line: 206, column: 32, scope: !273)
!311 = !DILocation(line: 207, column: 34, scope: !273)
!312 = !DILocation(line: 207, column: 27, scope: !273)
!313 = !DILocation(line: 207, column: 17, scope: !273)
!314 = !DILocation(line: 207, column: 32, scope: !273)
!315 = !DILocation(line: 208, column: 34, scope: !273)
!316 = !DILocation(line: 208, column: 27, scope: !273)
!317 = !DILocation(line: 208, column: 17, scope: !273)
!318 = !DILocation(line: 208, column: 32, scope: !273)
!319 = !DILocation(line: 209, column: 34, scope: !273)
!320 = !DILocation(line: 209, column: 27, scope: !273)
!321 = !DILocation(line: 209, column: 17, scope: !273)
!322 = !DILocation(line: 209, column: 32, scope: !273)
!323 = !DILocation(line: 211, column: 17, scope: !273)
!324 = !DILocation(line: 211, column: 25, scope: !273)
!325 = !DILocation(line: 212, column: 31, scope: !273)
!326 = !DILocation(line: 212, column: 17, scope: !273)
!327 = !DILocation(line: 212, column: 29, scope: !273)
!328 = !DILocation(line: 213, column: 31, scope: !273)
!329 = !DILocation(line: 213, column: 17, scope: !273)
!330 = !DILocation(line: 213, column: 29, scope: !273)
!331 = !DILocation(line: 214, column: 31, scope: !273)
!332 = !DILocation(line: 214, column: 17, scope: !273)
!333 = !DILocation(line: 214, column: 29, scope: !273)
!334 = !DILocation(line: 215, column: 31, scope: !273)
!335 = !DILocation(line: 215, column: 17, scope: !273)
!336 = !DILocation(line: 215, column: 29, scope: !273)
!337 = !DILocation(line: 216, column: 31, scope: !273)
!338 = !DILocation(line: 216, column: 17, scope: !273)
!339 = !DILocation(line: 216, column: 29, scope: !273)
!340 = !DILocation(line: 217, column: 31, scope: !273)
!341 = !DILocation(line: 217, column: 17, scope: !273)
!342 = !DILocation(line: 217, column: 29, scope: !273)
!343 = !DILocation(line: 218, column: 31, scope: !273)
!344 = !DILocation(line: 218, column: 17, scope: !273)
!345 = !DILocation(line: 218, column: 29, scope: !273)
!346 = !DILocation(line: 198, column: 44, scope: !274)
!347 = !DILocation(line: 198, column: 34, scope: !274)
!348 = distinct !{!348, !282, !349, !129}
!349 = !DILocation(line: 219, column: 13, scope: !269)
!350 = !DILocation(line: 196, column: 33, scope: !267)
!351 = !DILocation(line: 224, column: 1, scope: !255)

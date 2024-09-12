; ModuleID = 'mm.c'
source_filename = "mm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.root = type { i64 }
%struct.block = type { i64, %union.anon }
%union.anon = type { %struct.anon }
%struct.anon = type { %struct.block*, %struct.block* }

@heap_list = dso_local local_unnamed_addr global %union.root* null, align 8, !dbg !0
@heap_start = internal unnamed_addr global %struct.block* null, align 8, !dbg !57

; Function Attrs: nounwind uwtable
define dso_local zeroext i1 @mm_checkheap(i32 noundef %0) local_unnamed_addr #0 !dbg !73 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !78, metadata !DIExpression()), !dbg !105
  %2 = load i8*, i8** bitcast (%struct.block** @heap_start to i8**), align 8, !dbg !106, !tbaa !107
  %3 = ptrtoint i8* %2 to i64, !dbg !111
  call void @llvm.dbg.value(metadata i64 %3, metadata !80, metadata !DIExpression()), !dbg !105
  %4 = tail call i8* @mem_heap_lo() #6, !dbg !112
  call void @llvm.dbg.value(metadata i8* %4, metadata !81, metadata !DIExpression()), !dbg !105
  %5 = tail call i8* @mem_heap_hi() #6, !dbg !113
  call void @llvm.dbg.value(metadata i8* %5, metadata !82, metadata !DIExpression()), !dbg !105
  call void @llvm.dbg.value(metadata i64 0, metadata !83, metadata !DIExpression()), !dbg !105
  %6 = load %struct.block*, %struct.block** @heap_start, align 8, !dbg !114, !tbaa !107
  call void @llvm.dbg.value(metadata %struct.block* %6, metadata !79, metadata !DIExpression()), !dbg !105
  call void @llvm.dbg.value(metadata i64 0, metadata !83, metadata !DIExpression()), !dbg !105
  %7 = getelementptr %struct.block, %struct.block* %6, i64 0, i32 0, !dbg !115
  %8 = load i64, i64* %7, align 8, !dbg !115, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !124
  call void @llvm.dbg.value(metadata i64 %8, metadata !126, metadata !DIExpression()), !dbg !131
  %9 = and i64 %8, -16, !dbg !133
  %10 = icmp eq i64 %9, 0, !dbg !134
  br i1 %10, label %11, label %13, !dbg !135

11:                                               ; preds = %1
  %12 = tail call i64 @mem_heapsize() #6, !dbg !136
  br label %53, !dbg !138

13:                                               ; preds = %1
  %14 = bitcast i8* %4 to %struct.block*
  %15 = bitcast i8* %5 to %struct.block*
  br label %16, !dbg !135

16:                                               ; preds = %13, %42
  %17 = phi i64 [ %9, %13 ], [ %48, %42 ]
  %18 = phi i64 [ %8, %13 ], [ %47, %42 ]
  %19 = phi %struct.block* [ %6, %13 ], [ %45, %42 ]
  %20 = phi i64 [ 0, %13 ], [ %21, %42 ]
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !79, metadata !DIExpression()), !dbg !105
  call void @llvm.dbg.value(metadata i64 %20, metadata !83, metadata !DIExpression()), !dbg !105
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !84, metadata !DIExpression()), !dbg !139
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !140
  call void @llvm.dbg.value(metadata i64 %18, metadata !126, metadata !DIExpression()), !dbg !142
  %21 = add i64 %17, %20, !dbg !144
  call void @llvm.dbg.value(metadata i64 %21, metadata !83, metadata !DIExpression()), !dbg !105
  %22 = icmp ult %struct.block* %19, %14, !dbg !145
  %23 = icmp ugt %struct.block* %19, %15
  %24 = select i1 %22, i1 true, i1 %23, !dbg !147
  br i1 %24, label %127, label %25, !dbg !147

25:                                               ; preds = %16
  %26 = ptrtoint %struct.block* %19 to i64, !dbg !148
  call void @llvm.dbg.value(metadata i64 %26, metadata !84, metadata !DIExpression()), !dbg !139
  %27 = sub i64 %26, %3, !dbg !149
  %28 = and i64 %27, 15, !dbg !151
  %29 = icmp eq i64 %28, 0, !dbg !152
  br i1 %29, label %30, label %127, !dbg !153

30:                                               ; preds = %25
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !154, metadata !DIExpression()), !dbg !159
  %31 = getelementptr inbounds %struct.block, %struct.block* %19, i64 0, i32 1, !dbg !161
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !162
  call void @llvm.dbg.value(metadata i64 %18, metadata !126, metadata !DIExpression()), !dbg !164
  %32 = getelementptr inbounds %union.anon, %union.anon* %31, i64 -1, !dbg !166
  %33 = bitcast %union.anon* %32 to i8*, !dbg !166
  %34 = getelementptr inbounds i8, i8* %33, i64 %17, !dbg !167
  %35 = bitcast i8* %34 to i64*, !dbg !168
  %36 = load i64, i64* %35, align 8, !dbg !169, !tbaa !170
  call void @llvm.dbg.value(metadata i64 %36, metadata !171, metadata !DIExpression()), !dbg !176
  %37 = and i64 %36, 1, !dbg !178
  %38 = icmp ne i64 %37, 0, !dbg !179
  call void @llvm.dbg.value(metadata i1 %38, metadata !88, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !139
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !180, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.value(metadata i64 %18, metadata !171, metadata !DIExpression()), !dbg !188
  %39 = and i64 %18, 1, !dbg !190
  %40 = icmp ne i64 %39, 0, !dbg !191
  %41 = xor i1 %40, %38, !dbg !192
  br i1 %41, label %127, label %42

42:                                               ; preds = %30
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !193, metadata !DIExpression()), !dbg !198
  %43 = bitcast %struct.block* %19 to i8*, !dbg !200
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !201
  call void @llvm.dbg.value(metadata i64 undef, metadata !126, metadata !DIExpression()), !dbg !203
  %44 = getelementptr inbounds i8, i8* %43, i64 %17, !dbg !205
  %45 = bitcast i8* %44 to %struct.block*, !dbg !206
  call void @llvm.dbg.value(metadata %struct.block* %45, metadata !79, metadata !DIExpression()), !dbg !105
  call void @llvm.dbg.value(metadata i64 %21, metadata !83, metadata !DIExpression()), !dbg !105
  %46 = bitcast i8* %44 to i64*, !dbg !115
  %47 = load i64, i64* %46, align 8, !dbg !115, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !124
  call void @llvm.dbg.value(metadata i64 %47, metadata !126, metadata !DIExpression()), !dbg !131
  %48 = and i64 %47, -16, !dbg !133
  %49 = icmp eq i64 %48, 0, !dbg !134
  br i1 %49, label %50, label %16, !dbg !135, !llvm.loop !207

50:                                               ; preds = %42
  %51 = tail call i64 @mem_heapsize() #6, !dbg !136
  %52 = icmp ugt i64 %21, %51, !dbg !210
  br i1 %52, label %127, label %53, !dbg !138

53:                                               ; preds = %11, %50
  %54 = load %union.root*, %union.root** @heap_list, align 8, !tbaa !107
  %55 = bitcast i8* %4 to %struct.block*
  %56 = bitcast i8* %5 to %struct.block*
  call void @llvm.dbg.value(metadata i64 0, metadata !89, metadata !DIExpression()), !dbg !211
  br label %57, !dbg !212

57:                                               ; preds = %53, %120
  %58 = phi i1 [ true, %53 ], [ %122, %120 ]
  %59 = phi i64 [ 0, %53 ], [ %121, %120 ]
  call void @llvm.dbg.value(metadata i64 %59, metadata !89, metadata !DIExpression()), !dbg !211
  %60 = getelementptr inbounds %union.root, %union.root* %54, i64 %59, !dbg !213
  %61 = bitcast %union.root* %60 to %struct.block**, !dbg !214
  %62 = load %struct.block*, %struct.block** %61, align 8, !dbg !214, !tbaa !215
  call void @llvm.dbg.value(metadata %struct.block* %62, metadata !79, metadata !DIExpression()), !dbg !105
  %63 = trunc i64 %59 to i32
  %64 = add i32 %63, 4
  %65 = shl nuw i32 1, %64
  %66 = zext i32 %65 to i64
  %67 = add i32 %63, 3
  %68 = shl nuw i32 1, %67
  %69 = zext i32 %68 to i64
  call void @llvm.dbg.value(metadata %struct.block* %62, metadata !79, metadata !DIExpression()), !dbg !105
  %70 = icmp eq %struct.block* %62, null, !dbg !216
  br i1 %70, label %120, label %71, !dbg !217

71:                                               ; preds = %57, %114
  %72 = phi %struct.block* [ %104, %114 ], [ %62, %57 ]
  call void @llvm.dbg.value(metadata %struct.block* %72, metadata !79, metadata !DIExpression()), !dbg !105
  call void @llvm.dbg.value(metadata %struct.block* %72, metadata !218, metadata !DIExpression()), !dbg !222
  call void @llvm.dbg.value(metadata %struct.block* %72, metadata !224, metadata !DIExpression()), !dbg !227
  %73 = getelementptr inbounds %struct.block, %struct.block* %72, i64 0, i32 0, !dbg !229
  %74 = getelementptr inbounds i64, i64* %73, i64 -1, !dbg !230
  call void @llvm.dbg.value(metadata i64* %74, metadata !221, metadata !DIExpression()), !dbg !222
  %75 = load i64, i64* %74, align 8, !dbg !231, !tbaa !170
  call void @llvm.dbg.value(metadata i64 %75, metadata !126, metadata !DIExpression()), !dbg !233
  %76 = and i64 %75, -16, !dbg !235
  %77 = icmp eq i64 %76, 0, !dbg !236
  %78 = bitcast %struct.block* %72 to i8*, !dbg !237
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !91, metadata !DIExpression()), !dbg !238
  call void @llvm.dbg.value(metadata %struct.block* %72, metadata !193, metadata !DIExpression()), !dbg !239
  %79 = load i64, i64* %73, align 8, !dbg !241, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !242
  call void @llvm.dbg.value(metadata i64 %79, metadata !126, metadata !DIExpression()), !dbg !244
  %80 = and i64 %79, -16, !dbg !246
  %81 = getelementptr inbounds i8, i8* %78, i64 %80, !dbg !247
  call void @llvm.dbg.value(metadata i8* %81, metadata !95, metadata !DIExpression()), !dbg !238
  br i1 %77, label %89, label %82, !dbg !248

82:                                               ; preds = %71
  %83 = sub i64 0, %76, !dbg !237
  %84 = getelementptr inbounds i8, i8* %78, i64 %83, !dbg !237
  call void @llvm.dbg.value(metadata i8* %84, metadata !91, metadata !DIExpression()), !dbg !238
  %85 = bitcast i8* %84 to i64*, !dbg !250
  %86 = load i64, i64* %85, align 8, !dbg !250, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !180, metadata !DIExpression()), !dbg !251
  call void @llvm.dbg.value(metadata i64 %86, metadata !171, metadata !DIExpression()), !dbg !253
  %87 = and i64 %86, 1, !dbg !255
  %88 = icmp eq i64 %87, 0, !dbg !256
  br i1 %88, label %124, label %89, !dbg !257

89:                                               ; preds = %71, %82
  %90 = bitcast i8* %81 to i64*, !dbg !258
  %91 = load i64, i64* %90, align 8, !dbg !258, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !180, metadata !DIExpression()), !dbg !260
  call void @llvm.dbg.value(metadata i64 %91, metadata !171, metadata !DIExpression()), !dbg !262
  %92 = and i64 %91, 1, !dbg !264
  %93 = icmp eq i64 %92, 0, !dbg !265
  br i1 %93, label %124, label %94, !dbg !266

94:                                               ; preds = %89
  %95 = getelementptr inbounds %struct.block, %struct.block* %72, i64 0, i32 1, i32 0, i32 0, !dbg !267
  %96 = load %struct.block*, %struct.block** %95, align 8, !dbg !267, !tbaa !215
  %97 = icmp eq %struct.block* %96, null, !dbg !268
  br i1 %97, label %102, label %98, !dbg !269

98:                                               ; preds = %94
  call void @llvm.dbg.value(metadata %struct.block* %96, metadata !96, metadata !DIExpression()), !dbg !270
  call void @llvm.dbg.value(metadata %struct.block* %96, metadata !99, metadata !DIExpression()), !dbg !270
  %99 = icmp ult %struct.block* %96, %55, !dbg !271
  %100 = icmp ugt %struct.block* %96, %56
  %101 = select i1 %99, i1 true, i1 %100, !dbg !273
  br i1 %101, label %124, label %102, !dbg !273

102:                                              ; preds = %98, %94
  %103 = getelementptr inbounds %struct.block, %struct.block* %72, i64 0, i32 1, i32 0, i32 1, !dbg !274
  %104 = load %struct.block*, %struct.block** %103, align 8, !dbg !274, !tbaa !215
  %105 = icmp eq %struct.block* %104, null, !dbg !275
  br i1 %105, label %116, label %106, !dbg !276

106:                                              ; preds = %102
  call void @llvm.dbg.value(metadata %struct.block* %104, metadata !100, metadata !DIExpression()), !dbg !277
  call void @llvm.dbg.value(metadata %struct.block* %104, metadata !103, metadata !DIExpression()), !dbg !277
  %107 = icmp ult %struct.block* %104, %55, !dbg !278
  %108 = icmp ugt %struct.block* %104, %56
  %109 = select i1 %107, i1 true, i1 %108, !dbg !280
  %110 = icmp ugt i64 %80, %66
  %111 = select i1 %109, i1 true, i1 %110, !dbg !280
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !281
  call void @llvm.dbg.value(metadata i64 %79, metadata !126, metadata !DIExpression()), !dbg !283
  call void @llvm.dbg.value(metadata i64 %80, metadata !104, metadata !DIExpression()), !dbg !238
  %112 = icmp ult i64 %80, %69
  %113 = select i1 %111, i1 true, i1 %112, !dbg !280
  br i1 %113, label %124, label %114, !dbg !280

114:                                              ; preds = %106, %116
  call void @llvm.dbg.value(metadata %struct.block* %104, metadata !79, metadata !DIExpression()), !dbg !105
  %115 = icmp eq %struct.block* %104, null, !dbg !216
  br i1 %115, label %120, label %71, !dbg !217, !llvm.loop !285

116:                                              ; preds = %102
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !281
  call void @llvm.dbg.value(metadata i64 %79, metadata !126, metadata !DIExpression()), !dbg !283
  call void @llvm.dbg.value(metadata i64 %80, metadata !104, metadata !DIExpression()), !dbg !238
  %117 = icmp ugt i64 %80, %66, !dbg !287
  %118 = icmp ult i64 %80, %69
  %119 = select i1 %117, i1 true, i1 %118, !dbg !289
  br i1 %119, label %124, label %114, !dbg !289

120:                                              ; preds = %114, %57
  %121 = add nuw nsw i64 %59, 1, !dbg !290
  call void @llvm.dbg.value(metadata i64 %121, metadata !89, metadata !DIExpression()), !dbg !211
  %122 = icmp ult i64 %59, 19, !dbg !291
  %123 = icmp eq i64 %121, 20, !dbg !291
  br i1 %123, label %124, label %57, !dbg !212, !llvm.loop !292

124:                                              ; preds = %120, %116, %106, %98, %89, %82
  %125 = phi i1 [ %58, %82 ], [ %58, %89 ], [ %58, %98 ], [ %58, %106 ], [ %58, %116 ], [ %122, %120 ]
  %126 = xor i1 %125, true
  br label %127

127:                                              ; preds = %30, %25, %16, %124, %50
  %128 = phi i1 [ false, %50 ], [ %126, %124 ], [ false, %16 ], [ false, %25 ], [ false, %30 ], !dbg !105
  ret i1 %128, !dbg !294
}

declare !dbg !295 i8* @mem_heap_lo() local_unnamed_addr #1

declare !dbg !300 i8* @mem_heap_hi() local_unnamed_addr #1

declare !dbg !301 i64 @mem_heapsize() local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local zeroext i1 @mm_init() local_unnamed_addr #0 !dbg !304 {
  %1 = tail call i8* @mem_sbrk(i64 noundef 176) #6, !dbg !310
  store i8* %1, i8** bitcast (%union.root** @heap_list to i8**), align 8, !dbg !311, !tbaa !107
  %2 = icmp eq i8* %1, inttoptr (i64 -1 to i8*), !dbg !312
  br i1 %2, label %21, label %3, !dbg !314

3:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i64 0, metadata !308, metadata !DIExpression()), !dbg !315
  %4 = bitcast i8* %1 to %struct.block**, !dbg !316
  store %struct.block* null, %struct.block** %4, align 8, !dbg !319, !tbaa !215
  call void @llvm.dbg.value(metadata i64 1, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 1, metadata !308, metadata !DIExpression()), !dbg !315
  %5 = load %union.root*, %union.root** @heap_list, align 8, !dbg !320, !tbaa !107
  %6 = getelementptr inbounds %union.root, %union.root* %5, i64 1, !dbg !320
  call void @llvm.dbg.value(metadata i64 2, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 2, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 3, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 3, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 4, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 4, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 5, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 5, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 6, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 6, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 7, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 7, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 8, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 8, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 9, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 9, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 10, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 10, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 11, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 11, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 12, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 12, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 13, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 13, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 14, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 14, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 15, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 15, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 16, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 16, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 17, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 17, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 18, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 18, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 19, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 19, metadata !308, metadata !DIExpression()), !dbg !315
  call void @llvm.dbg.value(metadata i64 20, metadata !308, metadata !DIExpression()), !dbg !315
  %7 = getelementptr inbounds %union.root, %union.root* %5, i64 20, i32 0, !dbg !321
  %8 = bitcast %union.root* %6 to i8*, !dbg !322
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(152) %8, i8 0, i64 152, i1 false), !dbg !319
  %9 = getelementptr inbounds %union.root, %union.root* %5, i64 21, i32 0, !dbg !323
  %10 = bitcast i64* %7 to <2 x i64>*, !dbg !322
  store <2 x i64> <i64 1, i64 1>, <2 x i64>* %10, align 8, !dbg !322, !tbaa !215
  store i64* %9, i64** bitcast (%struct.block** @heap_start to i64**), align 8, !dbg !324, !tbaa !107
  call void @llvm.dbg.value(metadata i64 4096, metadata !325, metadata !DIExpression()) #6, !dbg !333
  call void @llvm.dbg.value(metadata i64 4096, metadata !325, metadata !DIExpression()) #6, !dbg !333
  %11 = tail call i8* @mem_sbrk(i64 noundef 4096) #6, !dbg !336
  call void @llvm.dbg.value(metadata i8* %11, metadata !330, metadata !DIExpression()) #6, !dbg !333
  %12 = icmp eq i8* %11, inttoptr (i64 -1 to i8*), !dbg !338
  br i1 %12, label %21, label %13, !dbg !339

13:                                               ; preds = %3
  call void @llvm.dbg.value(metadata i8* %11, metadata !340, metadata !DIExpression()) #6, !dbg !345
  %14 = getelementptr inbounds i8, i8* %11, i64 -8, !dbg !347
  %15 = bitcast i8* %14 to %struct.block*, !dbg !348
  call void @llvm.dbg.value(metadata %struct.block* %15, metadata !331, metadata !DIExpression()) #6, !dbg !333
  call void @llvm.dbg.value(metadata %struct.block* %15, metadata !349, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.dbg.value(metadata i64 4096, metadata !354, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.dbg.value(metadata i1 false, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !357
  %16 = bitcast i8* %14 to i64*, !dbg !359
  store i64 4096, i64* %16, align 8, !dbg !360, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %15, metadata !154, metadata !DIExpression()) #6, !dbg !361
  %17 = getelementptr inbounds i8, i8* %11, i64 4080, !dbg !363
  call void @llvm.dbg.value(metadata %struct.block* %15, metadata !193, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i8* %11, metadata !332, metadata !DIExpression(DW_OP_plus_uconst, 4088, DW_OP_stack_value)) #6, !dbg !333
  call void @llvm.dbg.value(metadata i8* %11, metadata !366, metadata !DIExpression(DW_OP_plus_uconst, 4088, DW_OP_stack_value)) #6, !dbg !371
  %18 = bitcast i8* %17 to <2 x i64>*, !dbg !373
  call void @llvm.dbg.value(metadata <2 x i64>* %18, metadata !356, metadata !DIExpression()) #6, !dbg !357
  store <2 x i64> <i64 4096, i64 1>, <2 x i64>* %18, align 8, !dbg !373, !tbaa !170
  %19 = tail call fastcc %struct.block* @coalesce_block(%struct.block* noundef nonnull %15) #6, !dbg !374
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !331, metadata !DIExpression()) #6, !dbg !333
  %20 = icmp ne %struct.block* %19, null
  br label %21

21:                                               ; preds = %13, %3, %0
  %22 = phi i1 [ false, %0 ], [ %20, %13 ], [ false, %3 ], !dbg !375
  ret i1 %22, !dbg !376
}

declare !dbg !377 i8* @mem_sbrk(i64 noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i8* @mm_malloc(i64 noundef %0) local_unnamed_addr #0 !dbg !380 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !384, metadata !DIExpression()), !dbg !390
  call void @llvm.dbg.value(metadata i8* null, metadata !388, metadata !DIExpression()), !dbg !390
  %2 = load %struct.block*, %struct.block** @heap_start, align 8, !dbg !391, !tbaa !107
  %3 = icmp eq %struct.block* %2, null, !dbg !393
  br i1 %3, label %4, label %27, !dbg !394

4:                                                ; preds = %1
  %5 = tail call i8* @mem_sbrk(i64 noundef 176) #6, !dbg !395
  store i8* %5, i8** bitcast (%union.root** @heap_list to i8**), align 8, !dbg !399, !tbaa !107
  %6 = icmp eq i8* %5, inttoptr (i64 -1 to i8*), !dbg !400
  br i1 %6, label %198, label %7, !dbg !401

7:                                                ; preds = %4
  call void @llvm.dbg.value(metadata i64 0, metadata !308, metadata !DIExpression()) #6, !dbg !402
  %8 = bitcast i8* %5 to %struct.block**, !dbg !403
  store %struct.block* null, %struct.block** %8, align 8, !dbg !404, !tbaa !215
  call void @llvm.dbg.value(metadata i64 1, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 1, metadata !308, metadata !DIExpression()) #6, !dbg !402
  %9 = load %union.root*, %union.root** @heap_list, align 8, !dbg !405, !tbaa !107
  %10 = getelementptr inbounds %union.root, %union.root* %9, i64 1, !dbg !405
  call void @llvm.dbg.value(metadata i64 2, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 2, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 3, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 3, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 4, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 4, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 5, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 5, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 6, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 6, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 7, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 7, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 8, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 8, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 9, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 9, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 10, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 10, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 11, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 11, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 12, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 12, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 13, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 13, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 14, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 14, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 15, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 15, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 16, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 16, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 17, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 17, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 18, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 18, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 19, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 19, metadata !308, metadata !DIExpression()) #6, !dbg !402
  call void @llvm.dbg.value(metadata i64 20, metadata !308, metadata !DIExpression()) #6, !dbg !402
  %11 = getelementptr inbounds %union.root, %union.root* %9, i64 20, i32 0, !dbg !406
  %12 = bitcast %union.root* %10 to i8*, !dbg !407
  tail call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(152) %12, i8 0, i64 152, i1 false) #6, !dbg !404
  %13 = getelementptr inbounds %union.root, %union.root* %9, i64 21, i32 0, !dbg !408
  %14 = bitcast i64* %11 to <2 x i64>*, !dbg !407
  store <2 x i64> <i64 1, i64 1>, <2 x i64>* %14, align 8, !dbg !407, !tbaa !215
  store i64* %13, i64** bitcast (%struct.block** @heap_start to i64**), align 8, !dbg !409, !tbaa !107
  call void @llvm.dbg.value(metadata i64 4096, metadata !325, metadata !DIExpression()) #6, !dbg !410
  call void @llvm.dbg.value(metadata i64 4096, metadata !325, metadata !DIExpression()) #6, !dbg !410
  %15 = tail call i8* @mem_sbrk(i64 noundef 4096) #6, !dbg !412
  call void @llvm.dbg.value(metadata i8* %15, metadata !330, metadata !DIExpression()) #6, !dbg !410
  %16 = icmp eq i8* %15, inttoptr (i64 -1 to i8*), !dbg !413
  br i1 %16, label %198, label %17, !dbg !414

17:                                               ; preds = %7
  call void @llvm.dbg.value(metadata i8* %15, metadata !340, metadata !DIExpression()) #6, !dbg !415
  %18 = getelementptr inbounds i8, i8* %15, i64 -8, !dbg !417
  %19 = bitcast i8* %18 to %struct.block*, !dbg !418
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !331, metadata !DIExpression()) #6, !dbg !410
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !349, metadata !DIExpression()) #6, !dbg !419
  call void @llvm.dbg.value(metadata i64 4096, metadata !354, metadata !DIExpression()) #6, !dbg !419
  call void @llvm.dbg.value(metadata i1 false, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !419
  %20 = bitcast i8* %18 to i64*, !dbg !421
  store i64 4096, i64* %20, align 8, !dbg !422, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !154, metadata !DIExpression()) #6, !dbg !423
  %21 = getelementptr inbounds i8, i8* %15, i64 4080, !dbg !425
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !193, metadata !DIExpression()) #6, !dbg !426
  call void @llvm.dbg.value(metadata i8* %15, metadata !332, metadata !DIExpression(DW_OP_plus_uconst, 4088, DW_OP_stack_value)) #6, !dbg !410
  call void @llvm.dbg.value(metadata i8* %15, metadata !366, metadata !DIExpression(DW_OP_plus_uconst, 4088, DW_OP_stack_value)) #6, !dbg !428
  %22 = bitcast i8* %21 to <2 x i64>*, !dbg !430
  call void @llvm.dbg.value(metadata <2 x i64>* %22, metadata !356, metadata !DIExpression()) #6, !dbg !419
  store <2 x i64> <i64 4096, i64 1>, <2 x i64>* %22, align 8, !dbg !430, !tbaa !170
  %23 = tail call fastcc %struct.block* @coalesce_block(%struct.block* noundef nonnull %19) #6, !dbg !431
  call void @llvm.dbg.value(metadata %struct.block* %23, metadata !331, metadata !DIExpression()) #6, !dbg !410
  %24 = icmp eq %struct.block* %23, null
  %25 = icmp eq i64 %0, 0
  %26 = or i1 %25, %24, !dbg !432
  br i1 %26, label %198, label %29, !dbg !432

27:                                               ; preds = %1
  %28 = icmp eq i64 %0, 0, !dbg !433
  br i1 %28, label %198, label %29, !dbg !435

29:                                               ; preds = %17, %27
  call void @llvm.dbg.value(metadata i64 %0, metadata !436, metadata !DIExpression(DW_OP_plus_uconst, 16, DW_OP_stack_value)), !dbg !442
  call void @llvm.dbg.value(metadata i64 16, metadata !441, metadata !DIExpression()), !dbg !442
  %30 = add i64 %0, 31, !dbg !444
  %31 = and i64 %30, -16, !dbg !445
  call void @llvm.dbg.value(metadata i64 %31, metadata !385, metadata !DIExpression()), !dbg !390
  call void @llvm.dbg.value(metadata i64 %31, metadata !446, metadata !DIExpression()), !dbg !451
  call void @llvm.dbg.value(metadata i64 %31, metadata !453, metadata !DIExpression()), !dbg !459
  call void @llvm.dbg.value(metadata i64 0, metadata !458, metadata !DIExpression()), !dbg !459
  %32 = icmp ugt i64 %31, 16, !dbg !461
  br i1 %32, label %33, label %70, !dbg !466

33:                                               ; preds = %29
  call void @llvm.dbg.value(metadata i64 1, metadata !458, metadata !DIExpression()), !dbg !459
  %34 = icmp ugt i64 %31, 32, !dbg !461
  br i1 %34, label %35, label %70, !dbg !466

35:                                               ; preds = %33
  call void @llvm.dbg.value(metadata i64 2, metadata !458, metadata !DIExpression()), !dbg !459
  %36 = icmp ugt i64 %31, 64, !dbg !461
  br i1 %36, label %37, label %70, !dbg !466

37:                                               ; preds = %35
  call void @llvm.dbg.value(metadata i64 3, metadata !458, metadata !DIExpression()), !dbg !459
  %38 = icmp ugt i64 %31, 128, !dbg !461
  br i1 %38, label %39, label %70, !dbg !466

39:                                               ; preds = %37
  call void @llvm.dbg.value(metadata i64 4, metadata !458, metadata !DIExpression()), !dbg !459
  %40 = icmp ugt i64 %31, 256, !dbg !461
  br i1 %40, label %41, label %70, !dbg !466

41:                                               ; preds = %39
  call void @llvm.dbg.value(metadata i64 5, metadata !458, metadata !DIExpression()), !dbg !459
  %42 = icmp ugt i64 %31, 512, !dbg !461
  br i1 %42, label %43, label %70, !dbg !466

43:                                               ; preds = %41
  call void @llvm.dbg.value(metadata i64 6, metadata !458, metadata !DIExpression()), !dbg !459
  %44 = icmp ugt i64 %31, 1024, !dbg !461
  br i1 %44, label %45, label %70, !dbg !466

45:                                               ; preds = %43
  call void @llvm.dbg.value(metadata i64 7, metadata !458, metadata !DIExpression()), !dbg !459
  %46 = icmp ugt i64 %31, 2048, !dbg !461
  br i1 %46, label %47, label %70, !dbg !466

47:                                               ; preds = %45
  call void @llvm.dbg.value(metadata i64 8, metadata !458, metadata !DIExpression()), !dbg !459
  %48 = icmp ugt i64 %31, 4096, !dbg !461
  br i1 %48, label %49, label %70, !dbg !466

49:                                               ; preds = %47
  call void @llvm.dbg.value(metadata i64 9, metadata !458, metadata !DIExpression()), !dbg !459
  %50 = icmp ugt i64 %31, 8192, !dbg !461
  br i1 %50, label %51, label %70, !dbg !466

51:                                               ; preds = %49
  call void @llvm.dbg.value(metadata i64 10, metadata !458, metadata !DIExpression()), !dbg !459
  %52 = icmp ugt i64 %31, 16384, !dbg !461
  br i1 %52, label %53, label %70, !dbg !466

53:                                               ; preds = %51
  call void @llvm.dbg.value(metadata i64 11, metadata !458, metadata !DIExpression()), !dbg !459
  %54 = icmp ugt i64 %31, 32768, !dbg !461
  br i1 %54, label %55, label %70, !dbg !466

55:                                               ; preds = %53
  call void @llvm.dbg.value(metadata i64 12, metadata !458, metadata !DIExpression()), !dbg !459
  %56 = icmp ugt i64 %31, 65536, !dbg !461
  br i1 %56, label %57, label %70, !dbg !466

57:                                               ; preds = %55
  call void @llvm.dbg.value(metadata i64 13, metadata !458, metadata !DIExpression()), !dbg !459
  %58 = icmp ugt i64 %31, 131072, !dbg !461
  br i1 %58, label %59, label %70, !dbg !466

59:                                               ; preds = %57
  call void @llvm.dbg.value(metadata i64 14, metadata !458, metadata !DIExpression()), !dbg !459
  %60 = icmp ugt i64 %31, 262144, !dbg !461
  br i1 %60, label %61, label %70, !dbg !466

61:                                               ; preds = %59
  call void @llvm.dbg.value(metadata i64 15, metadata !458, metadata !DIExpression()), !dbg !459
  %62 = icmp ugt i64 %31, 524288, !dbg !461
  br i1 %62, label %63, label %70, !dbg !466

63:                                               ; preds = %61
  call void @llvm.dbg.value(metadata i64 16, metadata !458, metadata !DIExpression()), !dbg !459
  %64 = icmp ugt i64 %31, 1048576, !dbg !461
  br i1 %64, label %65, label %70, !dbg !466

65:                                               ; preds = %63
  call void @llvm.dbg.value(metadata i64 17, metadata !458, metadata !DIExpression()), !dbg !459
  %66 = icmp ugt i64 %31, 2097152, !dbg !461
  br i1 %66, label %67, label %70, !dbg !466

67:                                               ; preds = %65
  call void @llvm.dbg.value(metadata i64 18, metadata !458, metadata !DIExpression()), !dbg !459
  %68 = icmp ugt i64 %31, 4194304, !dbg !461
  %69 = select i1 %68, i64 19, i64 18, !dbg !466
  br label %70, !dbg !466

70:                                               ; preds = %67, %65, %63, %61, %59, %57, %55, %53, %51, %49, %47, %45, %43, %41, %39, %37, %35, %33, %29
  %71 = phi i64 [ 0, %29 ], [ 1, %33 ], [ 2, %35 ], [ 3, %37 ], [ 4, %39 ], [ 5, %41 ], [ 6, %43 ], [ 7, %45 ], [ 8, %47 ], [ 9, %49 ], [ 10, %51 ], [ 11, %53 ], [ 12, %55 ], [ 13, %57 ], [ 14, %59 ], [ 15, %61 ], [ 16, %63 ], [ 17, %65 ], [ %69, %67 ], !dbg !467
  call void @llvm.dbg.value(metadata i64 %71, metadata !449, metadata !DIExpression()), !dbg !451
  %72 = load %union.root*, %union.root** @heap_list, align 8, !tbaa !107
  br label %73, !dbg !468

73:                                               ; preds = %89, %70
  %74 = phi i64 [ %71, %70 ], [ %90, %89 ]
  call void @llvm.dbg.value(metadata i64 %74, metadata !449, metadata !DIExpression()), !dbg !451
  %75 = getelementptr inbounds %union.root, %union.root* %72, i64 %74, !dbg !469
  %76 = bitcast %union.root* %75 to %struct.block**, !dbg !471
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !450, metadata !DIExpression()), !dbg !451
  %77 = load %struct.block*, %struct.block** %76, align 8, !dbg !472, !tbaa !215
  call void @llvm.dbg.value(metadata %struct.block* %77, metadata !450, metadata !DIExpression()), !dbg !451
  %78 = icmp eq %struct.block* %77, null, !dbg !473
  br i1 %78, label %89, label %79, !dbg !473

79:                                               ; preds = %73, %85
  %80 = phi %struct.block* [ %87, %85 ], [ %77, %73 ]
  %81 = getelementptr %struct.block, %struct.block* %80, i64 0, i32 0, !dbg !474
  %82 = load i64, i64* %81, align 8, !dbg !474, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !477
  call void @llvm.dbg.value(metadata i64 %82, metadata !126, metadata !DIExpression()), !dbg !479
  %83 = and i64 %82, -16, !dbg !481
  %84 = icmp ult i64 %83, %31, !dbg !482
  br i1 %84, label %85, label %114, !dbg !483

85:                                               ; preds = %79
  %86 = getelementptr inbounds %struct.block, %struct.block* %80, i64 0, i32 1, i32 0, i32 1, !dbg !484
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !450, metadata !DIExpression()), !dbg !451
  %87 = load %struct.block*, %struct.block** %86, align 8, !dbg !472, !tbaa !215
  call void @llvm.dbg.value(metadata %struct.block* %87, metadata !450, metadata !DIExpression()), !dbg !451
  %88 = icmp eq %struct.block* %87, null, !dbg !473
  br i1 %88, label %89, label %79, !dbg !473, !llvm.loop !485

89:                                               ; preds = %85, %73
  %90 = add nuw nsw i64 %74, 1, !dbg !487
  call void @llvm.dbg.value(metadata i64 %90, metadata !449, metadata !DIExpression()), !dbg !451
  %91 = icmp eq i64 %90, 20, !dbg !488
  br i1 %91, label %92, label %73, !dbg !468, !llvm.loop !489

92:                                               ; preds = %89
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !387, metadata !DIExpression()), !dbg !390
  call void @llvm.dbg.value(metadata i64 %31, metadata !491, metadata !DIExpression()), !dbg !495
  call void @llvm.dbg.value(metadata i64 4096, metadata !494, metadata !DIExpression()), !dbg !495
  %93 = icmp ugt i64 %31, 4096, !dbg !499
  %94 = select i1 %93, i64 %31, i64 4096, !dbg !500
  call void @llvm.dbg.value(metadata i64 %94, metadata !386, metadata !DIExpression()), !dbg !390
  call void @llvm.dbg.value(metadata i64 %94, metadata !436, metadata !DIExpression()) #6, !dbg !501
  call void @llvm.dbg.value(metadata i64 16, metadata !441, metadata !DIExpression()) #6, !dbg !501
  call void @llvm.dbg.value(metadata i64 %94, metadata !325, metadata !DIExpression()) #6, !dbg !504
  %95 = tail call i8* @mem_sbrk(i64 noundef %94) #6, !dbg !505
  call void @llvm.dbg.value(metadata i8* %95, metadata !330, metadata !DIExpression()) #6, !dbg !504
  %96 = icmp eq i8* %95, inttoptr (i64 -1 to i8*), !dbg !506
  br i1 %96, label %198, label %97, !dbg !507

97:                                               ; preds = %92
  call void @llvm.dbg.value(metadata i8* %95, metadata !340, metadata !DIExpression()) #6, !dbg !508
  %98 = getelementptr inbounds i8, i8* %95, i64 -8, !dbg !510
  %99 = bitcast i8* %98 to %struct.block*, !dbg !511
  call void @llvm.dbg.value(metadata %struct.block* %99, metadata !331, metadata !DIExpression()) #6, !dbg !504
  call void @llvm.dbg.value(metadata %struct.block* %99, metadata !349, metadata !DIExpression()) #6, !dbg !512
  call void @llvm.dbg.value(metadata i64 %94, metadata !354, metadata !DIExpression()) #6, !dbg !512
  call void @llvm.dbg.value(metadata i1 false, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !512
  %100 = bitcast i8* %98 to i64*, !dbg !514
  store i64 %94, i64* %100, align 8, !dbg !515, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %99, metadata !154, metadata !DIExpression()) #6, !dbg !516
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !518
  call void @llvm.dbg.value(metadata !DIArgList(i64 0, i64 %94), metadata !126, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)) #6, !dbg !520
  %101 = getelementptr inbounds i8, i8* %95, i64 %94, !dbg !522
  %102 = getelementptr inbounds i8, i8* %101, i64 -16, !dbg !523
  %103 = bitcast i8* %102 to i64*, !dbg !524
  call void @llvm.dbg.value(metadata i64* %103, metadata !356, metadata !DIExpression()) #6, !dbg !512
  store i64 %94, i64* %103, align 8, !dbg !525, !tbaa !170
  call void @llvm.dbg.value(metadata %struct.block* %99, metadata !193, metadata !DIExpression()) #6, !dbg !526
  %104 = load i64, i64* %100, align 8, !dbg !528, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !529
  call void @llvm.dbg.value(metadata i64 %104, metadata !126, metadata !DIExpression()) #6, !dbg !531
  %105 = and i64 %104, -16, !dbg !533
  %106 = getelementptr inbounds i8, i8* %98, i64 %105, !dbg !534
  call void @llvm.dbg.value(metadata i8* %106, metadata !332, metadata !DIExpression()) #6, !dbg !504
  call void @llvm.dbg.value(metadata i8* %106, metadata !366, metadata !DIExpression()) #6, !dbg !535
  %107 = bitcast i8* %106 to i64*, !dbg !537
  store i64 1, i64* %107, align 8, !dbg !538, !tbaa !116
  %108 = tail call fastcc %struct.block* @coalesce_block(%struct.block* noundef nonnull %99) #6, !dbg !539
  call void @llvm.dbg.value(metadata %struct.block* %108, metadata !331, metadata !DIExpression()) #6, !dbg !504
  call void @llvm.dbg.value(metadata %struct.block* %108, metadata !387, metadata !DIExpression()), !dbg !390
  %109 = icmp eq %struct.block* %108, null, !dbg !540
  br i1 %109, label %198, label %110, !dbg !542

110:                                              ; preds = %97
  %111 = getelementptr %struct.block, %struct.block* %108, i64 0, i32 0
  %112 = load i64, i64* %111, align 8, !dbg !543, !tbaa !116
  %113 = and i64 %112, -16, !dbg !544
  br label %114, !dbg !542

114:                                              ; preds = %79, %110
  %115 = phi i64 [ %113, %110 ], [ %83, %79 ], !dbg !544
  %116 = phi %struct.block* [ %108, %110 ], [ %80, %79 ], !dbg !390
  call void @llvm.dbg.value(metadata %struct.block* %116, metadata !387, metadata !DIExpression()), !dbg !390
  %117 = getelementptr %struct.block, %struct.block* %116, i64 0, i32 0, !dbg !543
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !547
  call void @llvm.dbg.value(metadata i64 undef, metadata !126, metadata !DIExpression()), !dbg !548
  call void @llvm.dbg.value(metadata i64 %115, metadata !389, metadata !DIExpression()), !dbg !390
  call void @llvm.dbg.value(metadata %struct.block* %116, metadata !349, metadata !DIExpression()), !dbg !549
  call void @llvm.dbg.value(metadata i64 %115, metadata !354, metadata !DIExpression()), !dbg !549
  call void @llvm.dbg.value(metadata i1 true, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !549
  call void @llvm.dbg.value(metadata i64 %115, metadata !551, metadata !DIExpression()), !dbg !558
  call void @llvm.dbg.value(metadata i1 true, metadata !556, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !558
  call void @llvm.dbg.value(metadata i64 %115, metadata !557, metadata !DIExpression()), !dbg !558
  %118 = or i64 %115, 1, !dbg !560
  call void @llvm.dbg.value(metadata !DIArgList(i64 1, i64 %115), metadata !557, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !558
  store i64 %118, i64* %117, align 8, !dbg !561, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %116, metadata !154, metadata !DIExpression()), !dbg !562
  %119 = getelementptr inbounds %struct.block, %struct.block* %116, i64 0, i32 1, !dbg !564
  %120 = bitcast %union.anon* %119 to i8*, !dbg !565
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !566
  call void @llvm.dbg.value(metadata !DIArgList(i64 1, i64 %115), metadata !126, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !568
  %121 = getelementptr inbounds i8, i8* %120, i64 %115, !dbg !570
  %122 = getelementptr inbounds i8, i8* %121, i64 -16, !dbg !571
  %123 = bitcast i8* %122 to i64*, !dbg !572
  call void @llvm.dbg.value(metadata i64* %123, metadata !356, metadata !DIExpression()), !dbg !549
  call void @llvm.dbg.value(metadata i64 %115, metadata !551, metadata !DIExpression()), !dbg !573
  call void @llvm.dbg.value(metadata i1 true, metadata !556, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !573
  call void @llvm.dbg.value(metadata !DIArgList(i64 1, i64 %115), metadata !557, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !573
  store i64 %118, i64* %123, align 8, !dbg !575, !tbaa !170
  call void @llvm.dbg.value(metadata %struct.block* %116, metadata !576, metadata !DIExpression()) #6, !dbg !586
  call void @llvm.dbg.value(metadata i64 %31, metadata !581, metadata !DIExpression()) #6, !dbg !586
  %124 = load i64, i64* %117, align 8, !dbg !588, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !589
  call void @llvm.dbg.value(metadata i64 %124, metadata !126, metadata !DIExpression()) #6, !dbg !591
  %125 = and i64 %124, -16, !dbg !593
  call void @llvm.dbg.value(metadata i64 %125, metadata !582, metadata !DIExpression()) #6, !dbg !586
  tail call fastcc void @delete(%struct.block* noundef nonnull %116) #6, !dbg !594
  %126 = sub i64 %125, %31, !dbg !595
  %127 = icmp ugt i64 %126, 31, !dbg !596
  br i1 %127, label %128, label %198, !dbg !597

128:                                              ; preds = %114
  call void @llvm.dbg.value(metadata %struct.block* %116, metadata !349, metadata !DIExpression()) #6, !dbg !598
  call void @llvm.dbg.value(metadata i64 %31, metadata !354, metadata !DIExpression()) #6, !dbg !598
  call void @llvm.dbg.value(metadata i1 true, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !598
  call void @llvm.dbg.value(metadata i64 %31, metadata !551, metadata !DIExpression()) #6, !dbg !600
  call void @llvm.dbg.value(metadata i1 true, metadata !556, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !600
  call void @llvm.dbg.value(metadata i64 %31, metadata !557, metadata !DIExpression()) #6, !dbg !600
  %129 = or i64 %31, 1, !dbg !602
  call void @llvm.dbg.value(metadata !DIArgList(i64 1, i64 %31), metadata !557, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)) #6, !dbg !600
  store i64 %129, i64* %117, align 8, !dbg !603, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %116, metadata !154, metadata !DIExpression()) #6, !dbg !604
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !606
  call void @llvm.dbg.value(metadata !DIArgList(i64 1, i64 %31), metadata !126, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)) #6, !dbg !608
  %130 = getelementptr inbounds i8, i8* %120, i64 %31, !dbg !610
  %131 = getelementptr inbounds i8, i8* %130, i64 -16, !dbg !611
  %132 = bitcast i8* %131 to i64*, !dbg !612
  call void @llvm.dbg.value(metadata i64* %132, metadata !356, metadata !DIExpression()) #6, !dbg !598
  call void @llvm.dbg.value(metadata i64 %31, metadata !551, metadata !DIExpression()) #6, !dbg !613
  call void @llvm.dbg.value(metadata i1 true, metadata !556, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !613
  call void @llvm.dbg.value(metadata !DIArgList(i64 1, i64 %31), metadata !557, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)) #6, !dbg !613
  store i64 %129, i64* %132, align 8, !dbg !615, !tbaa !170
  call void @llvm.dbg.value(metadata %struct.block* %116, metadata !193, metadata !DIExpression()) #6, !dbg !616
  %133 = bitcast %struct.block* %116 to i8*, !dbg !618
  %134 = load i64, i64* %117, align 8, !dbg !619, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !620
  call void @llvm.dbg.value(metadata i64 %134, metadata !126, metadata !DIExpression()) #6, !dbg !622
  %135 = and i64 %134, -16, !dbg !624
  %136 = getelementptr inbounds i8, i8* %133, i64 %135, !dbg !625
  call void @llvm.dbg.value(metadata i8* %136, metadata !583, metadata !DIExpression()) #6, !dbg !626
  call void @llvm.dbg.value(metadata i8* %136, metadata !349, metadata !DIExpression()) #6, !dbg !627
  call void @llvm.dbg.value(metadata i64 %126, metadata !354, metadata !DIExpression()) #6, !dbg !627
  call void @llvm.dbg.value(metadata i1 false, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !627
  call void @llvm.dbg.value(metadata i64 %126, metadata !551, metadata !DIExpression()) #6, !dbg !629
  call void @llvm.dbg.value(metadata i1 false, metadata !556, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !629
  call void @llvm.dbg.value(metadata !DIArgList(i64 0, i64 %126), metadata !557, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)) #6, !dbg !629
  %137 = bitcast i8* %136 to i64*, !dbg !631
  store i64 %126, i64* %137, align 8, !dbg !632, !tbaa !116
  call void @llvm.dbg.value(metadata i8* %136, metadata !154, metadata !DIExpression()) #6, !dbg !633
  %138 = getelementptr inbounds i8, i8* %136, i64 8, !dbg !635
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !636
  call void @llvm.dbg.value(metadata !DIArgList(i64 0, i64 %126), metadata !126, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)) #6, !dbg !638
  %139 = getelementptr inbounds i8, i8* %138, i64 %126, !dbg !640
  %140 = getelementptr inbounds i8, i8* %139, i64 -16, !dbg !641
  %141 = bitcast i8* %140 to i64*, !dbg !642
  call void @llvm.dbg.value(metadata i64* %141, metadata !356, metadata !DIExpression()) #6, !dbg !627
  call void @llvm.dbg.value(metadata i64 %126, metadata !551, metadata !DIExpression()) #6, !dbg !643
  call void @llvm.dbg.value(metadata i1 false, metadata !556, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !643
  call void @llvm.dbg.value(metadata !DIArgList(i64 0, i64 %126), metadata !557, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)) #6, !dbg !643
  store i64 %126, i64* %141, align 8, !dbg !645, !tbaa !170
  call void @llvm.dbg.value(metadata i8* %136, metadata !646, metadata !DIExpression()) #6, !dbg !651
  %142 = load i64, i64* %137, align 8, !dbg !653, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !654
  call void @llvm.dbg.value(metadata i64 %142, metadata !126, metadata !DIExpression()) #6, !dbg !656
  %143 = and i64 %142, -16, !dbg !658
  call void @llvm.dbg.value(metadata i64 %143, metadata !649, metadata !DIExpression()) #6, !dbg !651
  %144 = getelementptr inbounds i8, i8* %136, i64 16, !dbg !659
  %145 = bitcast i8* %144 to %struct.block**, !dbg !659
  %146 = bitcast i8* %138 to %struct.block**, !dbg !660
  call void @llvm.dbg.value(metadata i64 %143, metadata !453, metadata !DIExpression()) #6, !dbg !661
  call void @llvm.dbg.value(metadata i64 0, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %147 = icmp ugt i64 %143, 16, !dbg !663
  tail call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %138, i8 0, i64 16, i1 false) #6, !dbg !664
  br i1 %147, label %148, label %185, !dbg !665

148:                                              ; preds = %128
  call void @llvm.dbg.value(metadata i64 1, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %149 = icmp ugt i64 %143, 32, !dbg !663
  br i1 %149, label %150, label %185, !dbg !665

150:                                              ; preds = %148
  call void @llvm.dbg.value(metadata i64 2, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %151 = icmp ugt i64 %143, 64, !dbg !663
  br i1 %151, label %152, label %185, !dbg !665

152:                                              ; preds = %150
  call void @llvm.dbg.value(metadata i64 3, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %153 = icmp ugt i64 %143, 128, !dbg !663
  br i1 %153, label %154, label %185, !dbg !665

154:                                              ; preds = %152
  call void @llvm.dbg.value(metadata i64 4, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %155 = icmp ugt i64 %143, 256, !dbg !663
  br i1 %155, label %156, label %185, !dbg !665

156:                                              ; preds = %154
  call void @llvm.dbg.value(metadata i64 5, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %157 = icmp ugt i64 %143, 512, !dbg !663
  br i1 %157, label %158, label %185, !dbg !665

158:                                              ; preds = %156
  call void @llvm.dbg.value(metadata i64 6, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %159 = icmp ugt i64 %143, 1024, !dbg !663
  br i1 %159, label %160, label %185, !dbg !665

160:                                              ; preds = %158
  call void @llvm.dbg.value(metadata i64 7, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %161 = icmp ugt i64 %143, 2048, !dbg !663
  br i1 %161, label %162, label %185, !dbg !665

162:                                              ; preds = %160
  call void @llvm.dbg.value(metadata i64 8, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %163 = icmp ugt i64 %143, 4096, !dbg !663
  br i1 %163, label %164, label %185, !dbg !665

164:                                              ; preds = %162
  call void @llvm.dbg.value(metadata i64 9, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %165 = icmp ugt i64 %143, 8192, !dbg !663
  br i1 %165, label %166, label %185, !dbg !665

166:                                              ; preds = %164
  call void @llvm.dbg.value(metadata i64 10, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %167 = icmp ugt i64 %143, 16384, !dbg !663
  br i1 %167, label %168, label %185, !dbg !665

168:                                              ; preds = %166
  call void @llvm.dbg.value(metadata i64 11, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %169 = icmp ugt i64 %143, 32768, !dbg !663
  br i1 %169, label %170, label %185, !dbg !665

170:                                              ; preds = %168
  call void @llvm.dbg.value(metadata i64 12, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %171 = icmp ugt i64 %143, 65536, !dbg !663
  br i1 %171, label %172, label %185, !dbg !665

172:                                              ; preds = %170
  call void @llvm.dbg.value(metadata i64 13, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %173 = icmp ugt i64 %143, 131072, !dbg !663
  br i1 %173, label %174, label %185, !dbg !665

174:                                              ; preds = %172
  call void @llvm.dbg.value(metadata i64 14, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %175 = icmp ugt i64 %143, 262144, !dbg !663
  br i1 %175, label %176, label %185, !dbg !665

176:                                              ; preds = %174
  call void @llvm.dbg.value(metadata i64 15, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %177 = icmp ugt i64 %143, 524288, !dbg !663
  br i1 %177, label %178, label %185, !dbg !665

178:                                              ; preds = %176
  call void @llvm.dbg.value(metadata i64 16, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %179 = icmp ugt i64 %143, 1048576, !dbg !663
  br i1 %179, label %180, label %185, !dbg !665

180:                                              ; preds = %178
  call void @llvm.dbg.value(metadata i64 17, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %181 = icmp ugt i64 %143, 2097152, !dbg !663
  br i1 %181, label %182, label %185, !dbg !665

182:                                              ; preds = %180
  call void @llvm.dbg.value(metadata i64 18, metadata !458, metadata !DIExpression()) #6, !dbg !661
  %183 = icmp ugt i64 %143, 4194304, !dbg !663
  %184 = select i1 %183, i64 19, i64 18, !dbg !665
  br label %185, !dbg !665

185:                                              ; preds = %182, %180, %178, %176, %174, %172, %170, %168, %166, %164, %162, %160, %158, %156, %154, %152, %150, %148, %128
  %186 = phi i64 [ 0, %128 ], [ 1, %148 ], [ 2, %150 ], [ 3, %152 ], [ 4, %154 ], [ 5, %156 ], [ 6, %158 ], [ 7, %160 ], [ 8, %162 ], [ 9, %164 ], [ 10, %166 ], [ 11, %168 ], [ 12, %170 ], [ 13, %172 ], [ 14, %174 ], [ 15, %176 ], [ 16, %178 ], [ 17, %180 ], [ %184, %182 ], !dbg !666
  call void @llvm.dbg.value(metadata i64 %186, metadata !650, metadata !DIExpression()) #6, !dbg !651
  %187 = load %union.root*, %union.root** @heap_list, align 8, !dbg !667, !tbaa !107
  %188 = getelementptr inbounds %union.root, %union.root* %187, i64 %186, !dbg !667
  %189 = bitcast %union.root* %188 to %struct.block**, !dbg !669
  %190 = load %struct.block*, %struct.block** %189, align 8, !dbg !669, !tbaa !215
  %191 = icmp eq %struct.block* %190, null, !dbg !670
  br i1 %191, label %196, label %192, !dbg !671

192:                                              ; preds = %185
  store %struct.block* %190, %struct.block** %145, align 8, !dbg !672, !tbaa !215
  %193 = load %struct.block*, %struct.block** %189, align 8, !dbg !674, !tbaa !215
  %194 = getelementptr inbounds %struct.block, %struct.block* %193, i64 0, i32 1, i32 0, i32 0, !dbg !675
  %195 = bitcast %struct.block** %194 to i8**, !dbg !676
  store i8* %136, i8** %195, align 8, !dbg !676, !tbaa !215
  store %struct.block* null, %struct.block** %146, align 8, !dbg !677, !tbaa !215
  br label %196

196:                                              ; preds = %192, %185
  %197 = bitcast %union.root* %188 to i8**, !dbg !678
  store i8* %136, i8** %197, align 8, !dbg !678, !tbaa !215
  br label %198, !dbg !679

198:                                              ; preds = %92, %7, %4, %196, %114, %97, %27, %17
  %199 = phi i8* [ null, %17 ], [ null, %27 ], [ null, %97 ], [ %120, %114 ], [ %120, %196 ], [ null, %4 ], [ null, %7 ], [ null, %92 ], !dbg !390
  ret i8* %199, !dbg !680
}

; Function Attrs: mustprogress nofree nosync nounwind uwtable willreturn
define dso_local void @mm_free(i8* noundef %0) local_unnamed_addr #2 !dbg !681 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !685, metadata !DIExpression()), !dbg !688
  %2 = icmp eq i8* %0, null, !dbg !689
  br i1 %2, label %13, label %3, !dbg !691

3:                                                ; preds = %1
  call void @llvm.dbg.value(metadata i8* %0, metadata !340, metadata !DIExpression()), !dbg !692
  %4 = getelementptr inbounds i8, i8* %0, i64 -8, !dbg !694
  %5 = bitcast i8* %4 to %struct.block*, !dbg !695
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !686, metadata !DIExpression()), !dbg !688
  %6 = bitcast i8* %4 to i64*, !dbg !696
  %7 = load i64, i64* %6, align 8, !dbg !696, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !697
  call void @llvm.dbg.value(metadata i64 %7, metadata !126, metadata !DIExpression()), !dbg !699
  %8 = and i64 %7, -16, !dbg !701
  call void @llvm.dbg.value(metadata i64 %8, metadata !687, metadata !DIExpression()), !dbg !688
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !349, metadata !DIExpression()), !dbg !702
  call void @llvm.dbg.value(metadata i64 %8, metadata !354, metadata !DIExpression()), !dbg !702
  call void @llvm.dbg.value(metadata i1 false, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !702
  store i64 %8, i64* %6, align 8, !dbg !704, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !154, metadata !DIExpression()), !dbg !705
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !707
  call void @llvm.dbg.value(metadata !DIArgList(i64 0, i64 %8), metadata !126, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !709
  %9 = getelementptr inbounds i8, i8* %0, i64 %8, !dbg !711
  %10 = getelementptr inbounds i8, i8* %9, i64 -16, !dbg !712
  %11 = bitcast i8* %10 to i64*, !dbg !713
  call void @llvm.dbg.value(metadata i64* %11, metadata !356, metadata !DIExpression()), !dbg !702
  store i64 %8, i64* %11, align 8, !dbg !714, !tbaa !170
  %12 = tail call fastcc %struct.block* @coalesce_block(%struct.block* noundef nonnull %5), !dbg !715
  br label %13

13:                                               ; preds = %1, %3
  ret void, !dbg !716
}

; Function Attrs: mustprogress nofree nosync nounwind uwtable willreturn
define internal fastcc %struct.block* @coalesce_block(%struct.block* noundef %0) unnamed_addr #2 !dbg !717 {
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !719, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !218, metadata !DIExpression()), !dbg !728
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !224, metadata !DIExpression()), !dbg !730
  %2 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 0, !dbg !732
  %3 = getelementptr inbounds i64, i64* %2, i64 -1, !dbg !733
  call void @llvm.dbg.value(metadata i64* %3, metadata !221, metadata !DIExpression()), !dbg !728
  %4 = load i64, i64* %3, align 8, !dbg !734, !tbaa !170
  call void @llvm.dbg.value(metadata i64 %4, metadata !126, metadata !DIExpression()), !dbg !735
  %5 = and i64 %4, -16, !dbg !737
  %6 = icmp eq i64 %5, 0, !dbg !738
  %7 = bitcast %struct.block* %0 to i8*, !dbg !739
  %8 = sub i64 0, %5, !dbg !739
  %9 = getelementptr inbounds i8, i8* %7, i64 %8, !dbg !739
  %10 = bitcast i8* %9 to %struct.block*, !dbg !739
  %11 = select i1 %6, %struct.block* null, %struct.block* %10, !dbg !739
  call void @llvm.dbg.value(metadata %struct.block* %11, metadata !720, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !193, metadata !DIExpression()), !dbg !740
  %12 = load i64, i64* %2, align 8, !dbg !742, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !743
  call void @llvm.dbg.value(metadata i64 %12, metadata !126, metadata !DIExpression()), !dbg !745
  %13 = and i64 %12, -16, !dbg !747
  %14 = getelementptr inbounds i8, i8* %7, i64 %13, !dbg !748
  %15 = bitcast i8* %14 to %struct.block*, !dbg !749
  call void @llvm.dbg.value(metadata %struct.block* %15, metadata !721, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata i8 0, metadata !722, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata i8 0, metadata !723, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !750
  call void @llvm.dbg.value(metadata i64 %12, metadata !126, metadata !DIExpression()), !dbg !752
  call void @llvm.dbg.value(metadata i64 %13, metadata !724, metadata !DIExpression()), !dbg !727
  %16 = icmp eq %struct.block* %11, null, !dbg !754
  br i1 %16, label %23, label %17, !dbg !756

17:                                               ; preds = %1
  %18 = getelementptr %struct.block, %struct.block* %11, i64 0, i32 0, !dbg !757
  %19 = load i64, i64* %18, align 8, !dbg !757, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !759
  call void @llvm.dbg.value(metadata i64 %19, metadata !126, metadata !DIExpression()), !dbg !761
  %20 = and i64 %19, -16, !dbg !763
  call void @llvm.dbg.value(metadata i64 %20, metadata !725, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !180, metadata !DIExpression()), !dbg !764
  call void @llvm.dbg.value(metadata i64 %19, metadata !171, metadata !DIExpression()), !dbg !766
  %21 = and i64 %19, 1, !dbg !768
  %22 = icmp ne i64 %21, 0, !dbg !769
  call void @llvm.dbg.value(metadata i1 %22, metadata !722, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !727
  br label %23

23:                                               ; preds = %1, %17
  %24 = phi i1 [ %22, %17 ], [ true, %1 ]
  %25 = phi i64 [ %20, %17 ], [ 0, %1 ], !dbg !770
  call void @llvm.dbg.value(metadata i64 %25, metadata !725, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata i8 undef, metadata !722, metadata !DIExpression()), !dbg !727
  %26 = bitcast i8* %14 to i64*, !dbg !771
  %27 = load i64, i64* %26, align 8, !dbg !771, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !774
  call void @llvm.dbg.value(metadata i64 %27, metadata !126, metadata !DIExpression()), !dbg !776
  %28 = and i64 %27, -16, !dbg !778
  call void @llvm.dbg.value(metadata i64 %28, metadata !726, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !180, metadata !DIExpression()), !dbg !779
  call void @llvm.dbg.value(metadata i64 %27, metadata !171, metadata !DIExpression()), !dbg !781
  %29 = and i64 %27, 1, !dbg !783
  %30 = icmp ne i64 %29, 0, !dbg !784
  call void @llvm.dbg.value(metadata i8 undef, metadata !723, metadata !DIExpression()), !dbg !727
  %31 = xor i1 %24, true, !dbg !785
  %32 = xor i1 %30, true, !dbg !785
  %33 = select i1 %31, i1 true, i1 %32, !dbg !785
  br i1 %33, label %87, label %34, !dbg !785

34:                                               ; preds = %23
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !646, metadata !DIExpression()) #6, !dbg !787
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !790
  call void @llvm.dbg.value(metadata i64 %12, metadata !126, metadata !DIExpression()) #6, !dbg !792
  call void @llvm.dbg.value(metadata i64 %13, metadata !649, metadata !DIExpression()) #6, !dbg !787
  %35 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, i32 0, i32 1, !dbg !794
  %36 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, i32 0, i32 0, !dbg !795
  call void @llvm.dbg.value(metadata i64 %13, metadata !453, metadata !DIExpression()) #6, !dbg !796
  call void @llvm.dbg.value(metadata i64 0, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %37 = icmp ugt i64 %13, 16, !dbg !798
  %38 = bitcast %struct.block** %36 to i8*, !dbg !799
  tail call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %38, i8 0, i64 16, i1 false) #6, !dbg !800
  br i1 %37, label %39, label %76, !dbg !799

39:                                               ; preds = %34
  call void @llvm.dbg.value(metadata i64 1, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %40 = icmp ugt i64 %13, 32, !dbg !798
  br i1 %40, label %41, label %76, !dbg !799

41:                                               ; preds = %39
  call void @llvm.dbg.value(metadata i64 2, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %42 = icmp ugt i64 %13, 64, !dbg !798
  br i1 %42, label %43, label %76, !dbg !799

43:                                               ; preds = %41
  call void @llvm.dbg.value(metadata i64 3, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %44 = icmp ugt i64 %13, 128, !dbg !798
  br i1 %44, label %45, label %76, !dbg !799

45:                                               ; preds = %43
  call void @llvm.dbg.value(metadata i64 4, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %46 = icmp ugt i64 %13, 256, !dbg !798
  br i1 %46, label %47, label %76, !dbg !799

47:                                               ; preds = %45
  call void @llvm.dbg.value(metadata i64 5, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %48 = icmp ugt i64 %13, 512, !dbg !798
  br i1 %48, label %49, label %76, !dbg !799

49:                                               ; preds = %47
  call void @llvm.dbg.value(metadata i64 6, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %50 = icmp ugt i64 %13, 1024, !dbg !798
  br i1 %50, label %51, label %76, !dbg !799

51:                                               ; preds = %49
  call void @llvm.dbg.value(metadata i64 7, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %52 = icmp ugt i64 %13, 2048, !dbg !798
  br i1 %52, label %53, label %76, !dbg !799

53:                                               ; preds = %51
  call void @llvm.dbg.value(metadata i64 8, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %54 = icmp ugt i64 %13, 4096, !dbg !798
  br i1 %54, label %55, label %76, !dbg !799

55:                                               ; preds = %53
  call void @llvm.dbg.value(metadata i64 9, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %56 = icmp ugt i64 %13, 8192, !dbg !798
  br i1 %56, label %57, label %76, !dbg !799

57:                                               ; preds = %55
  call void @llvm.dbg.value(metadata i64 10, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %58 = icmp ugt i64 %13, 16384, !dbg !798
  br i1 %58, label %59, label %76, !dbg !799

59:                                               ; preds = %57
  call void @llvm.dbg.value(metadata i64 11, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %60 = icmp ugt i64 %13, 32768, !dbg !798
  br i1 %60, label %61, label %76, !dbg !799

61:                                               ; preds = %59
  call void @llvm.dbg.value(metadata i64 12, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %62 = icmp ugt i64 %13, 65536, !dbg !798
  br i1 %62, label %63, label %76, !dbg !799

63:                                               ; preds = %61
  call void @llvm.dbg.value(metadata i64 13, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %64 = icmp ugt i64 %13, 131072, !dbg !798
  br i1 %64, label %65, label %76, !dbg !799

65:                                               ; preds = %63
  call void @llvm.dbg.value(metadata i64 14, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %66 = icmp ugt i64 %13, 262144, !dbg !798
  br i1 %66, label %67, label %76, !dbg !799

67:                                               ; preds = %65
  call void @llvm.dbg.value(metadata i64 15, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %68 = icmp ugt i64 %13, 524288, !dbg !798
  br i1 %68, label %69, label %76, !dbg !799

69:                                               ; preds = %67
  call void @llvm.dbg.value(metadata i64 16, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %70 = icmp ugt i64 %13, 1048576, !dbg !798
  br i1 %70, label %71, label %76, !dbg !799

71:                                               ; preds = %69
  call void @llvm.dbg.value(metadata i64 17, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %72 = icmp ugt i64 %13, 2097152, !dbg !798
  br i1 %72, label %73, label %76, !dbg !799

73:                                               ; preds = %71
  call void @llvm.dbg.value(metadata i64 18, metadata !458, metadata !DIExpression()) #6, !dbg !796
  %74 = icmp ugt i64 %13, 4194304, !dbg !798
  %75 = select i1 %74, i64 19, i64 18, !dbg !799
  br label %76, !dbg !799

76:                                               ; preds = %73, %71, %69, %67, %65, %63, %61, %59, %57, %55, %53, %51, %49, %47, %45, %43, %41, %39, %34
  %77 = phi i64 [ 0, %34 ], [ 1, %39 ], [ 2, %41 ], [ 3, %43 ], [ 4, %45 ], [ 5, %47 ], [ 6, %49 ], [ 7, %51 ], [ 8, %53 ], [ 9, %55 ], [ 10, %57 ], [ 11, %59 ], [ 12, %61 ], [ 13, %63 ], [ 14, %65 ], [ 15, %67 ], [ 16, %69 ], [ 17, %71 ], [ %75, %73 ], !dbg !801
  call void @llvm.dbg.value(metadata i64 %77, metadata !650, metadata !DIExpression()) #6, !dbg !787
  %78 = load %union.root*, %union.root** @heap_list, align 8, !dbg !802, !tbaa !107
  %79 = getelementptr inbounds %union.root, %union.root* %78, i64 %77, !dbg !802
  %80 = bitcast %union.root* %79 to %struct.block**, !dbg !803
  %81 = load %struct.block*, %struct.block** %80, align 8, !dbg !803, !tbaa !215
  %82 = icmp eq %struct.block* %81, null, !dbg !804
  br i1 %82, label %86, label %83, !dbg !805

83:                                               ; preds = %76
  store %struct.block* %81, %struct.block** %35, align 8, !dbg !806, !tbaa !215
  %84 = load %struct.block*, %struct.block** %80, align 8, !dbg !807, !tbaa !215
  %85 = getelementptr inbounds %struct.block, %struct.block* %84, i64 0, i32 1, i32 0, i32 0, !dbg !808
  store %struct.block* %0, %struct.block** %85, align 8, !dbg !809, !tbaa !215
  store %struct.block* null, %struct.block** %36, align 8, !dbg !810, !tbaa !215
  br label %86

86:                                               ; preds = %76, %83
  store %struct.block* %0, %struct.block** %80, align 8, !dbg !811, !tbaa !215
  br label %291, !dbg !812

87:                                               ; preds = %23
  %88 = select i1 %31, i1 true, i1 %30, !dbg !813
  br i1 %88, label %150, label %89, !dbg !813

89:                                               ; preds = %87
  %90 = add i64 %28, %13, !dbg !815
  call void @llvm.dbg.value(metadata i64 %90, metadata !724, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !349, metadata !DIExpression()), !dbg !817
  call void @llvm.dbg.value(metadata i64 %90, metadata !354, metadata !DIExpression()), !dbg !817
  call void @llvm.dbg.value(metadata i1 false, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !817
  store i64 %90, i64* %2, align 8, !dbg !819, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !154, metadata !DIExpression()), !dbg !820
  %91 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, !dbg !822
  %92 = bitcast %union.anon* %91 to i8*, !dbg !823
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !824
  call void @llvm.dbg.value(metadata !DIArgList(i64 0, i64 %90), metadata !126, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !826
  %93 = getelementptr inbounds i8, i8* %92, i64 %90, !dbg !828
  %94 = getelementptr inbounds i8, i8* %93, i64 -16, !dbg !829
  %95 = bitcast i8* %94 to i64*, !dbg !830
  call void @llvm.dbg.value(metadata i64* %95, metadata !356, metadata !DIExpression()), !dbg !817
  store i64 %90, i64* %95, align 8, !dbg !831, !tbaa !170
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !646, metadata !DIExpression()) #6, !dbg !832
  %96 = load i64, i64* %2, align 8, !dbg !834, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !835
  call void @llvm.dbg.value(metadata i64 %96, metadata !126, metadata !DIExpression()) #6, !dbg !837
  %97 = and i64 %96, -16, !dbg !839
  call void @llvm.dbg.value(metadata i64 %97, metadata !649, metadata !DIExpression()) #6, !dbg !832
  %98 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, i32 0, i32 1, !dbg !840
  %99 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, i32 0, i32 0, !dbg !841
  call void @llvm.dbg.value(metadata i64 %97, metadata !453, metadata !DIExpression()) #6, !dbg !842
  call void @llvm.dbg.value(metadata i64 0, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %100 = icmp ugt i64 %97, 16, !dbg !844
  %101 = bitcast %struct.block** %99 to i8*, !dbg !845
  tail call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %101, i8 0, i64 16, i1 false) #6, !dbg !846
  br i1 %100, label %102, label %139, !dbg !845

102:                                              ; preds = %89
  call void @llvm.dbg.value(metadata i64 1, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %103 = icmp ugt i64 %97, 32, !dbg !844
  br i1 %103, label %104, label %139, !dbg !845

104:                                              ; preds = %102
  call void @llvm.dbg.value(metadata i64 2, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %105 = icmp ugt i64 %97, 64, !dbg !844
  br i1 %105, label %106, label %139, !dbg !845

106:                                              ; preds = %104
  call void @llvm.dbg.value(metadata i64 3, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %107 = icmp ugt i64 %97, 128, !dbg !844
  br i1 %107, label %108, label %139, !dbg !845

108:                                              ; preds = %106
  call void @llvm.dbg.value(metadata i64 4, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %109 = icmp ugt i64 %97, 256, !dbg !844
  br i1 %109, label %110, label %139, !dbg !845

110:                                              ; preds = %108
  call void @llvm.dbg.value(metadata i64 5, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %111 = icmp ugt i64 %97, 512, !dbg !844
  br i1 %111, label %112, label %139, !dbg !845

112:                                              ; preds = %110
  call void @llvm.dbg.value(metadata i64 6, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %113 = icmp ugt i64 %97, 1024, !dbg !844
  br i1 %113, label %114, label %139, !dbg !845

114:                                              ; preds = %112
  call void @llvm.dbg.value(metadata i64 7, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %115 = icmp ugt i64 %97, 2048, !dbg !844
  br i1 %115, label %116, label %139, !dbg !845

116:                                              ; preds = %114
  call void @llvm.dbg.value(metadata i64 8, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %117 = icmp ugt i64 %97, 4096, !dbg !844
  br i1 %117, label %118, label %139, !dbg !845

118:                                              ; preds = %116
  call void @llvm.dbg.value(metadata i64 9, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %119 = icmp ugt i64 %97, 8192, !dbg !844
  br i1 %119, label %120, label %139, !dbg !845

120:                                              ; preds = %118
  call void @llvm.dbg.value(metadata i64 10, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %121 = icmp ugt i64 %97, 16384, !dbg !844
  br i1 %121, label %122, label %139, !dbg !845

122:                                              ; preds = %120
  call void @llvm.dbg.value(metadata i64 11, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %123 = icmp ugt i64 %97, 32768, !dbg !844
  br i1 %123, label %124, label %139, !dbg !845

124:                                              ; preds = %122
  call void @llvm.dbg.value(metadata i64 12, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %125 = icmp ugt i64 %97, 65536, !dbg !844
  br i1 %125, label %126, label %139, !dbg !845

126:                                              ; preds = %124
  call void @llvm.dbg.value(metadata i64 13, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %127 = icmp ugt i64 %97, 131072, !dbg !844
  br i1 %127, label %128, label %139, !dbg !845

128:                                              ; preds = %126
  call void @llvm.dbg.value(metadata i64 14, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %129 = icmp ugt i64 %97, 262144, !dbg !844
  br i1 %129, label %130, label %139, !dbg !845

130:                                              ; preds = %128
  call void @llvm.dbg.value(metadata i64 15, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %131 = icmp ugt i64 %97, 524288, !dbg !844
  br i1 %131, label %132, label %139, !dbg !845

132:                                              ; preds = %130
  call void @llvm.dbg.value(metadata i64 16, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %133 = icmp ugt i64 %97, 1048576, !dbg !844
  br i1 %133, label %134, label %139, !dbg !845

134:                                              ; preds = %132
  call void @llvm.dbg.value(metadata i64 17, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %135 = icmp ugt i64 %97, 2097152, !dbg !844
  br i1 %135, label %136, label %139, !dbg !845

136:                                              ; preds = %134
  call void @llvm.dbg.value(metadata i64 18, metadata !458, metadata !DIExpression()) #6, !dbg !842
  %137 = icmp ugt i64 %97, 4194304, !dbg !844
  %138 = select i1 %137, i64 19, i64 18, !dbg !845
  br label %139, !dbg !845

139:                                              ; preds = %136, %134, %132, %130, %128, %126, %124, %122, %120, %118, %116, %114, %112, %110, %108, %106, %104, %102, %89
  %140 = phi i64 [ 0, %89 ], [ 1, %102 ], [ 2, %104 ], [ 3, %106 ], [ 4, %108 ], [ 5, %110 ], [ 6, %112 ], [ 7, %114 ], [ 8, %116 ], [ 9, %118 ], [ 10, %120 ], [ 11, %122 ], [ 12, %124 ], [ 13, %126 ], [ 14, %128 ], [ 15, %130 ], [ 16, %132 ], [ 17, %134 ], [ %138, %136 ], !dbg !847
  call void @llvm.dbg.value(metadata i64 %140, metadata !650, metadata !DIExpression()) #6, !dbg !832
  %141 = load %union.root*, %union.root** @heap_list, align 8, !dbg !848, !tbaa !107
  %142 = getelementptr inbounds %union.root, %union.root* %141, i64 %140, !dbg !848
  %143 = bitcast %union.root* %142 to %struct.block**, !dbg !849
  %144 = load %struct.block*, %struct.block** %143, align 8, !dbg !849, !tbaa !215
  %145 = icmp eq %struct.block* %144, null, !dbg !850
  br i1 %145, label %149, label %146, !dbg !851

146:                                              ; preds = %139
  store %struct.block* %144, %struct.block** %98, align 8, !dbg !852, !tbaa !215
  %147 = load %struct.block*, %struct.block** %143, align 8, !dbg !853, !tbaa !215
  %148 = getelementptr inbounds %struct.block, %struct.block* %147, i64 0, i32 1, i32 0, i32 0, !dbg !854
  store %struct.block* %0, %struct.block** %148, align 8, !dbg !855, !tbaa !215
  store %struct.block* null, %struct.block** %99, align 8, !dbg !856, !tbaa !215
  br label %149

149:                                              ; preds = %139, %146
  store %struct.block* %0, %struct.block** %143, align 8, !dbg !857, !tbaa !215
  tail call fastcc void @delete(%struct.block* noundef nonnull %15), !dbg !858
  br label %291, !dbg !859

150:                                              ; preds = %87
  %151 = select i1 %24, i1 true, i1 %32, !dbg !860
  tail call fastcc void @delete(%struct.block* noundef %11), !dbg !862
  br i1 %151, label %221, label %152, !dbg !860

152:                                              ; preds = %150
  %153 = add i64 %25, %13, !dbg !863
  call void @llvm.dbg.value(metadata i64 %153, metadata !724, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !218, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !224, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i64* %3, metadata !221, metadata !DIExpression()), !dbg !865
  %154 = load i64, i64* %3, align 8, !dbg !869, !tbaa !170
  call void @llvm.dbg.value(metadata i64 %154, metadata !126, metadata !DIExpression()), !dbg !870
  %155 = and i64 %154, -16, !dbg !872
  %156 = icmp eq i64 %155, 0, !dbg !873
  %157 = sub i64 0, %155, !dbg !874
  %158 = getelementptr inbounds i8, i8* %7, i64 %157, !dbg !874
  %159 = bitcast i8* %158 to %struct.block*, !dbg !874
  %160 = select i1 %156, %struct.block* null, %struct.block* %159, !dbg !874
  call void @llvm.dbg.value(metadata %struct.block* %160, metadata !719, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata %struct.block* %160, metadata !349, metadata !DIExpression()), !dbg !875
  call void @llvm.dbg.value(metadata i64 %153, metadata !354, metadata !DIExpression()), !dbg !875
  call void @llvm.dbg.value(metadata i1 false, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !875
  %161 = getelementptr inbounds %struct.block, %struct.block* %160, i64 0, i32 0, !dbg !877
  store i64 %153, i64* %161, align 8, !dbg !878, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %160, metadata !154, metadata !DIExpression()), !dbg !879
  %162 = getelementptr inbounds %struct.block, %struct.block* %160, i64 0, i32 1, !dbg !881
  %163 = bitcast %union.anon* %162 to i8*, !dbg !882
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !883
  call void @llvm.dbg.value(metadata !DIArgList(i64 0, i64 %153), metadata !126, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !885
  %164 = getelementptr inbounds i8, i8* %163, i64 %153, !dbg !887
  %165 = getelementptr inbounds i8, i8* %164, i64 -16, !dbg !888
  %166 = bitcast i8* %165 to i64*, !dbg !889
  call void @llvm.dbg.value(metadata i64* %166, metadata !356, metadata !DIExpression()), !dbg !875
  store i64 %153, i64* %166, align 8, !dbg !890, !tbaa !170
  call void @llvm.dbg.value(metadata %struct.block* %160, metadata !646, metadata !DIExpression()) #6, !dbg !891
  %167 = load i64, i64* %161, align 8, !dbg !893, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !894
  call void @llvm.dbg.value(metadata i64 %167, metadata !126, metadata !DIExpression()) #6, !dbg !896
  %168 = and i64 %167, -16, !dbg !898
  call void @llvm.dbg.value(metadata i64 %168, metadata !649, metadata !DIExpression()) #6, !dbg !891
  %169 = getelementptr inbounds %struct.block, %struct.block* %160, i64 0, i32 1, i32 0, i32 1, !dbg !899
  %170 = getelementptr inbounds %struct.block, %struct.block* %160, i64 0, i32 1, i32 0, i32 0, !dbg !900
  call void @llvm.dbg.value(metadata i64 %168, metadata !453, metadata !DIExpression()) #6, !dbg !901
  call void @llvm.dbg.value(metadata i64 0, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %171 = icmp ugt i64 %168, 16, !dbg !903
  %172 = bitcast %struct.block** %170 to i8*, !dbg !904
  tail call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %172, i8 0, i64 16, i1 false) #6, !dbg !905
  br i1 %171, label %173, label %210, !dbg !904

173:                                              ; preds = %152
  call void @llvm.dbg.value(metadata i64 1, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %174 = icmp ugt i64 %168, 32, !dbg !903
  br i1 %174, label %175, label %210, !dbg !904

175:                                              ; preds = %173
  call void @llvm.dbg.value(metadata i64 2, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %176 = icmp ugt i64 %168, 64, !dbg !903
  br i1 %176, label %177, label %210, !dbg !904

177:                                              ; preds = %175
  call void @llvm.dbg.value(metadata i64 3, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %178 = icmp ugt i64 %168, 128, !dbg !903
  br i1 %178, label %179, label %210, !dbg !904

179:                                              ; preds = %177
  call void @llvm.dbg.value(metadata i64 4, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %180 = icmp ugt i64 %168, 256, !dbg !903
  br i1 %180, label %181, label %210, !dbg !904

181:                                              ; preds = %179
  call void @llvm.dbg.value(metadata i64 5, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %182 = icmp ugt i64 %168, 512, !dbg !903
  br i1 %182, label %183, label %210, !dbg !904

183:                                              ; preds = %181
  call void @llvm.dbg.value(metadata i64 6, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %184 = icmp ugt i64 %168, 1024, !dbg !903
  br i1 %184, label %185, label %210, !dbg !904

185:                                              ; preds = %183
  call void @llvm.dbg.value(metadata i64 7, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %186 = icmp ugt i64 %168, 2048, !dbg !903
  br i1 %186, label %187, label %210, !dbg !904

187:                                              ; preds = %185
  call void @llvm.dbg.value(metadata i64 8, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %188 = icmp ugt i64 %168, 4096, !dbg !903
  br i1 %188, label %189, label %210, !dbg !904

189:                                              ; preds = %187
  call void @llvm.dbg.value(metadata i64 9, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %190 = icmp ugt i64 %168, 8192, !dbg !903
  br i1 %190, label %191, label %210, !dbg !904

191:                                              ; preds = %189
  call void @llvm.dbg.value(metadata i64 10, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %192 = icmp ugt i64 %168, 16384, !dbg !903
  br i1 %192, label %193, label %210, !dbg !904

193:                                              ; preds = %191
  call void @llvm.dbg.value(metadata i64 11, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %194 = icmp ugt i64 %168, 32768, !dbg !903
  br i1 %194, label %195, label %210, !dbg !904

195:                                              ; preds = %193
  call void @llvm.dbg.value(metadata i64 12, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %196 = icmp ugt i64 %168, 65536, !dbg !903
  br i1 %196, label %197, label %210, !dbg !904

197:                                              ; preds = %195
  call void @llvm.dbg.value(metadata i64 13, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %198 = icmp ugt i64 %168, 131072, !dbg !903
  br i1 %198, label %199, label %210, !dbg !904

199:                                              ; preds = %197
  call void @llvm.dbg.value(metadata i64 14, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %200 = icmp ugt i64 %168, 262144, !dbg !903
  br i1 %200, label %201, label %210, !dbg !904

201:                                              ; preds = %199
  call void @llvm.dbg.value(metadata i64 15, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %202 = icmp ugt i64 %168, 524288, !dbg !903
  br i1 %202, label %203, label %210, !dbg !904

203:                                              ; preds = %201
  call void @llvm.dbg.value(metadata i64 16, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %204 = icmp ugt i64 %168, 1048576, !dbg !903
  br i1 %204, label %205, label %210, !dbg !904

205:                                              ; preds = %203
  call void @llvm.dbg.value(metadata i64 17, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %206 = icmp ugt i64 %168, 2097152, !dbg !903
  br i1 %206, label %207, label %210, !dbg !904

207:                                              ; preds = %205
  call void @llvm.dbg.value(metadata i64 18, metadata !458, metadata !DIExpression()) #6, !dbg !901
  %208 = icmp ugt i64 %168, 4194304, !dbg !903
  %209 = select i1 %208, i64 19, i64 18, !dbg !904
  br label %210, !dbg !904

210:                                              ; preds = %207, %205, %203, %201, %199, %197, %195, %193, %191, %189, %187, %185, %183, %181, %179, %177, %175, %173, %152
  %211 = phi i64 [ 0, %152 ], [ 1, %173 ], [ 2, %175 ], [ 3, %177 ], [ 4, %179 ], [ 5, %181 ], [ 6, %183 ], [ 7, %185 ], [ 8, %187 ], [ 9, %189 ], [ 10, %191 ], [ 11, %193 ], [ 12, %195 ], [ 13, %197 ], [ 14, %199 ], [ 15, %201 ], [ 16, %203 ], [ 17, %205 ], [ %209, %207 ], !dbg !906
  call void @llvm.dbg.value(metadata i64 %211, metadata !650, metadata !DIExpression()) #6, !dbg !891
  %212 = load %union.root*, %union.root** @heap_list, align 8, !dbg !907, !tbaa !107
  %213 = getelementptr inbounds %union.root, %union.root* %212, i64 %211, !dbg !907
  %214 = bitcast %union.root* %213 to %struct.block**, !dbg !908
  %215 = load %struct.block*, %struct.block** %214, align 8, !dbg !908, !tbaa !215
  %216 = icmp eq %struct.block* %215, null, !dbg !909
  br i1 %216, label %220, label %217, !dbg !910

217:                                              ; preds = %210
  store %struct.block* %215, %struct.block** %169, align 8, !dbg !911, !tbaa !215
  %218 = load %struct.block*, %struct.block** %214, align 8, !dbg !912, !tbaa !215
  %219 = getelementptr inbounds %struct.block, %struct.block* %218, i64 0, i32 1, i32 0, i32 0, !dbg !913
  store %struct.block* %160, %struct.block** %219, align 8, !dbg !914, !tbaa !215
  store %struct.block* null, %struct.block** %170, align 8, !dbg !915, !tbaa !215
  br label %220

220:                                              ; preds = %210, %217
  store %struct.block* %160, %struct.block** %214, align 8, !dbg !916, !tbaa !215
  br label %291, !dbg !917

221:                                              ; preds = %150
  tail call fastcc void @delete(%struct.block* noundef nonnull %15), !dbg !918
  call void @llvm.dbg.value(metadata i64 undef, metadata !724, metadata !DIExpression()), !dbg !727
  %222 = add i64 %25, %13, !dbg !920
  %223 = add i64 %222, %28, !dbg !921
  call void @llvm.dbg.value(metadata i64 %223, metadata !724, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !218, metadata !DIExpression()), !dbg !922
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !224, metadata !DIExpression()), !dbg !924
  call void @llvm.dbg.value(metadata i64* %3, metadata !221, metadata !DIExpression()), !dbg !922
  %224 = load i64, i64* %3, align 8, !dbg !926, !tbaa !170
  call void @llvm.dbg.value(metadata i64 %224, metadata !126, metadata !DIExpression()), !dbg !927
  %225 = and i64 %224, -16, !dbg !929
  %226 = icmp eq i64 %225, 0, !dbg !930
  %227 = sub i64 0, %225, !dbg !931
  %228 = getelementptr inbounds i8, i8* %7, i64 %227, !dbg !931
  %229 = bitcast i8* %228 to %struct.block*, !dbg !931
  %230 = select i1 %226, %struct.block* null, %struct.block* %229, !dbg !931
  call void @llvm.dbg.value(metadata %struct.block* %230, metadata !719, metadata !DIExpression()), !dbg !727
  call void @llvm.dbg.value(metadata %struct.block* %230, metadata !349, metadata !DIExpression()), !dbg !932
  call void @llvm.dbg.value(metadata i64 %223, metadata !354, metadata !DIExpression()), !dbg !932
  call void @llvm.dbg.value(metadata i1 false, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !932
  %231 = getelementptr inbounds %struct.block, %struct.block* %230, i64 0, i32 0, !dbg !934
  store i64 %223, i64* %231, align 8, !dbg !935, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %230, metadata !154, metadata !DIExpression()), !dbg !936
  %232 = getelementptr inbounds %struct.block, %struct.block* %230, i64 0, i32 1, !dbg !938
  %233 = bitcast %union.anon* %232 to i8*, !dbg !939
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !940
  call void @llvm.dbg.value(metadata !DIArgList(i64 0, i64 %223), metadata !126, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !942
  %234 = getelementptr inbounds i8, i8* %233, i64 %223, !dbg !944
  %235 = getelementptr inbounds i8, i8* %234, i64 -16, !dbg !945
  %236 = bitcast i8* %235 to i64*, !dbg !946
  call void @llvm.dbg.value(metadata i64* %236, metadata !356, metadata !DIExpression()), !dbg !932
  store i64 %223, i64* %236, align 8, !dbg !947, !tbaa !170
  call void @llvm.dbg.value(metadata %struct.block* %230, metadata !646, metadata !DIExpression()) #6, !dbg !948
  %237 = load i64, i64* %231, align 8, !dbg !950, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !951
  call void @llvm.dbg.value(metadata i64 %237, metadata !126, metadata !DIExpression()) #6, !dbg !953
  %238 = and i64 %237, -16, !dbg !955
  call void @llvm.dbg.value(metadata i64 %238, metadata !649, metadata !DIExpression()) #6, !dbg !948
  %239 = getelementptr inbounds %struct.block, %struct.block* %230, i64 0, i32 1, i32 0, i32 1, !dbg !956
  %240 = getelementptr inbounds %struct.block, %struct.block* %230, i64 0, i32 1, i32 0, i32 0, !dbg !957
  call void @llvm.dbg.value(metadata i64 %238, metadata !453, metadata !DIExpression()) #6, !dbg !958
  call void @llvm.dbg.value(metadata i64 0, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %241 = icmp ugt i64 %238, 16, !dbg !960
  %242 = bitcast %struct.block** %240 to i8*, !dbg !961
  tail call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %242, i8 0, i64 16, i1 false) #6, !dbg !962
  br i1 %241, label %243, label %280, !dbg !961

243:                                              ; preds = %221
  call void @llvm.dbg.value(metadata i64 1, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %244 = icmp ugt i64 %238, 32, !dbg !960
  br i1 %244, label %245, label %280, !dbg !961

245:                                              ; preds = %243
  call void @llvm.dbg.value(metadata i64 2, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %246 = icmp ugt i64 %238, 64, !dbg !960
  br i1 %246, label %247, label %280, !dbg !961

247:                                              ; preds = %245
  call void @llvm.dbg.value(metadata i64 3, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %248 = icmp ugt i64 %238, 128, !dbg !960
  br i1 %248, label %249, label %280, !dbg !961

249:                                              ; preds = %247
  call void @llvm.dbg.value(metadata i64 4, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %250 = icmp ugt i64 %238, 256, !dbg !960
  br i1 %250, label %251, label %280, !dbg !961

251:                                              ; preds = %249
  call void @llvm.dbg.value(metadata i64 5, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %252 = icmp ugt i64 %238, 512, !dbg !960
  br i1 %252, label %253, label %280, !dbg !961

253:                                              ; preds = %251
  call void @llvm.dbg.value(metadata i64 6, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %254 = icmp ugt i64 %238, 1024, !dbg !960
  br i1 %254, label %255, label %280, !dbg !961

255:                                              ; preds = %253
  call void @llvm.dbg.value(metadata i64 7, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %256 = icmp ugt i64 %238, 2048, !dbg !960
  br i1 %256, label %257, label %280, !dbg !961

257:                                              ; preds = %255
  call void @llvm.dbg.value(metadata i64 8, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %258 = icmp ugt i64 %238, 4096, !dbg !960
  br i1 %258, label %259, label %280, !dbg !961

259:                                              ; preds = %257
  call void @llvm.dbg.value(metadata i64 9, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %260 = icmp ugt i64 %238, 8192, !dbg !960
  br i1 %260, label %261, label %280, !dbg !961

261:                                              ; preds = %259
  call void @llvm.dbg.value(metadata i64 10, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %262 = icmp ugt i64 %238, 16384, !dbg !960
  br i1 %262, label %263, label %280, !dbg !961

263:                                              ; preds = %261
  call void @llvm.dbg.value(metadata i64 11, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %264 = icmp ugt i64 %238, 32768, !dbg !960
  br i1 %264, label %265, label %280, !dbg !961

265:                                              ; preds = %263
  call void @llvm.dbg.value(metadata i64 12, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %266 = icmp ugt i64 %238, 65536, !dbg !960
  br i1 %266, label %267, label %280, !dbg !961

267:                                              ; preds = %265
  call void @llvm.dbg.value(metadata i64 13, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %268 = icmp ugt i64 %238, 131072, !dbg !960
  br i1 %268, label %269, label %280, !dbg !961

269:                                              ; preds = %267
  call void @llvm.dbg.value(metadata i64 14, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %270 = icmp ugt i64 %238, 262144, !dbg !960
  br i1 %270, label %271, label %280, !dbg !961

271:                                              ; preds = %269
  call void @llvm.dbg.value(metadata i64 15, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %272 = icmp ugt i64 %238, 524288, !dbg !960
  br i1 %272, label %273, label %280, !dbg !961

273:                                              ; preds = %271
  call void @llvm.dbg.value(metadata i64 16, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %274 = icmp ugt i64 %238, 1048576, !dbg !960
  br i1 %274, label %275, label %280, !dbg !961

275:                                              ; preds = %273
  call void @llvm.dbg.value(metadata i64 17, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %276 = icmp ugt i64 %238, 2097152, !dbg !960
  br i1 %276, label %277, label %280, !dbg !961

277:                                              ; preds = %275
  call void @llvm.dbg.value(metadata i64 18, metadata !458, metadata !DIExpression()) #6, !dbg !958
  %278 = icmp ugt i64 %238, 4194304, !dbg !960
  %279 = select i1 %278, i64 19, i64 18, !dbg !961
  br label %280, !dbg !961

280:                                              ; preds = %277, %275, %273, %271, %269, %267, %265, %263, %261, %259, %257, %255, %253, %251, %249, %247, %245, %243, %221
  %281 = phi i64 [ 0, %221 ], [ 1, %243 ], [ 2, %245 ], [ 3, %247 ], [ 4, %249 ], [ 5, %251 ], [ 6, %253 ], [ 7, %255 ], [ 8, %257 ], [ 9, %259 ], [ 10, %261 ], [ 11, %263 ], [ 12, %265 ], [ 13, %267 ], [ 14, %269 ], [ 15, %271 ], [ 16, %273 ], [ 17, %275 ], [ %279, %277 ], !dbg !963
  call void @llvm.dbg.value(metadata i64 %281, metadata !650, metadata !DIExpression()) #6, !dbg !948
  %282 = load %union.root*, %union.root** @heap_list, align 8, !dbg !964, !tbaa !107
  %283 = getelementptr inbounds %union.root, %union.root* %282, i64 %281, !dbg !964
  %284 = bitcast %union.root* %283 to %struct.block**, !dbg !965
  %285 = load %struct.block*, %struct.block** %284, align 8, !dbg !965, !tbaa !215
  %286 = icmp eq %struct.block* %285, null, !dbg !966
  br i1 %286, label %290, label %287, !dbg !967

287:                                              ; preds = %280
  store %struct.block* %285, %struct.block** %239, align 8, !dbg !968, !tbaa !215
  %288 = load %struct.block*, %struct.block** %284, align 8, !dbg !969, !tbaa !215
  %289 = getelementptr inbounds %struct.block, %struct.block* %288, i64 0, i32 1, i32 0, i32 0, !dbg !970
  store %struct.block* %230, %struct.block** %289, align 8, !dbg !971, !tbaa !215
  store %struct.block* null, %struct.block** %240, align 8, !dbg !972, !tbaa !215
  br label %290

290:                                              ; preds = %280, %287
  store %struct.block* %230, %struct.block** %284, align 8, !dbg !973, !tbaa !215
  br label %291, !dbg !974

291:                                              ; preds = %290, %220, %149, %86
  %292 = phi %struct.block* [ %0, %86 ], [ %230, %290 ], [ %160, %220 ], [ %0, %149 ], !dbg !975
  ret %struct.block* %292, !dbg !976
}

; Function Attrs: nounwind uwtable
define dso_local i8* @mm_realloc(i8* noundef %0, i64 noundef %1) local_unnamed_addr #0 !dbg !977 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !981, metadata !DIExpression()), !dbg !986
  call void @llvm.dbg.value(metadata i64 %1, metadata !982, metadata !DIExpression()), !dbg !986
  call void @llvm.dbg.value(metadata i8* %0, metadata !340, metadata !DIExpression()), !dbg !987
  %3 = getelementptr inbounds i8, i8* %0, i64 -8, !dbg !989
  %4 = bitcast i8* %3 to %struct.block*, !dbg !990
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !983, metadata !DIExpression()), !dbg !986
  %5 = icmp eq i64 %1, 0, !dbg !991
  %6 = icmp eq i8* %0, null, !dbg !986
  br i1 %5, label %7, label %12, !dbg !993

7:                                                ; preds = %2
  call void @llvm.dbg.value(metadata i8* %0, metadata !685, metadata !DIExpression()) #6, !dbg !994
  br i1 %6, label %33, label %8, !dbg !997

8:                                                ; preds = %7
  call void @llvm.dbg.value(metadata i8* %0, metadata !340, metadata !DIExpression()) #6, !dbg !998
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !686, metadata !DIExpression()) #6, !dbg !994
  %9 = bitcast i8* %3 to i64*, !dbg !1000
  %10 = load i64, i64* %9, align 8, !dbg !1000, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !1001
  call void @llvm.dbg.value(metadata i64 %10, metadata !126, metadata !DIExpression()) #6, !dbg !1003
  %11 = and i64 %10, -16, !dbg !1005
  call void @llvm.dbg.value(metadata i64 %11, metadata !687, metadata !DIExpression()) #6, !dbg !994
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !349, metadata !DIExpression()) #6, !dbg !1006
  call void @llvm.dbg.value(metadata i64 %11, metadata !354, metadata !DIExpression()) #6, !dbg !1006
  call void @llvm.dbg.value(metadata i1 false, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !1006
  store i64 %11, i64* %9, align 8, !dbg !1008, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !154, metadata !DIExpression()) #6, !dbg !1009
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !1011
  call void @llvm.dbg.value(metadata !DIArgList(i64 0, i64 %11), metadata !126, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)) #6, !dbg !1013
  call void @llvm.dbg.value(metadata i64* %31, metadata !356, metadata !DIExpression()) #6, !dbg !1006
  br label %26

12:                                               ; preds = %2
  %13 = tail call i8* @mm_malloc(i64 noundef %1), !dbg !986
  br i1 %6, label %33, label %14, !dbg !1015

14:                                               ; preds = %12
  call void @llvm.dbg.value(metadata i8* %13, metadata !985, metadata !DIExpression()), !dbg !986
  %15 = icmp eq i8* %13, null, !dbg !1016
  br i1 %15, label %33, label %16, !dbg !1018

16:                                               ; preds = %14
  %17 = bitcast i8* %3 to i64*, !dbg !1019
  %18 = load i64, i64* %17, align 8, !dbg !1019, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !1020, metadata !DIExpression()), !dbg !1024
  call void @llvm.dbg.value(metadata i64 %18, metadata !1023, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1024
  %19 = add i64 %18, -16, !dbg !1026
  %20 = and i64 %19, -16, !dbg !1026
  call void @llvm.dbg.value(metadata i64 %20, metadata !984, metadata !DIExpression()), !dbg !986
  %21 = icmp ugt i64 %20, %1, !dbg !1027
  %22 = select i1 %21, i64 %1, i64 %20, !dbg !1029
  call void @llvm.dbg.value(metadata i64 %22, metadata !984, metadata !DIExpression()), !dbg !986
  %23 = tail call i8* @mem_memcpy(i8* noundef nonnull %13, i8* noundef nonnull %0, i64 noundef %22) #6, !dbg !1030
  call void @llvm.dbg.value(metadata i8* %0, metadata !685, metadata !DIExpression()) #6, !dbg !1031
  call void @llvm.dbg.value(metadata i8* %0, metadata !340, metadata !DIExpression()) #6, !dbg !1033
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !686, metadata !DIExpression()) #6, !dbg !1031
  %24 = load i64, i64* %17, align 8, !dbg !1035, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !1036
  call void @llvm.dbg.value(metadata i64 %24, metadata !126, metadata !DIExpression()) #6, !dbg !1038
  %25 = and i64 %24, -16, !dbg !1040
  call void @llvm.dbg.value(metadata i64 %25, metadata !687, metadata !DIExpression()) #6, !dbg !1031
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !349, metadata !DIExpression()) #6, !dbg !1041
  call void @llvm.dbg.value(metadata i64 %25, metadata !354, metadata !DIExpression()) #6, !dbg !1041
  call void @llvm.dbg.value(metadata i1 false, metadata !355, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !1041
  store i64 %25, i64* %17, align 8, !dbg !1043, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !154, metadata !DIExpression()) #6, !dbg !1044
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()) #6, !dbg !1046
  call void @llvm.dbg.value(metadata !DIArgList(i64 0, i64 %25), metadata !126, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)) #6, !dbg !1048
  call void @llvm.dbg.value(metadata i64* undef, metadata !356, metadata !DIExpression()) #6, !dbg !1041
  br label %26, !dbg !1050

26:                                               ; preds = %16, %8
  %27 = phi i64 [ %11, %8 ], [ %25, %16 ]
  %28 = phi i8* [ null, %8 ], [ %13, %16 ]
  %29 = getelementptr inbounds i8, i8* %0, i64 %27, !dbg !986
  %30 = getelementptr inbounds i8, i8* %29, i64 -16, !dbg !986
  %31 = bitcast i8* %30 to i64*, !dbg !986
  store i64 %27, i64* %31, align 8, !dbg !986, !tbaa !170
  %32 = tail call fastcc %struct.block* @coalesce_block(%struct.block* noundef nonnull %4) #6, !dbg !986
  br label %33, !dbg !1051

33:                                               ; preds = %26, %12, %7, %14
  %34 = phi i8* [ null, %14 ], [ null, %7 ], [ %13, %12 ], [ %28, %26 ], !dbg !986
  ret i8* %34, !dbg !1051
}

declare !dbg !1052 i8* @mem_memcpy(i8* noundef, i8* noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i8* @mm_calloc(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 !dbg !1057 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !1061, metadata !DIExpression()), !dbg !1065
  call void @llvm.dbg.value(metadata i64 %1, metadata !1062, metadata !DIExpression()), !dbg !1065
  %3 = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %0, i64 %1), !dbg !1066
  %4 = extractvalue { i64, i1 } %3, 0, !dbg !1066
  call void @llvm.dbg.value(metadata i64 %4, metadata !1064, metadata !DIExpression()), !dbg !1065
  %5 = icmp eq i64 %0, 0, !dbg !1067
  br i1 %5, label %13, label %6, !dbg !1069

6:                                                ; preds = %2
  %7 = extractvalue { i64, i1 } %3, 1, !dbg !1066
  br i1 %7, label %13, label %8, !dbg !1070

8:                                                ; preds = %6
  %9 = tail call i8* @mm_malloc(i64 noundef %4), !dbg !1071
  call void @llvm.dbg.value(metadata i8* %9, metadata !1063, metadata !DIExpression()), !dbg !1065
  %10 = icmp eq i8* %9, null, !dbg !1072
  br i1 %10, label %13, label %11, !dbg !1074

11:                                               ; preds = %8
  %12 = tail call i8* @mem_memset(i8* noundef nonnull %9, i32 noundef 0, i64 noundef %4) #6, !dbg !1075
  br label %13, !dbg !1076

13:                                               ; preds = %8, %6, %2, %11
  %14 = phi i8* [ %9, %11 ], [ null, %2 ], [ null, %6 ], [ null, %8 ], !dbg !1065
  ret i8* %14, !dbg !1077
}

declare !dbg !1078 i8* @mem_memset(i8* noundef, i32 noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable willreturn
define internal fastcc void @delete(%struct.block* nocapture noundef %0) unnamed_addr #3 !dbg !1081 {
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !1083, metadata !DIExpression()), !dbg !1093
  %2 = getelementptr %struct.block, %struct.block* %0, i64 0, i32 0, !dbg !1094
  %3 = load i64, i64* %2, align 8, !dbg !1094, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !119, metadata !DIExpression()), !dbg !1095
  call void @llvm.dbg.value(metadata i64 %3, metadata !126, metadata !DIExpression()), !dbg !1097
  %4 = and i64 %3, -16, !dbg !1099
  call void @llvm.dbg.value(metadata i64 %4, metadata !1084, metadata !DIExpression()), !dbg !1093
  call void @llvm.dbg.value(metadata i64 %4, metadata !453, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 0, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 0, metadata !458, metadata !DIExpression()), !dbg !1100
  %5 = icmp ugt i64 %4, 16, !dbg !1102
  br i1 %5, label %6, label %43, !dbg !1103

6:                                                ; preds = %1
  call void @llvm.dbg.value(metadata i64 1, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 1, metadata !458, metadata !DIExpression()), !dbg !1100
  %7 = icmp ugt i64 %4, 32, !dbg !1102
  br i1 %7, label %8, label %43, !dbg !1103

8:                                                ; preds = %6
  call void @llvm.dbg.value(metadata i64 2, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 2, metadata !458, metadata !DIExpression()), !dbg !1100
  %9 = icmp ugt i64 %4, 64, !dbg !1102
  br i1 %9, label %10, label %43, !dbg !1103

10:                                               ; preds = %8
  call void @llvm.dbg.value(metadata i64 3, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 3, metadata !458, metadata !DIExpression()), !dbg !1100
  %11 = icmp ugt i64 %4, 128, !dbg !1102
  br i1 %11, label %12, label %43, !dbg !1103

12:                                               ; preds = %10
  call void @llvm.dbg.value(metadata i64 4, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 4, metadata !458, metadata !DIExpression()), !dbg !1100
  %13 = icmp ugt i64 %4, 256, !dbg !1102
  br i1 %13, label %14, label %43, !dbg !1103

14:                                               ; preds = %12
  call void @llvm.dbg.value(metadata i64 5, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 5, metadata !458, metadata !DIExpression()), !dbg !1100
  %15 = icmp ugt i64 %4, 512, !dbg !1102
  br i1 %15, label %16, label %43, !dbg !1103

16:                                               ; preds = %14
  call void @llvm.dbg.value(metadata i64 6, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 6, metadata !458, metadata !DIExpression()), !dbg !1100
  %17 = icmp ugt i64 %4, 1024, !dbg !1102
  br i1 %17, label %18, label %43, !dbg !1103

18:                                               ; preds = %16
  call void @llvm.dbg.value(metadata i64 7, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 7, metadata !458, metadata !DIExpression()), !dbg !1100
  %19 = icmp ugt i64 %4, 2048, !dbg !1102
  br i1 %19, label %20, label %43, !dbg !1103

20:                                               ; preds = %18
  call void @llvm.dbg.value(metadata i64 8, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 8, metadata !458, metadata !DIExpression()), !dbg !1100
  %21 = icmp ugt i64 %4, 4096, !dbg !1102
  br i1 %21, label %22, label %43, !dbg !1103

22:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i64 9, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 9, metadata !458, metadata !DIExpression()), !dbg !1100
  %23 = icmp ugt i64 %4, 8192, !dbg !1102
  br i1 %23, label %24, label %43, !dbg !1103

24:                                               ; preds = %22
  call void @llvm.dbg.value(metadata i64 10, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 10, metadata !458, metadata !DIExpression()), !dbg !1100
  %25 = icmp ugt i64 %4, 16384, !dbg !1102
  br i1 %25, label %26, label %43, !dbg !1103

26:                                               ; preds = %24
  call void @llvm.dbg.value(metadata i64 11, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 11, metadata !458, metadata !DIExpression()), !dbg !1100
  %27 = icmp ugt i64 %4, 32768, !dbg !1102
  br i1 %27, label %28, label %43, !dbg !1103

28:                                               ; preds = %26
  call void @llvm.dbg.value(metadata i64 12, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 12, metadata !458, metadata !DIExpression()), !dbg !1100
  %29 = icmp ugt i64 %4, 65536, !dbg !1102
  br i1 %29, label %30, label %43, !dbg !1103

30:                                               ; preds = %28
  call void @llvm.dbg.value(metadata i64 13, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 13, metadata !458, metadata !DIExpression()), !dbg !1100
  %31 = icmp ugt i64 %4, 131072, !dbg !1102
  br i1 %31, label %32, label %43, !dbg !1103

32:                                               ; preds = %30
  call void @llvm.dbg.value(metadata i64 14, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 14, metadata !458, metadata !DIExpression()), !dbg !1100
  %33 = icmp ugt i64 %4, 262144, !dbg !1102
  br i1 %33, label %34, label %43, !dbg !1103

34:                                               ; preds = %32
  call void @llvm.dbg.value(metadata i64 15, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 15, metadata !458, metadata !DIExpression()), !dbg !1100
  %35 = icmp ugt i64 %4, 524288, !dbg !1102
  br i1 %35, label %36, label %43, !dbg !1103

36:                                               ; preds = %34
  call void @llvm.dbg.value(metadata i64 16, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 16, metadata !458, metadata !DIExpression()), !dbg !1100
  %37 = icmp ugt i64 %4, 1048576, !dbg !1102
  br i1 %37, label %38, label %43, !dbg !1103

38:                                               ; preds = %36
  call void @llvm.dbg.value(metadata i64 17, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 17, metadata !458, metadata !DIExpression()), !dbg !1100
  %39 = icmp ugt i64 %4, 2097152, !dbg !1102
  br i1 %39, label %40, label %43, !dbg !1103

40:                                               ; preds = %38
  call void @llvm.dbg.value(metadata i64 18, metadata !458, metadata !DIExpression()), !dbg !1100
  call void @llvm.dbg.value(metadata i64 18, metadata !458, metadata !DIExpression()), !dbg !1100
  %41 = icmp ugt i64 %4, 4194304, !dbg !1102
  %42 = select i1 %41, i64 19, i64 18, !dbg !1103
  br label %43, !dbg !1103

43:                                               ; preds = %1, %6, %8, %10, %12, %14, %16, %18, %20, %22, %24, %26, %28, %30, %32, %34, %36, %38, %40
  %44 = phi i64 [ 0, %1 ], [ 1, %6 ], [ 2, %8 ], [ 3, %10 ], [ 4, %12 ], [ 5, %14 ], [ 6, %16 ], [ 7, %18 ], [ 8, %20 ], [ 9, %22 ], [ 10, %24 ], [ 11, %26 ], [ 12, %28 ], [ 13, %30 ], [ 14, %32 ], [ 15, %34 ], [ 16, %36 ], [ 17, %38 ], [ %42, %40 ], !dbg !1104
  call void @llvm.dbg.value(metadata i64 %44, metadata !1085, metadata !DIExpression()), !dbg !1093
  %45 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, i32 0, i32 0, !dbg !1105
  %46 = load %struct.block*, %struct.block** %45, align 8, !dbg !1105, !tbaa !215
  %47 = icmp eq %struct.block* %46, null, !dbg !1106
  %48 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, i32 0, i32 1, !dbg !1107
  %49 = load %struct.block*, %struct.block** %48, align 8, !dbg !1107, !tbaa !215
  %50 = icmp eq %struct.block* %49, null, !dbg !1107
  br i1 %47, label %51, label %56, !dbg !1108

51:                                               ; preds = %43
  %52 = load %union.root*, %union.root** @heap_list, align 8, !dbg !1107, !tbaa !107
  %53 = getelementptr inbounds %union.root, %union.root* %52, i64 %44, !dbg !1107
  %54 = bitcast %union.root* %53 to %struct.block**, !dbg !1107
  br i1 %50, label %55, label %59, !dbg !1109

55:                                               ; preds = %51
  store %struct.block* null, %struct.block** %54, align 8, !dbg !1110, !tbaa !215
  br label %66, !dbg !1112

56:                                               ; preds = %43
  %57 = getelementptr inbounds %struct.block, %struct.block* %46, i64 0, i32 1, i32 0, i32 1, !dbg !1113
  br i1 %50, label %58, label %62, !dbg !1114

58:                                               ; preds = %56
  store %struct.block* null, %struct.block** %57, align 8, !dbg !1115, !tbaa !215
  store %struct.block* null, %struct.block** %45, align 8, !dbg !1117, !tbaa !215
  br label %66, !dbg !1118

59:                                               ; preds = %51
  store %struct.block* %49, %struct.block** %54, align 8, !dbg !1119, !tbaa !215
  %60 = load %struct.block*, %struct.block** %48, align 8, !dbg !1121, !tbaa !215
  %61 = getelementptr inbounds %struct.block, %struct.block* %60, i64 0, i32 1, i32 0, i32 0, !dbg !1122
  store %struct.block* null, %struct.block** %61, align 8, !dbg !1123, !tbaa !215
  store %struct.block* null, %struct.block** %48, align 8, !dbg !1124, !tbaa !215
  br label %66, !dbg !1125

62:                                               ; preds = %56
  call void @llvm.dbg.value(metadata %struct.block* %49, metadata !1086, metadata !DIExpression()), !dbg !1126
  call void @llvm.dbg.value(metadata %struct.block* %46, metadata !1092, metadata !DIExpression()), !dbg !1126
  store %struct.block* %49, %struct.block** %57, align 8, !dbg !1127, !tbaa !215
  %63 = load %struct.block*, %struct.block** %48, align 8, !dbg !1128, !tbaa !215
  %64 = getelementptr inbounds %struct.block, %struct.block* %63, i64 0, i32 1, i32 0, i32 0, !dbg !1129
  store %struct.block* %46, %struct.block** %64, align 8, !dbg !1130, !tbaa !215
  %65 = bitcast %struct.block** %45 to i8*, !dbg !1131
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %65, i8 0, i64 16, i1 false), !dbg !1132
  br label %66, !dbg !1131

66:                                               ; preds = %58, %62, %59, %55
  ret void, !dbg !1133
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #4

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #4

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #5

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nofree nosync nounwind uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #5 = { argmemonly nofree nounwind willreturn writeonly }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!66, !67, !68, !69, !70, !71}
!llvm.ident = !{!72}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "heap_list", scope: !2, file: !3, line: 147, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !45, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "mm.c", directory: "/afs/andrew.cmu.edu/usr7/hanningw/private/18213/malloclab/cachelab5-Nonsens77", checksumkind: CSK_MD5, checksum: "b3e91e91ccb4c5e7f13ef689be0837ad")
!4 = !{!5, !8, !9, !37, !39, !40, !41, !42}
!5 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !6, line: 46, baseType: !7)
!6 = !DIFile(filename: "/usr/lib/llvm-14/lib/clang/14.0.0/include/stddef.h", directory: "", checksumkind: CSK_MD5, checksum: "2499dd2361b915724b073282bea3a7bc")
!7 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIDerivedType(tag: DW_TAG_typedef, name: "root_t", file: !3, line: 139, baseType: !11)
!11 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "root", file: !3, line: 136, size: 64, elements: !12)
!12 = !{!13, !19}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "header", scope: !11, file: !3, line: 137, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "word_t", file: !3, line: 86, baseType: !15)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !16, line: 27, baseType: !17)
!16 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "2bf2ae53c58c01b1a1b9383b5195125c")
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !18, line: 45, baseType: !7)
!18 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "d108b5f93a74c50510d7d9bc0ab36df9")
!19 = !DIDerivedType(tag: DW_TAG_member, name: "first", scope: !11, file: !3, line: 138, baseType: !20, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "block", file: !3, line: 120, size: 192, elements: !22)
!22 = !{!23, !24}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "header", scope: !21, file: !3, line: 122, baseType: !14, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_member, scope: !21, file: !3, line: 127, baseType: !25, size: 128, offset: 64)
!25 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !21, file: !3, line: 127, size: 128, elements: !26)
!26 = !{!27, !32}
!27 = !DIDerivedType(tag: DW_TAG_member, scope: !25, file: !3, line: 128, baseType: !28, size: 128)
!28 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !25, file: !3, line: 128, size: 128, elements: !29)
!29 = !{!30, !31}
!30 = !DIDerivedType(tag: DW_TAG_member, name: "pred", scope: !28, file: !3, line: 129, baseType: !20, size: 64)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "succ", scope: !28, file: !3, line: 130, baseType: !20, size: 64, offset: 64)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !25, file: !3, line: 132, baseType: !33)
!33 = !DICompositeType(tag: DW_TAG_array_type, baseType: !34, elements: !35)
!34 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!35 = !{!36}
!36 = !DISubrange(count: 0)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = !DIDerivedType(tag: DW_TAG_typedef, name: "block_t", file: !3, line: 134, baseType: !21)
!39 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!41 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!42 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !43, line: 87, baseType: !44)
!43 = !DIFile(filename: "/usr/include/stdint.h", directory: "", checksumkind: CSK_MD5, checksum: "a48e64edacc5b19f56c99745232c963c")
!44 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!45 = !{!0, !46, !49, !51, !53, !55, !57, !59, !62, !64}
!46 = !DIGlobalVariableExpression(var: !47, expr: !DIExpression(DW_OP_constu, 16, DW_OP_stack_value))
!47 = distinct !DIGlobalVariable(name: "align", scope: !2, file: !3, line: 101, type: !48, isLocal: true, isDefinition: true)
!48 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5)
!49 = !DIGlobalVariableExpression(var: !50, expr: !DIExpression(DW_OP_constu, 20, DW_OP_stack_value))
!50 = distinct !DIGlobalVariable(name: "seg_size", scope: !2, file: !3, line: 98, type: !48, isLocal: true, isDefinition: true)
!51 = !DIGlobalVariableExpression(var: !52, expr: !DIExpression(DW_OP_constu, 8, DW_OP_stack_value))
!52 = distinct !DIGlobalVariable(name: "wsize", scope: !2, file: !3, line: 89, type: !48, isLocal: true, isDefinition: true)
!53 = !DIGlobalVariableExpression(var: !54, expr: !DIExpression(DW_OP_constu, 4096, DW_OP_stack_value))
!54 = distinct !DIGlobalVariable(name: "chunksize", scope: !2, file: !3, line: 107, type: !48, isLocal: true, isDefinition: true)
!55 = !DIGlobalVariableExpression(var: !56, expr: !DIExpression(DW_OP_constu, 16, DW_OP_stack_value))
!56 = distinct !DIGlobalVariable(name: "dsize", scope: !2, file: !3, line: 92, type: !48, isLocal: true, isDefinition: true)
!57 = !DIGlobalVariableExpression(var: !58, expr: !DIExpression())
!58 = distinct !DIGlobalVariable(name: "heap_start", scope: !2, file: !3, line: 144, type: !37, isLocal: true, isDefinition: true)
!59 = !DIGlobalVariableExpression(var: !60, expr: !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_stack_value))
!60 = distinct !DIGlobalVariable(name: "size_mask", scope: !2, file: !3, line: 117, type: !61, isLocal: true, isDefinition: true)
!61 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !14)
!62 = !DIGlobalVariableExpression(var: !63, expr: !DIExpression(DW_OP_constu, 1, DW_OP_stack_value))
!63 = distinct !DIGlobalVariable(name: "alloc_mask", scope: !2, file: !3, line: 112, type: !61, isLocal: true, isDefinition: true)
!64 = !DIGlobalVariableExpression(var: !65, expr: !DIExpression(DW_OP_constu, 32, DW_OP_stack_value))
!65 = distinct !DIGlobalVariable(name: "min_block_size", scope: !2, file: !3, line: 95, type: !48, isLocal: true, isDefinition: true)
!66 = !{i32 7, !"Dwarf Version", i32 5}
!67 = !{i32 2, !"Debug Info Version", i32 3}
!68 = !{i32 1, !"wchar_size", i32 4}
!69 = !{i32 7, !"PIC Level", i32 2}
!70 = !{i32 7, !"PIE Level", i32 2}
!71 = !{i32 7, !"uwtable", i32 1}
!72 = !{!"Ubuntu clang version 14.0.0-1ubuntu1"}
!73 = distinct !DISubprogram(name: "mm_checkheap", scope: !3, file: !3, line: 745, type: !74, scopeLine: 745, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !77)
!74 = !DISubroutineType(types: !75)
!75 = !{!39, !76}
!76 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!77 = !{!78, !79, !80, !81, !82, !83, !84, !88, !89, !91, !95, !96, !99, !100, !103, !104}
!78 = !DILocalVariable(name: "line", arg: 1, scope: !73, file: !3, line: 745, type: !76)
!79 = !DILocalVariable(name: "block", scope: !73, file: !3, line: 761, type: !37)
!80 = !DILocalVariable(name: "start_address", scope: !73, file: !3, line: 762, type: !5)
!81 = !DILocalVariable(name: "firstbyte_address", scope: !73, file: !3, line: 763, type: !5)
!82 = !DILocalVariable(name: "lastbyte_address", scope: !73, file: !3, line: 764, type: !5)
!83 = !DILocalVariable(name: "total_size", scope: !73, file: !3, line: 765, type: !5)
!84 = !DILocalVariable(name: "address", scope: !85, file: !3, line: 768, type: !5)
!85 = distinct !DILexicalBlock(scope: !86, file: !3, line: 767, column: 77)
!86 = distinct !DILexicalBlock(scope: !87, file: !3, line: 767, column: 5)
!87 = distinct !DILexicalBlock(scope: !73, file: !3, line: 767, column: 5)
!88 = !DILocalVariable(name: "foot_alloc", scope: !85, file: !3, line: 782, type: !39)
!89 = !DILocalVariable(name: "i", scope: !90, file: !3, line: 797, type: !5)
!90 = distinct !DILexicalBlock(scope: !73, file: !3, line: 797, column: 5)
!91 = !DILocalVariable(name: "prev", scope: !92, file: !3, line: 801, type: !37)
!92 = distinct !DILexicalBlock(scope: !93, file: !3, line: 799, column: 31)
!93 = distinct !DILexicalBlock(scope: !94, file: !3, line: 797, column: 43)
!94 = distinct !DILexicalBlock(scope: !90, file: !3, line: 797, column: 5)
!95 = !DILocalVariable(name: "next", scope: !92, file: !3, line: 802, type: !37)
!96 = !DILocalVariable(name: "pred", scope: !97, file: !3, line: 816, type: !37)
!97 = distinct !DILexicalBlock(scope: !98, file: !3, line: 815, column: 30)
!98 = distinct !DILexicalBlock(scope: !92, file: !3, line: 815, column: 17)
!99 = !DILocalVariable(name: "pred_address", scope: !97, file: !3, line: 817, type: !5)
!100 = !DILocalVariable(name: "succ", scope: !101, file: !3, line: 827, type: !37)
!101 = distinct !DILexicalBlock(scope: !102, file: !3, line: 826, column: 30)
!102 = distinct !DILexicalBlock(scope: !92, file: !3, line: 826, column: 17)
!103 = !DILocalVariable(name: "succ_address", scope: !101, file: !3, line: 828, type: !5)
!104 = !DILocalVariable(name: "size", scope: !92, file: !3, line: 842, type: !5)
!105 = !DILocation(line: 0, scope: !73)
!106 = !DILocation(line: 762, column: 44, scope: !73)
!107 = !{!108, !108, i64 0}
!108 = !{!"any pointer", !109, i64 0}
!109 = !{!"omnipotent char", !110, i64 0}
!110 = !{!"Simple C/C++ TBAA"}
!111 = !DILocation(line: 762, column: 28, scope: !73)
!112 = !DILocation(line: 763, column: 40, scope: !73)
!113 = !DILocation(line: 764, column: 39, scope: !73)
!114 = !DILocation(line: 767, column: 18, scope: !87)
!115 = !DILocation(line: 767, column: 30, scope: !86)
!116 = !{!117, !118, i64 0}
!117 = !{!"block", !118, i64 0, !109, i64 8}
!118 = !{!"long", !109, i64 0}
!119 = !DILocalVariable(name: "block", arg: 1, scope: !120, file: !3, line: 227, type: !37)
!120 = distinct !DISubprogram(name: "get_size", scope: !3, file: !3, line: 227, type: !121, scopeLine: 227, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !123)
!121 = !DISubroutineType(types: !122)
!122 = !{!5, !37}
!123 = !{!119}
!124 = !DILocation(line: 0, scope: !120, inlinedAt: !125)
!125 = distinct !DILocation(line: 767, column: 30, scope: !86)
!126 = !DILocalVariable(name: "word", arg: 1, scope: !127, file: !3, line: 218, type: !14)
!127 = distinct !DISubprogram(name: "extract_size", scope: !3, file: !3, line: 218, type: !128, scopeLine: 218, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !130)
!128 = !DISubroutineType(types: !129)
!129 = !{!5, !14}
!130 = !{!126}
!131 = !DILocation(line: 0, scope: !127, inlinedAt: !132)
!132 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !125)
!133 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !132)
!134 = !DILocation(line: 767, column: 46, scope: !86)
!135 = !DILocation(line: 767, column: 5, scope: !87)
!136 = !DILocation(line: 790, column: 22, scope: !137)
!137 = distinct !DILexicalBlock(scope: !73, file: !3, line: 790, column: 9)
!138 = !DILocation(line: 790, column: 9, scope: !73)
!139 = !DILocation(line: 0, scope: !85)
!140 = !DILocation(line: 0, scope: !120, inlinedAt: !141)
!141 = distinct !DILocation(line: 769, column: 23, scope: !85)
!142 = !DILocation(line: 0, scope: !127, inlinedAt: !143)
!143 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !141)
!144 = !DILocation(line: 769, column: 20, scope: !85)
!145 = !DILocation(line: 771, column: 22, scope: !146)
!146 = distinct !DILexicalBlock(scope: !85, file: !3, line: 771, column: 13)
!147 = !DILocation(line: 771, column: 43, scope: !146)
!148 = !DILocation(line: 768, column: 26, scope: !85)
!149 = !DILocation(line: 777, column: 23, scope: !150)
!150 = distinct !DILexicalBlock(scope: !85, file: !3, line: 777, column: 13)
!151 = !DILocation(line: 777, column: 40, scope: !150)
!152 = !DILocation(line: 777, column: 49, scope: !150)
!153 = !DILocation(line: 777, column: 13, scope: !85)
!154 = !DILocalVariable(name: "block", arg: 1, scope: !155, file: !3, line: 260, type: !37)
!155 = distinct !DISubprogram(name: "header_to_footer", scope: !3, file: !3, line: 260, type: !156, scopeLine: 260, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !158)
!156 = !DISubroutineType(types: !157)
!157 = !{!40, !37}
!158 = !{!154}
!159 = !DILocation(line: 0, scope: !155, inlinedAt: !160)
!160 = distinct !DILocation(line: 782, column: 42, scope: !85)
!161 = !DILocation(line: 263, column: 30, scope: !155, inlinedAt: !160)
!162 = !DILocation(line: 0, scope: !120, inlinedAt: !163)
!163 = distinct !DILocation(line: 263, column: 40, scope: !155, inlinedAt: !160)
!164 = !DILocation(line: 0, scope: !127, inlinedAt: !165)
!165 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !163)
!166 = !DILocation(line: 263, column: 38, scope: !155, inlinedAt: !160)
!167 = !DILocation(line: 263, column: 56, scope: !155, inlinedAt: !160)
!168 = !DILocation(line: 263, column: 12, scope: !155, inlinedAt: !160)
!169 = !DILocation(line: 782, column: 41, scope: !85)
!170 = !{!118, !118, i64 0}
!171 = !DILocalVariable(name: "word", arg: 1, scope: !172, file: !3, line: 301, type: !14)
!172 = distinct !DISubprogram(name: "extract_alloc", scope: !3, file: !3, line: 301, type: !173, scopeLine: 301, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !175)
!173 = !DISubroutineType(types: !174)
!174 = !{!39, !14}
!175 = !{!171}
!176 = !DILocation(line: 0, scope: !172, inlinedAt: !177)
!177 = distinct !DILocation(line: 782, column: 27, scope: !85)
!178 = !DILocation(line: 302, column: 24, scope: !172, inlinedAt: !177)
!179 = !DILocation(line: 302, column: 12, scope: !172, inlinedAt: !177)
!180 = !DILocalVariable(name: "block", arg: 1, scope: !181, file: !3, line: 310, type: !37)
!181 = distinct !DISubprogram(name: "get_alloc", scope: !3, file: !3, line: 310, type: !182, scopeLine: 310, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !184)
!182 = !DISubroutineType(types: !183)
!183 = !{!39, !37}
!184 = !{!180}
!185 = !DILocation(line: 0, scope: !181, inlinedAt: !186)
!186 = distinct !DILocation(line: 783, column: 13, scope: !187)
!187 = distinct !DILexicalBlock(scope: !85, file: !3, line: 783, column: 13)
!188 = !DILocation(line: 0, scope: !172, inlinedAt: !189)
!189 = distinct !DILocation(line: 311, column: 12, scope: !181, inlinedAt: !186)
!190 = !DILocation(line: 302, column: 24, scope: !172, inlinedAt: !189)
!191 = !DILocation(line: 302, column: 12, scope: !172, inlinedAt: !189)
!192 = !DILocation(line: 783, column: 30, scope: !187)
!193 = !DILocalVariable(name: "block", arg: 1, scope: !194, file: !3, line: 357, type: !37)
!194 = distinct !DISubprogram(name: "find_next", scope: !3, file: !3, line: 357, type: !195, scopeLine: 357, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !197)
!195 = !DISubroutineType(types: !196)
!196 = !{!37, !37}
!197 = !{!193}
!198 = !DILocation(line: 0, scope: !194, inlinedAt: !199)
!199 = distinct !DILocation(line: 767, column: 59, scope: !86)
!200 = !DILocation(line: 361, column: 24, scope: !194, inlinedAt: !199)
!201 = !DILocation(line: 0, scope: !120, inlinedAt: !202)
!202 = distinct !DILocation(line: 361, column: 40, scope: !194, inlinedAt: !199)
!203 = !DILocation(line: 0, scope: !127, inlinedAt: !204)
!204 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !202)
!205 = !DILocation(line: 361, column: 38, scope: !194, inlinedAt: !199)
!206 = !DILocation(line: 361, column: 12, scope: !194, inlinedAt: !199)
!207 = distinct !{!207, !135, !208, !209}
!208 = !DILocation(line: 788, column: 5, scope: !87)
!209 = !{!"llvm.loop.mustprogress"}
!210 = !DILocation(line: 790, column: 20, scope: !137)
!211 = !DILocation(line: 0, scope: !90)
!212 = !DILocation(line: 797, column: 5, scope: !90)
!213 = !DILocation(line: 798, column: 17, scope: !93)
!214 = !DILocation(line: 798, column: 30, scope: !93)
!215 = !{!109, !109, i64 0}
!216 = !DILocation(line: 799, column: 22, scope: !93)
!217 = !DILocation(line: 799, column: 9, scope: !93)
!218 = !DILocalVariable(name: "block", arg: 1, scope: !219, file: !3, line: 390, type: !37)
!219 = distinct !DISubprogram(name: "find_prev", scope: !3, file: !3, line: 390, type: !195, scopeLine: 390, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !220)
!220 = !{!218, !221}
!221 = !DILocalVariable(name: "footerp", scope: !219, file: !3, line: 392, type: !40)
!222 = !DILocation(line: 0, scope: !219, inlinedAt: !223)
!223 = distinct !DILocation(line: 801, column: 29, scope: !92)
!224 = !DILocalVariable(name: "block", arg: 1, scope: !225, file: !3, line: 369, type: !37)
!225 = distinct !DISubprogram(name: "find_prev_footer", scope: !3, file: !3, line: 369, type: !156, scopeLine: 369, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !226)
!226 = !{!224}
!227 = !DILocation(line: 0, scope: !225, inlinedAt: !228)
!228 = distinct !DILocation(line: 392, column: 23, scope: !219, inlinedAt: !223)
!229 = !DILocation(line: 372, column: 21, scope: !225, inlinedAt: !228)
!230 = !DILocation(line: 372, column: 29, scope: !225, inlinedAt: !228)
!231 = !DILocation(line: 397, column: 22, scope: !232, inlinedAt: !223)
!232 = distinct !DILexicalBlock(scope: !219, file: !3, line: 397, column: 9)
!233 = !DILocation(line: 0, scope: !127, inlinedAt: !234)
!234 = distinct !DILocation(line: 397, column: 9, scope: !232, inlinedAt: !223)
!235 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !234)
!236 = !DILocation(line: 397, column: 32, scope: !232, inlinedAt: !223)
!237 = !DILocation(line: 397, column: 9, scope: !219, inlinedAt: !223)
!238 = !DILocation(line: 0, scope: !92)
!239 = !DILocation(line: 0, scope: !194, inlinedAt: !240)
!240 = distinct !DILocation(line: 802, column: 29, scope: !92)
!241 = !DILocation(line: 361, column: 40, scope: !194, inlinedAt: !240)
!242 = !DILocation(line: 0, scope: !120, inlinedAt: !243)
!243 = distinct !DILocation(line: 361, column: 40, scope: !194, inlinedAt: !240)
!244 = !DILocation(line: 0, scope: !127, inlinedAt: !245)
!245 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !243)
!246 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !245)
!247 = !DILocation(line: 361, column: 38, scope: !194, inlinedAt: !240)
!248 = !DILocation(line: 803, column: 30, scope: !249)
!249 = distinct !DILexicalBlock(scope: !92, file: !3, line: 803, column: 17)
!250 = !DILocation(line: 803, column: 34, scope: !249)
!251 = !DILocation(line: 0, scope: !181, inlinedAt: !252)
!252 = distinct !DILocation(line: 803, column: 34, scope: !249)
!253 = !DILocation(line: 0, scope: !172, inlinedAt: !254)
!254 = distinct !DILocation(line: 311, column: 12, scope: !181, inlinedAt: !252)
!255 = !DILocation(line: 302, column: 24, scope: !172, inlinedAt: !254)
!256 = !DILocation(line: 302, column: 12, scope: !172, inlinedAt: !254)
!257 = !DILocation(line: 803, column: 17, scope: !92)
!258 = !DILocation(line: 808, column: 34, scope: !259)
!259 = distinct !DILexicalBlock(scope: !92, file: !3, line: 808, column: 17)
!260 = !DILocation(line: 0, scope: !181, inlinedAt: !261)
!261 = distinct !DILocation(line: 808, column: 34, scope: !259)
!262 = !DILocation(line: 0, scope: !172, inlinedAt: !263)
!263 = distinct !DILocation(line: 311, column: 12, scope: !181, inlinedAt: !261)
!264 = !DILocation(line: 302, column: 24, scope: !172, inlinedAt: !263)
!265 = !DILocation(line: 302, column: 12, scope: !172, inlinedAt: !263)
!266 = !DILocation(line: 808, column: 17, scope: !92)
!267 = !DILocation(line: 815, column: 24, scope: !98)
!268 = !DILocation(line: 815, column: 17, scope: !98)
!269 = !DILocation(line: 815, column: 17, scope: !92)
!270 = !DILocation(line: 0, scope: !97)
!271 = !DILocation(line: 818, column: 35, scope: !272)
!272 = distinct !DILexicalBlock(scope: !97, file: !3, line: 818, column: 21)
!273 = !DILocation(line: 818, column: 56, scope: !272)
!274 = !DILocation(line: 826, column: 24, scope: !102)
!275 = !DILocation(line: 826, column: 17, scope: !102)
!276 = !DILocation(line: 826, column: 17, scope: !92)
!277 = !DILocation(line: 0, scope: !101)
!278 = !DILocation(line: 829, column: 35, scope: !279)
!279 = distinct !DILexicalBlock(scope: !101, file: !3, line: 829, column: 21)
!280 = !DILocation(line: 829, column: 56, scope: !279)
!281 = !DILocation(line: 0, scope: !120, inlinedAt: !282)
!282 = distinct !DILocation(line: 842, column: 27, scope: !92)
!283 = !DILocation(line: 0, scope: !127, inlinedAt: !284)
!284 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !282)
!285 = distinct !{!285, !217, !286, !209}
!286 = !DILocation(line: 851, column: 9, scope: !93)
!287 = !DILocation(line: 843, column: 22, scope: !288)
!288 = distinct !DILexicalBlock(scope: !92, file: !3, line: 843, column: 17)
!289 = !DILocation(line: 843, column: 39, scope: !288)
!290 = !DILocation(line: 797, column: 39, scope: !94)
!291 = !DILocation(line: 797, column: 26, scope: !94)
!292 = distinct !{!292, !212, !293, !209}
!293 = !DILocation(line: 852, column: 5, scope: !90)
!294 = !DILocation(line: 856, column: 1, scope: !73)
!295 = !DISubprogram(name: "mem_heap_lo", scope: !296, file: !296, line: 48, type: !297, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !299)
!296 = !DIFile(filename: "./memlib.h", directory: "/afs/andrew.cmu.edu/usr7/hanningw/private/18213/malloclab/cachelab5-Nonsens77", checksumkind: CSK_MD5, checksum: "37b081d8653fabdc7bb50cf8ca5e2d25")
!297 = !DISubroutineType(types: !298)
!298 = !{!8}
!299 = !{}
!300 = !DISubprogram(name: "mem_heap_hi", scope: !296, file: !296, line: 58, type: !297, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !299)
!301 = !DISubprogram(name: "mem_heapsize", scope: !296, file: !296, line: 64, type: !302, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !299)
!302 = !DISubroutineType(types: !303)
!303 = !{!5}
!304 = distinct !DISubprogram(name: "mm_init", scope: !3, file: !3, line: 868, type: !305, scopeLine: 868, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !307)
!305 = !DISubroutineType(types: !306)
!306 = !{!39}
!307 = !{!308}
!308 = !DILocalVariable(name: "i", scope: !309, file: !3, line: 876, type: !5)
!309 = distinct !DILexicalBlock(scope: !304, file: !3, line: 876, column: 5)
!310 = !DILocation(line: 870, column: 28, scope: !304)
!311 = !DILocation(line: 870, column: 15, scope: !304)
!312 = !DILocation(line: 872, column: 19, scope: !313)
!313 = distinct !DILexicalBlock(scope: !304, file: !3, line: 872, column: 9)
!314 = !DILocation(line: 872, column: 9, scope: !304)
!315 = !DILocation(line: 0, scope: !309)
!316 = !DILocation(line: 877, column: 22, scope: !317)
!317 = distinct !DILexicalBlock(scope: !318, file: !3, line: 876, column: 43)
!318 = distinct !DILexicalBlock(scope: !309, file: !3, line: 876, column: 5)
!319 = !DILocation(line: 877, column: 28, scope: !317)
!320 = !DILocation(line: 877, column: 9, scope: !317)
!321 = !DILocation(line: 881, column: 25, scope: !304)
!322 = !DILocation(line: 881, column: 32, scope: !304)
!323 = !DILocation(line: 883, column: 29, scope: !304)
!324 = !DILocation(line: 886, column: 16, scope: !304)
!325 = !DILocalVariable(name: "size", arg: 1, scope: !326, file: !3, line: 625, type: !5)
!326 = distinct !DISubprogram(name: "extend_heap", scope: !3, file: !3, line: 625, type: !327, scopeLine: 625, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !329)
!327 = !DISubroutineType(types: !328)
!328 = !{!37, !5}
!329 = !{!325, !330, !331, !332}
!330 = !DILocalVariable(name: "bp", scope: !326, file: !3, line: 627, type: !8)
!331 = !DILocalVariable(name: "block", scope: !326, file: !3, line: 643, type: !37)
!332 = !DILocalVariable(name: "block_next", scope: !326, file: !3, line: 647, type: !37)
!333 = !DILocation(line: 0, scope: !326, inlinedAt: !334)
!334 = distinct !DILocation(line: 889, column: 9, scope: !335)
!335 = distinct !DILexicalBlock(scope: !304, file: !3, line: 889, column: 9)
!336 = !DILocation(line: 631, column: 15, scope: !337, inlinedAt: !334)
!337 = distinct !DILexicalBlock(scope: !326, file: !3, line: 631, column: 9)
!338 = !DILocation(line: 631, column: 41, scope: !337, inlinedAt: !334)
!339 = !DILocation(line: 631, column: 9, scope: !326, inlinedAt: !334)
!340 = !DILocalVariable(name: "bp", arg: 1, scope: !341, file: !3, line: 237, type: !8)
!341 = distinct !DISubprogram(name: "payload_to_header", scope: !3, file: !3, line: 237, type: !342, scopeLine: 237, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !344)
!342 = !DISubroutineType(types: !343)
!343 = !{!37, !8}
!344 = !{!340}
!345 = !DILocation(line: 0, scope: !341, inlinedAt: !346)
!346 = distinct !DILocation(line: 643, column: 22, scope: !326, inlinedAt: !334)
!347 = !DILocation(line: 238, column: 35, scope: !341, inlinedAt: !346)
!348 = !DILocation(line: 238, column: 12, scope: !341, inlinedAt: !346)
!349 = !DILocalVariable(name: "block", arg: 1, scope: !350, file: !3, line: 339, type: !37)
!350 = distinct !DISubprogram(name: "write_block", scope: !3, file: !3, line: 339, type: !351, scopeLine: 339, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !353)
!351 = !DISubroutineType(types: !352)
!352 = !{null, !37, !5, !39}
!353 = !{!349, !354, !355, !356}
!354 = !DILocalVariable(name: "size", arg: 2, scope: !350, file: !3, line: 339, type: !5)
!355 = !DILocalVariable(name: "alloc", arg: 3, scope: !350, file: !3, line: 339, type: !39)
!356 = !DILocalVariable(name: "footerp", scope: !350, file: !3, line: 343, type: !40)
!357 = !DILocation(line: 0, scope: !350, inlinedAt: !358)
!358 = distinct !DILocation(line: 644, column: 5, scope: !326, inlinedAt: !334)
!359 = !DILocation(line: 342, column: 12, scope: !350, inlinedAt: !358)
!360 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !358)
!361 = !DILocation(line: 0, scope: !155, inlinedAt: !362)
!362 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !358)
!363 = !DILocation(line: 263, column: 56, scope: !155, inlinedAt: !362)
!364 = !DILocation(line: 0, scope: !194, inlinedAt: !365)
!365 = distinct !DILocation(line: 647, column: 27, scope: !326, inlinedAt: !334)
!366 = !DILocalVariable(name: "block", arg: 1, scope: !367, file: !3, line: 321, type: !37)
!367 = distinct !DISubprogram(name: "write_epilogue", scope: !3, file: !3, line: 321, type: !368, scopeLine: 321, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !370)
!368 = !DISubroutineType(types: !369)
!369 = !{null, !37}
!370 = !{!366}
!371 = !DILocation(line: 0, scope: !367, inlinedAt: !372)
!372 = distinct !DILocation(line: 648, column: 5, scope: !326, inlinedAt: !334)
!373 = !DILocation(line: 344, column: 14, scope: !350, inlinedAt: !358)
!374 = !DILocation(line: 651, column: 13, scope: !326, inlinedAt: !334)
!375 = !DILocation(line: 0, scope: !304)
!376 = !DILocation(line: 895, column: 1, scope: !304)
!377 = !DISubprogram(name: "mem_sbrk", scope: !296, file: !296, line: 37, type: !378, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !299)
!378 = !DISubroutineType(types: !379)
!379 = !{!8, !42}
!380 = distinct !DISubprogram(name: "mm_malloc", scope: !3, file: !3, line: 908, type: !381, scopeLine: 908, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !383)
!381 = !DISubroutineType(types: !382)
!382 = !{!8, !5}
!383 = !{!384, !385, !386, !387, !388, !389}
!384 = !DILocalVariable(name: "size", arg: 1, scope: !380, file: !3, line: 908, type: !5)
!385 = !DILocalVariable(name: "asize", scope: !380, file: !3, line: 912, type: !5)
!386 = !DILocalVariable(name: "extendsize", scope: !380, file: !3, line: 913, type: !5)
!387 = !DILocalVariable(name: "block", scope: !380, file: !3, line: 914, type: !37)
!388 = !DILocalVariable(name: "bp", scope: !380, file: !3, line: 915, type: !8)
!389 = !DILocalVariable(name: "block_size", scope: !380, file: !3, line: 955, type: !5)
!390 = !DILocation(line: 0, scope: !380)
!391 = !DILocation(line: 918, column: 9, scope: !392)
!392 = distinct !DILexicalBlock(scope: !380, file: !3, line: 918, column: 9)
!393 = !DILocation(line: 918, column: 20, scope: !392)
!394 = !DILocation(line: 918, column: 9, scope: !380)
!395 = !DILocation(line: 870, column: 28, scope: !304, inlinedAt: !396)
!396 = distinct !DILocation(line: 919, column: 15, scope: !397)
!397 = distinct !DILexicalBlock(scope: !398, file: !3, line: 919, column: 13)
!398 = distinct !DILexicalBlock(scope: !392, file: !3, line: 918, column: 29)
!399 = !DILocation(line: 870, column: 15, scope: !304, inlinedAt: !396)
!400 = !DILocation(line: 872, column: 19, scope: !313, inlinedAt: !396)
!401 = !DILocation(line: 872, column: 9, scope: !304, inlinedAt: !396)
!402 = !DILocation(line: 0, scope: !309, inlinedAt: !396)
!403 = !DILocation(line: 877, column: 22, scope: !317, inlinedAt: !396)
!404 = !DILocation(line: 877, column: 28, scope: !317, inlinedAt: !396)
!405 = !DILocation(line: 877, column: 9, scope: !317, inlinedAt: !396)
!406 = !DILocation(line: 881, column: 25, scope: !304, inlinedAt: !396)
!407 = !DILocation(line: 881, column: 32, scope: !304, inlinedAt: !396)
!408 = !DILocation(line: 883, column: 29, scope: !304, inlinedAt: !396)
!409 = !DILocation(line: 886, column: 16, scope: !304, inlinedAt: !396)
!410 = !DILocation(line: 0, scope: !326, inlinedAt: !411)
!411 = distinct !DILocation(line: 889, column: 9, scope: !335, inlinedAt: !396)
!412 = !DILocation(line: 631, column: 15, scope: !337, inlinedAt: !411)
!413 = !DILocation(line: 631, column: 41, scope: !337, inlinedAt: !411)
!414 = !DILocation(line: 631, column: 9, scope: !326, inlinedAt: !411)
!415 = !DILocation(line: 0, scope: !341, inlinedAt: !416)
!416 = distinct !DILocation(line: 643, column: 22, scope: !326, inlinedAt: !411)
!417 = !DILocation(line: 238, column: 35, scope: !341, inlinedAt: !416)
!418 = !DILocation(line: 238, column: 12, scope: !341, inlinedAt: !416)
!419 = !DILocation(line: 0, scope: !350, inlinedAt: !420)
!420 = distinct !DILocation(line: 644, column: 5, scope: !326, inlinedAt: !411)
!421 = !DILocation(line: 342, column: 12, scope: !350, inlinedAt: !420)
!422 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !420)
!423 = !DILocation(line: 0, scope: !155, inlinedAt: !424)
!424 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !420)
!425 = !DILocation(line: 263, column: 56, scope: !155, inlinedAt: !424)
!426 = !DILocation(line: 0, scope: !194, inlinedAt: !427)
!427 = distinct !DILocation(line: 647, column: 27, scope: !326, inlinedAt: !411)
!428 = !DILocation(line: 0, scope: !367, inlinedAt: !429)
!429 = distinct !DILocation(line: 648, column: 5, scope: !326, inlinedAt: !411)
!430 = !DILocation(line: 344, column: 14, scope: !350, inlinedAt: !420)
!431 = !DILocation(line: 651, column: 13, scope: !326, inlinedAt: !411)
!432 = !DILocation(line: 919, column: 13, scope: !398)
!433 = !DILocation(line: 926, column: 14, scope: !434)
!434 = distinct !DILexicalBlock(scope: !380, file: !3, line: 926, column: 9)
!435 = !DILocation(line: 926, column: 9, scope: !380)
!436 = !DILocalVariable(name: "size", arg: 1, scope: !437, file: !3, line: 185, type: !5)
!437 = distinct !DISubprogram(name: "round_up", scope: !3, file: !3, line: 185, type: !438, scopeLine: 185, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !440)
!438 = !DISubroutineType(types: !439)
!439 = !{!5, !5, !5}
!440 = !{!436, !441}
!441 = !DILocalVariable(name: "n", arg: 2, scope: !437, file: !3, line: 185, type: !5)
!442 = !DILocation(line: 0, scope: !437, inlinedAt: !443)
!443 = distinct !DILocation(line: 932, column: 13, scope: !380)
!444 = !DILocation(line: 186, column: 23, scope: !437, inlinedAt: !443)
!445 = !DILocation(line: 186, column: 14, scope: !437, inlinedAt: !443)
!446 = !DILocalVariable(name: "asize", arg: 1, scope: !447, file: !3, line: 714, type: !5)
!447 = distinct !DISubprogram(name: "find_fit", scope: !3, file: !3, line: 714, type: !327, scopeLine: 714, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !448)
!448 = !{!446, !449, !450}
!449 = !DILocalVariable(name: "num", scope: !447, file: !3, line: 716, type: !5)
!450 = !DILocalVariable(name: "block", scope: !447, file: !3, line: 717, type: !37)
!451 = !DILocation(line: 0, scope: !447, inlinedAt: !452)
!452 = distinct !DILocation(line: 935, column: 13, scope: !380)
!453 = !DILocalVariable(name: "size", arg: 1, scope: !454, file: !3, line: 452, type: !5)
!454 = distinct !DISubprogram(name: "search", scope: !3, file: !3, line: 452, type: !455, scopeLine: 452, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !457)
!455 = !DISubroutineType(types: !456)
!456 = !{!5, !5}
!457 = !{!453, !458}
!458 = !DILocalVariable(name: "i", scope: !454, file: !3, line: 453, type: !5)
!459 = !DILocation(line: 0, scope: !454, inlinedAt: !460)
!460 = distinct !DILocation(line: 716, column: 18, scope: !447, inlinedAt: !452)
!461 = !DILocation(line: 455, column: 18, scope: !462, inlinedAt: !460)
!462 = distinct !DILexicalBlock(scope: !463, file: !3, line: 455, column: 13)
!463 = distinct !DILexicalBlock(scope: !464, file: !3, line: 454, column: 42)
!464 = distinct !DILexicalBlock(scope: !465, file: !3, line: 454, column: 5)
!465 = distinct !DILexicalBlock(scope: !454, file: !3, line: 454, column: 5)
!466 = !DILocation(line: 455, column: 13, scope: !463, inlinedAt: !460)
!467 = !DILocation(line: 0, scope: !465, inlinedAt: !460)
!468 = !DILocation(line: 719, column: 5, scope: !447, inlinedAt: !452)
!469 = !DILocation(line: 720, column: 17, scope: !470, inlinedAt: !452)
!470 = distinct !DILexicalBlock(scope: !447, file: !3, line: 719, column: 28)
!471 = !DILocation(line: 720, column: 32, scope: !470, inlinedAt: !452)
!472 = !DILocation(line: 0, scope: !470, inlinedAt: !452)
!473 = !DILocation(line: 721, column: 9, scope: !470, inlinedAt: !452)
!474 = !DILocation(line: 724, column: 17, scope: !475, inlinedAt: !452)
!475 = distinct !DILexicalBlock(scope: !476, file: !3, line: 724, column: 17)
!476 = distinct !DILexicalBlock(scope: !470, file: !3, line: 721, column: 23)
!477 = !DILocation(line: 0, scope: !120, inlinedAt: !478)
!478 = distinct !DILocation(line: 724, column: 17, scope: !475, inlinedAt: !452)
!479 = !DILocation(line: 0, scope: !127, inlinedAt: !480)
!480 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !478)
!481 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !480)
!482 = !DILocation(line: 724, column: 33, scope: !475, inlinedAt: !452)
!483 = !DILocation(line: 724, column: 17, scope: !476, inlinedAt: !452)
!484 = !DILocation(line: 727, column: 28, scope: !476, inlinedAt: !452)
!485 = distinct !{!485, !473, !486, !209}
!486 = !DILocation(line: 728, column: 9, scope: !470, inlinedAt: !452)
!487 = !DILocation(line: 729, column: 12, scope: !470, inlinedAt: !452)
!488 = !DILocation(line: 719, column: 16, scope: !447, inlinedAt: !452)
!489 = distinct !{!489, !468, !490, !209}
!490 = !DILocation(line: 730, column: 5, scope: !447, inlinedAt: !452)
!491 = !DILocalVariable(name: "x", arg: 1, scope: !492, file: !3, line: 175, type: !5)
!492 = distinct !DISubprogram(name: "max", scope: !3, file: !3, line: 175, type: !438, scopeLine: 175, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !493)
!493 = !{!491, !494}
!494 = !DILocalVariable(name: "y", arg: 2, scope: !492, file: !3, line: 175, type: !5)
!495 = !DILocation(line: 0, scope: !492, inlinedAt: !496)
!496 = distinct !DILocation(line: 943, column: 22, scope: !497)
!497 = distinct !DILexicalBlock(scope: !498, file: !3, line: 941, column: 24)
!498 = distinct !DILexicalBlock(scope: !380, file: !3, line: 941, column: 9)
!499 = !DILocation(line: 176, column: 15, scope: !492, inlinedAt: !496)
!500 = !DILocation(line: 176, column: 12, scope: !492, inlinedAt: !496)
!501 = !DILocation(line: 0, scope: !437, inlinedAt: !502)
!502 = distinct !DILocation(line: 630, column: 12, scope: !326, inlinedAt: !503)
!503 = distinct !DILocation(line: 944, column: 17, scope: !497)
!504 = !DILocation(line: 0, scope: !326, inlinedAt: !503)
!505 = !DILocation(line: 631, column: 15, scope: !337, inlinedAt: !503)
!506 = !DILocation(line: 631, column: 41, scope: !337, inlinedAt: !503)
!507 = !DILocation(line: 631, column: 9, scope: !326, inlinedAt: !503)
!508 = !DILocation(line: 0, scope: !341, inlinedAt: !509)
!509 = distinct !DILocation(line: 643, column: 22, scope: !326, inlinedAt: !503)
!510 = !DILocation(line: 238, column: 35, scope: !341, inlinedAt: !509)
!511 = !DILocation(line: 238, column: 12, scope: !341, inlinedAt: !509)
!512 = !DILocation(line: 0, scope: !350, inlinedAt: !513)
!513 = distinct !DILocation(line: 644, column: 5, scope: !326, inlinedAt: !503)
!514 = !DILocation(line: 342, column: 12, scope: !350, inlinedAt: !513)
!515 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !513)
!516 = !DILocation(line: 0, scope: !155, inlinedAt: !517)
!517 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !513)
!518 = !DILocation(line: 0, scope: !120, inlinedAt: !519)
!519 = distinct !DILocation(line: 263, column: 40, scope: !155, inlinedAt: !517)
!520 = !DILocation(line: 0, scope: !127, inlinedAt: !521)
!521 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !519)
!522 = !DILocation(line: 263, column: 38, scope: !155, inlinedAt: !517)
!523 = !DILocation(line: 263, column: 56, scope: !155, inlinedAt: !517)
!524 = !DILocation(line: 263, column: 12, scope: !155, inlinedAt: !517)
!525 = !DILocation(line: 344, column: 14, scope: !350, inlinedAt: !513)
!526 = !DILocation(line: 0, scope: !194, inlinedAt: !527)
!527 = distinct !DILocation(line: 647, column: 27, scope: !326, inlinedAt: !503)
!528 = !DILocation(line: 361, column: 40, scope: !194, inlinedAt: !527)
!529 = !DILocation(line: 0, scope: !120, inlinedAt: !530)
!530 = distinct !DILocation(line: 361, column: 40, scope: !194, inlinedAt: !527)
!531 = !DILocation(line: 0, scope: !127, inlinedAt: !532)
!532 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !530)
!533 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !532)
!534 = !DILocation(line: 361, column: 38, scope: !194, inlinedAt: !527)
!535 = !DILocation(line: 0, scope: !367, inlinedAt: !536)
!536 = distinct !DILocation(line: 648, column: 5, scope: !326, inlinedAt: !503)
!537 = !DILocation(line: 324, column: 12, scope: !367, inlinedAt: !536)
!538 = !DILocation(line: 324, column: 19, scope: !367, inlinedAt: !536)
!539 = !DILocation(line: 651, column: 13, scope: !326, inlinedAt: !503)
!540 = !DILocation(line: 946, column: 19, scope: !541)
!541 = distinct !DILexicalBlock(scope: !497, file: !3, line: 946, column: 13)
!542 = !DILocation(line: 946, column: 13, scope: !497)
!543 = !DILocation(line: 955, column: 25, scope: !380)
!544 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !545)
!545 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !546)
!546 = distinct !DILocation(line: 955, column: 25, scope: !380)
!547 = !DILocation(line: 0, scope: !120, inlinedAt: !546)
!548 = !DILocation(line: 0, scope: !127, inlinedAt: !545)
!549 = !DILocation(line: 0, scope: !350, inlinedAt: !550)
!550 = distinct !DILocation(line: 956, column: 5, scope: !380)
!551 = !DILocalVariable(name: "size", arg: 1, scope: !552, file: !3, line: 201, type: !5)
!552 = distinct !DISubprogram(name: "pack", scope: !3, file: !3, line: 201, type: !553, scopeLine: 201, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !555)
!553 = !DISubroutineType(types: !554)
!554 = !{!14, !5, !39}
!555 = !{!551, !556, !557}
!556 = !DILocalVariable(name: "alloc", arg: 2, scope: !552, file: !3, line: 201, type: !39)
!557 = !DILocalVariable(name: "word", scope: !552, file: !3, line: 202, type: !14)
!558 = !DILocation(line: 0, scope: !552, inlinedAt: !559)
!559 = distinct !DILocation(line: 342, column: 21, scope: !350, inlinedAt: !550)
!560 = !DILocation(line: 203, column: 9, scope: !552, inlinedAt: !559)
!561 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !550)
!562 = !DILocation(line: 0, scope: !155, inlinedAt: !563)
!563 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !550)
!564 = !DILocation(line: 263, column: 30, scope: !155, inlinedAt: !563)
!565 = !DILocation(line: 263, column: 23, scope: !155, inlinedAt: !563)
!566 = !DILocation(line: 0, scope: !120, inlinedAt: !567)
!567 = distinct !DILocation(line: 263, column: 40, scope: !155, inlinedAt: !563)
!568 = !DILocation(line: 0, scope: !127, inlinedAt: !569)
!569 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !567)
!570 = !DILocation(line: 263, column: 38, scope: !155, inlinedAt: !563)
!571 = !DILocation(line: 263, column: 56, scope: !155, inlinedAt: !563)
!572 = !DILocation(line: 263, column: 12, scope: !155, inlinedAt: !563)
!573 = !DILocation(line: 0, scope: !552, inlinedAt: !574)
!574 = distinct !DILocation(line: 344, column: 16, scope: !350, inlinedAt: !550)
!575 = !DILocation(line: 344, column: 14, scope: !350, inlinedAt: !550)
!576 = !DILocalVariable(name: "block", arg: 1, scope: !577, file: !3, line: 667, type: !37)
!577 = distinct !DISubprogram(name: "split_block", scope: !3, file: !3, line: 667, type: !578, scopeLine: 667, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !580)
!578 = !DISubroutineType(types: !579)
!579 = !{null, !37, !5}
!580 = !{!576, !581, !582, !583}
!581 = !DILocalVariable(name: "asize", arg: 2, scope: !577, file: !3, line: 667, type: !5)
!582 = !DILocalVariable(name: "block_size", scope: !577, file: !3, line: 672, type: !5)
!583 = !DILocalVariable(name: "block_next", scope: !584, file: !3, line: 676, type: !37)
!584 = distinct !DILexicalBlock(scope: !585, file: !3, line: 675, column: 49)
!585 = distinct !DILexicalBlock(scope: !577, file: !3, line: 675, column: 9)
!586 = !DILocation(line: 0, scope: !577, inlinedAt: !587)
!587 = distinct !DILocation(line: 959, column: 5, scope: !380)
!588 = !DILocation(line: 672, column: 25, scope: !577, inlinedAt: !587)
!589 = !DILocation(line: 0, scope: !120, inlinedAt: !590)
!590 = distinct !DILocation(line: 672, column: 25, scope: !577, inlinedAt: !587)
!591 = !DILocation(line: 0, scope: !127, inlinedAt: !592)
!592 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !590)
!593 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !592)
!594 = !DILocation(line: 674, column: 5, scope: !577, inlinedAt: !587)
!595 = !DILocation(line: 675, column: 21, scope: !585, inlinedAt: !587)
!596 = !DILocation(line: 675, column: 30, scope: !585, inlinedAt: !587)
!597 = !DILocation(line: 675, column: 9, scope: !577, inlinedAt: !587)
!598 = !DILocation(line: 0, scope: !350, inlinedAt: !599)
!599 = distinct !DILocation(line: 677, column: 9, scope: !584, inlinedAt: !587)
!600 = !DILocation(line: 0, scope: !552, inlinedAt: !601)
!601 = distinct !DILocation(line: 342, column: 21, scope: !350, inlinedAt: !599)
!602 = !DILocation(line: 203, column: 9, scope: !552, inlinedAt: !601)
!603 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !599)
!604 = !DILocation(line: 0, scope: !155, inlinedAt: !605)
!605 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !599)
!606 = !DILocation(line: 0, scope: !120, inlinedAt: !607)
!607 = distinct !DILocation(line: 263, column: 40, scope: !155, inlinedAt: !605)
!608 = !DILocation(line: 0, scope: !127, inlinedAt: !609)
!609 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !607)
!610 = !DILocation(line: 263, column: 38, scope: !155, inlinedAt: !605)
!611 = !DILocation(line: 263, column: 56, scope: !155, inlinedAt: !605)
!612 = !DILocation(line: 263, column: 12, scope: !155, inlinedAt: !605)
!613 = !DILocation(line: 0, scope: !552, inlinedAt: !614)
!614 = distinct !DILocation(line: 344, column: 16, scope: !350, inlinedAt: !599)
!615 = !DILocation(line: 344, column: 14, scope: !350, inlinedAt: !599)
!616 = !DILocation(line: 0, scope: !194, inlinedAt: !617)
!617 = distinct !DILocation(line: 679, column: 22, scope: !584, inlinedAt: !587)
!618 = !DILocation(line: 361, column: 24, scope: !194, inlinedAt: !617)
!619 = !DILocation(line: 361, column: 40, scope: !194, inlinedAt: !617)
!620 = !DILocation(line: 0, scope: !120, inlinedAt: !621)
!621 = distinct !DILocation(line: 361, column: 40, scope: !194, inlinedAt: !617)
!622 = !DILocation(line: 0, scope: !127, inlinedAt: !623)
!623 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !621)
!624 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !623)
!625 = !DILocation(line: 361, column: 38, scope: !194, inlinedAt: !617)
!626 = !DILocation(line: 0, scope: !584, inlinedAt: !587)
!627 = !DILocation(line: 0, scope: !350, inlinedAt: !628)
!628 = distinct !DILocation(line: 680, column: 9, scope: !584, inlinedAt: !587)
!629 = !DILocation(line: 0, scope: !552, inlinedAt: !630)
!630 = distinct !DILocation(line: 342, column: 21, scope: !350, inlinedAt: !628)
!631 = !DILocation(line: 342, column: 12, scope: !350, inlinedAt: !628)
!632 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !628)
!633 = !DILocation(line: 0, scope: !155, inlinedAt: !634)
!634 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !628)
!635 = !DILocation(line: 263, column: 30, scope: !155, inlinedAt: !634)
!636 = !DILocation(line: 0, scope: !120, inlinedAt: !637)
!637 = distinct !DILocation(line: 263, column: 40, scope: !155, inlinedAt: !634)
!638 = !DILocation(line: 0, scope: !127, inlinedAt: !639)
!639 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !637)
!640 = !DILocation(line: 263, column: 38, scope: !155, inlinedAt: !634)
!641 = !DILocation(line: 263, column: 56, scope: !155, inlinedAt: !634)
!642 = !DILocation(line: 263, column: 12, scope: !155, inlinedAt: !634)
!643 = !DILocation(line: 0, scope: !552, inlinedAt: !644)
!644 = distinct !DILocation(line: 344, column: 16, scope: !350, inlinedAt: !628)
!645 = !DILocation(line: 344, column: 14, scope: !350, inlinedAt: !628)
!646 = !DILocalVariable(name: "block", arg: 1, scope: !647, file: !3, line: 466, type: !37)
!647 = distinct !DISubprogram(name: "insert", scope: !3, file: !3, line: 466, type: !368, scopeLine: 466, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !648)
!648 = !{!646, !649, !650}
!649 = !DILocalVariable(name: "size", scope: !647, file: !3, line: 469, type: !5)
!650 = !DILocalVariable(name: "num", scope: !647, file: !3, line: 473, type: !5)
!651 = !DILocation(line: 0, scope: !647, inlinedAt: !652)
!652 = distinct !DILocation(line: 682, column: 9, scope: !584, inlinedAt: !587)
!653 = !DILocation(line: 469, column: 19, scope: !647, inlinedAt: !652)
!654 = !DILocation(line: 0, scope: !120, inlinedAt: !655)
!655 = distinct !DILocation(line: 469, column: 19, scope: !647, inlinedAt: !652)
!656 = !DILocation(line: 0, scope: !127, inlinedAt: !657)
!657 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !655)
!658 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !657)
!659 = !DILocation(line: 470, column: 12, scope: !647, inlinedAt: !652)
!660 = !DILocation(line: 471, column: 12, scope: !647, inlinedAt: !652)
!661 = !DILocation(line: 0, scope: !454, inlinedAt: !662)
!662 = distinct !DILocation(line: 473, column: 18, scope: !647, inlinedAt: !652)
!663 = !DILocation(line: 455, column: 18, scope: !462, inlinedAt: !662)
!664 = !DILocation(line: 471, column: 17, scope: !647, inlinedAt: !652)
!665 = !DILocation(line: 455, column: 13, scope: !463, inlinedAt: !662)
!666 = !DILocation(line: 0, scope: !465, inlinedAt: !662)
!667 = !DILocation(line: 475, column: 9, scope: !668, inlinedAt: !652)
!668 = distinct !DILexicalBlock(scope: !647, file: !3, line: 475, column: 9)
!669 = !DILocation(line: 475, column: 24, scope: !668, inlinedAt: !652)
!670 = !DILocation(line: 475, column: 30, scope: !668, inlinedAt: !652)
!671 = !DILocation(line: 475, column: 9, scope: !647, inlinedAt: !652)
!672 = !DILocation(line: 480, column: 21, scope: !673, inlinedAt: !652)
!673 = distinct !DILexicalBlock(scope: !668, file: !3, line: 477, column: 12)
!674 = !DILocation(line: 481, column: 24, scope: !673, inlinedAt: !652)
!675 = !DILocation(line: 481, column: 31, scope: !673, inlinedAt: !652)
!676 = !DILocation(line: 481, column: 36, scope: !673, inlinedAt: !652)
!677 = !DILocation(line: 482, column: 21, scope: !673, inlinedAt: !652)
!678 = !DILocation(line: 0, scope: !668, inlinedAt: !652)
!679 = !DILocation(line: 683, column: 5, scope: !584, inlinedAt: !587)
!680 = !DILocation(line: 967, column: 1, scope: !380)
!681 = distinct !DISubprogram(name: "mm_free", scope: !3, file: !3, line: 979, type: !682, scopeLine: 979, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !684)
!682 = !DISubroutineType(types: !683)
!683 = !{null, !8}
!684 = !{!685, !686, !687}
!685 = !DILocalVariable(name: "bp", arg: 1, scope: !681, file: !3, line: 979, type: !8)
!686 = !DILocalVariable(name: "block", scope: !681, file: !3, line: 987, type: !37)
!687 = !DILocalVariable(name: "size", scope: !681, file: !3, line: 988, type: !5)
!688 = !DILocation(line: 0, scope: !681)
!689 = !DILocation(line: 983, column: 12, scope: !690)
!690 = distinct !DILexicalBlock(scope: !681, file: !3, line: 983, column: 9)
!691 = !DILocation(line: 983, column: 9, scope: !681)
!692 = !DILocation(line: 0, scope: !341, inlinedAt: !693)
!693 = distinct !DILocation(line: 987, column: 22, scope: !681)
!694 = !DILocation(line: 238, column: 35, scope: !341, inlinedAt: !693)
!695 = !DILocation(line: 238, column: 12, scope: !341, inlinedAt: !693)
!696 = !DILocation(line: 988, column: 19, scope: !681)
!697 = !DILocation(line: 0, scope: !120, inlinedAt: !698)
!698 = distinct !DILocation(line: 988, column: 19, scope: !681)
!699 = !DILocation(line: 0, scope: !127, inlinedAt: !700)
!700 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !698)
!701 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !700)
!702 = !DILocation(line: 0, scope: !350, inlinedAt: !703)
!703 = distinct !DILocation(line: 995, column: 5, scope: !681)
!704 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !703)
!705 = !DILocation(line: 0, scope: !155, inlinedAt: !706)
!706 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !703)
!707 = !DILocation(line: 0, scope: !120, inlinedAt: !708)
!708 = distinct !DILocation(line: 263, column: 40, scope: !155, inlinedAt: !706)
!709 = !DILocation(line: 0, scope: !127, inlinedAt: !710)
!710 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !708)
!711 = !DILocation(line: 263, column: 38, scope: !155, inlinedAt: !706)
!712 = !DILocation(line: 263, column: 56, scope: !155, inlinedAt: !706)
!713 = !DILocation(line: 263, column: 12, scope: !155, inlinedAt: !706)
!714 = !DILocation(line: 344, column: 14, scope: !350, inlinedAt: !703)
!715 = !DILocation(line: 998, column: 5, scope: !681)
!716 = !DILocation(line: 1001, column: 1, scope: !681)
!717 = distinct !DISubprogram(name: "coalesce_block", scope: !3, file: !3, line: 547, type: !195, scopeLine: 547, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !718)
!718 = !{!719, !720, !721, !722, !723, !724, !725, !726}
!719 = !DILocalVariable(name: "block", arg: 1, scope: !717, file: !3, line: 547, type: !37)
!720 = !DILocalVariable(name: "prev", scope: !717, file: !3, line: 549, type: !37)
!721 = !DILocalVariable(name: "next", scope: !717, file: !3, line: 550, type: !37)
!722 = !DILocalVariable(name: "prev_alloc", scope: !717, file: !3, line: 552, type: !39)
!723 = !DILocalVariable(name: "next_alloc", scope: !717, file: !3, line: 553, type: !39)
!724 = !DILocalVariable(name: "size", scope: !717, file: !3, line: 554, type: !5)
!725 = !DILocalVariable(name: "prev_size", scope: !717, file: !3, line: 555, type: !5)
!726 = !DILocalVariable(name: "next_size", scope: !717, file: !3, line: 556, type: !5)
!727 = !DILocation(line: 0, scope: !717)
!728 = !DILocation(line: 0, scope: !219, inlinedAt: !729)
!729 = distinct !DILocation(line: 549, column: 21, scope: !717)
!730 = !DILocation(line: 0, scope: !225, inlinedAt: !731)
!731 = distinct !DILocation(line: 392, column: 23, scope: !219, inlinedAt: !729)
!732 = !DILocation(line: 372, column: 21, scope: !225, inlinedAt: !731)
!733 = !DILocation(line: 372, column: 29, scope: !225, inlinedAt: !731)
!734 = !DILocation(line: 397, column: 22, scope: !232, inlinedAt: !729)
!735 = !DILocation(line: 0, scope: !127, inlinedAt: !736)
!736 = distinct !DILocation(line: 397, column: 9, scope: !232, inlinedAt: !729)
!737 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !736)
!738 = !DILocation(line: 397, column: 32, scope: !232, inlinedAt: !729)
!739 = !DILocation(line: 397, column: 9, scope: !219, inlinedAt: !729)
!740 = !DILocation(line: 0, scope: !194, inlinedAt: !741)
!741 = distinct !DILocation(line: 550, column: 21, scope: !717)
!742 = !DILocation(line: 361, column: 40, scope: !194, inlinedAt: !741)
!743 = !DILocation(line: 0, scope: !120, inlinedAt: !744)
!744 = distinct !DILocation(line: 361, column: 40, scope: !194, inlinedAt: !741)
!745 = !DILocation(line: 0, scope: !127, inlinedAt: !746)
!746 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !744)
!747 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !746)
!748 = !DILocation(line: 361, column: 38, scope: !194, inlinedAt: !741)
!749 = !DILocation(line: 361, column: 12, scope: !194, inlinedAt: !741)
!750 = !DILocation(line: 0, scope: !120, inlinedAt: !751)
!751 = distinct !DILocation(line: 554, column: 19, scope: !717)
!752 = !DILocation(line: 0, scope: !127, inlinedAt: !753)
!753 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !751)
!754 = !DILocation(line: 558, column: 14, scope: !755)
!755 = distinct !DILexicalBlock(scope: !717, file: !3, line: 558, column: 9)
!756 = !DILocation(line: 558, column: 9, scope: !717)
!757 = !DILocation(line: 563, column: 21, scope: !758)
!758 = distinct !DILexicalBlock(scope: !755, file: !3, line: 561, column: 12)
!759 = !DILocation(line: 0, scope: !120, inlinedAt: !760)
!760 = distinct !DILocation(line: 563, column: 21, scope: !758)
!761 = !DILocation(line: 0, scope: !127, inlinedAt: !762)
!762 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !760)
!763 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !762)
!764 = !DILocation(line: 0, scope: !181, inlinedAt: !765)
!765 = distinct !DILocation(line: 564, column: 22, scope: !758)
!766 = !DILocation(line: 0, scope: !172, inlinedAt: !767)
!767 = distinct !DILocation(line: 311, column: 12, scope: !181, inlinedAt: !765)
!768 = !DILocation(line: 302, column: 24, scope: !172, inlinedAt: !767)
!769 = !DILocation(line: 302, column: 12, scope: !172, inlinedAt: !767)
!770 = !DILocation(line: 0, scope: !755)
!771 = !DILocation(line: 572, column: 21, scope: !772)
!772 = distinct !DILexicalBlock(scope: !773, file: !3, line: 570, column: 12)
!773 = distinct !DILexicalBlock(scope: !717, file: !3, line: 567, column: 9)
!774 = !DILocation(line: 0, scope: !120, inlinedAt: !775)
!775 = distinct !DILocation(line: 572, column: 21, scope: !772)
!776 = !DILocation(line: 0, scope: !127, inlinedAt: !777)
!777 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !775)
!778 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !777)
!779 = !DILocation(line: 0, scope: !181, inlinedAt: !780)
!780 = distinct !DILocation(line: 573, column: 22, scope: !772)
!781 = !DILocation(line: 0, scope: !172, inlinedAt: !782)
!782 = distinct !DILocation(line: 311, column: 12, scope: !181, inlinedAt: !780)
!783 = !DILocation(line: 302, column: 24, scope: !172, inlinedAt: !782)
!784 = !DILocation(line: 302, column: 12, scope: !172, inlinedAt: !782)
!785 = !DILocation(line: 577, column: 20, scope: !786)
!786 = distinct !DILexicalBlock(scope: !717, file: !3, line: 577, column: 9)
!787 = !DILocation(line: 0, scope: !647, inlinedAt: !788)
!788 = distinct !DILocation(line: 578, column: 9, scope: !789)
!789 = distinct !DILexicalBlock(scope: !786, file: !3, line: 577, column: 35)
!790 = !DILocation(line: 0, scope: !120, inlinedAt: !791)
!791 = distinct !DILocation(line: 469, column: 19, scope: !647, inlinedAt: !788)
!792 = !DILocation(line: 0, scope: !127, inlinedAt: !793)
!793 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !791)
!794 = !DILocation(line: 470, column: 12, scope: !647, inlinedAt: !788)
!795 = !DILocation(line: 471, column: 12, scope: !647, inlinedAt: !788)
!796 = !DILocation(line: 0, scope: !454, inlinedAt: !797)
!797 = distinct !DILocation(line: 473, column: 18, scope: !647, inlinedAt: !788)
!798 = !DILocation(line: 455, column: 18, scope: !462, inlinedAt: !797)
!799 = !DILocation(line: 455, column: 13, scope: !463, inlinedAt: !797)
!800 = !DILocation(line: 471, column: 17, scope: !647, inlinedAt: !788)
!801 = !DILocation(line: 0, scope: !465, inlinedAt: !797)
!802 = !DILocation(line: 475, column: 9, scope: !668, inlinedAt: !788)
!803 = !DILocation(line: 475, column: 24, scope: !668, inlinedAt: !788)
!804 = !DILocation(line: 475, column: 30, scope: !668, inlinedAt: !788)
!805 = !DILocation(line: 475, column: 9, scope: !647, inlinedAt: !788)
!806 = !DILocation(line: 480, column: 21, scope: !673, inlinedAt: !788)
!807 = !DILocation(line: 481, column: 24, scope: !673, inlinedAt: !788)
!808 = !DILocation(line: 481, column: 31, scope: !673, inlinedAt: !788)
!809 = !DILocation(line: 481, column: 36, scope: !673, inlinedAt: !788)
!810 = !DILocation(line: 482, column: 21, scope: !673, inlinedAt: !788)
!811 = !DILocation(line: 0, scope: !668, inlinedAt: !788)
!812 = !DILocation(line: 579, column: 9, scope: !789)
!813 = !DILocation(line: 583, column: 25, scope: !814)
!814 = distinct !DILexicalBlock(scope: !786, file: !3, line: 583, column: 14)
!815 = !DILocation(line: 584, column: 14, scope: !816)
!816 = distinct !DILexicalBlock(scope: !814, file: !3, line: 583, column: 41)
!817 = !DILocation(line: 0, scope: !350, inlinedAt: !818)
!818 = distinct !DILocation(line: 585, column: 9, scope: !816)
!819 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !818)
!820 = !DILocation(line: 0, scope: !155, inlinedAt: !821)
!821 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !818)
!822 = !DILocation(line: 263, column: 30, scope: !155, inlinedAt: !821)
!823 = !DILocation(line: 263, column: 23, scope: !155, inlinedAt: !821)
!824 = !DILocation(line: 0, scope: !120, inlinedAt: !825)
!825 = distinct !DILocation(line: 263, column: 40, scope: !155, inlinedAt: !821)
!826 = !DILocation(line: 0, scope: !127, inlinedAt: !827)
!827 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !825)
!828 = !DILocation(line: 263, column: 38, scope: !155, inlinedAt: !821)
!829 = !DILocation(line: 263, column: 56, scope: !155, inlinedAt: !821)
!830 = !DILocation(line: 263, column: 12, scope: !155, inlinedAt: !821)
!831 = !DILocation(line: 344, column: 14, scope: !350, inlinedAt: !818)
!832 = !DILocation(line: 0, scope: !647, inlinedAt: !833)
!833 = distinct !DILocation(line: 586, column: 9, scope: !816)
!834 = !DILocation(line: 469, column: 19, scope: !647, inlinedAt: !833)
!835 = !DILocation(line: 0, scope: !120, inlinedAt: !836)
!836 = distinct !DILocation(line: 469, column: 19, scope: !647, inlinedAt: !833)
!837 = !DILocation(line: 0, scope: !127, inlinedAt: !838)
!838 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !836)
!839 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !838)
!840 = !DILocation(line: 470, column: 12, scope: !647, inlinedAt: !833)
!841 = !DILocation(line: 471, column: 12, scope: !647, inlinedAt: !833)
!842 = !DILocation(line: 0, scope: !454, inlinedAt: !843)
!843 = distinct !DILocation(line: 473, column: 18, scope: !647, inlinedAt: !833)
!844 = !DILocation(line: 455, column: 18, scope: !462, inlinedAt: !843)
!845 = !DILocation(line: 455, column: 13, scope: !463, inlinedAt: !843)
!846 = !DILocation(line: 471, column: 17, scope: !647, inlinedAt: !833)
!847 = !DILocation(line: 0, scope: !465, inlinedAt: !843)
!848 = !DILocation(line: 475, column: 9, scope: !668, inlinedAt: !833)
!849 = !DILocation(line: 475, column: 24, scope: !668, inlinedAt: !833)
!850 = !DILocation(line: 475, column: 30, scope: !668, inlinedAt: !833)
!851 = !DILocation(line: 475, column: 9, scope: !647, inlinedAt: !833)
!852 = !DILocation(line: 480, column: 21, scope: !673, inlinedAt: !833)
!853 = !DILocation(line: 481, column: 24, scope: !673, inlinedAt: !833)
!854 = !DILocation(line: 481, column: 31, scope: !673, inlinedAt: !833)
!855 = !DILocation(line: 481, column: 36, scope: !673, inlinedAt: !833)
!856 = !DILocation(line: 482, column: 21, scope: !673, inlinedAt: !833)
!857 = !DILocation(line: 0, scope: !668, inlinedAt: !833)
!858 = !DILocation(line: 587, column: 9, scope: !816)
!859 = !DILocation(line: 588, column: 9, scope: !816)
!860 = !DILocation(line: 592, column: 26, scope: !861)
!861 = distinct !DILexicalBlock(scope: !814, file: !3, line: 592, column: 14)
!862 = !DILocation(line: 0, scope: !861)
!863 = !DILocation(line: 594, column: 14, scope: !864)
!864 = distinct !DILexicalBlock(scope: !861, file: !3, line: 592, column: 41)
!865 = !DILocation(line: 0, scope: !219, inlinedAt: !866)
!866 = distinct !DILocation(line: 595, column: 17, scope: !864)
!867 = !DILocation(line: 0, scope: !225, inlinedAt: !868)
!868 = distinct !DILocation(line: 392, column: 23, scope: !219, inlinedAt: !866)
!869 = !DILocation(line: 397, column: 22, scope: !232, inlinedAt: !866)
!870 = !DILocation(line: 0, scope: !127, inlinedAt: !871)
!871 = distinct !DILocation(line: 397, column: 9, scope: !232, inlinedAt: !866)
!872 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !871)
!873 = !DILocation(line: 397, column: 32, scope: !232, inlinedAt: !866)
!874 = !DILocation(line: 397, column: 9, scope: !219, inlinedAt: !866)
!875 = !DILocation(line: 0, scope: !350, inlinedAt: !876)
!876 = distinct !DILocation(line: 596, column: 9, scope: !864)
!877 = !DILocation(line: 342, column: 12, scope: !350, inlinedAt: !876)
!878 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !876)
!879 = !DILocation(line: 0, scope: !155, inlinedAt: !880)
!880 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !876)
!881 = !DILocation(line: 263, column: 30, scope: !155, inlinedAt: !880)
!882 = !DILocation(line: 263, column: 23, scope: !155, inlinedAt: !880)
!883 = !DILocation(line: 0, scope: !120, inlinedAt: !884)
!884 = distinct !DILocation(line: 263, column: 40, scope: !155, inlinedAt: !880)
!885 = !DILocation(line: 0, scope: !127, inlinedAt: !886)
!886 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !884)
!887 = !DILocation(line: 263, column: 38, scope: !155, inlinedAt: !880)
!888 = !DILocation(line: 263, column: 56, scope: !155, inlinedAt: !880)
!889 = !DILocation(line: 263, column: 12, scope: !155, inlinedAt: !880)
!890 = !DILocation(line: 344, column: 14, scope: !350, inlinedAt: !876)
!891 = !DILocation(line: 0, scope: !647, inlinedAt: !892)
!892 = distinct !DILocation(line: 597, column: 9, scope: !864)
!893 = !DILocation(line: 469, column: 19, scope: !647, inlinedAt: !892)
!894 = !DILocation(line: 0, scope: !120, inlinedAt: !895)
!895 = distinct !DILocation(line: 469, column: 19, scope: !647, inlinedAt: !892)
!896 = !DILocation(line: 0, scope: !127, inlinedAt: !897)
!897 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !895)
!898 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !897)
!899 = !DILocation(line: 470, column: 12, scope: !647, inlinedAt: !892)
!900 = !DILocation(line: 471, column: 12, scope: !647, inlinedAt: !892)
!901 = !DILocation(line: 0, scope: !454, inlinedAt: !902)
!902 = distinct !DILocation(line: 473, column: 18, scope: !647, inlinedAt: !892)
!903 = !DILocation(line: 455, column: 18, scope: !462, inlinedAt: !902)
!904 = !DILocation(line: 455, column: 13, scope: !463, inlinedAt: !902)
!905 = !DILocation(line: 471, column: 17, scope: !647, inlinedAt: !892)
!906 = !DILocation(line: 0, scope: !465, inlinedAt: !902)
!907 = !DILocation(line: 475, column: 9, scope: !668, inlinedAt: !892)
!908 = !DILocation(line: 475, column: 24, scope: !668, inlinedAt: !892)
!909 = !DILocation(line: 475, column: 30, scope: !668, inlinedAt: !892)
!910 = !DILocation(line: 475, column: 9, scope: !647, inlinedAt: !892)
!911 = !DILocation(line: 480, column: 21, scope: !673, inlinedAt: !892)
!912 = !DILocation(line: 481, column: 24, scope: !673, inlinedAt: !892)
!913 = !DILocation(line: 481, column: 31, scope: !673, inlinedAt: !892)
!914 = !DILocation(line: 481, column: 36, scope: !673, inlinedAt: !892)
!915 = !DILocation(line: 482, column: 21, scope: !673, inlinedAt: !892)
!916 = !DILocation(line: 0, scope: !668, inlinedAt: !892)
!917 = !DILocation(line: 598, column: 9, scope: !864)
!918 = !DILocation(line: 604, column: 9, scope: !919)
!919 = distinct !DILexicalBlock(scope: !861, file: !3, line: 602, column: 10)
!920 = !DILocation(line: 605, column: 14, scope: !919)
!921 = !DILocation(line: 606, column: 14, scope: !919)
!922 = !DILocation(line: 0, scope: !219, inlinedAt: !923)
!923 = distinct !DILocation(line: 607, column: 17, scope: !919)
!924 = !DILocation(line: 0, scope: !225, inlinedAt: !925)
!925 = distinct !DILocation(line: 392, column: 23, scope: !219, inlinedAt: !923)
!926 = !DILocation(line: 397, column: 22, scope: !232, inlinedAt: !923)
!927 = !DILocation(line: 0, scope: !127, inlinedAt: !928)
!928 = distinct !DILocation(line: 397, column: 9, scope: !232, inlinedAt: !923)
!929 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !928)
!930 = !DILocation(line: 397, column: 32, scope: !232, inlinedAt: !923)
!931 = !DILocation(line: 397, column: 9, scope: !219, inlinedAt: !923)
!932 = !DILocation(line: 0, scope: !350, inlinedAt: !933)
!933 = distinct !DILocation(line: 608, column: 9, scope: !919)
!934 = !DILocation(line: 342, column: 12, scope: !350, inlinedAt: !933)
!935 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !933)
!936 = !DILocation(line: 0, scope: !155, inlinedAt: !937)
!937 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !933)
!938 = !DILocation(line: 263, column: 30, scope: !155, inlinedAt: !937)
!939 = !DILocation(line: 263, column: 23, scope: !155, inlinedAt: !937)
!940 = !DILocation(line: 0, scope: !120, inlinedAt: !941)
!941 = distinct !DILocation(line: 263, column: 40, scope: !155, inlinedAt: !937)
!942 = !DILocation(line: 0, scope: !127, inlinedAt: !943)
!943 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !941)
!944 = !DILocation(line: 263, column: 38, scope: !155, inlinedAt: !937)
!945 = !DILocation(line: 263, column: 56, scope: !155, inlinedAt: !937)
!946 = !DILocation(line: 263, column: 12, scope: !155, inlinedAt: !937)
!947 = !DILocation(line: 344, column: 14, scope: !350, inlinedAt: !933)
!948 = !DILocation(line: 0, scope: !647, inlinedAt: !949)
!949 = distinct !DILocation(line: 609, column: 9, scope: !919)
!950 = !DILocation(line: 469, column: 19, scope: !647, inlinedAt: !949)
!951 = !DILocation(line: 0, scope: !120, inlinedAt: !952)
!952 = distinct !DILocation(line: 469, column: 19, scope: !647, inlinedAt: !949)
!953 = !DILocation(line: 0, scope: !127, inlinedAt: !954)
!954 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !952)
!955 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !954)
!956 = !DILocation(line: 470, column: 12, scope: !647, inlinedAt: !949)
!957 = !DILocation(line: 471, column: 12, scope: !647, inlinedAt: !949)
!958 = !DILocation(line: 0, scope: !454, inlinedAt: !959)
!959 = distinct !DILocation(line: 473, column: 18, scope: !647, inlinedAt: !949)
!960 = !DILocation(line: 455, column: 18, scope: !462, inlinedAt: !959)
!961 = !DILocation(line: 455, column: 13, scope: !463, inlinedAt: !959)
!962 = !DILocation(line: 471, column: 17, scope: !647, inlinedAt: !949)
!963 = !DILocation(line: 0, scope: !465, inlinedAt: !959)
!964 = !DILocation(line: 475, column: 9, scope: !668, inlinedAt: !949)
!965 = !DILocation(line: 475, column: 24, scope: !668, inlinedAt: !949)
!966 = !DILocation(line: 475, column: 30, scope: !668, inlinedAt: !949)
!967 = !DILocation(line: 475, column: 9, scope: !647, inlinedAt: !949)
!968 = !DILocation(line: 480, column: 21, scope: !673, inlinedAt: !949)
!969 = !DILocation(line: 481, column: 24, scope: !673, inlinedAt: !949)
!970 = !DILocation(line: 481, column: 31, scope: !673, inlinedAt: !949)
!971 = !DILocation(line: 481, column: 36, scope: !673, inlinedAt: !949)
!972 = !DILocation(line: 482, column: 21, scope: !673, inlinedAt: !949)
!973 = !DILocation(line: 0, scope: !668, inlinedAt: !949)
!974 = !DILocation(line: 610, column: 9, scope: !919)
!975 = !DILocation(line: 0, scope: !786)
!976 = !DILocation(line: 612, column: 1, scope: !717)
!977 = distinct !DISubprogram(name: "mm_realloc", scope: !3, file: !3, line: 1015, type: !978, scopeLine: 1015, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !980)
!978 = !DISubroutineType(types: !979)
!979 = !{!8, !8, !5}
!980 = !{!981, !982, !983, !984, !985}
!981 = !DILocalVariable(name: "ptr", arg: 1, scope: !977, file: !3, line: 1015, type: !8)
!982 = !DILocalVariable(name: "size", arg: 2, scope: !977, file: !3, line: 1015, type: !5)
!983 = !DILocalVariable(name: "block", scope: !977, file: !3, line: 1016, type: !37)
!984 = !DILocalVariable(name: "copysize", scope: !977, file: !3, line: 1017, type: !5)
!985 = !DILocalVariable(name: "newptr", scope: !977, file: !3, line: 1018, type: !8)
!986 = !DILocation(line: 0, scope: !977)
!987 = !DILocation(line: 0, scope: !341, inlinedAt: !988)
!988 = distinct !DILocation(line: 1016, column: 22, scope: !977)
!989 = !DILocation(line: 238, column: 35, scope: !341, inlinedAt: !988)
!990 = !DILocation(line: 238, column: 12, scope: !341, inlinedAt: !988)
!991 = !DILocation(line: 1021, column: 14, scope: !992)
!992 = distinct !DILexicalBlock(scope: !977, file: !3, line: 1021, column: 9)
!993 = !DILocation(line: 1021, column: 9, scope: !977)
!994 = !DILocation(line: 0, scope: !681, inlinedAt: !995)
!995 = distinct !DILocation(line: 1022, column: 9, scope: !996)
!996 = distinct !DILexicalBlock(scope: !992, file: !3, line: 1021, column: 20)
!997 = !DILocation(line: 983, column: 9, scope: !681, inlinedAt: !995)
!998 = !DILocation(line: 0, scope: !341, inlinedAt: !999)
!999 = distinct !DILocation(line: 987, column: 22, scope: !681, inlinedAt: !995)
!1000 = !DILocation(line: 988, column: 19, scope: !681, inlinedAt: !995)
!1001 = !DILocation(line: 0, scope: !120, inlinedAt: !1002)
!1002 = distinct !DILocation(line: 988, column: 19, scope: !681, inlinedAt: !995)
!1003 = !DILocation(line: 0, scope: !127, inlinedAt: !1004)
!1004 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !1002)
!1005 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !1004)
!1006 = !DILocation(line: 0, scope: !350, inlinedAt: !1007)
!1007 = distinct !DILocation(line: 995, column: 5, scope: !681, inlinedAt: !995)
!1008 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !1007)
!1009 = !DILocation(line: 0, scope: !155, inlinedAt: !1010)
!1010 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !1007)
!1011 = !DILocation(line: 0, scope: !120, inlinedAt: !1012)
!1012 = distinct !DILocation(line: 263, column: 40, scope: !155, inlinedAt: !1010)
!1013 = !DILocation(line: 0, scope: !127, inlinedAt: !1014)
!1014 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !1012)
!1015 = !DILocation(line: 1027, column: 9, scope: !977)
!1016 = !DILocation(line: 1035, column: 16, scope: !1017)
!1017 = distinct !DILexicalBlock(scope: !977, file: !3, line: 1035, column: 9)
!1018 = !DILocation(line: 1035, column: 9, scope: !977)
!1019 = !DILocation(line: 1040, column: 16, scope: !977)
!1020 = !DILocalVariable(name: "block", arg: 1, scope: !1021, file: !3, line: 288, type: !37)
!1021 = distinct !DISubprogram(name: "get_payload_size", scope: !3, file: !3, line: 288, type: !121, scopeLine: 288, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !1022)
!1022 = !{!1020, !1023}
!1023 = !DILocalVariable(name: "asize", scope: !1021, file: !3, line: 289, type: !5)
!1024 = !DILocation(line: 0, scope: !1021, inlinedAt: !1025)
!1025 = distinct !DILocation(line: 1040, column: 16, scope: !977)
!1026 = !DILocation(line: 290, column: 18, scope: !1021, inlinedAt: !1025)
!1027 = !DILocation(line: 1041, column: 14, scope: !1028)
!1028 = distinct !DILexicalBlock(scope: !977, file: !3, line: 1041, column: 9)
!1029 = !DILocation(line: 1041, column: 9, scope: !977)
!1030 = !DILocation(line: 1044, column: 5, scope: !977)
!1031 = !DILocation(line: 0, scope: !681, inlinedAt: !1032)
!1032 = distinct !DILocation(line: 1047, column: 5, scope: !977)
!1033 = !DILocation(line: 0, scope: !341, inlinedAt: !1034)
!1034 = distinct !DILocation(line: 987, column: 22, scope: !681, inlinedAt: !1032)
!1035 = !DILocation(line: 988, column: 19, scope: !681, inlinedAt: !1032)
!1036 = !DILocation(line: 0, scope: !120, inlinedAt: !1037)
!1037 = distinct !DILocation(line: 988, column: 19, scope: !681, inlinedAt: !1032)
!1038 = !DILocation(line: 0, scope: !127, inlinedAt: !1039)
!1039 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !1037)
!1040 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !1039)
!1041 = !DILocation(line: 0, scope: !350, inlinedAt: !1042)
!1042 = distinct !DILocation(line: 995, column: 5, scope: !681, inlinedAt: !1032)
!1043 = !DILocation(line: 342, column: 19, scope: !350, inlinedAt: !1042)
!1044 = !DILocation(line: 0, scope: !155, inlinedAt: !1045)
!1045 = distinct !DILocation(line: 343, column: 23, scope: !350, inlinedAt: !1042)
!1046 = !DILocation(line: 0, scope: !120, inlinedAt: !1047)
!1047 = distinct !DILocation(line: 263, column: 40, scope: !155, inlinedAt: !1045)
!1048 = !DILocation(line: 0, scope: !127, inlinedAt: !1049)
!1049 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !1047)
!1050 = !DILocation(line: 1049, column: 5, scope: !977)
!1051 = !DILocation(line: 1050, column: 1, scope: !977)
!1052 = !DISubprogram(name: "mem_memcpy", scope: !296, file: !296, line: 113, type: !1053, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !299)
!1053 = !DISubroutineType(types: !1054)
!1054 = !{!8, !8, !1055, !5}
!1055 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1056, size: 64)
!1056 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1057 = distinct !DISubprogram(name: "mm_calloc", scope: !3, file: !3, line: 1064, type: !1058, scopeLine: 1064, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !1060)
!1058 = !DISubroutineType(types: !1059)
!1059 = !{!8, !5, !5}
!1060 = !{!1061, !1062, !1063, !1064}
!1061 = !DILocalVariable(name: "elements", arg: 1, scope: !1057, file: !3, line: 1064, type: !5)
!1062 = !DILocalVariable(name: "size", arg: 2, scope: !1057, file: !3, line: 1064, type: !5)
!1063 = !DILocalVariable(name: "bp", scope: !1057, file: !3, line: 1065, type: !8)
!1064 = !DILocalVariable(name: "asize", scope: !1057, file: !3, line: 1066, type: !5)
!1065 = !DILocation(line: 0, scope: !1057)
!1066 = !DILocation(line: 1066, column: 29, scope: !1057)
!1067 = !DILocation(line: 1068, column: 18, scope: !1068)
!1068 = distinct !DILexicalBlock(scope: !1057, file: !3, line: 1068, column: 9)
!1069 = !DILocation(line: 1068, column: 9, scope: !1057)
!1070 = !DILocation(line: 1071, column: 9, scope: !1057)
!1071 = !DILocation(line: 1076, column: 10, scope: !1057)
!1072 = !DILocation(line: 1077, column: 12, scope: !1073)
!1073 = distinct !DILexicalBlock(scope: !1057, file: !3, line: 1077, column: 9)
!1074 = !DILocation(line: 1077, column: 9, scope: !1057)
!1075 = !DILocation(line: 1082, column: 5, scope: !1057)
!1076 = !DILocation(line: 1084, column: 5, scope: !1057)
!1077 = !DILocation(line: 1085, column: 1, scope: !1057)
!1078 = !DISubprogram(name: "mem_memset", scope: !296, file: !296, line: 122, type: !1079, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !299)
!1079 = !DISubroutineType(types: !1080)
!1080 = !{!8, !8, !76, !5}
!1081 = distinct !DISubprogram(name: "delete", scope: !3, file: !3, line: 490, type: !368, scopeLine: 490, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !1082)
!1082 = !{!1083, !1084, !1085, !1086, !1092}
!1083 = !DILocalVariable(name: "block", arg: 1, scope: !1081, file: !3, line: 490, type: !37)
!1084 = !DILocalVariable(name: "size", scope: !1081, file: !3, line: 493, type: !5)
!1085 = !DILocalVariable(name: "num", scope: !1081, file: !3, line: 495, type: !5)
!1086 = !DILocalVariable(name: "succ", scope: !1087, file: !3, line: 527, type: !37)
!1087 = distinct !DILexicalBlock(scope: !1088, file: !3, line: 525, column: 58)
!1088 = distinct !DILexicalBlock(scope: !1089, file: !3, line: 525, column: 14)
!1089 = distinct !DILexicalBlock(scope: !1090, file: !3, line: 515, column: 14)
!1090 = distinct !DILexicalBlock(scope: !1091, file: !3, line: 506, column: 14)
!1091 = distinct !DILexicalBlock(scope: !1081, file: !3, line: 499, column: 9)
!1092 = !DILocalVariable(name: "pred", scope: !1087, file: !3, line: 528, type: !37)
!1093 = !DILocation(line: 0, scope: !1081)
!1094 = !DILocation(line: 493, column: 19, scope: !1081)
!1095 = !DILocation(line: 0, scope: !120, inlinedAt: !1096)
!1096 = distinct !DILocation(line: 493, column: 19, scope: !1081)
!1097 = !DILocation(line: 0, scope: !127, inlinedAt: !1098)
!1098 = distinct !DILocation(line: 228, column: 12, scope: !120, inlinedAt: !1096)
!1099 = !DILocation(line: 219, column: 18, scope: !127, inlinedAt: !1098)
!1100 = !DILocation(line: 0, scope: !454, inlinedAt: !1101)
!1101 = distinct !DILocation(line: 495, column: 18, scope: !1081)
!1102 = !DILocation(line: 455, column: 18, scope: !462, inlinedAt: !1101)
!1103 = !DILocation(line: 455, column: 13, scope: !463, inlinedAt: !1101)
!1104 = !DILocation(line: 0, scope: !465, inlinedAt: !1101)
!1105 = !DILocation(line: 499, column: 16, scope: !1091)
!1106 = !DILocation(line: 499, column: 21, scope: !1091)
!1107 = !DILocation(line: 0, scope: !1091)
!1108 = !DILocation(line: 499, column: 29, scope: !1091)
!1109 = !DILocation(line: 499, column: 9, scope: !1081)
!1110 = !DILocation(line: 501, column: 30, scope: !1111)
!1111 = distinct !DILexicalBlock(scope: !1091, file: !3, line: 499, column: 53)
!1112 = !DILocation(line: 502, column: 5, scope: !1111)
!1113 = !DILocation(line: 0, scope: !1090)
!1114 = !DILocation(line: 506, column: 14, scope: !1091)
!1115 = !DILocation(line: 509, column: 27, scope: !1116)
!1116 = distinct !DILexicalBlock(scope: !1090, file: !3, line: 506, column: 58)
!1117 = !DILocation(line: 510, column: 21, scope: !1116)
!1118 = !DILocation(line: 511, column: 5, scope: !1116)
!1119 = !DILocation(line: 518, column: 30, scope: !1120)
!1120 = distinct !DILexicalBlock(scope: !1089, file: !3, line: 515, column: 58)
!1121 = !DILocation(line: 519, column: 16, scope: !1120)
!1122 = !DILocation(line: 519, column: 22, scope: !1120)
!1123 = !DILocation(line: 519, column: 27, scope: !1120)
!1124 = !DILocation(line: 520, column: 21, scope: !1120)
!1125 = !DILocation(line: 521, column: 5, scope: !1120)
!1126 = !DILocation(line: 0, scope: !1087)
!1127 = !DILocation(line: 529, column: 27, scope: !1087)
!1128 = !DILocation(line: 530, column: 16, scope: !1087)
!1129 = !DILocation(line: 530, column: 22, scope: !1087)
!1130 = !DILocation(line: 530, column: 27, scope: !1087)
!1131 = !DILocation(line: 533, column: 5, scope: !1087)
!1132 = !DILocation(line: 532, column: 21, scope: !1087)
!1133 = !DILocation(line: 534, column: 1, scope: !1081)

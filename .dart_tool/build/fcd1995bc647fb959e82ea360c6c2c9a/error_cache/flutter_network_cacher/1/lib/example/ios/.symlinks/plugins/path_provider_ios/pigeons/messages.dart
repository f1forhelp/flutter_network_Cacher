["objectbox_generator:resolver on lib/example/ios/.symlinks/plugins/path_provider_ios/pigeons/messages.dart",["","line 1, column 203 of package:flutter_network_cacher/example/ios/.symlinks/plugins/path_provider_ios/pigeons/messages.dart: Could not resolve annotation for `abstract class PathProviderApi`.\n  ╷\n1 │ ┌ @ConfigurePigeon(PigeonOptions(\n2 │ │   input: 'pigeons/messages.dart',\n3 │ │   objcOptions: ObjcOptions(prefix: 'FLT'),\n4 │ │   objcHeaderOut: 'ios/Classes/messages.g.h',\n5 │ │   objcSourceOut: 'ios/Classes/messages.g.m',\n6 │ │   dartOut: 'lib/messages.g.dart',\n7 │ │   dartTestOut: 'test/messages_test.g.dart',\n8 │ │   copyrightHeader: 'pigeons/copyright.txt',\n9 │ └ ))\n  ╵","#0      TypeChecker._computeConstantValue (package:source_gen/src/type_checker.dart:114:7)\n#1      TypeChecker._annotationsWhere (package:source_gen/src/type_checker.dart:139:21)\n#2      _SyncIterator.moveNext (dart:core-patch/core_patch.dart:186:26)\n#3      Iterable.isEmpty (dart:core/iterable.dart:513:33)\n#4      TypeChecker.firstAnnotationOf (package:source_gen/src/type_checker.dart:73:20)\n#5      LibraryReader.annotatedWith (package:source_gen/src/library.dart:45:34)\n#6      _SyncIterator.moveNext (dart:core-patch/core_patch.dart:186:26)\n#7      EntityResolver.build (package:objectbox_generator/src/entity_resolver.dart:40:39)\n<asynchronous suspension>\n#8      runBuilder.buildForInput (package:build/src/generate/run_builder.dart:52:7)\n<asynchronous suspension>\n#9      Future.wait.<anonymous closure> (dart:async/future.dart:521:21)\n<asynchronous suspension>\n"]]
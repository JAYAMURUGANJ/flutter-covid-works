import 'package:get_it/get_it.dart';
import 'package:ipab_template/services/calls_and_messages_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}

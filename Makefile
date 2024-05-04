docker_run: 
	cd westwind_server && docker compose up --build --detach
server_run: 
	cd westwind_server && dart bin/main.dart
server_run_apply:
	cd westwind_server && dart bin/main.dart --apply-migrations
server_run_repair:
	cd westwind_server && dart bin/main.dart --apply-repair-migrations
server_generate: 
	cd westwind_server && serverpod generate --watch
server_migration:
	cd westwind_server && serverpod create-migration
flutter_run:
	cd westwind_flutter && flutter run -d chrom
db_migration:
	cd westwind_server && serverpod create-migration
db_migration_force:
	cd westwind_server && serverpod create-migration --force
flutter_gen: 
	cd westwind_flutter && flutter packages pub run build_runner build --delete-conflicting-outputs
freezed:
	flutter packages pub run build_runner build --delete-conflicting-outputs
delete_db:
	cd westwind_server && docker compose down -v 
   


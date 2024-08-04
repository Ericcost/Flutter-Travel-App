import 'package:flutter_travel_app/features.trip/data/datasources/trip_local_datasource.dart';
import 'package:flutter_travel_app/features.trip/data/models/trip_model.dart';
import 'package:flutter_travel_app/features.trip/domain/entities/trip.dart';
import 'package:flutter_travel_app/features.trip/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource localDataSource;

  TripRepositoryImpl(this.localDataSource);
  
  @override
  Future<void> addTrip(Trip trip) async {
    final tripModel = TripModel.fromEntity(trip);
    localDataSource.addTrip(tripModel);
  }

  @override
  Future<void> deleteTrip(int index) async {
    localDataSource.deleteTrip(index);
  }

  @override
  Future<List<Trip>> getTrips() async {
    final tripModels = localDataSource.getTrips();
    List<Trip> res = tripModels.map((model) => model.toEntity()).toList();
    return res;
  }
  
}
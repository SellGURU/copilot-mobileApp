import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'branding_service.dart';
import '../models/branding_data.dart';
import '../utility/branding_color_setter.dart';

// Events
abstract class BrandingEvent extends Equatable {
  const BrandingEvent();

  @override
  List<Object?> get props => [];
}

class LoadBrandingData extends BrandingEvent {}

class RefreshBrandingData extends BrandingEvent {}

class ClearBrandingData extends BrandingEvent {}

// States
abstract class BrandingState extends Equatable {
  const BrandingState();

  @override
  List<Object?> get props => [];
}

class BrandingInitial extends BrandingState {}

class BrandingLoading extends BrandingState {}

class BrandingLoaded extends BrandingState {
  final BrandingData data;

  const BrandingLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class BrandingError extends BrandingState {
  final String message;

  const BrandingError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class BrandingBloc extends Bloc<BrandingEvent, BrandingState> {
  final BrandingService _brandingService = BrandingService.instance;

  BrandingBloc() : super(BrandingInitial()) {
    on<LoadBrandingData>(_onLoadBrandingData);
    on<RefreshBrandingData>(_onRefreshBrandingData);
    on<ClearBrandingData>(_onClearBrandingData);
  }

  Future<void> _onLoadBrandingData(
    LoadBrandingData event,
    Emitter<BrandingState> emit,
  ) async {
    try {
      // Load data (will try API first, then use cache if needed)
      emit(BrandingLoading());
      final data = await _brandingService.loadBrandingData();
      // Set the color in AppColors
      BrandingColorSetter.setPrimaryColorFromBranding(data);
      emit(BrandingLoaded(data));
    } catch (e) {
      emit(BrandingError(e.toString()));
    }
  }

  Future<void> _onRefreshBrandingData(
    RefreshBrandingData event,
    Emitter<BrandingState> emit,
  ) async {
    try {
      emit(BrandingLoading());
      final data = await _brandingService.refreshBrandingData();
      // Set the color in AppColors
      BrandingColorSetter.setPrimaryColorFromBranding(data);
      emit(BrandingLoaded(data));
    } catch (e) {
      emit(BrandingError(e.toString()));
    }
  }

  void _onClearBrandingData(
    ClearBrandingData event,
    Emitter<BrandingState> emit,
  ) {
    _brandingService.clearCache();
    emit(BrandingInitial());
  }

  // Helper method to get current branding data
  BrandingData? getCurrentBrandingData() {
    if (state is BrandingLoaded) {
      return (state as BrandingLoaded).data;
    }
    return _brandingService.cachedData;
  }
} 
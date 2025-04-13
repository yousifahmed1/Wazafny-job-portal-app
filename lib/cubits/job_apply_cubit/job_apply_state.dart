import 'package:equatable/equatable.dart';

class JobApplyState extends Equatable {
  final Map<String, dynamic> applyFormData;

  const JobApplyState({required this.applyFormData});

  // Create a copy of the state with updated data
  JobApplyState copyWith({
    Map<String, dynamic>? applyFormData,
  }) {
    return JobApplyState(
      applyFormData: applyFormData ?? this.applyFormData,
    );
  }

  @override
  List<Object> get props => [applyFormData];
}

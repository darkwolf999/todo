// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskResponseDto _$TaskResponseDtoFromJson(Map<String, dynamic> json) {
  return _TaskResponseDto.fromJson(json);
}

/// @nodoc
mixin _$TaskResponseDto {
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'element')
  TaskDto get taskDto => throw _privateConstructorUsedError;
  int get revision => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskResponseDtoCopyWith<TaskResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskResponseDtoCopyWith<$Res> {
  factory $TaskResponseDtoCopyWith(
          TaskResponseDto value, $Res Function(TaskResponseDto) then) =
      _$TaskResponseDtoCopyWithImpl<$Res, TaskResponseDto>;
  @useResult
  $Res call(
      {String status, @JsonKey(name: 'element') TaskDto taskDto, int revision});

  $TaskDtoCopyWith<$Res> get taskDto;
}

/// @nodoc
class _$TaskResponseDtoCopyWithImpl<$Res, $Val extends TaskResponseDto>
    implements $TaskResponseDtoCopyWith<$Res> {
  _$TaskResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? taskDto = null,
    Object? revision = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      taskDto: null == taskDto
          ? _value.taskDto
          : taskDto // ignore: cast_nullable_to_non_nullable
              as TaskDto,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskDtoCopyWith<$Res> get taskDto {
    return $TaskDtoCopyWith<$Res>(_value.taskDto, (value) {
      return _then(_value.copyWith(taskDto: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TaskResponseDtoCopyWith<$Res>
    implements $TaskResponseDtoCopyWith<$Res> {
  factory _$$_TaskResponseDtoCopyWith(
          _$_TaskResponseDto value, $Res Function(_$_TaskResponseDto) then) =
      __$$_TaskResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status, @JsonKey(name: 'element') TaskDto taskDto, int revision});

  @override
  $TaskDtoCopyWith<$Res> get taskDto;
}

/// @nodoc
class __$$_TaskResponseDtoCopyWithImpl<$Res>
    extends _$TaskResponseDtoCopyWithImpl<$Res, _$_TaskResponseDto>
    implements _$$_TaskResponseDtoCopyWith<$Res> {
  __$$_TaskResponseDtoCopyWithImpl(
      _$_TaskResponseDto _value, $Res Function(_$_TaskResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? taskDto = null,
    Object? revision = null,
  }) {
    return _then(_$_TaskResponseDto(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      taskDto: null == taskDto
          ? _value.taskDto
          : taskDto // ignore: cast_nullable_to_non_nullable
              as TaskDto,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskResponseDto implements _TaskResponseDto {
  const _$_TaskResponseDto(
      {required this.status,
      @JsonKey(name: 'element') required this.taskDto,
      required this.revision});

  factory _$_TaskResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_TaskResponseDtoFromJson(json);

  @override
  final String status;
  @override
  @JsonKey(name: 'element')
  final TaskDto taskDto;
  @override
  final int revision;

  @override
  String toString() {
    return 'TaskResponseDto(status: $status, taskDto: $taskDto, revision: $revision)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskResponseDto &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.taskDto, taskDto) || other.taskDto == taskDto) &&
            (identical(other.revision, revision) ||
                other.revision == revision));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, taskDto, revision);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskResponseDtoCopyWith<_$_TaskResponseDto> get copyWith =>
      __$$_TaskResponseDtoCopyWithImpl<_$_TaskResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskResponseDtoToJson(
      this,
    );
  }
}

abstract class _TaskResponseDto implements TaskResponseDto {
  const factory _TaskResponseDto(
      {required final String status,
      @JsonKey(name: 'element') required final TaskDto taskDto,
      required final int revision}) = _$_TaskResponseDto;

  factory _TaskResponseDto.fromJson(Map<String, dynamic> json) =
      _$_TaskResponseDto.fromJson;

  @override
  String get status;
  @override
  @JsonKey(name: 'element')
  TaskDto get taskDto;
  @override
  int get revision;
  @override
  @JsonKey(ignore: true)
  _$$_TaskResponseDtoCopyWith<_$_TaskResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

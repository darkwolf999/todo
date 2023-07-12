// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_list_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TasksListDto _$TasksListDtoFromJson(Map<String, dynamic> json) {
  return _TasksListDto.fromJson(json);
}

/// @nodoc
mixin _$TasksListDto {
  String get status => throw _privateConstructorUsedError;
  List<TaskDto> get list => throw _privateConstructorUsedError;
  int get revision => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TasksListDtoCopyWith<TasksListDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksListDtoCopyWith<$Res> {
  factory $TasksListDtoCopyWith(
          TasksListDto value, $Res Function(TasksListDto) then) =
      _$TasksListDtoCopyWithImpl<$Res, TasksListDto>;
  @useResult
  $Res call({String status, List<TaskDto> list, int revision});
}

/// @nodoc
class _$TasksListDtoCopyWithImpl<$Res, $Val extends TasksListDto>
    implements $TasksListDtoCopyWith<$Res> {
  _$TasksListDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? list = null,
    Object? revision = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TaskDto>,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TasksListDtoCopyWith<$Res>
    implements $TasksListDtoCopyWith<$Res> {
  factory _$$_TasksListDtoCopyWith(
          _$_TasksListDto value, $Res Function(_$_TasksListDto) then) =
      __$$_TasksListDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, List<TaskDto> list, int revision});
}

/// @nodoc
class __$$_TasksListDtoCopyWithImpl<$Res>
    extends _$TasksListDtoCopyWithImpl<$Res, _$_TasksListDto>
    implements _$$_TasksListDtoCopyWith<$Res> {
  __$$_TasksListDtoCopyWithImpl(
      _$_TasksListDto _value, $Res Function(_$_TasksListDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? list = null,
    Object? revision = null,
  }) {
    return _then(_$_TasksListDto(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TaskDto>,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TasksListDto implements _TasksListDto {
  const _$_TasksListDto(
      {required this.status,
      required final List<TaskDto> list,
      required this.revision})
      : _list = list;

  factory _$_TasksListDto.fromJson(Map<String, dynamic> json) =>
      _$$_TasksListDtoFromJson(json);

  @override
  final String status;
  final List<TaskDto> _list;
  @override
  List<TaskDto> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  final int revision;

  @override
  String toString() {
    return 'TasksListDto(status: $status, list: $list, revision: $revision)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TasksListDto &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.revision, revision) ||
                other.revision == revision));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_list), revision);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TasksListDtoCopyWith<_$_TasksListDto> get copyWith =>
      __$$_TasksListDtoCopyWithImpl<_$_TasksListDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TasksListDtoToJson(
      this,
    );
  }
}

abstract class _TasksListDto implements TasksListDto {
  const factory _TasksListDto(
      {required final String status,
      required final List<TaskDto> list,
      required final int revision}) = _$_TasksListDto;

  factory _TasksListDto.fromJson(Map<String, dynamic> json) =
      _$_TasksListDto.fromJson;

  @override
  String get status;
  @override
  List<TaskDto> get list;
  @override
  int get revision;
  @override
  @JsonKey(ignore: true)
  _$$_TasksListDtoCopyWith<_$_TasksListDto> get copyWith =>
      throw _privateConstructorUsedError;
}

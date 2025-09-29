// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SearchState {
  String get query => throw _privateConstructorUsedError;
  List<SearchResult> get results => throw _privateConstructorUsedError;
  List<String> get suggestions => throw _privateConstructorUsedError;
  List<String> get trendingSearches => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get hasSearched => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchStateCopyWith<SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
    SearchState value,
    $Res Function(SearchState) then,
  ) = _$SearchStateCopyWithImpl<$Res, SearchState>;
  @useResult
  $Res call({
    String query,
    List<SearchResult> results,
    List<String> suggestions,
    List<String> trendingSearches,
    bool isLoading,
    bool hasSearched,
    String? error,
  });
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? results = null,
    Object? suggestions = null,
    Object? trendingSearches = null,
    Object? isLoading = null,
    Object? hasSearched = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            query: null == query
                ? _value.query
                : query // ignore: cast_nullable_to_non_nullable
                      as String,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<SearchResult>,
            suggestions: null == suggestions
                ? _value.suggestions
                : suggestions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            trendingSearches: null == trendingSearches
                ? _value.trendingSearches
                : trendingSearches // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasSearched: null == hasSearched
                ? _value.hasSearched
                : hasSearched // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SearchStateImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$SearchStateImplCopyWith(
    _$SearchStateImpl value,
    $Res Function(_$SearchStateImpl) then,
  ) = __$$SearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String query,
    List<SearchResult> results,
    List<String> suggestions,
    List<String> trendingSearches,
    bool isLoading,
    bool hasSearched,
    String? error,
  });
}

/// @nodoc
class __$$SearchStateImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateImpl>
    implements _$$SearchStateImplCopyWith<$Res> {
  __$$SearchStateImplCopyWithImpl(
    _$SearchStateImpl _value,
    $Res Function(_$SearchStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? results = null,
    Object? suggestions = null,
    Object? trendingSearches = null,
    Object? isLoading = null,
    Object? hasSearched = null,
    Object? error = freezed,
  }) {
    return _then(
      _$SearchStateImpl(
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<SearchResult>,
        suggestions: null == suggestions
            ? _value._suggestions
            : suggestions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        trendingSearches: null == trendingSearches
            ? _value._trendingSearches
            : trendingSearches // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasSearched: null == hasSearched
            ? _value.hasSearched
            : hasSearched // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SearchStateImpl implements _SearchState {
  const _$SearchStateImpl({
    this.query = '',
    final List<SearchResult> results = const [],
    final List<String> suggestions = const [],
    final List<String> trendingSearches = const [],
    this.isLoading = false,
    this.hasSearched = false,
    this.error,
  }) : _results = results,
       _suggestions = suggestions,
       _trendingSearches = trendingSearches;

  @override
  @JsonKey()
  final String query;
  final List<SearchResult> _results;
  @override
  @JsonKey()
  List<SearchResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  final List<String> _suggestions;
  @override
  @JsonKey()
  List<String> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  final List<String> _trendingSearches;
  @override
  @JsonKey()
  List<String> get trendingSearches {
    if (_trendingSearches is EqualUnmodifiableListView)
      return _trendingSearches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trendingSearches);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool hasSearched;
  @override
  final String? error;

  @override
  String toString() {
    return 'SearchState(query: $query, results: $results, suggestions: $suggestions, trendingSearches: $trendingSearches, isLoading: $isLoading, hasSearched: $hasSearched, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateImpl &&
            (identical(other.query, query) || other.query == query) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            const DeepCollectionEquality().equals(
              other._suggestions,
              _suggestions,
            ) &&
            const DeepCollectionEquality().equals(
              other._trendingSearches,
              _trendingSearches,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasSearched, hasSearched) ||
                other.hasSearched == hasSearched) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    query,
    const DeepCollectionEquality().hash(_results),
    const DeepCollectionEquality().hash(_suggestions),
    const DeepCollectionEquality().hash(_trendingSearches),
    isLoading,
    hasSearched,
    error,
  );

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      __$$SearchStateImplCopyWithImpl<_$SearchStateImpl>(this, _$identity);
}

abstract class _SearchState implements SearchState {
  const factory _SearchState({
    final String query,
    final List<SearchResult> results,
    final List<String> suggestions,
    final List<String> trendingSearches,
    final bool isLoading,
    final bool hasSearched,
    final String? error,
  }) = _$SearchStateImpl;

  @override
  String get query;
  @override
  List<SearchResult> get results;
  @override
  List<String> get suggestions;
  @override
  List<String> get trendingSearches;
  @override
  bool get isLoading;
  @override
  bool get hasSearched;
  @override
  String? get error;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

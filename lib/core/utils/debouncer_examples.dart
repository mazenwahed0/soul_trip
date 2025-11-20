import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:soul_trip/core/utils/debouncer.dart';

/// Example: Using Debouncer in different scenarios
/// This file demonstrates various use cases for the Debouncer utility

// ============================================================================
// Example 1: Search TextField with Debouncing
// ============================================================================

class SearchTextFieldExample extends StatefulWidget {
  const SearchTextFieldExample({super.key});

  @override
  State<SearchTextFieldExample> createState() => _SearchTextFieldExampleState();
}

class _SearchTextFieldExampleState extends State<SearchTextFieldExample> {
  final _controller = TextEditingController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  String _searchResults = '';

  @override
  void dispose() {
    _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel any pending search and start a new one
    _debouncer.run(() {
      // This will only execute 500ms after the user stops typing
      _performSearch(query);
    });
  }

  void _performSearch(String query) {
    // Simulate API call
    setState(() {
      _searchResults = 'Searching for: $query';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: _onSearchChanged,
          decoration: const InputDecoration(hintText: 'Type to search...'),
        ),
        Text(_searchResults),
      ],
    );
  }
}

// ============================================================================
// Example 2: Auto-Save Form
// ============================================================================

class AutoSaveFormExample extends StatefulWidget {
  const AutoSaveFormExample({super.key});

  @override
  State<AutoSaveFormExample> createState() => _AutoSaveFormExampleState();
}

class _AutoSaveFormExampleState extends State<AutoSaveFormExample> {
  final _debouncer = Debouncer(delay: const Duration(seconds: 2));
  String _formData = '';

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  void _onFormChanged(String value) {
    setState(() {
      _formData = value;
    });

    // Auto-save 2 seconds after user stops typing
    _debouncer.run(() {
      _saveToServer();
    });
  }

  Future<void> _saveToServer() async {
    // Simulate API call
    log('Auto-saving: $_formData');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _onFormChanged,
      decoration: const InputDecoration(
        hintText: 'Type something... (auto-saves after 2s)',
      ),
    );
  }
}

// ============================================================================
// Example 3: Window Resize Handler
// ============================================================================

class WindowResizeExample extends StatefulWidget {
  const WindowResizeExample({super.key});

  @override
  State<WindowResizeExample> createState() => _WindowResizeExampleState();
}

class _WindowResizeExampleState extends State<WindowResizeExample> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 300));
  Size _windowSize = Size.zero;

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  void _onResize(Size size) {
    // Only update layout 300ms after user stops resizing
    _debouncer.run(() {
      setState(() {
        _windowSize = size;
      });
      _updateLayout();
    });
  }

  void _updateLayout() {
    log('Updating layout for size: $_windowSize');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _onResize(Size(constraints.maxWidth, constraints.maxHeight));
        return Text('Window size: $_windowSize');
      },
    );
  }
}

// ============================================================================
// Example 4: API Rate Limiting
// ============================================================================

class ApiRateLimitExample {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 1000));
  int _apiCallCount = 0;

  void trackUserActivity(String activity) {
    // Only send analytics 1 second after user stops interacting
    _debouncer.run(() {
      _sendAnalytics(activity);
    });
  }

  Future<void> _sendAnalytics(String activity) async {
    _apiCallCount++;
    log('Analytics sent ($_apiCallCount): $activity');
  }

  void dispose() {
    _debouncer.dispose();
  }
}

// ============================================================================
// Example 5: Scroll to Bottom Detection
// ============================================================================

class ScrollDetectionExample extends StatefulWidget {
  const ScrollDetectionExample({super.key});

  @override
  State<ScrollDetectionExample> createState() => _ScrollDetectionExampleState();
}

class _ScrollDetectionExampleState extends State<ScrollDetectionExample> {
  final _scrollController = ScrollController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 200));

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Check if near bottom 200ms after user stops scrolling
    _debouncer.run(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreItems();
      }
    });
  }

  void _loadMoreItems() {
    log('Loading more items...');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 100,
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    );
  }
}

// ============================================================================
// Example 6: Combined Debouncer with Request ID (Like Search Feature)
// ============================================================================

class SearchWithRequestIdExample {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  int _requestId = 0;

  Future<void> search(String query) async {
    // Increment request ID
    final currentRequestId = ++_requestId;

    log('🔍 Search initiated - Query: "$query", Request ID: $currentRequestId');

    // Debounce the search
    _debouncer.run(() async {
      // Check if this is still the latest request
      if (currentRequestId != _requestId) {
        log('⏭️ Skipping outdated request ID: $currentRequestId');
        return;
      }

      // Perform the search
      final results = await _performSearch(query);

      // Double-check before using results
      if (currentRequestId != _requestId) {
        log('⏭️ Discarding outdated results for request ID: $currentRequestId');
        return;
      }

      log('✅ Search success for request ID $currentRequestId: $results');
    });
  }

  Future<String> _performSearch(String query) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    return '$query results';
  }

  void dispose() {
    _debouncer.dispose();
  }
}

// ============================================================================
// Example 7: Cancellable Debouncer
// ============================================================================

class CancellableSearchExample extends StatefulWidget {
  const CancellableSearchExample({super.key});

  @override
  State<CancellableSearchExample> createState() =>
      _CancellableSearchExampleState();
}

class _CancellableSearchExampleState extends State<CancellableSearchExample> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      // Cancel any pending search when input is cleared
      _debouncer.cancel();
      return;
    }

    _debouncer.run(() {
      log('Searching for: $query');
    });
  }

  void _clearSearch() {
    _controller.clear();
    _debouncer.cancel(); // Important: cancel pending operations
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onChanged: _onSearchChanged,
          ),
        ),
        IconButton(icon: const Icon(Icons.clear), onPressed: _clearSearch),
      ],
    );
  }
}

// ============================================================================
// Usage Tips:
// ============================================================================
//
// 1. Always dispose the debouncer in your widget's dispose method
// 2. Choose appropriate delay duration based on use case:
//    - Search: 300-500ms
//    - Auto-save: 1-3 seconds
//    - Window resize: 200-300ms
//    - Scroll detection: 100-200ms
//
// 3. Combine with Request ID for better race condition handling
// 4. Use cancel() when user clears input or cancels action
// 5. Test with different delay durations to find optimal UX
//
// ============================================================================

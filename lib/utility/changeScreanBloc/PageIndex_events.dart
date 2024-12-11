/// This file defines the events related to page index management in a Flutter application.
///
/// The events are used by the [PageIndexBloc] to trigger updates to the current page index.

/// Abstract class representing all possible page index events.
abstract class PageIndexEvents {}

/// Event to update the current page index.
/// This event carries the new page index as a parameter.
class UpdatePageIndex extends PageIndexEvents {
  /// The new page index to be set.
  final int pageIndex;

  /// Constructor to initialize the [UpdatePageIndex] event with the provided page index.
  UpdatePageIndex(this.pageIndex);
}


abstract class PageIndexEvents {}
class UpdatePageIndex extends PageIndexEvents {
  final int pageIndex;
  UpdatePageIndex(this.pageIndex);
}

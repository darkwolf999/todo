abstract class RevisionProvider {
  int getRevision();

  Future<void> updateRevision(int revision);
}

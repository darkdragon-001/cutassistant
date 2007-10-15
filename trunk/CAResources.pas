UNIT CAResources;

INTERFACE

RESOURCESTRING

  { Main }
  RsNotAvailable                   = 'N/A';
  RsCaptionCutApplication          = 'Cut app.: %s';
  RsNoCutsDefined                  = 'No cuts defined.';
  RsCouldNotCreateTargetPath       = 'Could not create target file path %s. Abort.';
  RsTargetMovieAlreadyExists       = 'Target file already exists:'#13#10
                                   + #13#10
                                   + '%s'#13#10
                                   + #13#10
                                   + 'Overwrite?';
  RsSaveCutMovieAs                 = 'Save cut movie as...';
  RsCouldNotDeleteFile             = 'Could not delete existing file %s. Abort.';
  RsCaptionTotalCutoff             = 'Total cutoff: %s';
  RsCaptionResultingDuration       = 'Resulting movie duration: %s';
  RsCouldNotInsertSampleGrabber    = 'Could not insert sample grabber.';
  RsErrorOpenMovie                 = 'Could not open Movie!'#13#10
                                   + 'Error: %s';
  RsErrorFileNotFound              = 'File not found: '#13#10
                                   + '%s';
  RsCannotLoadCutlist              = 'Cannot load cutlist. Please load movie first.';
  RsTitleMovieMetaData             = 'Movie Meta Data';
  RsMovieMetaDataMovietype         = 'Filetype: %s';
  RsMovieMetaDataCutApplication    = 'Cut application: %s';
  RsMovieMetaDataFilename          = 'Filename: %s';
  RsMovieMetaDataFrameRate         = 'Frame Rate: %s';
  RsMovieMetaDataVideoFourCC       = 'Video FourCC: %s';
  RsMovieMetaDataUnknownDataFormat = '***unknown data format***';
  RsMovieMetaDataNoInterface       = '***Could not find interface***';
  RsCutlistSavedAs                 = 'Cutlist saved successfully to'#13#10
                                   + '%s.';
  RsFilterDescriptionWmv           = 'Windows Media Files';
  RsFilterDescriptionAvi           = 'AVI Files';
  RsFilterDescriptionMp4           = 'MP4 Files';
  RsFilterDescriptionAllSupported  = 'All Supported Movie Files';
  RsFilterDescriptionAll           = 'All Files';

  RsFilterDescriptionAsf           = 'Asf Movie Files';

  RsExUnableToOpenKey              = 'Unable to open key "%s".';

  RsRegDescCutlist                 = 'Cutlist for Cut Assistant';
  RsRegDescCutlistOpen             = 'Open with Cut Assistant';
  RsRegDescMovieOpen               = 'Edit with Cut Assistant';

  RsErrorRegisteringApplication    = 'registering application.';
  RsErrorUnRegisteringApplication  = 'unregistering application.';

  RsMsgUploadCutlist               = 'Your Cutlist'#13#10
                                   + '%s'#13#10
                                   + 'will now be uploaded to the following site: '#13#10
                                   + '%s'#13#10
                                   + 'Continue?';
  RsMsgSaveChangedCutlist          = 'Save changes in current cutlist?';
  RsTitleSaveChangedCutlist        = 'Cutlist not saved';
  RsCutAppAsfBinNotFound           = 'Could not get Object CutApplication Asfbin.';

  RsTitleRepairMovie               = 'Select File to be repaired:';

  RsMsgRepairMovie                 = 'Current movie will be repaired using %s.'#13#10
                                   + 'Original file will be saved as '#13#10
                                   + '%s'#13#10
                                   + 'Continue?';
  RsMsgRepairMovieRenameFailed     = 'Could not rename original file. Abort.';
  RsMsgRepairMovieFinished         = 'Finished repairing movie. Open repaired movie now?';

  RsTitleCheckCutMovie             = 'Select File to check:';
  RsErrorMovieNotFound             = 'Movie File not found.';
  RsErrorCouldNotLoadMovie         = 'Could not load cut movie.';
  RsErrorCouldNotLoadCutMovie      = 'Could not load cut movie!'#13#10
                                   + 'Error: %s';

  RsCutApplicationWmv              = 'WMV Cut Application';
  RsCutApplicationAvi              = 'AVI Cut Application';
  RsCutApplicationHqAvi            = 'HQ Avi Cut Application';
  RsCutApplicationMp4              = 'MP4 Cut Application';
  RsCutApplicationOther            = 'Other Cut Application';

  RsTitleCutApplicationSettings    = 'Cut Application Settings';

  RsErrorUnknown                   = 'Unknown error.';
  RsMsgSearchCutlistNoneFound      = 'Search Cutlist by File Size: No Cutlist found.';
  RsErrorSearchCutlistXml          = 'XML-Error while getting cutlist infos:'#13#10'%s';

  RsMsgSendRatingNotPossible       = 'Current cutlist was not downloaded. Rating not possible.';
  RsMsgSendRatingDone              = 'Rating done.';
  RsMsgAnswerFromServer            = 'Answer from Server:'#13#10'%s';

  RsErrorUploadCutlist             = 'Error uploading cutlist: ';

  RsMsgCutlistDeleteUnexpected     = 'Delete command sent to server, but received unexpected response from server.';
  RsMsgCutlistDeleteEntryRemoved   = 'Database entry removed.';
  RsMsgCutlistDeleteEntryNotRemoved= 'Database entry NOT removed.';
  RsMsgCutlistDeleteFileRemoved    = 'File removed.';
  RsMsgCutlistDeleteFileNotRemoved = 'File NOT removed.';

  RsMsgAskUserForRating            = 'Please send a rating for the current cutlist.'#13#10
                                   + 'Would you like to do that now?';

  RsCutAssistantSupportRequest     = 'CutAssistant %s support request';

  RsDownloadCutlistWarnChanged     = 'Trying to download this cutlist:'#13#10
                                   + '%s [ID=%s]'#13#10
                                   + 'Existing cutlist is not saved and changes will be lost.'#13#10
                                   + 'Continue?';

  RsMsgOpenHomepage                = 'Open cutlist homepage in webbrowser?';
  RsDownloadCutlistInvalidData     = 'Server did not return any valid data (%d bytes). Abort.';
  RsErrorCreatePathFailedAbort     = 'Could not create cutlist path %s. Abort.';

  RsWarnTargetExistsOverwrite      = 'Target File exists already:'#13#10
                                   + '%s'#13#10
                                   + 'Overwrite?';

  RsErrorDeleteFileFailedAbort     = 'Could not delete existing file %s. Abort.';

  RsErrorConvertUploadData         = 'XML-Error while converting upload infos.'#13#10
                                   + '%s';

  RsErrorDownloadInfo              = 'Error while checking for Information and new Versions on Server.'#13#10;
  RsErrorDownloadInfoXml           = '%sXML-Error: %s';

  RsMsgInfoMessage                 = 'Information: %s';
  RsMsgInfoDevelopment             = 'Development Version Information: %s';
  RsMsgInfoStable                  = 'Stable Version Information: %s';

  RsTitleSaveSnapshot              = 'Save Snapshot as...';

  RsErrorExternalCall              = 'Error while calling %s: %s';

  RsErrorHttpFileNotFound          = 'File not found on server: %s';

  RsProgressTransferAborted        = 'Transfer aborted ...';
  RsErrorTransferAborting          = 'Transfer error. Aborting ...';

  RsProgressReadData               = 'Read %5d bytes from host.';
  RsProgressWroteData              = 'Wrote %5d bytes to host.';

  { CodecSettings }
  RsCheckingSourceFilterStart      = 'Checking Filters. Please wait ...';
  RsSourceFilterNone               = 'none';
  RsCheckingSourceFilter           = 'Checking Filter (%3d/%3d)';
  RsErrorCheckingSourceFilter      = 'Error while checking Filter %s'#13#10
                                   + 'ClassID: %s'#13#10
                                   + 'Error: %s';
  RsCheckingSourceFilterEnd        = 'Checking Filters. Done.';
  RsCodecUseDefault                = '%s use default';
  RsCodecDummyName                 = 'none';
  RsCodecDummyDesc                 = '(Do not include Codec information)';
  RsErrorCloseCodec                = 'Could not close Compressor.';

  { CutlistRate-dialog }
  RsTitleConfirmRating             = 'Please confirm preselected rating ...';
  RsMsgConfirmRating               = 'Do you want to use the proposed rating for the cutlist?'#13#10
                                   + #13#10
                                   + '  %s';

IMPLEMENTATION

END.


import { Controller } from "stimulus";

export default class extends Controller {
  static values = { url: String, filename: String }

  connect() { 
    this.initializeAdobeViewer();
  }

  initializeAdobeViewer() {
    let adobeDCView = new AdobeDC.View({ clientId: "e748c44682a84ca29c02e975f648cd41", divId: this.element.id });
    adobeDCView.previewFile({
      content: { location: { url: this.urlValue } },
      metaData: { fileName: this.filenameValue }
    },{
      embedMode: "IN_LINE",
      showAnnotationTools: false,
      showDownloadPDF: false,
      showPrintPDF: false
    });
  }
}

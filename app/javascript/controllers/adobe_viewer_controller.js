import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() { 
    this.initializeAdobeViewer();
  }

  initializeAdobeViewer() {
    const url = this.data.get("url");
    const filename = this.data.get("filename");
    const divId = this.data.get("element-id");

    let adobeDCView = new AdobeDC.View({ clientId: "e748c44682a84ca29c02e975f648cd41", divId: divId });
    adobeDCView.previewFile({
      content: { location: { url: url } },
      metaData: { fileName: filename }
    },{
      embedMode: "IN_LINE",
      showAnnotationTools: false,
      showDownloadPDF: false,
      showPrintPDF: false
    });    
  }
}

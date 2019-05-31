$latex = 'platex %O %S';
$dvipdf = 'dvipdfmx %O %S';
$pdf_mode = 3;

$pvc_view_file_via_temporary = 0;

if($^O eq 'darwin'){
    $pdf_previewer = 'open -a Skim %S'
} elsif($^O eq 'linux') {
    $pdf_previewer = 'evince %S &'
}


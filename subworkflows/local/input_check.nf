//
// Check input samplesheet and get read channels
//

include { SAMPLESHEET_CHECK } from '../../modules/local/samplesheet_check'

workflow INPUT_CHECK {
    take:
    samplesheet // file: /path/to/samplesheet.csv

    main:
    SAMPLESHEET_CHECK ( samplesheet )
        .csv
        .splitCsv ( header:true, sep:',' )
        .map { create_bam_channel(it) }
        .set { bam }

    emit:
    bam = SAMPLESHEET_CHECK.out.bam
    versions = SAMPLESHEET_CHECK.out.versions // channel: [ versions.yml ]
}

// Function to get list of [ meta, [ bam ] ]
def create_bam_channel(LinkedHashMap row) {
    // create meta map
    def meta = [:]
    meta.id         = row.sample

    // add path(s) of the bam file(s) to the meta map
    def bam_meta = []
    if (meta.filetype != mapped.getExtension().toString()) {
                error('The file extension does not fit the specified file_type.\n' + mapped.toString() )
            }

            meta.index  = index ? true : false

            return [meta, mapped, index]

            }

    return bam_meta

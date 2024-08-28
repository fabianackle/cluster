#!/usr/bin/env nextflow

/* Print pipeline info */
log.info """
    ===============================
    C L U S T E R   P I P E L I N E
    ===============================
    """
    .stripIndent()

params.iterations = [1, 2, 3]
params.outdir = "$projectDir/results"

process Big_job {
    cpus 8
    memory '8 GB'
    time '2h'

    tag "big_job_${iteration}"

    input:
    val(iteration)

    output:
    tuple val(iteration), path("big_job_${iteration}.txt")

    script:
    """
    date '+%Y-%m-%d %H:%M:%S' > big_job_${iteration}.txt
    hostname >> big_job_${iteration}.txt
    echo "Host has \$(ps -e | wc -l) processes running" >> big_job_${iteration}.txt
    scontrol show jobid=\$SLURM_JOBID >> big_job_${iteration}.txt
    delay=\$((1 + \$RANDOM % 100))
    echo "Will sleep for \$delay seconds" >> big_job_${iteration}.txt
    sleep \$delay
    date '+%Y-%m-%d %H:%M:%S' >> big_job_${iteration}.txt
    """
}

process Small_job {
    cpus 1
    memory '1 GB'
    time '10s'

    tag "small_job_${iteration}"

    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(iteration), path(big_file)

    output:
    path(big_file)
    path("small_job_${iteration}.txt")


    script:
    """
    date '+%Y-%m-%d %H:%M:%S' > small_job_${iteration}.txt
    hostname >> small_job_${iteration}.txt
    wc -c ${big_file} >> small_job_${iteration}.txt
    scontrol show jobid=\$SLURM_JOBID >> small_job_${iteration}.txt
    date '+%Y-%m-%d %H:%M:%S' >> small_job_${iteration}.txt
    """
}

workflow {
    input_ch = Channel.from(params.iterations)
    big_ch = Big_job(input_ch)
    small_ch = Small_job(big_ch)
}


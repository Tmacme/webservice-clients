# $Id$
# ======================================================================
#
# Test sample EMBL-EBI SOAPpy based web services clients.
#
# ======================================================================

# Python installation to use (each installation contains different versions
# of the required libraries).
PYTHON=python

# User e-mail address to use for the requests.
#EMAIL = email@example.org
EMAIL = support@ebi.ac.uk

# Source for test data used by the tests.
TEST_DATA_SVN=https://svn.ebi.ac.uk/webservices/webservices-2.0/trunk/test_data/

# Run all test sets
all: \
dbfetch \
iprscan \
ncbiblast

clean: \
dbfetch_clean \
iprscan_clean \
ncbiblast_clean

# Fetch/update test data.
test_data:
	-if [ -d ../test_data ]; then svn update ../test_data ; else svn co ${TEST_DATA_SVN} ../test_data ; fi

# WSDbfetch Document/literal SOAP
dbfetch: dbfetch_getSupportedDBs dbfetch_getSupportedFormats dbfetch_getSupportedStyles dbfetch_getDbFormats dbfetch_getFormatStyles dbfetch_fetchData dbfetch_fetchBatch

dbfetch_getSupportedDBs:
	${PYTHON} wsdbfetch_soappy.py getSupportedDBs > dbfetch-getSupportedDBs.txt

dbfetch_getSupportedFormats:
	${PYTHON} wsdbfetch_soappy.py getSupportedFormats > dbfetch-getSupportedFormats.txt

dbfetch_getSupportedStyles:
	${PYTHON} wsdbfetch_soappy.py getSupportedStyles > dbfetch-getSupportedStyles.txt

dbfetch_getDbFormats:
	${PYTHON} wsdbfetch_soappy.py getDbFormats uniprotkb > dbfetch-getDbFormats.txt

dbfetch_getFormatStyles:
	${PYTHON} wsdbfetch_soappy.py getFormatStyles uniprotkb default > dbfetch-getFormatStyles.txt

dbfetch_fetchData: dbfetch_fetchData_string dbfetch_fetchData_file dbfetch_fetchData_stdin

dbfetch_fetchData_string:
	${PYTHON} wsdbfetch_soappy.py fetchData 'UNIPROTKB:WAP_RAT' > dbfetch-fetchData.txt

dbfetch_fetchData_file: test_data
	echo 'TODO:' $@

dbfetch_fetchData_stdin: test_data
	echo 'TODO:' $@

dbfetch_fetchBatch: dbfetch_fetchBatch_string dbfetch_fetchBatch_file dbfetch_fetchBatch_stdin

dbfetch_fetchBatch_string:
	${PYTHON} wsdbfetch_soappy.py fetchBatch uniprotkb 'WAP_RAT,WAP_MOUSE' > dbfetch-fetchBatch.txt

dbfetch_fetchBatch_file: test_data
	echo 'TODO:' $@

dbfetch_fetchBatch_stdin: test_data
	echo 'TODO:' $@

dbfetch_clean:
	rm -f dbfetch-*

# InterProScan
iprscan: iprscan_params iprscan_param_detail iprscan_file iprscan_dbid iprscan_stdin_stdout iprscan_id_list_file iprscan_id_list_file_stdin_stdout iprscan_multifasta_file iprscan_multifasta_file_stdin_stdout

iprscan_params:
	${PYTHON} iprscan_soappy.py --params

iprscan_param_detail:
	${PYTHON} iprscan_soappy.py --paramDetail appl

iprscan_file: test_data
	${PYTHON} iprscan_soappy.py --email ${EMAIL} ../test_data/SWISSPROT_ABCC9_HUMAN.fasta

iprscan_dbid:
	${PYTHON} iprscan_soappy.py --email ${EMAIL} 'UNIPROT:ABCC9_HUMAN'

iprscan_stdin_stdout: test_data
	echo 'TODO:' $@

iprscan_id_list_file: test_data
	echo 'TODO:' $@

iprscan_id_list_file_stdin_stdout: test_data
	echo 'TODO:' $@

iprscan_multifasta_file: test_data
	echo 'TODO:' $@

iprscan_multifasta_file_stdin_stdout: test_data
	echo 'TODO:' $@

iprscan_clean:
	rm -f iprscan-*

# NCBI BLAST or NCBI BLAST+
ncbiblast: ncbiblast_params ncbiblast_param_detail ncbiblast_file ncbiblast_dbid ncbiblast_stdin_stdout ncbiblast_id_list_file ncbiblast_id_list_file_stdin_stdout ncbiblast_multifasta_file ncbiblast_multifasta_file_stdin_stdout

ncbiblast_params:
	${PYTHON} ncbiblast_soappy.py --params

ncbiblast_param_detail:
	${PYTHON} ncbiblast_soappy.py --paramDetail program

ncbiblast_file: test_data
	${PYTHON} ncbiblast_soappy.py --email ${EMAIL} --program blastp --database uniprotkb_swissprot --scores 10 --alignments 10 --stype protein ../test_data/SWISSPROT_ABCC9_HUMAN.fasta

ncbiblast_dbid:
	${PYTHON} ncbiblast_soappy.py --email ${EMAIL} --program blastp --database uniprotkb_swissprot --scores 10 --alignments 10 --stype protein 'UNIPROT:ABCC9_HUMAN'

ncbiblast_stdin_stdout: test_data
	echo 'TODO:' $@

ncbiblast_id_list_file: test_data
	echo 'TODO:' $@

ncbiblast_id_list_file_stdin_stdout: test_data
	echo 'TODO:' $@

ncbiblast_multifasta_file: test_data
	echo 'TODO:' $@

ncbiblast_multifasta_file_stdin_stdout: test_data
	echo 'TODO:' $@

ncbiblast_clean:
	rm -f ncbiblast-*

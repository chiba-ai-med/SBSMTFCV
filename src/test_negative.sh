# Expect Error
function catch {
  echo Catch
}
trap catch ERR

# Perform SBSMTFCV
docker run --rm -v $(pwd):/work ghcr.io/chiba-ai-med/sbsmtfcv:main \
-i /work/data/negative.tsv -o /work/output_negative \
--cores=10 --rank_min=2 --rank_max=3 \
--lambda_min=9 --lambda_max=10 --trials=2 \
--n_iter_max=10

# Error when no error
if [ $? = 0 ]; then
	echo "No error"
	exit 1
fi
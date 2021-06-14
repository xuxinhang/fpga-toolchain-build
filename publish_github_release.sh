
URL_PREFIX='https://api.github.com/repos/xuxinhang/fpga-toolchain-build'
http_header_accept="Accept: application/vnd.github.v3+json"
http_header_token="Authorization: token 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"


upload_release_asset () {
    release_tag=$1

    http_response=$(curl \
        -H "$http_header_accept" -H "$http_header_token" \
        -o /dev/null -s -w '%{http_code}' \
        $URL_PREFIX/releases/tags/$release_tag \
    )

    echo $http_response

    if [[ $http_response = '404' ]]
    then
        curl -H "$http_header_accept" -H "$http_header_token" -X POST \
            https://api.github.com/repos/xuxinhang/fpga-toolchain-build/releases \
            -d '{"tag_name":"'$release_tag'"}'
    fi

    release_upload_url=$(curl -s \
        -H "$http_header_accept" -H "$http_header_token" \
        $URL_PREFIX/releases/tags/$release_tag | \
        jq -r '.upload_url')

    release_upload_url="${release_upload_url%\{*}"

    file_list=$2

    for file_name in $file_list
    do
        echo "Uploading $file_name"
        curl -H "$http_header_accept" -H "$http_header_token" \
            -X POST --data-binary @$file_name -H "Content-Type: application/zip" \
            "$release_upload_url?name=$(basename $file_name)&label=$(basename $file_name)"
    done
}


release_tag="BUILD_DATE_$(date -u +"%Y%m%d")"

for TOOL_NAME in ${BUILD_TOOLS[*]}
do
    upload_release_asset $release_tag "$(ls `pwd`/$TOOL_NAME/{_package/*.*,_choco/*.nupkg})"
done


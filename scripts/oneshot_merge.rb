require 'json'

# もらったデータをマージするための怪しいスクリプト
# 抜け漏れは発生する（がめんどくさいのでいったんこんな感じで...）

data = JSON.parse(File.read('./scripts/merge_data/damlog_provided.json'))

pay = {}
data.keys.each do |point|
  data[point].each do |k, v|
    next if Time.at(k.to_i / 1000) >= Time.utc(2020, 07, 01, 14, 0) # 7月1日14時(UTC)以降は既存スクリプトで取得しているため
    pay[k] ||= []
    pay[k].push(v)
  end
end

pay.each do |k, v|
  next if v.size != 14 # フルで揃っているかチェック 更新時間がずれたものを弾く これはなんというかマージにあたっての折衷案みたいなもの
  filename = Time.at(k.to_i / 1000).utc.strftime('%Y-%m-%d-%H%M%S_added.json')
  File.open('./jsons/' + filename, 'w') do |writer|
    writer << v.to_json
  end
end

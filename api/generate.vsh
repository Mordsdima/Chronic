import superernd.cn
import encoding.base64

println('Hello; This is tool for generating a private token key')
println('Here your RANDOM key (DONT SHARE IT):')
println(base64.encode(cn.generate_random(32)))

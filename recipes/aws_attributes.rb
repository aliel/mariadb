#
# Galera default confirguration for aws opsworks
#

# get current instance info
aws_instance = search(:aws_opsworks_instance, "self:true").first

layer_id = aws_instance['layer_ids'][0]

layer = search(:aws_opsworks_layer, "layer_id:#{layer_id}").first

cluster_nodes = search(:aws_opsworks_instance, "layer_ids:#{layer_id}").map { |name, attrs|
  { :name => name['hostname'], :fqdn => name['hostname']}
}
  
node.default['mariadb']['galera']['cluster_nodes'] = cluster_nodes


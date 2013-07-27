# Model the root level Vagrant config object
#
# @see http://docs.vagrantup.com/v2/vagrantfile/index.html
class ConfigBuilder::Model::Root < ConfigBuilder::Model::Base

  include ConfigBuilder::ModelDelegator

  def_model_delegator :host
  def_model_delegator :ssh
  def_model_delegator :vms

  def to_proc
    Proc.new do |root_config|
      eval_models(root_config)
    end
  end

  private

  def eval_vms(root_config)
    @vms.each do |hash|
      v = ConfigBuilder::Model::VM.new_from_hash(hash)
      v.call(root_config)
    end
  end

  def eval_host(root_config)

  end

  def eval_ssh(root_config)

  end
end
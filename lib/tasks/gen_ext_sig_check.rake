# frozen_string_literal: true

namespace :gen_ext_sig_check do
  SIGNAL_ARRAY = ['AI', 'AO', 'AO*', 'DI', 'LO', 'LO*', 'LO+', 'LO220', 'RO', 'DO'].freeze

  desc 'check hw_peds vs hw_iosignals'
  task :check, [:project] => [:environment] do |_task, args|
    project = args[:project].to_i
    hw_peds = if project > 0
                HwPed.where(Project: project)
              else
                HwPed.all
              end
    hw_peds.each do |hw_ped|
      SIGNAL_ARRAY.each do |sig_name|
        sig_id = HwIosignaldef.where(ioname: sig_name).first.id
        hw_iosignals = HwIosignal.where(pedID: hw_ped.id, signID: sig_id).order(:id).to_a
        if hw_ped[sig_name] != hw_iosignals.size
          puts "ped: #{hw_ped['ped']}, signal: #{sig_name}, Np: #{hw_ped[sig_name]}, Nio: #{hw_iosignals.size} ,Proj: #{hw_ped['Project']}"
        end
      end
    end
  end

  task :fix, [:project] => [:environment] do |_task, args|
    project = args[:project].to_i
    hw_peds = if project > 0
                HwPed.where(Project: project)
              else
                HwPed.all
              end
    hw_peds.each do |hw_ped|
      SIGNAL_ARRAY.each do |sig_name|
        sig_id = HwIosignaldef.where(ioname: sig_name).first.id
        hw_iosignals = HwIosignal.where(pedID: hw_ped.id, signID: sig_id).order(:id).to_a
        icnt = hw_ped[sig_name] - hw_iosignals.size
        icnt = 0 if hw_ped[sig_name] < 0
        if icnt > 0
          while icnt > 0
            hw_iosignal = HwIosignal.new
            hw_iosignal.Project = hw_ped.Project
            hw_iosignal.pedID = hw_ped.id
            hw_iosignal.signID = sig_id
            hw_iosignal.skip_check_ped
            hw_iosignal.save
            icnt -= 1
          end
        elsif icnt < 0
          while icnt < 0
            hw_iosignal = HwIosignal.where(pedID: hw_ped.id, signID: sig_id).order(:id).last
            hw_iosignal.skip_check_ped
            hw_iosignal.destroy
            icnt += 1
          end
        end
      end
    end
  end
end

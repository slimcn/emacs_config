(defun ror-spec-model (model-name instance-name)
  "rspec model: 类名 单实例名 "
  (interactive "s类名(大写): \ns实例名(单数): ")
  (insert "require 'spec_helper'\ninclude SpecModelNS\n\ndescribe " model-name)
         (save-excursion
           (insert " do\n")
           (insert "  it \"can be instantiated\" do\n")
           (insert "    " model-name ".new.should be_an_instance_of(" model-name ")\n")
           (insert "  end\n")
           (insert "\n")
           (insert "  it \"can not be saved null successfully\" do\n")
           (insert "    " model-name ".create.should_not be_persisted\n")
           (insert "  end\n")
           (insert "\n")
           (insert "  before(:all) do\n")
           (insert "    @rec = Factory.create(:" instance-name ")\n")
           (insert "  end\n")
           (insert "  after(:all) do\n")
           (insert "    @rec.destroy\n")
           (insert "  end\n")
           (insert "\n")
           (insert "  [:col].each do |col|\n")
           (insert "    it \"not blank: #{col.to_s}\" do\n")
           (insert "      rec_err = SpecModelNS::set_presence " model-name ", col, @rec\n")
           (insert "      rec_err.errors[col].first.should eql(VALIDATE_MESSAGE[:presence])\n")
           (insert "    end\n")
           (insert "  end\n")
           (insert "\n")
           (insert "  [:col].each do |col|\n")
           (insert "    it \"uniqueness: #{col.to_s}\" do\n")
           (insert "      rec_err = SpecModelNS::set_uniqueness " model-name ", col, @rec\n")
           (insert "      rec_err.errors[col].first.should eql(VALIDATE_MESSAGE[:uniqueness])\n")
           (insert "    end\n")
           (insert "  end\n")
           (insert "end\n")))

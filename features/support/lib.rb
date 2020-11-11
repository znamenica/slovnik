module Spec
   def described_class
      kls = yield if block_given?
      @described_class = kls || @described_class
   end

   def is_expected
      expect(subject)
   end

   def subject
      Class === described_class ? described_class.new : described_class
   end
end

World(Spec)

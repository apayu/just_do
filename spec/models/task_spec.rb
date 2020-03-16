require "rails_helper"

RSpec.describe Task do
  # 常數
  # 關聯
  # 驗證
  # Scope
  # 類別方法
  # 實體方法

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe ".order_task" do
    it "order by created_at" do
      task1 = create(:task)
      task2 = create(:task)

      task = Task.order_task(:created_at, :desc)

      expect(task.first.name).to eq(task2.name)
    end
  end

end

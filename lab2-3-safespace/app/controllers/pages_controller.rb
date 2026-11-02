class PagesController < ApplicationController
  MESSAGES_FILE = Rails.root.join("messages.txt")

  # GET / - landing page with links to every section
  def home
    @sections = [
      { title: "What Is", icon: "bi-info-circle", text: "Understand domestic and gender-based violence and the warning signs.", path: what_is_path },
      { title: "Law Enforcement", icon: "bi-bank", text: "Malaysian laws that protect victims.", path: law_path },
      { title: "Enforcer", icon: "bi-shield-check", text: "Agencies that act on reports and protect victims.", path: enforcer_path },
      { title: "Hotline", icon: "bi-telephone", text: "Emergency and support numbers you can call now.", path: hotline_path },
      { title: "Contact", icon: "bi-envelope", text: "Send us a message or reach a support organisation.", path: contact_path }
    ]
  end

  def what_is; end
  def law; end
  def enforcer; end
  def contact; end
  def safety_check; end

  # GET /hotline - data kept in the controller, displayed by the view
  def hotline
    @hotlines = [
      { name: "Police / Emergency (MERS 999)", number: "999", desc: "Immediate danger, 24 hours" },
      { name: "Talian Kasih (KPWKM)", number: "15999", desc: "Government helpline, 24 hours" },
      { name: "Talian Kasih WhatsApp", number: "019-261 5999", desc: "Chat support" },
      { name: "Women's Aid Organisation (WAO)", number: "03-3000 8858", desc: "Domestic violence hotline" },
      { name: "WAO TINA (SMS / WhatsApp)", number: "018-988 8058", desc: "Text-based support" },
      { name: "Befrienders KL", number: "03-7627 2929", desc: "Emotional support, 24 hours" }
    ]
  end

  # POST /contact - validate the form and save the message to messages.txt
  def send_message
    name    = params[:name].to_s.strip
    email   = params[:email].to_s.strip
    message = params[:message].to_s.strip

    if name.empty? || email.empty? || message.empty?
      flash[:error] = "Please fill in all fields."
    elsif !email.match?(URI::MailTo::EMAIL_REGEXP)
      flash[:error] = "Please enter a valid email address."
    else
      File.open(MESSAGES_FILE, "a") do |f|
        f.puts "#{Time.now.strftime('%Y-%m-%d %H:%M')}|#{name}|#{email}|#{message.gsub(/\s+/, ' ')}"
      end
      flash[:notice] = "Thank you, #{name}. Your message has been received."
    end

    redirect_to contact_path
  end
end

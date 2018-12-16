namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "Configurando o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
    show_spinner("Apagando DB...") do %x(rails db:drop:_unsafe) end
    show_spinner("Criando DB...") do %x(rails db:create) end
    show_spinner("Migrando DB...") do %x(rails db:migrate) end
    show_spinner("Adicionando Administrador Default...") do %x(rails dev:add_default_admin) end
    show_spinner("Adicionando Usuário Default...") do %x(rails dev:add_default_user) end
  else
    puts "Você não está em ambiente de desenvolvimento."
  end
end

  desc "Adicionando Administrador padrão"
  task add_default_admin: :environment do

    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    );

  end


      desc "Adicionando Usuário padrão"
      task add_default_user: :environment do
      
        Admin.create!(
          email: 'user@user.com',
          password: DEFAULT_PASSWORD,
          password_confirmation: DEFAULT_PASSWORD
        );

      end


  private
        
  def show_spinner(msgstart, msgend = "Concluido com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msgstart}")
    spinner.auto_spin 
    yield
    spinner.success("(#{msgend})")
  end
end
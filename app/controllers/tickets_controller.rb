class TicketsController < ApplicationController

    get '/tickets' do
        if Helpers.is_logged_in?(session)
            @tickets = Ticket.all
            erb :'/tickets/tickets'
        else
            redirect to '/login'
        end
    end

    get '/tickets/new' do
        if Helpers.is_logged_in?(session)
            erb :'/tickets/new'
        else
            redirect to '/login'
        end
    end

    post '/tickets' do
        if params[:title].empty?
            redirect to '/tickets/new'
        else
            ticket = Ticket.new 
            ticket.title = params[:title]
            ticket.date = params[:date]
            ticket.artist = params[:artist]
            ticket.user = Helpers.current_user(session)
            ticket.save
            redirect to "/tickets/#{ticket.id}" 
        end
    end

    get '/tickets/:id/edit' do
        # binding.pry
        if Helpers.is_logged_in?(session) && Helpers.current_user(session) == Ticket.find(params[:id]).user
            @ticket = Ticket.find(params[:id]) 
            erb :'/tickets/edit'
        else
            redirect to '/login'
        end
    end

    patch '/tickets/:id' do
        if !params[:title].empty?
            ticket = Ticket.find(params[:id]) 
            ticket.title = params[:title] 
            ticket.date = params[:date]
            ticket.artist = params[:artist] 
            ticket.user = Helpers.current_user(session)
            ticket.save
            redirect to "/tickets/#{ticket.id}"
        else
            redirect to "/tickets/#{params[:id]}/edit" 
        end
    end

    get '/tickets/:id' do 
        if Helpers.is_logged_in?(session)
            @ticket = Ticket.find(params[:id])
            erb :'/tickets/show'
        else
            redirect to '/login'
        end
    end

    delete '/tickets/:id' do 
        if Helpers.current_user(session) == Ticket.find(params[:id]).user 
            Ticket.delete(params[:id])
            redirect to "/"
        else
            redirect to "/tickets/#{params[:id]}/edit"
        end
    end
end 
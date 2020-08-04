class TicketsController < ApplicationController

    get '/tickets' do
        if Helpers.is_logged_in?(session)
            @tickets = Helpers.current_user(session).tickets 
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
        # binding.pry 
        ticket = Ticket.new(title: params[:title], date: params[:date], artist: params[:artist],
        user_id: Helpers.current_user(session).id)
        if ticket.save
            redirect to "/tickets/#{ticket.id}"
        else
            redirect to '/tickets/new'
            # ticket.title = params[:title]
            # ticket.date = params[:date]
            # ticket.artist = params[:artist]
            # ticket.user = Helpers.current_user(session)
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
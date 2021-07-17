class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do

    @figure = Figure.create(name: params[:figure][:name])

    if !params[:figure][:title_ids].nil?
      params[:figure][:title_ids].each do |title|
        @figure.titles << Title.find(title)
      end
    end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end

    if !params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids].each do |landmark|
        @figure.landmarks << Landmark.find(landmark)
      end
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  patch '/figures/:id' do

    @figure = Figure.find(params[:id])

    @figure.name = params[:figure][:name]

    if !params[:figure][:title_ids].nil?
      params[:figure][:title_ids].each do |title|
        @figure.titles << Title.find(title)
      end
    end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end

    if !params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids].each do |landmark|
        @figure.landmarks << Landmark.find(landmark)
      end
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    @figure.save

    redirect "/figures/#{@figure.id}"
  end

end

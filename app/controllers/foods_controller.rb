class FoodsController < ApplicationController
    before_action :set_food, only: %i[show edit update destroy]
  
    # GET /foods or /foods.json
    def index
      @foods = Food.all
    end
  
    # GET /foods/1 or /foods/1.json
    def show; end
  
    # GET /foods/new
    def new
      @food = Food.new
    end
  
    # GET /foods/1/edit
    def edit; end
    
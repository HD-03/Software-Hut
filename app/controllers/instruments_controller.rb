class InstrumentsController < ApplicationController
    def new
      @instrument = Instrument.new
    end

    def create
        @instrument = Instrument.new(instrument_params)
        if @instrument.save
            redirect_to admin_dashboard_path, notice: 'Instrument added successfully.'
        else
            render :new
        end
    end

    private

    def instrument_params
        params.require(:instrument).permit(:name)
    end
end
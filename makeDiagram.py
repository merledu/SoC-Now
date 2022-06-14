import json
from PIL import Image, ImageDraw, ImageColor, ImageFont
def makeDiagram():
    f = open('SoC-Now-Generator/src/main/scala/config.json')
    data = json.load(f)
    f.close()
    ext = []
    device= []
    bus= ""
    x = 2500
    y = 1070

    font = ImageFont.truetype("ubuntu/Ubuntu-L.ttf", 85)
    font2 = ImageFont.truetype("ubuntu/Ubuntu-L.ttf", 38)
    font3= ImageFont.truetype("ubuntu/Ubuntu-L.ttf", 28)

    for i in range(len(data)):
        if list(data.values())[i] == 1 and i< 4:
            ext.append(list(data.keys())[i])
        if list(data.values())[i] == 1 and i>= 4 and i<10:
            device.append(list(data.keys())[i])
        if list(data.values())[i] == 1 and i>= 10:
            if list(data.keys())[i] == "tl":
                bus = "tilelink"
            else:
                bus = "wishbone"

    # im = Image.new('RGB', (x, y),(0,0,0))
    im = Image.new('RGBA', (x, y), (0, 0, 0, 0))


    draw = ImageDraw.Draw(im)
    # draw.rounded_rectangle((60,60, 2440,1010), fill=(255, 0, 0, 0), outline=(255, 255, 2            55),width=5, radius=20)
    draw.rectangle((950,150,150,950),fill=(0, 0, 0, 0),outline=(0,0,0),width=5)
    draw.text((300, 400), "Core" , font = font, align ="left")

    str = ""
    for i in ext:
        str +=i

    draw.text((300, 500), "RV32-"+str , font = font, align ="left")
    if len(device) >= 5:
        x1=1180
        x2=1350
        y1=240
        y2=90

        a =950
        b =210
        c =x1
        d =165
        val = a+60

        for i in device:
            draw.rectangle((x1,y1,x2,y2),fill=(0, 0, 0, 0),outline=(0,0,0),width=5)
            if i == "spi_flash":
                draw.text((x1+30, y2+40), "SPI-" , font = font2, align ="right")
                draw.text((x1+30, y2+85), "FLASH" , font = font2, align ="right")
            else:
                draw.text((x1+30, y2+55), i.upper() , font = font2, align ="right")

            draw.rectangle((a,b,c,d),fill=(0, 0, 0, 0),outline=(0,0,0),width=5)
            draw.text((val, d+4), bus.capitalize() , font = font3, align ="right") 

            x2 += 190
            x1 = x2-160

            val +=60
            c = x1
            d = y2 +195
            b = d+45
            
            y2 += 150
            y1 = (y2+150)

    elif len(device) == 4:
        x1=1330
        x2=1530
        y1=290 
        y2=90 

        a =950
        b =210
        c =x1
        d =165
        val = a+120

        for i in device:
            draw.rectangle((x1,y1,x2,y2),fill=(0, 0, 0, 0),outline=(0,0,0),width=5)
            if i == "spi_flash":
                draw.text((x1+60, y2+50), "SPI" , font = font2, align ="right")
                draw.text((x1+60, y2+105), "FLASH" , font = font2, align ="right")
            else:
                draw.text((x1+50, y2+85), i.upper() , font = font2, align ="right")

            draw.rectangle((a,b,c,d),fill=(0, 0, 0, 0),outline=(225,225,225),width=5)
            draw.text((val, d+4), bus.capitalize() , font = font3, align ="right") 

            x2 += 280
            x1 = x2-200

            val +=120
            c = x1
            d = y2 +325
            b = d+45
            
            y2 += 200
            y1 = (y2+200)
        
    else:
        x1=1280 
        x2=1540 
        y1=340 
        y2=90 

        a =950
        b =210
        c =x1
        d =165
        val = a+140

        for i in device:
            draw.rectangle((x1,y1,x2,y2),fill=(0, 0, 0, 0),outline=(0,0,0),width=3)
            if i == "spi_flash":
                draw.text((x1+60, y2+50), "SPI" , font = font2, align ="right")
                draw.text((x1+60, y2+105), "FLASH" , font = font2, align ="right")
            else:
                draw.text((x1+50, y2+85), i.upper() , font = font2, align ="right")

            draw.rectangle((a,b,c,d),fill=(0, 0, 0, 0),outline=(0,0,0),width=3)
            draw.text((val, d+4), bus.capitalize() , font = font3, align ="right") 

            x2 += 280
            x1 = x2-250

            val +=140
            c = x1
            d = y2 +325
            b = d+45
            
            y2 += 250
            y1 = (y2+250)
            
    im.save('static/img/diagram.png', quality=95)

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9280124F2A1
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 08:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgHXGiN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 02:38:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34269 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHXGiN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 02:38:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so7497024wrw.1;
        Sun, 23 Aug 2020 23:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VYlUOue9weg8rDgB4bx9HK1Y20q59ca+iyWSSQFRXYI=;
        b=VxyCZz/ldN3JRupiVAt+a0AG/oMnR57uzAkH3KBz5mnf9e8urLJES3Etd6R1rX8RW7
         tmP6iXBRKqGNxhPIw1RObPmrlQf65QLvMzBgzhc1w4sMK5pdS0iEutu8Og99uqW5gvvN
         nA0yTh3jwPa2KuaxhT3+JLPCDjBp2pQXJpDwfYEhFfYqPug9tqfO4KRzFmqO1hP1xssf
         B29dOgAmXtZ6w7XnZQJQTchstYtpcZt21ZOQpu1XKnWZurPKtc+jz5hhYyqDzfggMsYd
         SQqRa09FyjVyrRIdj7+A2kH+XCVXzm8HWlZbXibfeP8gUVa13eOpn/thTFOA9ye2ROHi
         aQHw==
X-Gm-Message-State: AOAM533gxNAIRoRz09oAoouHF/JsHnCGTtXeWOyIuwcqeEN8jEQrEEX1
        df6Xoy2gTDEjWhHmqZqCmBc=
X-Google-Smtp-Source: ABdhPJzG3N510Tf3V6Srikm+MUxu5X19cpEEmIR9h3dkveK++/7ys8cBoVMBBR1Rfun7Ww4TZ4WnsQ==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr4571409wro.164.1598251090024;
        Sun, 23 Aug 2020 23:38:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id 126sm22956165wme.42.2020.08.23.23.38.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Aug 2020 23:38:09 -0700 (PDT)
Date:   Mon, 24 Aug 2020 08:38:06 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: Re: [PATCH 02/22] dt-bindings: gpio: fsl-imx-gpio: Add gpio-ranges
 property
Message-ID: <20200824063806.GA2497@kozik-lap>
References: <20200823161550.3981-1-krzk@kernel.org>
 <20200823161550.3981-2-krzk@kernel.org>
 <20200824052446.GE13023@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824052446.GE13023@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 07:24:46AM +0200, Sascha Hauer wrote:
> On Sun, Aug 23, 2020 at 06:15:30PM +0200, Krzysztof Kozlowski wrote:
> > The GPIO controller node can have gpio-ranges property.  This fixes
> > dtbs_check warnings like:
> > 
> >   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000: 'gpio-ranges' does not match any of the regexes: 'pinctrl-[0-9]+'
> >     From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/gpio/fsl-imx-gpio.yaml    | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > index 454db20c2d1a..1fac69573bb9 100644
> > --- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > @@ -51,6 +51,9 @@ properties:
> >  
> >    gpio-controller: true
> >  
> > +  gpio-ranges:
> > +    maxItems: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -62,6 +65,18 @@ required:
> >  
> >  additionalProperties: false
> >  
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx8mp-gpio
> > +    then:
> > +      properties:
> > +        gpio-ranges:
> > +          minItems: 1
> > +          maxItems: 2
> 
> Why do you limit this to fsl,imx8mp-gpio? The i.MX5,6,7 dtsi files use
> gpio-ranges as well and other i.MX dtsi files could also use it.

All other cases use maximum one element in gpio-ranges, so they are
covered so I assumed they are continuous. But if it not the case, I can
make all them maximum 2.

Best regards,
Krzysztof


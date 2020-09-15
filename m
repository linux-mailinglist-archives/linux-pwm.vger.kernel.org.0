Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670EC269AB0
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Sep 2020 02:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgIOAus (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Sep 2020 20:50:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34559 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgIOAum (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Sep 2020 20:50:42 -0400
Received: by mail-io1-f68.google.com with SMTP id m17so2247512ioo.1;
        Mon, 14 Sep 2020 17:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=numAVrZHb/8qHZ8ZB/q47ZsqxyQJj3mtvFr+S2iyq1s=;
        b=ARCOKiCUBscvfFvDQW7E5C3sAcZM2KgjH2EktKnfNWdwu2scLAmpcXAxTIg+IEBN3C
         8K33S9Z+1+H9IctOEOeuZdpSF/Jk2F9RBERiFKsl1I6+0pSqzpSKnZsxZvmWxIGSvZyJ
         Iey3i4kDaAhMnP+L9J5cFbp4eKj42gPwGW77FhHpCEDZkaq6zGG7dA7JW6wE96/DRqr+
         B2Wq6l6JGHDCH5DUk+PwCJ9nYQS+htUsI3p0gCheuDWX1xFue6DkcbEoSPfCPD9VLA8M
         vnV1lfLxOrnZHpZgOKJPN5hFdJpPRoc0Ng1/8EwZAzKn6QX7IfCkUc1570AUDhwvOdGy
         9f9g==
X-Gm-Message-State: AOAM533fEsMTlQ/Tn6sQVOMQ2/47wHlWAgRD3D809oER51B6IcamUnmY
        4fjlwBslut41nr8+09GtfBYXQFi58EG6
X-Google-Smtp-Source: ABdhPJzkrOQ/Tj7bU50E5bkevBB2M2BB4OOXNmNinYGgnhVgF/+j7fw6h1GCd5QDyj11FlbJwqaGpw==
X-Received: by 2002:a02:a305:: with SMTP id q5mr15660693jai.121.1600131041000;
        Mon, 14 Sep 2020 17:50:41 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s85sm8227021ilk.35.2020.09.14.17.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 17:50:40 -0700 (PDT)
Received: (nullmailer pid 604109 invoked by uid 1000);
        Tue, 15 Sep 2020 00:50:34 -0000
Date:   Mon, 14 Sep 2020 18:50:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 02/10] dt-bindings: mfd: Add binding for Netronix's
 embedded controller
Message-ID: <20200915005034.GA593718@bogus>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-3-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905133230.1014581-3-j.neuschaefer@gmx.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Sep 05, 2020 at 03:32:22PM +0200, Jonathan Neuschäfer wrote:
> This EC is found in e-book readers of multiple brands (e.g. Kobo,
> Tolino), and is typically implemented as a TI MSP430 microcontroller.
> 
> It controls different functions of the system, such as power on/off,
> RTC, PWM for the backlight. The exact functionality provided can vary
> between boards.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> v2:
> - Add the plaintext DT binding for comparison
> 
> 
> For reference, here is the binding in text form:
> 
>   Netronix Embedded Controller
> 
>   This EC is found in e-book readers of multiple brands (e.g. Kobo, Tolino), and
>   is typically implemented as a TI MSP430 microcontroller.
> 
> 
>   Required properties:
>   - compatible: should be "netronix,ntxec"
>   - reg: The I2C address of the EC
> 
>   Optional properties:
>   - system-power-controller:
>     See Documentation/devicetree/bindings/power/power-controller.txt
>   - interrupts or interrupts-extended
>   - interrupt-controller
>   - #interrupt-cells: Should be 1
> 
>   Optional subnodes:
> 
>   Sub-nodes are identified by their compatible string.
> 
>    compatible string              | description
>   --------------------------------|--------------------------------------
>    netronix,ntxec-pwm             | PWM (used for backlight)
>    netronix,ntxec-rtc             | real time clock
> 
> 
>   Example:
> 
>   &i2c3 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_i2c3>;
>   	status = "okay";
> 
>   	ec: embedded-controller@43 {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pinctrl_ntxec>;
> 
>   		compatible = "netronix,ntxec";
>   		reg = <0x43>;
>   		system-power-controller;
>   		interrupt-parent = <&gpio4>;
>   		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
>   		interrupt-controller;
>   		#interrupt-cells = <1>;
> 
>   		pwm {
>   			compatible = "netronix,ntxec-pwm";
>   			#pwm-cells = <2>;
>   		};
> 
>   		rtc {
>   			compatible = "netronix,ntxec-rtc";
>   			interrupts-extended = <&ec 15>;
>   			interrupt-names = "alarm";
>   		};
>   	};
>   };
> ---
>  .../bindings/mfd/netronix,ntxec.yaml          | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> new file mode 100644
> index 0000000000000..596df460f98eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/netronix,ntxec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Netronix Embedded Controller
> +
> +maintainers:
> +  - Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> +
> +description: |
> +  This EC is found in e-book readers of multiple brands (e.g. Kobo, Tolino), and
> +  is typically implemented as a TI MSP430 microcontroller.
> +
> +
> +properties:
> +  compatible:
> +    const: netronix,ntxec
> +
> +  reg:
> +    items:
> +      - description: The I2C address of the EC
> +
> +  system-power-controller:
> +    type: boolean
> +    description: See Documentation/devicetree/bindings/power/power-controller.txt
> +
> +  interrupts:
> +    minItems: 1
> +    description:
> +      The EC can signal interrupts via a GPIO line
> +
> +required:
> +  - compatible
> +  - reg

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ec: embedded-controller@43 {
> +                    pinctrl-names = "default";
> +                    pinctrl-0 = <&pinctrl_ntxec>;
> +
> +                    compatible = "netronix,ntxec";
> +                    reg = <0x43>;
> +                    system-power-controller;
> +                    interrupt-parent = <&gpio4>;
> +                    interrupts = <11 IRQ_TYPE_EDGE_FALLING>;

> +                    interrupt-controller;
> +                    #interrupt-cells = <1>;

These need to be documented too.

> +            };
> +    };
> --
> 2.28.0
> 

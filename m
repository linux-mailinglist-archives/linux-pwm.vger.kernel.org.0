Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E24269AC3
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Sep 2020 02:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgIOAyu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Sep 2020 20:54:50 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44787 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgIOAys (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Sep 2020 20:54:48 -0400
Received: by mail-il1-f194.google.com with SMTP id h11so1370281ilj.11;
        Mon, 14 Sep 2020 17:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Uu60TNaJ5WiZEoTUp5Pm6cAzGAGF09qo0+Sx8E6CGrY=;
        b=heY3zxtdOgIrU3wtNWBxZBeB1J8d2iZkZJ4HjX0hiFBQ0bi51R99c/BjHWK5/ABfBI
         zuRGHnQB38T+4pP6w3hwYlAbpYpUw79FOxS9I+NmvmUqDo8epzhrHkeDbLRNOf2oGi4u
         2VpRyTDzr5XWyOBPD+Ux1UMMHaVJLvdO7WOb0kMqYFSXF+KrjIYSHFoWKHVCi0Qu6rEq
         ctnjFSGlqxCo6n6Ows9SdFeudVluC4p6MktQZl5++Yo8f7f3autCWwqVL/rX0ZfHDm+X
         GlGFVLTePhkgY+7Xcs+mBAUgCizZEVIA5JZTF3o2b9WrqMs7lqvSlS/cp3ZYxUqmRb5w
         IfDQ==
X-Gm-Message-State: AOAM532cTTgxjAq8xU12B4f/CnpwxVpihi38TPeaxEf428Tdqq718k6c
        1P/fMuzR5N64G5npqYOWvw==
X-Google-Smtp-Source: ABdhPJxMkfxz3ko4AaV3oT3oSGOSwswpuwFqnR3S7izCYKAmLPhb3acF+Wxp67/e7JcOa5Neo9oUbw==
X-Received: by 2002:a92:9fcc:: with SMTP id z73mr7796328ilk.234.1600131286742;
        Mon, 14 Sep 2020 17:54:46 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y10sm6805351ioy.25.2020.09.14.17.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 17:54:45 -0700 (PDT)
Received: (nullmailer pid 610633 invoked by uid 1000);
        Tue, 15 Sep 2020 00:54:43 -0000
Date:   Mon, 14 Sep 2020 18:54:43 -0600
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
Subject: Re: [PATCH v2 04/10] dt-bindings: pwm: Add bindings for PWM function
 in Netronix EC
Message-ID: <20200915005443.GA604385@bogus>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-5-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905133230.1014581-5-j.neuschaefer@gmx.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Sep 05, 2020 at 03:32:24PM +0200, Jonathan Neuschäfer wrote:
> The Netronix embedded controller as found in Kobo Aura and Tolino Shine
> supports one PWM channel, which is used to control the frontlight
> brightness on these devices.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v2:
> - Add plaintext binding to patch description, for comparison
> - Fix pwm-cells property (should be 2, not 1)
> - Add dummy regulator to example, because the pwm-backlight binding requires a
>   power supply
> 
> 
> For reference, here is the binding in text form:
> 
> 
>   PWM functionality in Netronix Embedded Controller
> 
>   Required properties:
>   - compatible: should be "netronix,ntxec-pwm"
>   - #pwm-cells: should be 2.
> 
>   Available PWM channels:
>   - 0: The PWM channel controlled by registers 0xa1-0xa7
> 
>   Example:
> 
>   	embedded-controller@43 {
>   		compatible = "netronix,ntxec";
>   		...
> 
>   		ec_pwm: pwm {
>   			compatible = "netronix,ntxec-pwm";
>   			#pwm-cells = <1>;
>   		};
>   	};
> 
>   	...
> 
>   	backlight {
>   		compatible = "pwm-backlight";
>   		pwms = <&ec_pwm 0 50000>;
>   	};
> ---
>  .../bindings/mfd/netronix,ntxec.yaml          | 19 +++++++++++
>  .../bindings/pwm/netronix,ntxec-pwm.yaml      | 33 +++++++++++++++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> index 596df460f98eb..73c873dda3e70 100644
> --- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> @@ -31,6 +31,9 @@ properties:
>      description:
>        The EC can signal interrupts via a GPIO line
> 
> +  pwm:
> +    $ref: ../pwm/netronix,ntxec-pwm.yaml
> +
>  required:
>    - compatible
>    - reg
> @@ -53,5 +56,21 @@ examples:
>                      interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
>                      interrupt-controller;
>                      #interrupt-cells = <1>;
> +
> +                    ec_pwm: pwm {
> +                            compatible = "netronix,ntxec-pwm";
> +                            #pwm-cells = <2>;
> +                    };
>              };
>      };
> +
> +    backlight {
> +            compatible = "pwm-backlight";
> +            pwms = <&ec_pwm 0 50000>;
> +            power-supply = <&backlight_regulator>;
> +    };
> +
> +    backlight_regulator: regulator-dummy {
> +            compatible = "regulator-fixed";
> +            regulator-name = "backlight";
> +    };
> diff --git a/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
> new file mode 100644
> index 0000000000000..0c9d2801b8de1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/netronix,ntxec-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM functionality in Netronix embedded controller
> +
> +maintainers:
> +  - Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> +
> +description: |
> +  See also Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> +
> +  The Netronix EC contains PWM functionality, which is usually used to drive
> +  the backlight LED.
> +
> +  The following PWM channels are supported:
> +    - 0: The PWM channel controlled by registers 0xa1-0xa7
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: netronix,ntxec-pwm
> +
> +  "#pwm-cells":
> +    const: 2

Just move this to the parent and make the parent a pwm provider. There's 
no need for child nodes for this or the rtc.

Rob

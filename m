Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9848638BB73
	for <lists+linux-pwm@lfdr.de>; Fri, 21 May 2021 03:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbhEUBVl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 May 2021 21:21:41 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:37628 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbhEUBVk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 May 2021 21:21:40 -0400
Received: by mail-ot1-f44.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so16607488otp.4;
        Thu, 20 May 2021 18:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L8yBjYQAgys656MK8UvpdfNfI8yFhToVlmHgAetNSy4=;
        b=Yk27UfrnX26WZ1G5byKd7VhaPj+8W2NQbwhc7uRuBQHm3E9/SW9JQL8HyS/zzopvM7
         qhkb30T45UyKXUpjlPdoS2STEQctwt/QXvvgfI4+0TrXUM3am7eeqVBMuGC3fUwN5dq2
         vIiGaewAP3mGDJj1/hnJdgIRtsiH+EldfV7H3BmOQBivmnnSAUpzpxgIu2fRIXGJYTTL
         KtCLBWvXjRRaBTaM0hsQjIF3DgIojbJIWTgZV8RNo/6Dj8lkCXiYjbY9ukW1JZFWeMhv
         7IYQOyh5IQ+/Yos3d7YGJJfBhgc4QVyD2ghLJ6sIDMANccQBOPoJiMY9zOX8wNUVJ04B
         9XNg==
X-Gm-Message-State: AOAM533HtHug4OgrlkEYb1Ckkm8ttag1Z2ozqT2Izzfvf7NkwbMFEvRW
        Q/tDwbwjCKoab8AOtGJdbg==
X-Google-Smtp-Source: ABdhPJwloniGyDrtyyk8GwSUBgwJrVccusdGH8bFeLm/IkJVIgSlu1dAYGnYt1qlN/bRKbEy1r88CA==
X-Received: by 2002:a9d:721e:: with SMTP id u30mr6028225otj.250.1621560017968;
        Thu, 20 May 2021 18:20:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v19sm1000293otq.35.2021.05.20.18.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:20:17 -0700 (PDT)
Received: (nullmailer pid 2424374 invoked by uid 1000);
        Fri, 21 May 2021 01:20:16 -0000
Date:   Thu, 20 May 2021 20:20:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        mkorpershoek@baylibre.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pwm: pwm-mtk-disp: convert to YAML
 schema
Message-ID: <20210521012016.GA2421079@robh.at.kernel.org>
References: <20210518175422.2678665-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518175422.2678665-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, May 18, 2021 at 07:54:19PM +0200, Fabien Parent wrote:
> Convert the dt-binding documentation for pwm-mtk-disp to YAML.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 44 ----------
>  .../devicetree/bindings/pwm/pwm-mtk-disp.yaml | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> deleted file mode 100644
> index 902b271891ae..000000000000
> --- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -MediaTek display PWM controller
> -
> -Required properties:
> - - compatible: should be "mediatek,<name>-disp-pwm":
> -   - "mediatek,mt2701-disp-pwm": found on mt2701 SoC.
> -   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
> -   - "mediatek,mt8167-disp-pwm", "mediatek,mt8173-disp-pwm": found on mt8167 SoC.
> -   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
> - - reg: physical base address and length of the controller's registers.
> - - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
> -   the cell format.
> - - clocks: phandle and clock specifier of the PWM reference clock.
> - - clock-names: must contain the following:
> -   - "main": clock used to generate PWM signals.
> -   - "mm": sync signals from the modules of mmsys.
> - - pinctrl-names: Must contain a "default" entry.
> - - pinctrl-0: One property must exist for each entry in pinctrl-names.
> -   See pinctrl/pinctrl-bindings.txt for details of the property values.
> -
> -Example:
> -	pwm0: pwm@1401e000 {
> -		compatible = "mediatek,mt8173-disp-pwm",
> -			     "mediatek,mt6595-disp-pwm";
> -		reg = <0 0x1401e000 0 0x1000>;
> -		#pwm-cells = <2>;
> -		clocks = <&mmsys CLK_MM_DISP_PWM026M>,
> -			 <&mmsys CLK_MM_DISP_PWM0MM>;
> -		clock-names = "main", "mm";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&disp_pwm0_pins>;
> -	};
> -
> -	backlight_lcd: backlight_lcd {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm0 0 1000000>;
> -		brightness-levels = <
> -			  0  16  32  48  64  80  96 112
> -			128 144 160 176 192 208 224 240
> -			255
> -		>;
> -		default-brightness-level = <9>;
> -		power-supply = <&mt6397_vio18_reg>;
> -		enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
> -	};
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
> new file mode 100644
> index 000000000000..0f016c81cd53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pwm/pwm-mtk-disp.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek display PWM controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Lee Jones <lee.jones@linaro.org>
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-disp-pwm
> +          - mediatek,mt6595-disp-pwm
> +          - mediatek,mt8173-disp-pwm
> +      - items:
> +          - const: mediatek,mt8167-disp-pwm
> +          - const: mediatek,mt8173-disp-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock used to generate PWM signals
> +      - description: sync signal from the mmsys module
> +
> +  clock-names:
> +    items:
> +      - const: main
> +      - const: mm
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  power-domains:
> +    description:
> +      List of phandles and PM domain specifiers, as defined by bindings of the
> +      PM domain provider (see also ../power_domain.txt).

Don't need to define what the common property is. You need to say how 
many.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    pwm0: pwm@1401e000 {
> +      compatible = "mediatek,mt8173-disp-pwm";
> +      reg = <0x1401e000 0x1000>;
> +      #pwm-cells = <2>;
> +      clocks = <&mmsys CLK_MM_DISP_PWM026M>,
> +               <&mmsys CLK_MM_DISP_PWM0MM>;
> +      clock-names = "main", "mm";
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&disp_pwm0_pins>;
> +    };
> +
> +    backlight_lcd: backlight_lcd {
> +      compatible = "pwm-backlight";
> +      pwms = <&pwm0 0 1000000>;
> +      brightness-levels = <
> +        0  16  32  48  64  80  96 112
> +        128 144 160 176 192 208 224 240
> +        255
> +      >;
> +      default-brightness-level = <9>;
> +      power-supply = <&mt6397_vio18_reg>;
> +      enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
> +    };
> -- 
> 2.31.1
> 

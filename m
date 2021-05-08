Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D537729C
	for <lists+linux-pwm@lfdr.de>; Sat,  8 May 2021 17:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhEHP1Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 May 2021 11:27:25 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:43619 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhEHP1X (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 May 2021 11:27:23 -0400
Received: by mail-oo1-f46.google.com with SMTP id p6-20020a4adc060000b02901f9a8fc324fso2595698oov.10;
        Sat, 08 May 2021 08:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJuzoZjZ+35ZvoZz1WXKKIkFjYgYLeq2LztuwL/J6dY=;
        b=E6oFEdxi83hpQPDPDyqmY0Tqp/jrX5eCFmX87NuKwj3whEQLA5ReqSXp2xP3Q8fcJv
         7u207jsbOhm30jEqifitM/AfCMSnDkX4Md+WX8sHZKNBkyzG16nlql4bYgtR55/6wuFt
         Pbl0+dqMKu2fNhVBlPlhc0vxvYIXdw943CCMf/MQ1geuLQ89jQOeDX6vBm4s90w2shGq
         0qKpEMHF/er3NdyhPmeIymWL+Zk7KlLXH/sNi1ZmJZM9/PC/+EaUR/qQUjaQT+0wbNuO
         ypINNYefVy1SWZopzfIR8u8ogGoKMBT9MYYmSQGpwGUSBKTmANbjxuIjES49xgOWdQRS
         DNeQ==
X-Gm-Message-State: AOAM530wV45so9TRh/p32cFjfr3iFzG+02Owy+Sl3GNjtVrtwJ9pdIpx
        4TPc5RN63EE41t19DonyGQ==
X-Google-Smtp-Source: ABdhPJy+XsVTuzV3ooxkmcD3lo3jcZgydV/5UpiGSCAtMz4wvPNZ10X+WiV0VbrIdmwafHTnLt43Sw==
X-Received: by 2002:a4a:250e:: with SMTP id g14mr12148349ooa.31.1620487581441;
        Sat, 08 May 2021 08:26:21 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x65sm529593otb.59.2021.05.08.08.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 08:26:20 -0700 (PDT)
Received: (nullmailer pid 445043 invoked by uid 1000);
        Sat, 08 May 2021 15:26:18 -0000
Date:   Sat, 8 May 2021 10:26:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: timer: renesas,tpu: Convert to
 json-schema
Message-ID: <20210508152618.GA3004584@robh.at.kernel.org>
References: <cover.1620375445.git.geert+renesas@glider.be>
 <29c1e39d396b0060213379264747ecf30d4c7ca8.1620375445.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29c1e39d396b0060213379264747ecf30d4c7ca8.1620375445.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 07, 2021 at 10:25:13AM +0200, Geert Uytterhoeven wrote:
> Convert the Renesas H8/300 Timer Pulse Unit Device Tree binding
> documentation to json-schema.
> 
> Correct clock-names, as "peripheral_clk" is the name of the supplier,
> and all users use "fck".
> 
> Note that there are two different bindings for the TPU, both using
> "renesas,tpu": this one for using the TPU as a clock source (used on
> H8/300), and a second use for using the TPU as a PWM controller (used on
> ARM).  To avoid conflicts, both bindings are marked with the appropriate
> "select" logic, to check for the absence respectively presence of the
> "#pwm-cells" property.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> I have listed Sato-san as the maintainer, as he wrote the original
> driver and bindings.
> Sato-san: Please scream if this is inappropriate ;-)
> ---
>  .../bindings/pwm/renesas,tpu-pwm.yaml         | 10 ++++
>  .../devicetree/bindings/timer/renesas,tpu.txt | 21 -------
>  .../bindings/timer/renesas,tpu.yaml           | 56 +++++++++++++++++++
>  3 files changed, 66 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> index 3a072ee29815c695..f8bc8c5905daa14c 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> @@ -9,6 +9,16 @@ title: Renesas R-Car Timer Pulse Unit PWM Controller
>  maintainers:
>    - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>  
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: renesas,tpu
> +    '#pwm-cells': true

You can drop this line. The schema is still true if not present which is 
why 'required' is needed.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +  required:
> +    - compatible
> +    - '#pwm-cells'
> +
>  properties:
>    compatible:
>      items:
> diff --git a/Documentation/devicetree/bindings/timer/renesas,tpu.txt b/Documentation/devicetree/bindings/timer/renesas,tpu.txt
> deleted file mode 100644
> index 1d46f9de4feb8a84..0000000000000000
> --- a/Documentation/devicetree/bindings/timer/renesas,tpu.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -* Renesas H8/300 Timer Pulse Unit
> -
> -The TPU is a 16bit timer/counter with configurable clock inputs and
> -programmable compare match.
> -This implementation support only cascade mode.
> -
> -Required Properties:
> -
> -  - compatible: must contain "renesas,tpu"
> -  - reg: base address and length of the registers block in 2 channel.
> -  - clocks: a list of phandle, one for each entry in clock-names.
> -  - clock-names: must contain "peripheral_clk" for the functional clock.
> -
> -
> -Example:
> -	tpu: tpu@ffffe0 {
> -		compatible = "renesas,tpu";
> -		reg = <0xffffe0 16>, <0xfffff0 12>;
> -		clocks = <&pclk>;
> -		clock-names = "peripheral_clk";
> -	};
> diff --git a/Documentation/devicetree/bindings/timer/renesas,tpu.yaml b/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
> new file mode 100644
> index 0000000000000000..01554dff23d8a954
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/renesas,tpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas H8/300 Timer Pulse Unit
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +description:
> +  The TPU is a 16bit timer/counter with configurable clock inputs and
> +  programmable compare match.
> +  This implementation supports only cascade mode.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: renesas,tpu
> +    '#pwm-cells': false
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    const: renesas,tpu
> +
> +  reg:
> +    items:
> +      - description: First channel
> +      - description: Second channel
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: fck
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
> +    tpu: tpu@ffffe0 {
> +            compatible = "renesas,tpu";
> +            reg = <0xffffe0 16>, <0xfffff0 12>;
> +            clocks = <&pclk>;
> +            clock-names = "fck";
> +    };
> -- 
> 2.25.1
> 

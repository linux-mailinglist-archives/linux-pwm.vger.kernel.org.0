Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569D1262157
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Sep 2020 22:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgIHUsk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Sep 2020 16:48:40 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41391 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgIHUsj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Sep 2020 16:48:39 -0400
Received: by mail-il1-f195.google.com with SMTP id w8so233215ilj.8;
        Tue, 08 Sep 2020 13:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L9u+1Lk2Z2W+mvjM22ziguVUQXZzuFNOokZobOUqdHY=;
        b=s6Zm8lCgqbSkr1cUk2P0gc0vKcX4344bGRUSq6BYZdelIdHrFDnEg1MCUTOLu9gHr2
         dZ2GYc8n9fpFkXuVw8X8OlZRi2fNuRm32UUs6RwQC1TDff0pNxzkddk2vjINcMnlG+PN
         wfq+T2Ul9Ml6O8k1OCucFxf7k01gFAQ8om7I6u0hASQZiO0vsie6tGMq66xGWjU/hDa9
         FDtGW92GVD0YUuIF5875NXVAIvSAS99jVL8LlsL7k60IYlzlVvjDLeIKyQzP8rPVpzqw
         y2gzdL7q/5grZcksU+9YTey1NDLqO6Nl+068BW3PvMHt77DTGTiZ2YHTTrs4Ej77GDb8
         ZDdw==
X-Gm-Message-State: AOAM533nHV0k2Vwo0l+oi8LTlPNU1OfYGKOJTyfNIrrJPV82nANJ1t9z
        nMTGSxuMr+WCCULZ8AI6xQ==
X-Google-Smtp-Source: ABdhPJzo2UJov8PXXJW5aMJngdajRHVncAYkVsO/Xj9gWLtftWvWC98MARoq/mot6KY+pWdHIRsPnA==
X-Received: by 2002:a05:6e02:ef1:: with SMTP id j17mr574189ilk.211.1599598118339;
        Tue, 08 Sep 2020 13:48:38 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id u18sm135827iln.78.2020.09.08.13.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:48:37 -0700 (PDT)
Received: (nullmailer pid 892637 invoked by uid 1000);
        Tue, 08 Sep 2020 20:48:34 -0000
Date:   Tue, 8 Sep 2020 14:48:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: microchip: atmel,at91rm9200-tcb: add
 atmel,tcb-pwm
Message-ID: <20200908204834.GA886652@bogus>
References: <20200820225546.2246517-1-alexandre.belloni@bootlin.com>
 <20200820225546.2246517-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820225546.2246517-2-alexandre.belloni@bootlin.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 21, 2020 at 12:55:43AM +0200, Alexandre Belloni wrote:
> Move the TCB pwm nodes under their parent and move its documentation to the
> main file.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> 
>  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt | 16 ----------
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 31 ++++++++++++++++++-
>  2 files changed, 30 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> deleted file mode 100644
> index 985fcc65f8c4..000000000000
> --- a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -Atmel TCB PWM controller
> -
> -Required properties:
> -- compatible: should be "atmel,tcb-pwm"
> -- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
> -  the cells format. The only third cell flag supported by this binding is
> -  PWM_POLARITY_INVERTED.
> -- tc-block: The Timer Counter block to use as a PWM chip.

What happened to 'tc-block'? Commit message should mention why it is 
gone.

> -
> -Example:
> -
> -pwm {
> -	compatible = "atmel,tcb-pwm";
> -	#pwm-cells = <3>;
> -	tc-block = <1>;
> -};
> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> index 55fffae05dcf..a51adfdb58f6 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> @@ -59,6 +59,7 @@ patternProperties:
>          items:
>            - enum:
>                - atmel,tcb-timer
> +              - atmel,tcb-pwm
>                - microchip,tcb-capture
>        reg:
>          description:
> @@ -68,11 +69,33 @@ patternProperties:
>  
>          minItems: 1
>          maxItems: 3
> +    required:
> +      - compatible
> +      - reg
> +
> +  "^pwm@[0-2]$":
> +    description: The timer block channels that are used as PWMs.
> +    $ref: ../../pwm/pwm.yaml#
> +    type: object
> +    properties:
> +      compatible:
> +        const: atmel,tcb-pwm
> +      reg:
> +        description:
> +          TCB channel to use for this PWM.

enum: [ 0, 1, 2 ]

> +
> +        maxItems: 1
> +      "#pwm-cells":
> +        description:
> +          The only third cell flag supported by this binding is
> +          PWM_POLARITY_INVERTED.
> +        const: 3
>  
>      required:
>        - compatible
>        - reg

       additionalProperties: false

>  
> +
>  allOf:
>    - if:
>        properties:
> @@ -158,7 +181,13 @@ examples:
>                          compatible = "atmel,tcb-timer";
>                          reg = <1>;
>                  };
> -        };
> +
> +                pwm@2 {
> +                        compatible = "atmel,tcb-pwm";
> +                        reg = <2>;
> +                        #pwm-cells = <3>;
> +                };
> +         };
>      /* TCB0 Capture with QDEC: */
>          timer@f800c000 {
>                  compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> -- 
> 2.26.2
> 

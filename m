Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0684CFFE4
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Mar 2022 14:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242147AbiCGNX6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Mar 2022 08:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242834AbiCGNXv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2022 08:23:51 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A997633A02
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 05:22:57 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 070583F5F5
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646659374;
        bh=7DE3CIcjsEOWGArllLnE/4SYWb481DICc4ujcmpZMCo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qm+Ekp9lZ35eZu0+bBAhi69fjghFEq1qnIGAFjikuazpTS61JKz5uIARAdt2fhT8V
         M4MlNscRL+flKEgXOddb2v4UJWw9zxLxObamn/BkVt5QUQVcg9h7Gy3itpkD6T8/7B
         uf2M+OwpE0gWPtt1y7RyJ4i1nVuHWdS1GS9lnVR4Yr2822X4oXi3JO6dDq8mWrpNCc
         KIdTINIcyu+hd76D3HA0oVCC+CguTHAm1UkDAW4AhQhw2S095hNiz2V4MH3/yYvBFp
         T9HGSrhWnn4UYSCWQ6S1ysHAmhwB3sZ9l6N9sYYA+StXL6ylS4PCtMQ+BmeXrSvTEY
         ZW3gOt//f9yUw==
Received: by mail-ed1-f69.google.com with SMTP id r8-20020aa7d588000000b00416438ed9a2so2139669edq.11
        for <linux-pwm@vger.kernel.org>; Mon, 07 Mar 2022 05:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7DE3CIcjsEOWGArllLnE/4SYWb481DICc4ujcmpZMCo=;
        b=x9kG6GDaRGBRJfogP65JZSkEJFUrx+upA2duMskoQiiXs3v7xTYGF9ri7yS35RlLfh
         dpRtQRGDTMiSXGMxGrTpEIlEc1/YtiQZrBDaa29iC6yXeO8CtY/Ir0G/doXjr5KdWV/T
         r3gexuwrz9vNWceHxVsHC41IHJ5zne5RxTYq0W+7iiu4AZ+3O12Pzo1SUNwQHi+9SUv1
         wn493NRM6JHc5yhPhKrE3gTvRZLQoLNvK6V4mLUqIwiCzx7LMzCKHP0r6T/r0zZOxXlz
         dtSpMIrxuymwQJxhfoc2V73zJd/9vQZ28u4ipIbsb7oG0H3tIrQF9J4gGK0f2YB2Fegs
         cQOw==
X-Gm-Message-State: AOAM532x0zDcuGG8+7Ggkfdr2Xhk3wGl/bSOApIW4Z3MVfBjXXxIoom8
        cAUP2YOYLrKshCYBjQDSyQqe3mgpJByN94t0g8I7NZQmBIl1Y22L3EAelLkgKE0zKtjQWDQNA4i
        vXCfznmVfDkP9rXZSQTHOcys9iRenBL4Bf8HC4g==
X-Received: by 2002:aa7:cfd2:0:b0:416:b04:bb60 with SMTP id r18-20020aa7cfd2000000b004160b04bb60mr10963256edy.76.1646659373615;
        Mon, 07 Mar 2022 05:22:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXxXeGEOYJaGgvq6dvSvl0b5LmE61OYrDSUPzwb/dvNqBwiKbTp6gV0bV0ZRCQ+AuRolvpWQ==
X-Received: by 2002:aa7:cfd2:0:b0:416:b04:bb60 with SMTP id r18-20020aa7cfd2000000b004160b04bb60mr10963234edy.76.1646659373332;
        Mon, 07 Mar 2022 05:22:53 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id h17-20020a05640250d100b004162ee0a7aesm2785236edb.38.2022.03.07.05.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:22:52 -0800 (PST)
Message-ID: <9e565eba-7678-1399-3cae-5335dc026e2c@canonical.com>
Date:   Mon, 7 Mar 2022 14:22:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: pwm: convert atmel pwm to json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>,
        claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220307130307.106102-1-sergiu.moga@microchip.com>
 <20220307130307.106102-2-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307130307.106102-2-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 07/03/2022 14:03, Sergiu Moga wrote:
> Convert PWM binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 -----------
>  .../devicetree/bindings/pwm/atmel-pwm.yaml    | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
> deleted file mode 100644
> index fbb5325be1f0..000000000000
> --- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt

I would prefer for new files to switch to common DT conversion:
vendor,name.yaml

You have there another PWM bindings for Atmel, so the name should not be
just "pwm" but something more specific, maybe "at91sam-pwm"?

> +++ /dev/null
> @@ -1,35 +0,0 @@
> -Atmel PWM controller
> -
> -Required properties:
> -  - compatible: should be one of:
> -    - "atmel,at91sam9rl-pwm"
> -    - "atmel,sama5d3-pwm"
> -    - "atmel,sama5d2-pwm"
> -    - "microchip,sam9x60-pwm"
> -  - reg: physical base address and length of the controller's registers
> -  - #pwm-cells: Should be 3. See pwm.yaml in this directory for a
> -    description of the cells format.
> -
> -Example:
> -
> -	pwm0: pwm@f8034000 {
> -		compatible = "atmel,at91sam9rl-pwm";
> -		reg = <0xf8034000 0x400>;
> -		#pwm-cells = <3>;
> -	};
> -
> -	pwmleds {
> -		compatible = "pwm-leds";
> -
> -		d1 {
> -			label = "d1";
> -			pwms = <&pwm0 3 5000 0>
> -			max-brightness = <255>;
> -		};
> -
> -		d2 {
> -			label = "d2";
> -			pwms = <&pwm0 1 5000 1>
> -			max-brightness = <255>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel-pwm.yaml
> new file mode 100644
> index 000000000000..f5378a2226bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/atmel-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel PWM controller

title: Atmel/Microchip PWM controller

> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +

allOf including pwm.yaml

> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91sam9rl-pwm
> +      - atmel,sama5d3-pwm
> +      - atmel,sama5d2-pwm
> +      - microchip,sam9x60-pwm
> +
> +  reg:
> +    description: |
> +      Physical base address and length of the controller's
> +      registers

Skip description, it's obvious.

> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    description: |
> +      Should be 3. See pwm.yaml in this directory for a
> +      description of the cells format.

Skip description, it's obvious.

> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#pwm-cells"

Skip pwm-cells, required by pwm.yaml.

> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +        pwm0: pwm@f8034000 {
> +                compatible = "atmel,at91sam9rl-pwm";
> +                reg = <0xf8034000 0x400>;
> +                #pwm-cells = <3>;
> +        };
> +
> +        pwmleds {

Skip this node. No actual benefit. All clients are the same.

> +                compatible = "pwm-leds";
> +
> +                led-1 {
> +                        label = "led-1";
> +                        pwms = <&pwm0 3 5000 0>;
> +                        max-brightness = <255>;
> +                };
> +
> +                led-2 {
> +                        label = "led-2";
> +                        pwms = <&pwm0 1 5000 1>;
> +                        max-brightness = <255>;
> +                };
> +        };


Best regards,
Krzysztof

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0552B223C
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2019 16:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfIMOg1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Sep 2019 10:36:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35841 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbfIMOg1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Sep 2019 10:36:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id k20so2820547oih.3;
        Fri, 13 Sep 2019 07:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+gFzsRCMB/S5/2NImCatrFU6mHejOO77M/5QHXhL2CE=;
        b=jrutpeE7+krC7rUouqgACbAycUGqck/gLe1i/gMID+BhQg83ZN4ZkEPa7P3D6EtL6M
         gmH67GqOwwnqDzyFlXm+cPWwAjviUzNxc2CoNPu1bs83Hn7pM72kKigGBG0rbahgFyzW
         eu3oq2Pzj9nDoebdu6GSVRvkxIG8jeA4Ep53yfOJ3aaL8a5S+OhQEDwBhMPEBUFOoXk3
         fFgEXp4JaOy2eY3CKBmW5aU4eVN75854bQz2fkepNthqKKxUuJ4LN9epJpK/cxEoRECO
         RPojgTRJiJl/34f5ej0wj6bWks2giWZCn2Lu5It+t3CpbCbZ/6SU2dbYC1i9Qe0s+pJI
         FiBg==
X-Gm-Message-State: APjAAAWJ7NZLfmw3nzvPw/0ARfma9GNCFoqhWbZaitspuLL/ocFkPRRh
        3jFcaSpzaQMiCIZzkDTTNQ==
X-Google-Smtp-Source: APXvYqzDJcu7XMQwyfdu88xRNFK5/eDi+cajXRPFFVqk0IhjM9XwyTsN3OWNGDYIZvHiX+LnZBRMuw==
X-Received: by 2002:a05:6808:8e3:: with SMTP id d3mr3373504oic.153.1568385385768;
        Fri, 13 Sep 2019 07:36:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o19sm841989oic.26.2019.09.13.07.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:25 -0700 (PDT)
Date:   Fri, 13 Sep 2019 15:36:24 +0100
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maciej Falkowski <m.falkowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] dt-bindings: pwm: Convert Samsung PWM bindings
 to json-schema
Message-ID: <20190912175001.GA29884@bogus>
References: <20190909183436.9045-1-krzk@kernel.org>
 <20190909183436.9045-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909183436.9045-2-krzk@kernel.org>
X-Mutt-References: <20190909183436.9045-2-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 09, 2019 at 08:34:36PM +0200, Krzysztof Kozlowski wrote:
> Convert Samsung PWM (S3C, S5P and Exynos SoCs) bindings to DT schema
> format using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/pwm/pwm-samsung.txt   |  51 --------
>  .../devicetree/bindings/pwm/pwm-samsung.yaml  | 111 ++++++++++++++++++
>  2 files changed, 111 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml


> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> new file mode 100644
> index 000000000000..90fb467bcdd5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-samsung.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC PWM timers
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +description: |+
> +  Samsung SoCs contain PWM timer blocks which can be used for system clock source
> +  and clock event timers, as well as to drive SoC outputs with PWM signal. Each
> +  PWM timer block provides 5 PWM channels (not all of them can drive physical
> +  outputs - see SoC and board manual).
> +
> +  Be aware that the clocksource driver supports only uniprocessor systems.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s3c2410-pwm             # 16-bit, S3C24xx
> +      - samsung,s3c6400-pwm             # 32-bit, S3C64xx
> +      - samsung,s5p6440-pwm             # 32-bit, S5P64x0
> +      - samsung,s5pc100-pwm             # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
> +      - samsung,exynos4210-pwm          # 32-bit, Exynos
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    description: |
> +      Should contain all following required clock names:
> +      - "timers" - PWM base clock used to generate PWM signals,
> +      and any subset of following optional clock names:
> +      - "pwm-tclk0" - first external PWM clock source,
> +      - "pwm-tclk1" - second external PWM clock source.
> +      Note that not all IP variants allow using all external clock sources.
> +      Refer to SoC documentation to learn which clock source configurations
> +      are available.
> +    oneOf:
> +      - items:
> +        - const: "timers"
> +      - items:
> +        - const: "timers"
> +        - const: "pwm-tclk0"
> +      - items:
> +        - const: "timers"
> +        - const: "pwm-tclk1"
> +      - items:
> +        - const: "timers"
> +        - const: "pwm-tclk0"
> +        - const: "pwm-tclk1"
> +
> +  interrupts:
> +    description:
> +      One interrupt per timer, starting at timer 0.
> +    minItems: 1
> +    maxItems: 5
> +
> +  "#pwm-cells":
> +    description:
> +      The only third cell flag supported by this binding
> +      is PWM_POLARITY_INVERTED.
> +    const: 3
> +
> +  samsung,pwm-outputs:
> +    description:
> +      A list of PWM channels used as PWM outputs on particular platform.
> +      It is an array of up to 5 elements being indices of PWM channels
> +      (from 0 to 4), the order does not matter.
> +    # TODO: Values should not repeat

uniqueItems: true

Though it looks like we have to enable that keyword. (As silently 
ignoring unknown keywords (such as typos) is 'feature' of json-schema, 
we explicitly list keywords we use.)

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      # FIXME: min/max limit of items does not work
> +      - items:
> +          minItems: 1
> +          maxItems: 5
> +      - items:
> +          minimum: 0
> +          maximum: 4

I think you want:

minItems: 1
maxItems: 2
items:
  minimum: 0
  maximum: 4

> +
> +required:
> +  - clocks
> +  - clock-names
> +  - compatible
> +  - interrupts
> +  - "#pwm-cells"
> +  - reg
> +
> +examples:
> +  - |
> +    pwm@7f006000 {
> +      compatible = "samsung,s3c6400-pwm";
> +      reg = <0x7f006000 0x1000>;
> +      interrupt-parent = <&vic0>;
> +      interrupts = <23>, <24>, <25>, <27>, <28>;
> +      clocks = <&clock 67>;
> +      clock-names = "timers";
> +      samsung,pwm-outputs = <0>, <1>;
> +      #pwm-cells = <3>;
> +    };
> -- 
> 2.17.1
> 


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D15B8B9471
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2019 17:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404387AbfITPvF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Sep 2019 11:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404366AbfITPvE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 20 Sep 2019 11:51:04 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A256421835;
        Fri, 20 Sep 2019 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568994662;
        bh=Gk8b96/zmrgvgnCdppmwZEWWClB9i1dZv17q7MLhgfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OZM0VO15KguCMz8L73yAu9wwfmIvWTtRKsRWtXbjJFKVXMMLe2p8bfBQAQkCKcL2U
         ZC9RtUZrL5eJL0Hk2B8lfXus6Mb7THpBP0h7NAF9u+kkBEJeVMK5UCXfPgFFwcMQVI
         OoR623SUjj3mRa2R4ehGSSj+mTawpcia4HoOgbSk=
Received: by mail-qt1-f181.google.com with SMTP id c3so9160727qtv.10;
        Fri, 20 Sep 2019 08:51:02 -0700 (PDT)
X-Gm-Message-State: APjAAAWXGvSPhFcDMnd4THmP6ll6O7mP+E75eYS4Kj3lHCTLtyL1HRen
        yl9J2Wb3SIHdR9DwrylD1o3W5auVUWbsxSkq9g==
X-Google-Smtp-Source: APXvYqwMIrqIhbU+PH2zwmKFyZZ7p9gmNZDVfDvJtsMY/FngbKyrGtmiBbkzWBc5h/SVux0vE5Rh9MaGgWH9K6YJIV0=
X-Received: by 2002:ac8:444f:: with SMTP id m15mr4046894qtn.110.1568994661811;
 Fri, 20 Sep 2019 08:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190918173141.4314-1-krzk@kernel.org> <20190918173141.4314-8-krzk@kernel.org>
In-Reply-To: <20190918173141.4314-8-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 Sep 2019 10:50:50 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+0ikCageBv3TSwx0tp=ZDkrFwpFVt2gJHWsFe2f-K2pA@mail.gmail.com>
Message-ID: <CAL_Jsq+0ikCageBv3TSwx0tp=ZDkrFwpFVt2gJHWsFe2f-K2pA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] dt-bindings: pwm: Convert Samsung PWM bindings to json-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 18, 2019 at 12:32 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Convert Samsung PWM (S3C, S5P and Exynos SoCs) bindings to DT schema
> format using json-schema.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Indent example with four spaces (more readable),
> 2. Fix samsung,pwm-outputs after review,
> 3. Remove double-quotes from clock names.
> ---
>  .../devicetree/bindings/pwm/pwm-samsung.txt   |  51 ---------
>  .../devicetree/bindings/pwm/pwm-samsung.yaml  | 107 ++++++++++++++++++
>  2 files changed, 107 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> deleted file mode 100644
> index 5538de9c2007..000000000000
> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -* Samsung PWM timers
> -
> -Samsung SoCs contain PWM timer blocks which can be used for system clock source
> -and clock event timers, as well as to drive SoC outputs with PWM signal. Each
> -PWM timer block provides 5 PWM channels (not all of them can drive physical
> -outputs - see SoC and board manual).
> -
> -Be aware that the clocksource driver supports only uniprocessor systems.
> -
> -Required properties:
> -- compatible : should be one of following:
> -    samsung,s3c2410-pwm - for 16-bit timers present on S3C24xx SoCs
> -    samsung,s3c6400-pwm - for 32-bit timers present on S3C64xx SoCs
> -    samsung,s5p6440-pwm - for 32-bit timers present on S5P64x0 SoCs
> -    samsung,s5pc100-pwm - for 32-bit timers present on S5PC100, S5PV210,
> -                         Exynos4210 rev0 SoCs
> -    samsung,exynos4210-pwm - for 32-bit timers present on Exynos4210,
> -                          Exynos4x12, Exynos5250 and Exynos5420 SoCs
> -- reg: base address and size of register area
> -- interrupts: list of timer interrupts (one interrupt per timer, starting at
> -  timer 0)
> -- clock-names: should contain all following required clock names:
> -    - "timers" - PWM base clock used to generate PWM signals,
> -  and any subset of following optional clock names:
> -    - "pwm-tclk0" - first external PWM clock source,
> -    - "pwm-tclk1" - second external PWM clock source.
> -  Note that not all IP variants allow using all external clock sources.
> -  Refer to SoC documentation to learn which clock source configurations
> -  are available.
> -- clocks: should contain clock specifiers of all clocks, which input names
> -  have been specified in clock-names property, in same order.
> -- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
> -  the cells format. The only third cell flag supported by this binding is
> -  PWM_POLARITY_INVERTED.
> -
> -Optional properties:
> -- samsung,pwm-outputs: list of PWM channels used as PWM outputs on particular
> -    platform - an array of up to 5 elements being indices of PWM channels
> -    (from 0 to 4), the order does not matter.
> -
> -Example:
> -       pwm@7f006000 {
> -               compatible = "samsung,s3c6400-pwm";
> -               reg = <0x7f006000 0x1000>;
> -               interrupt-parent = <&vic0>;
> -               interrupts = <23>, <24>, <25>, <27>, <28>;
> -               clocks = <&clock 67>;
> -               clock-names = "timers";
> -               samsung,pwm-outputs = <0>, <1>;
> -               #pwm-cells = <3>;
> -       }
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> new file mode 100644
> index 000000000000..06d11faabff6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> @@ -0,0 +1,107 @@
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
> +        - const: timers
> +      - items:
> +        - const: timers
> +        - const: pwm-tclk0
> +      - items:
> +        - const: timers
> +        - const: pwm-tclk1
> +      - items:
> +        - const: timers
> +        - const: pwm-tclk0
> +        - const: pwm-tclk1
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
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - uniqueItems: true
> +      - items:
> +          minimum: 0
> +          maximum: 4
> +
> +required:
> +  - clocks
> +  - clock-names
> +  - compatible
> +  - interrupts
> +  - "#pwm-cells"
> +  - reg

additionalProperties: false

should work here. And in the rng binding too.

Rob

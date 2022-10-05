Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27A5F584B
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Oct 2022 18:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJEQcY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Oct 2022 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJEQcW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Oct 2022 12:32:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F2D50714
        for <linux-pwm@vger.kernel.org>; Wed,  5 Oct 2022 09:32:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m14so2160076ljg.2
        for <linux-pwm@vger.kernel.org>; Wed, 05 Oct 2022 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3R2HKzhAxoqn6hiWZE2OL4sMSIpfHzrT9gZcR8mlyU0=;
        b=KTBbow3QVkLZuh66UHbWJxEettCZ9PehOYjTlqNLCnUENM0S4aJqZ/Y1Tp0B3nAzCH
         tnrQB7Orz3924b39z7cntMdQ4NYFDAq+DHHobCsMyS6wnfHZuW0rNYFxqYa+/Iw2dkMK
         FICdUcuVW6pE3hxqNIUM2iu5fPZ7Xe6w694yZxPDtE7XI5ktbt7nja4yGfXhnVuEFwT5
         TtN2zGrbMJjzAcdGedKn7TqYVfnFyJA/KdNqAqOpQ/D2oztqWWaXU8x9kYm/mZF6qHJe
         OiPqwMDjrItMDXmA1E9rLL7U3xuzZwaFXsrjMdFAxqHkHF43vFyQsHiunZaWIbvWWBel
         atlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3R2HKzhAxoqn6hiWZE2OL4sMSIpfHzrT9gZcR8mlyU0=;
        b=smZXX6g4qEj0DiSg8UMyVFwknH3Gr1Pc2wHZisJqpZh1/8XWEFXRuoT6RbXieowjLt
         RNGJ/eJQ8nfpB4rIu1BKJQfcOXgdwqzRXfte1P9Ce3pjCwTdv6U5pOs6cPhU9924nBXc
         7A9Qtv+6z0gybQ0VRfVax5OMU3AlJT1+ZkzP2IT8bmiLqKeX9rJKmSoYRs/UOTnbKm/b
         9iFXq8wTi7GbmjQF8mzNhyFph7BLJVpKE1YT0PKalG856T46BBOcSHK+0KGjtBXaVf8f
         5hDH00nXVQUim5vhiolFdkVXtwCLIB/cwhutX/UOa4fwjuIi5wjSb9iaR6ToFwYX7PXu
         15Ow==
X-Gm-Message-State: ACrzQf1uuMO4eUpqa3PmM7fooB+Tk28bGUU7qG+J2SbLYhlV4imLoOJh
        eM5WJ7vS2S+NiZEMIl/MHalv6Q==
X-Google-Smtp-Source: AMsMyM4NT+WToY5xcjbbGP+eFoVfPiLF8pCT0EcZssPUtK7JjRYcCCbVjg6jYf5v9kLAbSnImBx91w==
X-Received: by 2002:a2e:9f17:0:b0:26c:43f6:fd9d with SMTP id u23-20020a2e9f17000000b0026c43f6fd9dmr175058ljk.176.1664987537470;
        Wed, 05 Oct 2022 09:32:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g22-20020a05651222d600b0048aa9d67483sm2385790lfu.160.2022.10.05.09.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:32:17 -0700 (PDT)
Message-ID: <ea77fa9d-d579-b517-7b47-e6765d1a3492@linaro.org>
Date:   Wed, 5 Oct 2022 18:32:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/3] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20221005135518.876913-1-biju.das.jz@bp.renesas.com>
 <20221005135518.876913-2-biju.das.jz@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005135518.876913-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 05/10/2022 15:55, Biju Das wrote:
> The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
> channels and one 32-bit timer channel. It supports the following
> functions
>  - Counter
>  - Timer
>  - PWM
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> RFC->v1:
>  * Modelled counter and pwm as a single device that handles
>    multiple channels.
>  * Moved counter and pwm bindings to respective subsystems
>  * Dropped 'bindings' from MFD binding title.
>  * Updated the example
>  * Changed the compatible names.

RFC is a v1. This is a v2.

> ---
>  .../counter/renesas,rz-mtu3-counter.yaml      |  30 ++
>  .../bindings/mfd/renesas,rz-mtu3.yaml         | 290 ++++++++++++++++++
>  .../bindings/pwm/renesas,rz-mtu3-pwm.yaml     |  50 +++
>  3 files changed, 370 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/renesas,rz-mtu3-counter.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/counter/renesas,rz-mtu3-counter.yaml b/Documentation/devicetree/bindings/counter/renesas,rz-mtu3-counter.yaml
> new file mode 100644
> index 000000000000..c8b86ef254b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/renesas,rz-mtu3-counter.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/counter/renesas,rz-mtu3-counter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L MTU3a Counter Module
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +description: |
> +  This module is part of the rz-mtu3 multi-function device. For more
> +  details see ../mfd/renesas,rz-mtu3.yaml.
> +
> +  There are two phase counting modes: 16-bit phase counting mode in which MTU1
> +  and MTU2 operate independently, and cascade connection 32-bit phase counting
> +  mode in which MTU1 and MTU2 are cascaded.
> +
> +  In phase counting mode, the phase difference between two external input clocks
> +  is detected and the corresponding TCNT is incremented or decremented.
> +
> +properties:
> +  compatible:
> +    const: renesas,rz-mtu3-counter
> +
> +required:
> +  - compatible

One property - compatible - does not deserve its own schema. Integrate
with the other one.

> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> new file mode 100644
> index 000000000000..0413d22704c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> @@ -0,0 +1,290 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/renesas,rz-mtu3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L Multi-Function Timer Pulse Unit 3 (MTU3a)
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +description: |
> +  This hardware block pconsisting of eight 16-bit timer channels and one
> +  32- bit timer channel. It supports the following specifications:
> +    - Pulse input/output: 28 lines max.
> +    - Pulse input 3 lines
> +    - Count clock 11 clocks for each channel (14 clocks for MTU0, 12 clocks
> +      for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2 combination
> +      (when LWA = 1))
> +    - Operating frequency Up to 100 MHz
> +    - Available operations [MTU0 to MTU4, MTU6, MTU7, and MTU8]
> +        - Waveform output on compare match
> +        - Input capture function (noise filter setting available)
> +        - Counter-clearing operation
> +        - Simultaneous writing to multiple timer counters (TCNT)
> +          (excluding MTU8).
> +        - Simultaneous clearing on compare match or input capture
> +          (excluding MTU8).
> +        - Simultaneous input and output to registers in synchronization with
> +          counter operations           (excluding MTU8).
> +        - Up to 12-phase PWM output in combination with synchronous operation
> +          (excluding MTU8)
> +    - [MTU0 MTU3, MTU4, MTU6, MTU7, and MTU8]
> +        - Buffer operation specifiable
> +    - [MTU1, MTU2]
> +        - Phase counting mode can be specified independently
> +        - 32-bit phase counting mode can be specified for interlocked operation
> +          of MTU1 and MTU2 (when TMDR3.LWA = 1)
> +        - Cascade connection operation available
> +    - [MTU3, MTU4, MTU6, and MTU7]
> +        - Through interlocked operation of MTU3/4 and MTU6/7, the positive and
> +          negative signals in six phases (12 phases in total) can be output in
> +          complementary PWM and reset-synchronized PWM operation.
> +        - In complementary PWM mode, values can be transferred from buffer
> +          registers to temporary registers at crests and troughs of the timer-
> +          counter values or when the buffer registers (TGRD registers in MTU4
> +          and MTU7) are written to.
> +        - Double-buffering selectable in complementary PWM mode.
> +    - [MTU3 and MTU4]
> +        - Through interlocking with MTU0, a mode for driving AC synchronous
> +          motors (brushless DC motors) by using complementary PWM output and
> +          reset-synchronized PWM output is settable and allows the selection
> +          of two types of waveform output (chopping or level).
> +    - [MTU5]
> +        - Capable of operation as a dead-time compensation counter.
> +    - [MTU0/MTU5, MTU1, MTU2, and MTU8]
> +        - 32-bit phase counting mode specifiable by combining MTU1 and MTU2 and
> +          through interlocked operation with MTU0/MTU5 and MTU8.
> +    - Interrupt-skipping function
> +        - In complementary PWM mode, interrupts on crests and troughs of counter
> +          values and triggers to start conversion by the A/D converter can be
> +          skipped.
> +    - Interrupt sources: 43 sources.
> +    - Buffer operation:
> +        - Automatic transfer of register data (transfer from the buffer
> +          register to the timer register).
> +    - Trigger generation
> +        - A/D converter start triggers can be generated
> +        - A/D converter start request delaying function enables A/D converter
> +          to be started with any desired timing and to be synchronized with
> +          PWM output.
> +    - Low power consumption function
> +        - The MTU3a can be placed in the module-stop state.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
> +          - renesas,r9a07g054-mtu3  # RZ/V2L
> +      - const: renesas,rz-mtu3
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: MTU0.TGRA input capture/compare match
> +      - description: MTU0.TGRB input capture/compare match
> +      - description: MTU0.TGRC input capture/compare match
> +      - description: MTU0.TGRD input capture/compare match
> +      - description: MTU0.TCNT overflow
> +      - description: MTU0.TGRE compare match
> +      - description: MTU0.TGRF compare match
> +      - description: MTU1.TGRA input capture/compare match
> +      - description: MTU1.TGRB input capture/compare match
> +      - description: MTU1.TCNT overflow
> +      - description: MTU1.TCNT underflow
> +      - description: MTU2.TGRA input capture/compare match
> +      - description: MTU2.TGRB input capture/compare match
> +      - description: MTU2.TCNT overflow
> +      - description: MTU2.TCNT underflow
> +      - description: MTU3.TGRA input capture/compare match
> +      - description: MTU3.TGRB input capture/compare match
> +      - description: MTU3.TGRC input capture/compare match
> +      - description: MTU3.TGRD input capture/compare match
> +      - description: MTU3.TCNT overflow
> +      - description: MTU4.TGRA input capture/compare match
> +      - description: MTU4.TGRB input capture/compare match
> +      - description: MTU4.TGRC input capture/compare match
> +      - description: MTU4.TGRD input capture/compare match
> +      - description: MTU4.TCNT overflow/underflow
> +      - description: MTU5.TGRU input capture/compare match
> +      - description: MTU5.TGRV input capture/compare match
> +      - description: MTU5.TGRW input capture/compare match
> +      - description: MTU6.TGRA input capture/compare match
> +      - description: MTU6.TGRB input capture/compare match
> +      - description: MTU6.TGRC input capture/compare match
> +      - description: MTU6.TGRD input capture/compare match
> +      - description: MTU6.TCNT overflow
> +      - description: MTU7.TGRA input capture/compare match
> +      - description: MTU7.TGRB input capture/compare match
> +      - description: MTU7.TGRC input capture/compare match
> +      - description: MTU7.TGRD input capture/compare match
> +      - description: MTU7.TCNT overflow/underflow
> +      - description: MTU8.TGRA input capture/compare match
> +      - description: MTU8.TGRB input capture/compare match
> +      - description: MTU8.TGRC input capture/compare match
> +      - description: MTU8.TGRD input capture/compare match
> +      - description: MTU8.TCNT overflow
> +      - description: MTU8.TCNT underflow
> +
> +  interrupt-names:
> +    items:
> +      - const: tgia0
> +      - const: tgib0
> +      - const: tgic0
> +      - const: tgid0
> +      - const: tgiv0
> +      - const: tgie0
> +      - const: tgif0
> +      - const: tgia1
> +      - const: tgib1
> +      - const: tgiv1
> +      - const: tgiu1
> +      - const: tgia2
> +      - const: tgib2
> +      - const: tgiv2
> +      - const: tgiu2
> +      - const: tgia3
> +      - const: tgib3
> +      - const: tgic3
> +      - const: tgid3
> +      - const: tgiv3
> +      - const: tgia4
> +      - const: tgib4
> +      - const: tgic4
> +      - const: tgid4
> +      - const: tgiv4
> +      - const: tgiu5
> +      - const: tgiv5
> +      - const: tgiw5
> +      - const: tgia6
> +      - const: tgib6
> +      - const: tgic6
> +      - const: tgid6
> +      - const: tgiv6
> +      - const: tgia7
> +      - const: tgib7
> +      - const: tgic7
> +      - const: tgid7
> +      - const: tgiv7
> +      - const: tgia8
> +      - const: tgib8
> +      - const: tgic8
> +      - const: tgid8
> +      - const: tgiv8
> +      - const: tgiu8
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

You still do not have children with unit addresses, so these are weird.
So again - why do you need this?

> +
> +  "counter":

No need for quotes.

> +    $ref: ../counter/renesas,rz-mtu3-counter.yaml

> +
> +  "pwm":

No need for quotes.

> +    $ref: ../pwm/renesas,rz-mtu3-pwm.yaml

Full path, so /schemas/pwm/...

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - power-domains
> +  - resets

Best regards,
Krzysztof


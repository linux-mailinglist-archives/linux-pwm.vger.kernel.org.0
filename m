Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519BC5F6ECC
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Oct 2022 22:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiJFUSm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Oct 2022 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiJFUSh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Oct 2022 16:18:37 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B30FC6978;
        Thu,  6 Oct 2022 13:18:35 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id m130so3306997oif.6;
        Thu, 06 Oct 2022 13:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGITWTCzMqrcIoj3OhQzb1u0QF9SpCGTljQONPczoMQ=;
        b=nfAn1ypJygNkNc0lhbJLasbpDpJQ7AJJ2uvERhTVOlFmHhIkJZD33u4U7y9ePBTS6C
         EsUuTPuBgbnpItWRO3zw1wQcPDcSq61FZwPiNtqVKJ408wEzcoW7PoQcUANTaqOzPd21
         /aFVtYzaYeNDT5D1aA9W8OGd4q21E7wKugjYnk9xs6v6/Fd5HGfiDo0R4qK9cVoD7+kk
         GtEFQzQRRWa3aTTXhCPGiBwTPPathXOGfz9LplRYCPzNc9YN/8xsWELE2IP6wDjIvyCZ
         RpIm/g/jMk3HuL76K/zBAcq9qpt16cBhr+SCVe2J/AA9cVQQ79vIRYUEc4EH58eUM22y
         eFXQ==
X-Gm-Message-State: ACrzQf24jsw5wsaMzkB3yxf11nbWWkj8LC5goAauI+ziW9iUfAzMHOuQ
        phIQC3eldkUrYeqx5w45TQ==
X-Google-Smtp-Source: AMsMyM63+vn1pLZ6SRFW8DAnP1nPMW3aOY3+l9R+eP7eQuhzrE+n++5Z+enLyi4m6SAG6rKBCRm9Ww==
X-Received: by 2002:a05:6808:ec3:b0:353:f1b2:ba91 with SMTP id q3-20020a0568080ec300b00353f1b2ba91mr5816685oiv.216.1665087514205;
        Thu, 06 Oct 2022 13:18:34 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id b8-20020a9d5d08000000b0063695ad0cbesm229851oti.66.2022.10.06.13.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:18:33 -0700 (PDT)
Received: (nullmailer pid 97656 invoked by uid 1000);
        Thu, 06 Oct 2022 20:17:46 -0000
Date:   Thu, 6 Oct 2022 15:17:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Message-ID: <20221006201746.GA93297-robh@kernel.org>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006135717.1748560-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 06, 2022 at 02:57:14PM +0100, Biju Das wrote:
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
> v2->v3:
>  * Dropped counter bindings and integrated with mfd as it has only one property.
>  * Removed "#address-cells" and "#size-cells" as it do not have children with
>    unit addresses.
>  * Removed quotes from counter and pwm.
>  * Provided full path for pwm bindings.
>  * Updated the example.
> v1->v2:
>  * Modelled counter and pwm as a single device that handles
>    multiple channels.
>  * Moved counter and pwm bindings to respective subsystems
>  * Dropped 'bindings' from MFD binding title.
>  * Updated the example
>  * Changed the compatible names.
> ---
>  .../bindings/mfd/renesas,rz-mtu3.yaml         | 304 ++++++++++++++++++
>  .../bindings/pwm/renesas,rz-mtu3-pwm.yaml     |  50 +++
>  2 files changed, 354 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> new file mode 100644
> index 000000000000..44c952ad8d35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> @@ -0,0 +1,304 @@
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
> +  counter:
> +    description:
> +      There are two phase counting modes. 16-bit phase counting mode in which
> +      MTU1 and MTU2 operate independently, and cascade connection 32-bit phase
> +      counting mode in which MTU1 and MTU2 are cascaded.
> +
> +      In phase counting mode, the phase difference between two external input
> +      clocks is detected and the corresponding TCNT is incremented or
> +      decremented.
> +      The below counters are supported
> +        count0 - MTU1 16-bit phase counting
> +        count1 - MTU2 16-bit phase counting
> +        count2 - MTU1+ MTU2 32-bit phase counting
> +
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: renesas,rz-mtu3-counter
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +  pwm:
> +    $ref: /schemas/pwm/renesas,rz-mtu3-pwm.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - power-domains
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mtu3: timer@10001200 {
> +      compatible = "renesas,r9a07g044-mtu3", "renesas,rz-mtu3";
> +      reg = <0x10001200 0xb00>;
> +      interrupts = <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 173 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 176 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 180 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 181 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 182 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 183 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 185 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 186 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 191 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 192 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 198 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 201 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 202 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 204 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 206 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 207 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 211 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
> +      interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0", "tgiv0", "tgie0",
> +                        "tgif0",
> +                        "tgia1", "tgib1", "tgiv1", "tgiu1",
> +                        "tgia2", "tgib2", "tgiv2", "tgiu2",
> +                        "tgia3", "tgib3", "tgic3", "tgid3", "tgiv3",
> +                        "tgia4", "tgib4", "tgic4", "tgid4", "tgiv4",
> +                        "tgiu5", "tgiv5", "tgiw5",
> +                        "tgia6", "tgib6", "tgic6", "tgid6", "tgiv6",
> +                        "tgia7", "tgib7", "tgic7", "tgid7", "tgiv7",
> +                        "tgia8", "tgib8", "tgic8", "tgid8", "tgiv8", "tgiu8";
> +      clocks = <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
> +      power-domains = <&cpg>;
> +      resets = <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
> +
> +      counter {
> +        compatible = "renesas,rz-mtu3-counter";

You don't have any resources for the counter in DT, so you don't even 
need a node here. Just have the parent driver instaniate the counter 
driver.

> +      };
> +
> +      pwm {
> +        compatible = "renesas,rz-mtu3-pwm";
> +        #pwm-cells = <2>;

Here too, just declaring a PWM provider. Just move this to the parent 
node.

Rob

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8485F8BC7
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Oct 2022 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJIOjb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 9 Oct 2022 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJIOjO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Oct 2022 10:39:14 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F7A2B265;
        Sun,  9 Oct 2022 07:39:12 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id m6so369294qkm.4;
        Sun, 09 Oct 2022 07:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ed4axrQyevm7lR2zPnWxL/zxhJeh0GkQpIUsqHkjCV4=;
        b=xAA8/NlSd7dv1XZlxL02+u5SBpgg8jxvt9henRGssz2s7a3Gj3LxiSJiXwaDTcadR8
         NvLjkgcspiCfycNuHaDlAL43C/T5R/0hsVzhmw4uN1TrqqN4cTVhqvY/bdB/iSMsycuO
         fEW+EjL9qL0AN1ASP8KdE3cQgGY2tT+JPH6k9P3DGLGvDyfbTCc0yUZCCTKfZgvbo03i
         byMXLfMeMiYnOznPZ0EMw2ufW9GqgVW9KUPvq0NfmE3OpwN97zu1JPZ1QLz94vVOyhXG
         GP4+mGKleDsy+7HjVKugAff1dxaFQDf7ZrMQkXtIBWK1Wu+7vH9MoXOdnO84qGATYYNJ
         AUtA==
X-Gm-Message-State: ACrzQf2cxwaa9exgX/b8qVwy1eno3EAA5tWopASpuJgp2kML9CElWF9G
        F1PKdDm+5NF5ivrvdCarqVyI8/ZiETspYw==
X-Google-Smtp-Source: AMsMyM52r/OMh+P/RCwuQuwRiVDpcjpomw9XK6LzzpXeVD3KYjzbebzBOkaHZerdCqPMCsWeuVFoqg==
X-Received: by 2002:a05:620a:4054:b0:6ec:5735:2e20 with SMTP id i20-20020a05620a405400b006ec57352e20mr1626938qko.321.1665326350975;
        Sun, 09 Oct 2022 07:39:10 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id dt39-20020a05620a47a700b006ec59941acasm1707649qkb.11.2022.10.09.07.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 07:39:10 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id e20so10604241ybh.2;
        Sun, 09 Oct 2022 07:39:10 -0700 (PDT)
X-Received: by 2002:a25:2d49:0:b0:6bf:87:706f with SMTP id s9-20020a252d49000000b006bf0087706fmr13257867ybe.202.1665326349796;
 Sun, 09 Oct 2022 07:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-2-biju.das.jz@bp.renesas.com> <20221006201746.GA93297-robh@kernel.org>
 <OS0PR01MB5922F8058FC8FD1E35C17755865F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59221BDEB7E6B39AEFD31C44865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59221BDEB7E6B39AEFD31C44865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 9 Oct 2022 16:38:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmT7+8ow4-P-gbPb6gt221B51RN3vGXafmpeVwi4rbkA@mail.gmail.com>
Message-ID: <CAMuHMdWmT7+8ow4-P-gbPb6gt221B51RN3vGXafmpeVwi4rbkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Biju,

On Sat, Oct 8, 2022 at 9:42 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > On Thu, Oct 06, 2022 at 02:57:14PM +0100, Biju Das wrote:
> > > > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded
> > in
> > > > the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
> > > > channels and one 32-bit timer channel. It supports the following
> > > > functions
> > > >  - Counter
> > > >  - Timer
> > > >  - PWM
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > ---
> > > > v2->v3:
> > > >  * Dropped counter bindings and integrated with mfd as it has only
> > > one property.
> > > >  * Removed "#address-cells" and "#size-cells" as it do not have
> > > children with
> > > >    unit addresses.
> > > >  * Removed quotes from counter and pwm.
> > > >  * Provided full path for pwm bindings.
> > > >  * Updated the example.
> > > > v1->v2:
> > > >  * Modelled counter and pwm as a single device that handles
> > > >    multiple channels.
> > > >  * Moved counter and pwm bindings to respective subsystems
> > > >  * Dropped 'bindings' from MFD binding title.
> > > >  * Updated the example
> > > >  * Changed the compatible names.
> > > > ---
> > > >  .../bindings/mfd/renesas,rz-mtu3.yaml         | 304
> > > ++++++++++++++++++
> > > >  .../bindings/pwm/renesas,rz-mtu3-pwm.yaml     |  50 +++
> > > >  2 files changed, 354 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > > b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > > new file mode 100644
> > > > index 000000000000..44c952ad8d35
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > > @@ -0,0 +1,304 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > 1.2
> > > > +---
> > > > +$id:
> > > >
> > > > +
> > > > +title: Renesas RZ/G2L Multi-Function Timer Pulse Unit 3 (MTU3a)
> > > > +
> > > > +maintainers:
> > > > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > > > +
> > > > +description: |
> > > > +  This hardware block pconsisting of eight 16-bit timer channels
> > > and
> > > > +one
> > > > +  32- bit timer channel. It supports the following
> > specifications:
> > > > +    - Pulse input/output: 28 lines max.
> > > > +    - Pulse input 3 lines
> > > > +    - Count clock 11 clocks for each channel (14 clocks for MTU0,
> > > 12 clocks
> > > > +      for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2
> > > combination
> > > > +      (when LWA = 1))
> > > > +    - Operating frequency Up to 100 MHz
> > > > +    - Available operations [MTU0 to MTU4, MTU6, MTU7, and MTU8]
> > > > +        - Waveform output on compare match
> > > > +        - Input capture function (noise filter setting available)
> > > > +        - Counter-clearing operation
> > > > +        - Simultaneous writing to multiple timer counters (TCNT)
> > > > +          (excluding MTU8).
> > > > +        - Simultaneous clearing on compare match or input capture
> > > > +          (excluding MTU8).
> > > > +        - Simultaneous input and output to registers in
> > > synchronization with
> > > > +          counter operations           (excluding MTU8).
> > > > +        - Up to 12-phase PWM output in combination with
> > synchronous
> > > operation
> > > > +          (excluding MTU8)
> > > > +    - [MTU0 MTU3, MTU4, MTU6, MTU7, and MTU8]
> > > > +        - Buffer operation specifiable
> > > > +    - [MTU1, MTU2]
> > > > +        - Phase counting mode can be specified independently
> > > > +        - 32-bit phase counting mode can be specified for
> > > interlocked operation
> > > > +          of MTU1 and MTU2 (when TMDR3.LWA = 1)
> > > > +        - Cascade connection operation available
> > > > +    - [MTU3, MTU4, MTU6, and MTU7]
> > > > +        - Through interlocked operation of MTU3/4 and MTU6/7, the
> > > positive and
> > > > +          negative signals in six phases (12 phases in total) can
> > > be output in
> > > > +          complementary PWM and reset-synchronized PWM operation.
> > > > +        - In complementary PWM mode, values can be transferred
> > from
> > > buffer
> > > > +          registers to temporary registers at crests and troughs
> > of
> > > the timer-
> > > > +          counter values or when the buffer registers (TGRD
> > > registers in MTU4
> > > > +          and MTU7) are written to.
> > > > +        - Double-buffering selectable in complementary PWM mode.
> > > > +    - [MTU3 and MTU4]
> > > > +        - Through interlocking with MTU0, a mode for driving AC
> > > synchronous
> > > > +          motors (brushless DC motors) by using complementary PWM
> > > output and
> > > > +          reset-synchronized PWM output is settable and allows
> > the
> > > selection
> > > > +          of two types of waveform output (chopping or level).
> > > > +    - [MTU5]
> > > > +        - Capable of operation as a dead-time compensation
> > counter.
> > > > +    - [MTU0/MTU5, MTU1, MTU2, and MTU8]
> > > > +        - 32-bit phase counting mode specifiable by combining
> > MTU1
> > > and MTU2 and
> > > > +          through interlocked operation with MTU0/MTU5 and MTU8.
> > > > +    - Interrupt-skipping function
> > > > +        - In complementary PWM mode, interrupts on crests and
> > > troughs of counter
> > > > +          values and triggers to start conversion by the A/D
> > > converter can be
> > > > +          skipped.
> > > > +    - Interrupt sources: 43 sources.
> > > > +    - Buffer operation:
> > > > +        - Automatic transfer of register data (transfer from the
> > > buffer
> > > > +          register to the timer register).
> > > > +    - Trigger generation
> > > > +        - A/D converter start triggers can be generated
> > > > +        - A/D converter start request delaying function enables
> > A/D
> > > converter
> > > > +          to be started with any desired timing and to be
> > > synchronized with
> > > > +          PWM output.
> > > > +    - Low power consumption function
> > > > +        - The MTU3a can be placed in the module-stop state.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - enum:
> > > > +          - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
> > > > +          - renesas,r9a07g054-mtu3  # RZ/V2L
> > > > +      - const: renesas,rz-mtu3
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    items:
> > > > +      - description: MTU0.TGRA input capture/compare match
> > > > +      - description: MTU0.TGRB input capture/compare match
> > > > +      - description: MTU0.TGRC input capture/compare match
> > > > +      - description: MTU0.TGRD input capture/compare match
> > > > +      - description: MTU0.TCNT overflow
> > > > +      - description: MTU0.TGRE compare match
> > > > +      - description: MTU0.TGRF compare match
> > > > +      - description: MTU1.TGRA input capture/compare match
> > > > +      - description: MTU1.TGRB input capture/compare match
> > > > +      - description: MTU1.TCNT overflow
> > > > +      - description: MTU1.TCNT underflow
> > > > +      - description: MTU2.TGRA input capture/compare match
> > > > +      - description: MTU2.TGRB input capture/compare match
> > > > +      - description: MTU2.TCNT overflow
> > > > +      - description: MTU2.TCNT underflow
> > > > +      - description: MTU3.TGRA input capture/compare match
> > > > +      - description: MTU3.TGRB input capture/compare match
> > > > +      - description: MTU3.TGRC input capture/compare match
> > > > +      - description: MTU3.TGRD input capture/compare match
> > > > +      - description: MTU3.TCNT overflow
> > > > +      - description: MTU4.TGRA input capture/compare match
> > > > +      - description: MTU4.TGRB input capture/compare match
> > > > +      - description: MTU4.TGRC input capture/compare match
> > > > +      - description: MTU4.TGRD input capture/compare match
> > > > +      - description: MTU4.TCNT overflow/underflow
> > > > +      - description: MTU5.TGRU input capture/compare match
> > > > +      - description: MTU5.TGRV input capture/compare match
> > > > +      - description: MTU5.TGRW input capture/compare match
> > > > +      - description: MTU6.TGRA input capture/compare match
> > > > +      - description: MTU6.TGRB input capture/compare match
> > > > +      - description: MTU6.TGRC input capture/compare match
> > > > +      - description: MTU6.TGRD input capture/compare match
> > > > +      - description: MTU6.TCNT overflow
> > > > +      - description: MTU7.TGRA input capture/compare match
> > > > +      - description: MTU7.TGRB input capture/compare match
> > > > +      - description: MTU7.TGRC input capture/compare match
> > > > +      - description: MTU7.TGRD input capture/compare match
> > > > +      - description: MTU7.TCNT overflow/underflow
> > > > +      - description: MTU8.TGRA input capture/compare match
> > > > +      - description: MTU8.TGRB input capture/compare match
> > > > +      - description: MTU8.TGRC input capture/compare match
> > > > +      - description: MTU8.TGRD input capture/compare match
> > > > +      - description: MTU8.TCNT overflow
> > > > +      - description: MTU8.TCNT underflow
> > > > +
> > > > +  interrupt-names:
> > > > +    items:
> > > > +      - const: tgia0
> > > > +      - const: tgib0
> > > > +      - const: tgic0
> > > > +      - const: tgid0
> > > > +      - const: tgiv0
> > > > +      - const: tgie0
> > > > +      - const: tgif0
> > > > +      - const: tgia1
> > > > +      - const: tgib1
> > > > +      - const: tgiv1
> > > > +      - const: tgiu1
> > > > +      - const: tgia2
> > > > +      - const: tgib2
> > > > +      - const: tgiv2
> > > > +      - const: tgiu2
> > > > +      - const: tgia3
> > > > +      - const: tgib3
> > > > +      - const: tgic3
> > > > +      - const: tgid3
> > > > +      - const: tgiv3
> > > > +      - const: tgia4
> > > > +      - const: tgib4
> > > > +      - const: tgic4
> > > > +      - const: tgid4
> > > > +      - const: tgiv4
> > > > +      - const: tgiu5
> > > > +      - const: tgiv5
> > > > +      - const: tgiw5
> > > > +      - const: tgia6
> > > > +      - const: tgib6
> > > > +      - const: tgic6
> > > > +      - const: tgid6
> > > > +      - const: tgiv6
> > > > +      - const: tgia7
> > > > +      - const: tgib7
> > > > +      - const: tgic7
> > > > +      - const: tgid7
> > > > +      - const: tgiv7
> > > > +      - const: tgia8
> > > > +      - const: tgib8
> > > > +      - const: tgic8
> > > > +      - const: tgid8
> > > > +      - const: tgiv8
> > > > +      - const: tgiu8
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +
> > > > +  power-domains:
> > > > +    maxItems: 1
> > > > +
> > > > +  resets:
> > > > +    maxItems: 1
> > > > +
> > > > +  counter:
> > > > +    description:
> > > > +      There are two phase counting modes. 16-bit phase counting
> > > mode in which
> > > > +      MTU1 and MTU2 operate independently, and cascade connection
> > > 32-bit phase
> > > > +      counting mode in which MTU1 and MTU2 are cascaded.
> > > > +
> > > > +      In phase counting mode, the phase difference between two
> > > external input
> > > > +      clocks is detected and the corresponding TCNT is
> > incremented
> > > or
> > > > +      decremented.
> > > > +      The below counters are supported
> > > > +        count0 - MTU1 16-bit phase counting
> > > > +        count1 - MTU2 16-bit phase counting
> > > > +        count2 - MTU1+ MTU2 32-bit phase counting
> > > > +
> > > > +    type: object
> > > > +
> > > > +    properties:
> > > > +      compatible:
> > > > +        const: renesas,rz-mtu3-counter
> > > > +
> > > > +    required:
> > > > +      - compatible
> > > > +
> > > > +    additionalProperties: false
> > > > +
> > > > +  pwm:
> > > > +    $ref: /schemas/pwm/renesas,rz-mtu3-pwm.yaml
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - interrupt-names
> > > > +  - clocks
> > > > +  - power-domains
> > > > +  - resets
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +
> > > > +    mtu3: timer@10001200 {
> > > > +      compatible = "renesas,r9a07g044-mtu3", "renesas,rz-mtu3";
> > > > +      reg = <0x10001200 0xb00>;

> > > > +
> > > > +      counter {
> > > > +        compatible = "renesas,rz-mtu3-counter";
> > >
> > > You don't have any resources for the counter in DT, so you don't
> > even
> > > need a node here. Just have the parent driver instaniate the counter
> > > driver.
> >
>
> If I remove "renesas,rz-mtu3-counter" and "renesas,rz-mtu3-pwm" then instantiating
> the counter and pwm driver from parent driver by directly calling probe function is
> giving cyclic dependency error[1].
>
> So looks like either we need to use compatible "renesas,rz-mtu3-counter" and
> "renesas,rz-mtu3-pwm" if these functionalities to be in respective subsystem tree
>
> or
>
> squash counter and pwm functionalities to MFD subsystem.
>
> Please share your views on this. Is there any better way to handle this?

I think what Rob means is that you can have a single driver that binds
against "renesas,rz-mtu3", and registers both the counter and the pwm
functionalities. Just like the clock driver, which registers clock,
reset, and PM Domain functionalities.  I.e. no mfd would be involved
anymore.
You can still split the driver functionality across multiple source
files (core, counter, pwm).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

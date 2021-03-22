Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3344B344967
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 16:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCVPiU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 11:38:20 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:39817 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhCVPiQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 11:38:16 -0400
Received: by mail-vs1-f46.google.com with SMTP id e72so2232004vsc.6;
        Mon, 22 Mar 2021 08:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeaWu7NQhqTg67+28QJCmBXaQRsdudr3ZwUMLAQvMow=;
        b=pxJp6kwcs2WRp/H7USwaqjME4s4abgdyDbFEL0aZTRRWtWMwwWPca8sq8JjFDUouMF
         mP3PhHoUu6jpj2G6rja5KTcJNXGashBWBJQo2mvNmtGFp8ZXa9vnjruHzzwa0YeIlEFo
         w8br3x8E47ceHueurHwui310Ro2R51xUIe7L/dz8mY21EmWS3wqjQRi6D70HZhZETW8j
         EaJlHPRRMXE62uPp4MKGeG67SxAXDyv3c7eXosARVXk2LRRL8sQxhaaJc+jhLwm+i2op
         lxXVkzTYPE9aIsk2ad9tCArTkYPgyIq4KULkE86xxBkvZb2/V4tr21kPC0SIpB9ugRI0
         P3YQ==
X-Gm-Message-State: AOAM533I+WX2zMqHD/JKmigePgZYo4r+RtLm1rgWg4Y6zf2cEihb/1LB
        U63vdtubpwR6IfJ7XNXgnuzv6L43rUtqPTnj1DE=
X-Google-Smtp-Source: ABdhPJxNe+DMTZdB2lWgUCE5StB9yp5TTZKT2HloywUXMNLbDmvZ6gW30OxDfaCQ8FunvzXfxRMyQk6bPYmPn8SKULg=
X-Received: by 2002:a67:8883:: with SMTP id k125mr515895vsd.18.1616427495528;
 Mon, 22 Mar 2021 08:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
 <1599734644-4791-3-git-send-email-sagar.kadam@sifive.com> <20200922203429.GA3188204@bogus>
In-Reply-To: <20200922203429.GA3188204@bogus>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Mar 2021 16:38:04 +0100
Message-ID: <CAMuHMdXPG-+EOCrQZi1deKv1yYMBtohprUVYW_-Shdp_gfQs5Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] dt-bindings: riscv: convert plic bindings to json-schema
To:     Sagar Kadam <sagar.kadam@sifive.com>, Rob Herring <robh@kernel.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yash Shah <yash.shah@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sagar, Rob,

(replying to an old email, as this one seems to be the most appropriate)

On Tue, Sep 22, 2020 at 10:34 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Sep 10, 2020 at 04:14:03PM +0530, Sagar Kadam wrote:
> > Convert device tree bindings for SiFive's PLIC to YAML format
> >
> > Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml

> > +
> > +  '#address-cells':
> > +    const: 0
> > +    description: Should be <0> or more.
>
> Drop. 'or more' is wrong. If there's a case with more, it will need to
> be documented.

Why do we have the "'#address-cells': const: 0" at all...

> > +required:
> > +  - compatible
> > +  - '#address-cells'

... and why is it required?

> > +  - '#interrupt-cells'
> > +  - interrupt-controller
> > +  - reg
> > +  - interrupts-extended
> > +  - riscv,ndev
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    plic: interrupt-controller@c000000 {
> > +      #address-cells = <0>;
> > +      #interrupt-cells = <1>;
> > +      compatible = "sifive,plic-1.0.0", "sifive,fu540-c000-plic";
> > +      interrupt-controller;
> > +      interrupts-extended = <
> > +        &cpu0_intc 11
> > +        &cpu1_intc 11 &cpu1_intc 9
> > +        &cpu2_intc 11 &cpu2_intc 9
> > +        &cpu3_intc 11 &cpu3_intc 9
> > +        &cpu4_intc 11 &cpu4_intc 9>;
> > +      reg = <0xc000000 0x4000000>;
> > +      riscv,ndev = <10>;
> > +    };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

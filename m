Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13B943DB6F
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Oct 2021 08:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1Gqv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Oct 2021 02:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1Gqt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Oct 2021 02:46:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18BC061570;
        Wed, 27 Oct 2021 23:44:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so7214283pje.0;
        Wed, 27 Oct 2021 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Of/fJ5Rbng8I9x5msLxQeFrZ0a7kJhXv0gNEO1t779o=;
        b=NMAdjsrS0EN0+AbpLzUZlH3Jiy5AAIz0LoYoI3L2bBgG1beIBt9vWY45T9S69l8bvX
         7t4OELR8fivYPDTKWp9lS7PW7FiPfEx6Ic/1M7ojhGxSIEv4oQvr2KmSszR6157Zm9zK
         Prcoz/P7Sc+wPiBUXEwxqy5KEiL64u/uWLs2klpr+TPo+TxGgY0paYlJlhMZJlhtQbQy
         y7JNlP3kA4g8hb9XlVCm16QZRdgbMDY//wgnLqnX9A0rK3F6eAK4lYc0fakSxhREj/mX
         OYou0zgD7TAprY0faog4Fubs6ChtUMz9yUt1ijpoiDbgYuZVdvvx+7q4rood1WFNRjlt
         KA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Of/fJ5Rbng8I9x5msLxQeFrZ0a7kJhXv0gNEO1t779o=;
        b=x9x69PqdcLZbbZdS/Obo6uq8gLtHs6UmM8Z1PZ+38Exu/5tcGd8Y6nX6ThopBiqS4f
         VqBMuxYYpboFqLEWRi0/mY+RRaC8WWmnaltrVzU7Z+cwI7bxs1wNTP928dW4Ko3NBPu9
         omlabjWV1TSiWZXMIVkduq1mYQPjp8nnC71whK0PXLCZ/0FZ/EM23BYtQB7Cb/2bVX58
         qxB8YPJOhuYsKyCy669jjPLhw38n7Z0FudTHiHtFWplwYM+gRdslegJAuhx79a2eLrV2
         /Ypu579h5wsGjXz5oxxh6d+JRBe/xx4vEZ+x8OPynaZaRzueQ047pBKKqRC6tYJNOHYs
         g0gg==
X-Gm-Message-State: AOAM533S2oW8ekv1H/qhVzJljagK/69VP/5TbrKyMKFwjMGPechP8IIh
        4wn0aPFRiPJVEvoDFGTFTefFGRRBW9thFV0Ahew=
X-Google-Smtp-Source: ABdhPJx215XHFUIM0dMKIpGllu31hwPxBnDWAHwXrVcvry21qa2nlU6z0LnxaI0KGp0jVGclXOr9YOgK4O2cr2xsHOM=
X-Received: by 2002:a17:90a:4b85:: with SMTP id i5mr10996963pjh.25.1635403462831;
 Wed, 27 Oct 2021 23:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181125161534.GA4481@arx-s1> <0a9bda1e91246c7e473fcbb833ac94159d13b084.camel@aosc.io>
In-Reply-To: <0a9bda1e91246c7e473fcbb833ac94159d13b084.camel@aosc.io>
From:   Hao Zhang <hao5781286@gmail.com>
Date:   Thu, 28 Oct 2021 14:44:12 +0800
Message-ID: <CAJeuY79VCude_h2N3CP56e8ZzW85jGpqOQNHuM1kBC6WFV0fQQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] PWM support for allwinner sun8i R40/T3/V40 SOCs.
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Never mind, you can continue it.

Icenowy Zheng <icenowy@aosc.io> =E4=BA=8E2021=E5=B9=B47=E6=9C=8822=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=889:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Hao,
>
> Would you mind me to continue on this work? Newer Allwinner SoCs have
> PWM controllers similar to the R40 one.
>
> Yours sincerely,
> Icenowy Zheng
>
>
> =E5=9C=A8 2018-11-26=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 00:18 +0800=EF=
=BC=8CHao Zhang=E5=86=99=E9=81=93=EF=BC=9A
> > PWM support for allwinner sun8i R40/T3/V40 SOCs.
> >
> > The sun8i R40/T3/V40 PWM has 8 PWM channals and divides to 4 PWM
> > pairs,
> > each PWM pair built-in 1 clock module, 2 timer logic module and 1
> > programmable dead-time generator, it also support waveform capture.
> > It has 2 clock sources OSC24M and APB1, it is different with the
> > sun4i-pwm driver, Therefore add a new driver for it.
> >
> > Some test method:
> > cd /sys/class/pwm/pwmchip0
> > echo 0 > export
> > cd pwm0
> > echo 1000 > period
> > echo 500 > duty_cycle
> > echo 1 > enable
> > then check the PB2 pin with oscilloscope.
> >
> > v3 Changes:
> > 1. fix coding format.
> > 2. use 2/ilog2 instead of divide table
> > 3. remove spinlock.
> > 4. remove sun8i_pwm_data structure and use DT to parse pwm-channals
> > 5. remove inline because complier knows it better.
> > 6. don't hardcode clock source and parse two clock source from dt
> > "mux-0"
> >    and "mux-1"
> > 7. remove bypass method.
> > 8. add a method to change clock source when mux-0 is not support the
> >    input period it can change to mux-1.
> > 9. add cycle range check.
> > 10. add some variable to make it more readability.
> > 11. add clk_disable_unprepare when some false accur.
> >
> > v2 Changes:
> > 1. change sun8i-r40 symbol to sun8i.
> > 2. change pwm0_pin, pwm0-pin to pwm_ch0_pin, pwm-ch0-pin.
> > 3. remove clk_disable_unprepare(), check !match and IS_ERR(pwm-
> > >regmap).
> >
> > Hao Zhang (6):
> >   Documentation: ARM: sunxi: pwm: add Allwinner sun8i.
> >   ARM: dtsi: add pwm node for sun8i R40.
> >   ARM: dts: add PWM for Bananapi M2 Ultrar board.
> >   DEV: CLK: add function to check the using clock name of driver.
> >   DEV: CLK: sunxi ccu: export clk_apb1 for sun8i-r40 soc pwm.
> >   ARM: PWM: add allwinner sun8i R40/T3/V40 PWM support.
> >
> >  .../devicetree/bindings/pwm/pwm-sun8i.txt          |  24 ++
> >  arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   6 +
> >  arch/arm/boot/dts/sun8i-r40.dtsi                   |  17 +
> >  drivers/clk/clk.c                                  |   6 +
> >  drivers/clk/sunxi-ng/ccu-sun8i-r40.h               |   4 +-
> >  drivers/pwm/Kconfig                                |  12 +-
> >  drivers/pwm/Makefile                               |   1 +
> >  drivers/pwm/pwm-sun8i.c                            | 418
> > +++++++++++++++++++++
> >  include/dt-bindings/clock/sun8i-r40-ccu.h          |   2 +
> >  include/linux/clk-provider.h                       |   1 +
> >  10 files changed, 489 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-
> > sun8i.txt
> >  create mode 100644 drivers/pwm/pwm-sun8i.c
> >
>

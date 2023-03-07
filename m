Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DB76ADEB8
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Mar 2023 13:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCGMaz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Mar 2023 07:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCGMax (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Mar 2023 07:30:53 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CDD574C1;
        Tue,  7 Mar 2023 04:30:48 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d7so13967305qtr.12;
        Tue, 07 Mar 2023 04:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678192248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPIwXn5HU+7qQ+4crqE/1YbIbAYyi4pDL0FksvJzOPM=;
        b=H5r1l0V5HKcI+Dp14YU+RMT6wtaR+fxQ+ol+ZZ5eDPozUu9UjnikSJ+obviyAqpq3o
         LxSs8fCOxsGwzoVbkSSx5HNsWwtzB+vpQw7ygpFpcwYszyVd43J6M+5QsQnIbQ2n9nks
         YA/BAGJIbHcGZMbcdlLUS0aZyBmrmJPRK3armPeuMhOf5k8Yu+a7LBepyBXf8Gt8oUDw
         LGI0cZ4Dcn8/I+IuWkLEd7K/zaIl1b2jpikalhnGV0BPTenRgm2Vg4R7TktBot70tveB
         LrEpG/gVSnmqnI4CM8+WTrKVRJQTBoBHhaR0TDbSohSkAtoawMey40rUhexfQUheKN+2
         xYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678192248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPIwXn5HU+7qQ+4crqE/1YbIbAYyi4pDL0FksvJzOPM=;
        b=UeFtHLIlgOXX3W+3V1073tcViKTbuqKV9tebzC5DkanBc+P0Mxjj6RMrcrtyLXoIJL
         mvgH50aQF8RiQiXFM+JA67XI6erKrl98plo9PZ+eEy9udVxV631+PQbwRQJOeCMuFlIc
         FBKEufK3GOsLM3LyLvAAeubAKJ+euY9sf0rkBfULNLLf/b8Tf4UTrdBgi349oRDNj7RI
         A1W3ibRRpbw9bAFThYXA6OZz2YsBoF0vjUdC8YdJnR8gMtMM5SQ8sJIZiuQhek5Op5GI
         gLXatK6JI9Kmc8qXp24sT0P4rsB25H5cwPipFYFos5HRSWEUsj4MgH0ga6BIL2SG+l1c
         O/2A==
X-Gm-Message-State: AO0yUKWUySKXk1VkNP96dxNo/sCG8uESaPC7oEV59qL1GFv5S9xpqQ+9
        ZzFHZQteH6A7LJ5/PbMOElWSqdM/tu//q7gJKHM=
X-Google-Smtp-Source: AK7set9DUfQkAnhGRIDBxtS+yx3RcPCDooAEBcPw1L4dWXrzDvQ1mWZSmPG3EKKw/sh5tWVF5JTQlOEcCE3DNpk6Xl0=
X-Received: by 2002:ac8:40cb:0:b0:3bf:c33e:93a9 with SMTP id
 f11-20020ac840cb000000b003bfc33e93a9mr4111797qtm.1.1678192247935; Tue, 07 Mar
 2023 04:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
 <20230306090014.128732-7-biju.das.jz@bp.renesas.com> <ZAZ43tylTNxPIun8@surfacebook>
 <OS0PR01MB59223AF6B7850592F34CABF086B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAHp75Vcdyq-XKRFKzEjHFQ_0Qv61HkMEVu0Dg-ffsnVc9R3-ww@mail.gmail.com> <OS0PR01MB59229CD801939459BB2F8E8686B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59229CD801939459BB2F8E8686B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Mar 2023 14:30:11 +0200
Message-ID: <CAHp75VdJQ0OpVdhJ=9F1tJNXuuYmN2H51tSub+zDkzS3HLUXAg@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] drivers: pinctrl: renesas: Add RZ/G2L POEG
 driver support
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 7, 2023 at 12:10 PM Biju Das <biju.das.jz@bp.renesas.com> wrote=
:
> > On Tue, Mar 7, 2023 at 10:53=E2=80=AFAM Biju Das <biju.das.jz@bp.renesa=
s.com> wrote:
> > > > From: andy.shevchenko@gmail.com <andy.shevchenko@gmail.com>
> > > > Sent: Monday, March 6, 2023 11:36 PM Mon, Mar 06, 2023 at 09:00:07A=
M
> > > > +0000, Biju Das kirjoitti:

...

> > > > > +static void rzg2l_poeg_write(struct rzg2l_poeg_chip *chip, u32
> > > > > +data) {
> > > > > +   iowrite32(data, chip->mmio);
> > > > > +}
> > > > > +
> > > > > +static u32 rzg2l_poeg_read(struct rzg2l_poeg_chip *chip) {
> > > > > +   return ioread32(chip->mmio);
> > > > > +}
> > > >
> > > > Why not regmap MMIO?
> > >
> > > Some drivers used iowrite32, some uses writel, some uses regmap.
> > >
> > > will use regmap for read/write,If the preference is regmap MMIO as it
> > > comes with spinlock for MMIO access.
> >
> > Lock can be disabled. It's up to the user of regmap.
>
> Ok, Just want to double check,
> POEG has a single 32 bit register. So it worth to use regmap?
> A simple readl/write is sufficient no??

It can be. But can you explain why you used iowriteXX() / ioreadXX()
instead of writeX()/readX()?

--=20
With Best Regards,
Andy Shevchenko

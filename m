Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE45F40C8
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Oct 2022 12:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJDK3X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 Oct 2022 06:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJDK3K (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 Oct 2022 06:29:10 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C682CC9A;
        Tue,  4 Oct 2022 03:29:04 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-333a4a5d495so131013797b3.10;
        Tue, 04 Oct 2022 03:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=1lUIWCR3r011/t+0Z08z8q0dDNOYLDdrY1UN5uqDESU=;
        b=gWFEx5m1Blh2fa8ekzLkgvMBG69ssxYAMdYFjll11yfRMcZDKShKvPI0W4GX18SyJv
         9Z0dc/68MRlow3gJlBBCd0eEqYs5GQL2csch/wfy7Hl/TBvgNP4QFIwghTo+/9tSwUEB
         txQDJUjkjVlQzVrNZrjspI7ao2uA//Y+4DLnon5HEjU2w++AnmOQA2nqpG3+D18WSFWW
         HRbFDxtd+dCdfzq5A/I9l8C1rwfmW7pDEGuBoYG6eGOJRxjX6epdl4xDXrCjhwP9jWxL
         hkkFflJ+Rt2EntPEuDgOCVYgb9QZ/JPjzkrmUxsNroI8NzyjycOQucQrGECvmjtOKQtc
         yhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1lUIWCR3r011/t+0Z08z8q0dDNOYLDdrY1UN5uqDESU=;
        b=NBApH2ntn+gYq/THuRUXq5E7L85yRP2hpROdpbf3pqalCtZrT0uDT0JaAxZrFJ3gIC
         BjbjGxojpLNOnv/thMjJR+V5bD6PYyCjnBNRJv9r3zudoTwwNa9H//rJoh8zRbpb8w9+
         tOVLHUQ251fTOn1BntKaPyV6mJorpMKrJC9lDiNfj4/7oj8koAqQbyKVjeoWMcgDeCqh
         hnbRyOurWOuaTwPaisJIguPPyG7BBWnmq37722xKvGLBVKFCsU0BhkxI7bPmpAuqCwRB
         zV79DyU7T9TQb1Bmw/FfT66N3OYmqWkXFMu3y0j7/R5DucleyKEnPz4rm83E6/u26TmZ
         yueg==
X-Gm-Message-State: ACrzQf1mzTjZe8YBkkLXv5+DCXoNADINY+M3Sp8Il6ndi30YLsoi9cvM
        2jJPhllhTGFm2oR1gxWDTwA1IozJNuvdri2pmuE=
X-Google-Smtp-Source: AMsMyM5hUjwDTJXjQh3X5oEZcEqPnJf1clOw6pk6zBfZkQn7WdGWwxByl5BWqYRPXkcZlH19NWRTLO0YlNbG7PQ00G4=
X-Received: by 2002:a81:3887:0:b0:354:f509:7fae with SMTP id
 f129-20020a813887000000b00354f5097faemr24996677ywa.459.1664879344047; Tue, 04
 Oct 2022 03:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com> <20220815070935.guqzzlny7f6kcprc@pengutronix.de>
 <20220818075401.wguqvcbhzj5ttnio@pengutronix.de> <8ba9431b-b2bf-9fb0-9ba7-afeb2c3bce94@collabora.com>
 <20220921081721.l2bpeokwxy5pwfdh@pengutronix.de> <e109b19b-47a6-28b6-3eca-b45720637afe@nvidia.com>
 <Yy2iSuOiShnokwGL@orome>
In-Reply-To: <Yy2iSuOiShnokwGL@orome>
From:   Thomas Graichen <thomas.graichen@googlemail.com>
Date:   Tue, 4 Oct 2022 12:28:25 +0200
Message-ID: <CAOUEw12eDo2k5h+A05EHDkr4xDCQVw3O=2T-30KpFjhYRWhXmw@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pwm@vger.kernel.org,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>, kernel@pengutronix.de,
        linux-tegra@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
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

On Fri, Sep 23, 2022 at 2:10 PM Thierry Reding <thierry.reding@gmail.com> w=
rote:
>
> On Thu, Sep 22, 2022 at 12:12:31PM +0100, Jon Hunter wrote:
> > Hi Uwe,
> >
> > On 21/09/2022 09:17, Uwe Kleine-K=C3=B6nig wrote:
> >
> > ...
> >
> > > As the clk-rate is only 32768 Hz we get (with period_ns =3D 1000000)
> > >
> > >     32768 * 1000000 / (1000000000 << 8) =3D 0.128
> > >
> > > which is indeed rounded down to 0 and then runs into the error path
> > > returning -EINVAL. Before my change (that now broke the backlight
> > > configuration) configuration continued and then ended with actually
> > > configuring period =3D 7812500 ns which is off by nearly a factor of =
8.
> >
> > I am seeing the same issue on Tegra210 Jetson Nano (device-tree
> > tegra210-p3450-0000.dts). This also has a clock rate of 32768 Hz by
> > default which means the min period is 30517ns. However, in the probe
> > the min_period_ns comes from the pc->soc->max_frequency which is 48
> > MHz for Tegra210. The min_period_ns =3D 1/(48 MHz / (2^8)) which is
> > 5334ns. Hence, the actual min period is less than what is actually
> > possible.
> >
> > I wonder if we should be warning about this and fixing the min
> > period ...
> >
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index 2f3dcb9e9278..f72928c05c81 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -310,9 +310,13 @@ static int tegra_pwm_probe(struct platform_device =
*pdev)
> >          */
> >         pc->clk_rate =3D clk_get_rate(pc->clk);
> > +       if (pc->clk_rate < pc->soc->max_frequency)
> > +               dev_warn(&pdev->dev, "Max frequency limited to %lu Hz!"=
,
> > +                        pc->clk_rate);
> > +
> >         /* Set minimum limit of PWM period for the IP */
> >         pc->min_period_ns =3D
> > -           (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH))=
 + 1;
> > +           (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
> >         pc->rst =3D devm_reset_control_get_exclusive(&pdev->dev, "pwm")=
;
> >
> > The above does not fix this issue but ...
> > > I didn't find a device tree for an Asus Transformer tablet bases on a
> > > tegra124 in the kernel source, but the options are:
> > >
> > >   - Revert commit 8c193f4714df ("pwm: tegra: Optimize period calculat=
ion").
> > >     I don't like this. IMHO this commit is an improvement and the pro=
blem
> > >     is that the consumer requests a too small period. For a backlight
> > >     this might be ok to result in a much bigger period, for other
> > >     usecases it isn't and so I like refusing period =3D 1000000.
> > >
> > >   - We could just drop the "else / return -EINVAL".
> > >     This is inconsistent as then (again) some periods are rounded up
> > >     (with the given clk rate that would be 5334 <=3D period < 7812500=
)
> > >     while others (period < 5334) yield -EINVAL.
> > >
> > >   - Increase the period that the backlight is using to at least 78125=
00.
> > >     This is done (I guess) by replacing 1000000 by 7812500 (or more) =
in
> > >     the backlight's PWM phandle.
> > >
> > >   - Make the PWM clk faster.
> > >     Looking quickly through the tegra clk driver, the parent of the P=
WM
> > >     clk could be changed from clk_32k to pll_p or pll_c. This should =
be
> > >     doable in the dts using something like:
> > >
> > >             assigned-clocks =3D <&tegra_car TEGRA124_CLK_PWM>;
> > >     assigned-clock-parents =3D <&tegra_car TEGRA124_CLK_PLL_P>;
> > >
> > >     in the pwm node. (Note this includes much guesswork, I don't know=
 the
> > >     PPL's clk-rate, so this might break in other ways. Another option=
 is
> > >     using PLL_C.)
> > >
> > > Probably the latter is the nicest option. Is it possible to find out =
the
> > > setting when the machine is running the original vendor OS?
> >
> > The latter does seem correct to me. This fixes the issue for Tegra210 .=
..
> >
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot=
/dts/nvidia/tegra210.dtsi
> > index 4f0e51f1a343..842843e0a585 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> > @@ -670,6 +670,10 @@
> >                 clock-names =3D "pwm";
> >                 resets =3D <&tegra_car 17>;
> >                 reset-names =3D "pwm";
> > +
> > +               assigned-clocks =3D <&tegra_car TEGRA210_CLK_PWM>;
> > +               assigned-clock-parents =3D <&tegra_car TEGRA210_CLK_PLL=
_P>;
> > +
> >                 status =3D "disabled";
> >         };
>
> Traditionally we've always set the clock parent in the driver via the
> init table (at least on chips prior to Tegra186). On the other hand we
> have a few occurrences of assigned-clock-rates already for Tegra210. I
> don't feel strongly either way. A minor advantage of having the fix in
> the clock driver is that it fixes this automatically for older device
> trees. Not that it really matters since people always update kernel and
> DTB at the same time on Tegra devices.
>
> It'd be great if we could get confirmation that changing the parent
> clock fixes this on all other boards as well, then we can fix it at the
> same time for all of them.
>
> Thierry

just a little update: i just compiled a v6.0 kernel for the nyan
chromebook (tegra124) and now the display remains completely black -
with v5.19 it was at least working with broken brightness control -
reverting the pwm optimization patch it works perfectly fine in both
cases ... please let me know if you have any patches i should test to
fix this

best wishes - thomas

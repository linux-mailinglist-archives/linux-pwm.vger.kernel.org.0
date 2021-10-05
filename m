Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1285142276D
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Oct 2021 15:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhJENM7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Oct 2021 09:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbhJENM6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Oct 2021 09:12:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CC0C061753
        for <linux-pwm@vger.kernel.org>; Tue,  5 Oct 2021 06:11:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u18so86214535lfd.12
        for <linux-pwm@vger.kernel.org>; Tue, 05 Oct 2021 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jjr/5gs80cWEm3vhyk3aM1mKvl135EXltar2PLrRZ/k=;
        b=P2GJcTPd6Kk45HZ8Ezt3mOStexgciMfR/ERjqn7quus9WPj7c0pgJ31TVKDyKIyFGw
         Y+F7WGFBzXS/vp5jDxxMyzTz/hmBB5xPYGuEv6qEQ23KVdyCACYcfsWUkcNmRV/ofYHS
         vE4LfuNllox/XGETXWlqstK2Q0L/vr7oXCynROhlgtpi4vvXnVvj6wEyBllh0eoIaYn8
         f40td9gch4cO2Jp1h51EkJPAQ6/xwpwREWWIr5YIzLYLVQSBM9my6mb9NpueANAdQfBZ
         CLGXLy2HZcaqGOasKeUtPNXPs47D7ubFHOmVm/lx2TuvCwySuEvv9iGf+AtaMpafWnSk
         y69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jjr/5gs80cWEm3vhyk3aM1mKvl135EXltar2PLrRZ/k=;
        b=3jlaf0WYntItDb7iZAuh8JiHbIYMZYUTpxyo9q+HvEENAfJiC9V5rXVm9HrP35M4Hx
         qRvF5rRIn7nSOP2FVmGu23nKcjYfhw9GMxZx7ZuzAqN7+oZOiu75+DCJ5is377HxlCe4
         3Oxzrywx2C0Ttqbi8fwZSed3uWB8IgSvD60kU7l70r0xvmVJ7687JfVOZHwKpfDqut46
         XisEli+Ms1U4DGQLY/40lBorMytcPUuH/C9hi5G7JsEyma6CGdsHJ3QSmPBS4RJqPutN
         GIAuHk+7NBdCm1PWAD9riPTXa379NbUdg0WrtoTsacqC+VFNKaWwFqKI6thCuUOZ1oJV
         IXNA==
X-Gm-Message-State: AOAM530iohCk6UuUEyH1/YE0SXkLh37U20LmT9WROxHja4l/HxVkzUt+
        njcY09XuFK089Ore6CQGFcXMTbIYfWaZmRj6Ed6Mtw==
X-Google-Smtp-Source: ABdhPJzhN75cYX0QdxPZZrVkTo8LNm3eo8IzoivQ7mSAH2J9FquztKwBCIMLaRlaWOOdBUUox7ZGcX1wvMYGNrjgk1w=
X-Received: by 2002:a05:651c:20b:: with SMTP id y11mr22911109ljn.463.1633439466354;
 Tue, 05 Oct 2021 06:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210926224058.1252-1-digetx@gmail.com> <20210926224058.1252-7-digetx@gmail.com>
 <CAPDyKFq+LS4Jr1GyC-a-tGWPzGH0JxfJ9wKY=uQEBGYm952azw@mail.gmail.com> <24101cd6-d3f5-1e74-db39-145ecd30418b@gmail.com>
In-Reply-To: <24101cd6-d3f5-1e74-db39-145ecd30418b@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 Oct 2021 15:10:30 +0200
Message-ID: <CAPDyKFreK7976PJL-1zySoza_yXM7rMQ64aODWUZ+U3L-uCa0w@mail.gmail.com>
Subject: Re: [PATCH v13 06/35] clk: tegra: Support runtime PM and power domain
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 2 Oct 2021 at 22:44, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 01.10.2021 15:32, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> +static __maybe_unused int tegra_clock_pm_suspend(struct device *dev)
> >> +{
> >> +       struct tegra_clk_device *clk_dev =3D dev_get_drvdata(dev);
> >> +
> >> +       /*
> >> +        * Power management of the clock is entangled with the Tegra P=
MC
> >> +        * GENPD because PMC driver enables/disables clocks for toggli=
ng
> >> +        * of the PD's on/off state.
> >> +        *
> >> +        * The PMC GENPD is resumed in NOIRQ phase, before RPM of the =
clocks
> >> +        * becomes available, hence PMC can't use clocks at the early =
resume
> >> +        * phase if RPM is involved. For example when 3d clock is enab=
led,
> >> +        * it may enable the parent PLL clock that needs to be RPM-res=
umed.
> >> +        *
> >> +        * Secondly, the PLL clocks may be enabled by the low level su=
spend
> >> +        * code, so we need to assume that PLL is in enabled state dur=
ing
> >> +        * suspend.
> >> +        *
> >> +        * We will keep PLLs and system clock resumed during suspend t=
ime.
> >> +        * All PLLs on all SoCs are low power and system clock is alwa=
ys-on,
> >> +        * so practically not much is changed here.
> >> +        */
> >> +
> >> +       return clk_prepare(clk_dev->hw->clk);
> > I am trying to understand, more exactly, what you intend to achieve
> > with the clk_prepare() here. It looks a bit weird, to me. Can you try
> > to elaborate a bit more on the use case?
>
> The Tegra GENPD driver enable/disable clocks when domain is turned on.

Okay. I noticed that in tegra_genpd_power_on(). And the same clocks
are enabled/disabled also in tegra_genpd_power_off(), when powering
off the PM domain.

So I guess the problem kind of exists for tegra_genpd_power_off() too?

> This can't be done during early system resume, when domains are getting
> turned on by the drivers core, because when clock is enabled, it's
> getting prepared (RPM-resumed) and this preparation fails because
> performance state of the clock goes up and it doesn't work during the
> early resume time since I2C, which applies the state to hardware, is
> suspended and can't work at that early time.

This sounds complicated and I still don't quite follow all of it, sorry.

So, tegra_genpd_power_on() gets called from genpd_resume_noirq(), when
the first device of the attached devices to genpd gets resumed. And
vice versa for tegra_genpd_power_off() and genpd_suspend_noirq().

Are you saying that trying to enable/disable clocks from
tegra_genpd_power_on|off() in these paths doesn't work, because it
would also require the performance state to be changed, which would
fail because the I2C bus/driver is suspended?

>
> Secondly, Tegra has arch-specific low level assembly which touches
> clocks during last phase of system suspend and in the beginning of
> resume. Hence, clocks should stay prepared during suspend just because
> technically clock should be prepared before it can be enabled.

So the low level code is gating and ungating the clock behind the back
of the clock driver then? Why is that done like that, more exactly?

>
> > Is this rather about making sure that the clock's corresponding PM
> > domain stays powered on during system suspend? In that case, I think
> > there may be an alternative option....
> >
>
> This is not about domain staying powered on, this is about keeping the
> performance state of the domain high during suspend.

Right, so the PM domain managed in tegra_genpd_power_on|off() can
still be powered on/off, as long as the clock remains ungated?

Kind regards
Uffe

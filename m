Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6623EFF3D
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 10:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbhHRIgX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Aug 2021 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbhHRIgW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Aug 2021 04:36:22 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6741BC061796
        for <linux-pwm@vger.kernel.org>; Wed, 18 Aug 2021 01:35:48 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id s19so1260282vsl.11
        for <linux-pwm@vger.kernel.org>; Wed, 18 Aug 2021 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSrv+O3TCSW7cnAdJHoCzYxKAHMXFEbzmyCWpuUlKoA=;
        b=RvY/jkXxbAxhbejbhMhOx5m5pFICa1DjcAOGeLJ7Wj4+NnrlQTP43TzpsRFep1JuC0
         jjsEdR5Sfv4a46pjC5HeyNwlkFXs5ZoGbAdEHP8nbsLbwgDfxMA0VLsZ4sAxMJRV4mLW
         dSespNFG/uvXR/ZW39JUOK9BLxf8mk1WID8zgZpuFGqAaQDzTQz38k7uJeJxmgAVAmpm
         Z+x9YgOHPVn/vTMzWLFUUkw+FlGiQOiB5nzyvSzqnlo/nOvWO5fH93uQPcSphn3gJxjO
         Ww6B2AEhe5tNZTMbYBxAuxTYbw1ul/ILTwXNwMEmv6K/9UW9Wx7QIc3Fi/3JmvUSGIAc
         FWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSrv+O3TCSW7cnAdJHoCzYxKAHMXFEbzmyCWpuUlKoA=;
        b=a/5ZKHLy5pGJhVFM03BbNcJV4VsKFW6cPcA3E2tGNKZ0bSvk6kK7hDsSIXeB48JqMR
         NPmM1lpQBr2vIflsbBcqdjqgx3MUfZx1uzFCIYjNFbI6gNUYLBoDRcE9Sc09pBUF7kOD
         eGheVA2ypihjspe1VvBQ3g2Ddrc3lDI3Rp12UkrjLAspIxG2PE1VBtt24Q+3Md4d44lr
         v985OALlaQwuUm+cuAKgSD51CyH71ISd4nZ5PUBrdXUuTZ6M2dkRawn3Z1OgsI+smQav
         pK0OGJLSN3vks4wH4+p5aGvpxIVnR4rIOFRmqhHRKw2bKD8W5dF7NBvI0cY/Myz9ekiL
         qyZQ==
X-Gm-Message-State: AOAM533wy4vxng8XeOWDmdJjd/sRXVZq3mLTEyqjE7SsS2w+CYjDWq6w
        U57F7W6yEvnf90IcTCwaNsHzUjDz6N+HvdHmTg88Rg==
X-Google-Smtp-Source: ABdhPJxfVbNmo+y9lVXwMUpwV89/qvFiwVR66AUipk2ir89qZuIeawGetBYzPol3o/SxK7XiQzvipAWUl+UAJR794SQ=
X-Received: by 2002:a67:f6d8:: with SMTP id v24mr6490718vso.48.1629275747436;
 Wed, 18 Aug 2021 01:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210817012754.8710-1-digetx@gmail.com> <20210817012754.8710-12-digetx@gmail.com>
 <CAPDyKFrax-EYtO03W5QWM2tcWLWeMM8hHZCRYFcsenuiP2zObQ@mail.gmail.com> <YRvBkyfFCqthBIBV@orome.fritz.box>
In-Reply-To: <YRvBkyfFCqthBIBV@orome.fritz.box>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Aug 2021 10:35:11 +0200
Message-ID: <CAPDyKFp+9Bv3EVSnV683ixNXzukJtmG_QrS5C1ZQqLxv9QJ-bQ@mail.gmail.com>
Subject: Re: [PATCH v8 11/34] gpu: host1x: Add runtime PM and OPP support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 17 Aug 2021 at 16:03, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Aug 17, 2021 at 02:04:38PM +0200, Ulf Hansson wrote:
> > On Tue, 17 Aug 2021 at 03:30, Dmitry Osipenko <digetx@gmail.com> wrote:
> > >
> > > Add runtime PM and OPP support to the Host1x driver. It's required for
> > > enabling system-wide DVFS and supporting dynamic power management using
> > > a generic power domain. For the starter we will keep host1x always-on
> > > because dynamic power management require a major refactoring of the driver
> > > code since lot's of code paths will need the RPM handling and we're going
> > > to remove some of these paths in the future. Host1x doesn't consume much
> > > power so it is good enough, we at least need to resume Host1x in order
> > > to initialize the power state.
> > >
> > > Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> > > Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
> > > Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
> > > Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > ---
> >
> > [...]
> >
> > > +
> > >  static int host1x_probe(struct platform_device *pdev)
> > >  {
> > >         struct host1x *host;
> > > @@ -394,6 +423,10 @@ static int host1x_probe(struct platform_device *pdev)
> > >         /* set common host1x device data */
> > >         platform_set_drvdata(pdev, host);
> > >
> > > +       err = devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);
> > > +       if (err)
> > > +               return err;
> > > +
> > >         host->regs = devm_ioremap_resource(&pdev->dev, regs);
> > >         if (IS_ERR(host->regs))
> > >                 return PTR_ERR(host->regs);
> > > @@ -423,12 +456,9 @@ static int host1x_probe(struct platform_device *pdev)
> > >                 return err;
> > >         }
> > >
> > > -       host->rst = devm_reset_control_get(&pdev->dev, "host1x");
> > > -       if (IS_ERR(host->rst)) {
> > > -               err = PTR_ERR(host->rst);
> > > -               dev_err(&pdev->dev, "failed to get reset: %d\n", err);
> > > +       err = host1x_get_resets(host);
> > > +       if (err)
> > >                 return err;
> > > -       }
> > >
> > >         err = host1x_iommu_init(host);
> > >         if (err < 0) {
> > > @@ -443,22 +473,10 @@ static int host1x_probe(struct platform_device *pdev)
> > >                 goto iommu_exit;
> > >         }
> > >
> > > -       err = clk_prepare_enable(host->clk);
> > > -       if (err < 0) {
> > > -               dev_err(&pdev->dev, "failed to enable clock\n");
> > > -               goto free_channels;
> > > -       }
> > > -
> > > -       err = reset_control_deassert(host->rst);
> > > -       if (err < 0) {
> > > -               dev_err(&pdev->dev, "failed to deassert reset: %d\n", err);
> > > -               goto unprepare_disable;
> > > -       }
> > > -
> >
> > Removing the clk_prepare_enable() and reset_control_deassert() from
> > host1x_probe(), might not be a good idea. See more about why, below.
> >
> > >         err = host1x_syncpt_init(host);
> > >         if (err) {
> > >                 dev_err(&pdev->dev, "failed to initialize syncpts\n");
> > > -               goto reset_assert;
> > > +               goto free_channels;
> > >         }
> > >
> > >         err = host1x_intr_init(host, syncpt_irq);
> > > @@ -467,10 +485,14 @@ static int host1x_probe(struct platform_device *pdev)
> > >                 goto deinit_syncpt;
> > >         }
> > >
> > > -       host1x_debug_init(host);
> > > +       pm_runtime_enable(&pdev->dev);
> > >
> > > -       if (host->info->has_hypervisor)
> > > -               host1x_setup_sid_table(host);
> > > +       /* the driver's code isn't ready yet for the dynamic RPM */
> > > +       err = pm_runtime_resume_and_get(&pdev->dev);
> >
> > If the driver is being built with the CONFIG_PM Kconfig option being
> > unset, pm_runtime_resume_and_get() will return 0 to indicate success -
> > and without calling the ->runtime_resume() callback.
> > In other words, the clock will remain gated and the reset will not be
> > deasserted, likely causing the driver to be malfunctioning.
> >
> > If the driver isn't ever being built with CONFIG_PM unset, feel free
> > to ignore my above comments.
> >
> > Otherwise, if it needs to work both with and without CONFIG_PM being
> > set, you may use the following pattern in host1x_probe() to deploy
> > runtime PM support:
> >
> > "Enable the needed resources to probe the device"
> > pm_runtime_get_noresume()
> > pm_runtime_set_active()
> > pm_runtime_enable()
> >
> > "Before successfully completing probe"
> > pm_runtime_put()
>
> We made a conscious decision a few years ago to have ARCH_TEGRA select
> PM on both 32-bit and 64-bit ARM, specifically to avoid the need to do
> this dance (though there are still a few drivers left that do this, I
> think).
>
> So I think this should be unnecessary. Unless perhaps if the sysfs PM
> controls have any influence on this. As far as I know, as long as the
> PM kconfig option is enabled, the sysfs control only influence the
> runtime behaviour (i.e. setting the sysfs PM control to "on" is going
> to force runtime PM to be resumed) but there's no way to disable
> runtime PM altogether via sysfs that would make the above necessary.

Thanks for clarifying! As I said, feel free to ignore my comments then.

For this and the other patches in the series, I assume you only need
to care about whether the driver is a cross SoC driver and used on
other platforms than Tegra then.

>
> Thierry

Kind regards
Uffe

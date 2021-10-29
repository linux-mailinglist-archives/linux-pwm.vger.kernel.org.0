Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F89243FFED
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 17:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJ2P67 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Fri, 29 Oct 2021 11:58:59 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44965 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2P66 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 11:58:58 -0400
Received: by mail-oi1-f174.google.com with SMTP id y207so13932305oia.11;
        Fri, 29 Oct 2021 08:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/SMjFsF1c2jJAFrAQjbA6gkypuYLRMtEM9UCUe5CB44=;
        b=XvruEgbq7nqBo2gsz2lqSNIuzXn6FpXLiQUfC9viytYOUOOubxsaauhvlk/erw/vpH
         AciuLqAWXCYdmEsrF0CKe9BF+IADh3luNjqBujkPMlQr99xcq55DfpFEeZz+kC6fn8VO
         pim4ETWFcwQo20zJPFtC/H11hQPevtK61qNNvNEuNGz0dNGsS0r0wm/e6HoJNYMbBOCp
         ukmC8ao2yWYJ66hYb4U+RFaZtnql/A1T5VrCvmYKRisg5OvLVi2S4d+IHzBXw7dLnbDj
         /Sqmi7ohii0MYS1VquVNTORF0LIJzcycXiebwZw+tHpZ25cRj/R2/ywYsqyWxktsLzbR
         4wOw==
X-Gm-Message-State: AOAM530bRLEOof/BF2tsgePqfh/DyLDffSdjP87y8B814ukz+TUXY2Mv
        tRx5Dcj3l//1WktkiRYJJnYZU2UG1KiE/LresbM=
X-Google-Smtp-Source: ABdhPJyt4UMxkF1vsuAi+BGZn90y8TkCvU/MAtayV4OwG5udI4L0shq0uzCyV4nG28Fc/pQknaSM5LL0g9M7DRCchMM=
X-Received: by 2002:a05:6808:128d:: with SMTP id a13mr2577oiw.51.1635522989816;
 Fri, 29 Oct 2021 08:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211025224032.21012-1-digetx@gmail.com> <20211025224032.21012-21-digetx@gmail.com>
 <09c05206-c0e5-9a25-8ffa-b9291f6ea5ae@gmail.com>
In-Reply-To: <09c05206-c0e5-9a25-8ffa-b9291f6ea5ae@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Oct 2021 17:56:18 +0200
Message-ID: <CAJZ5v0i9OtA1nDiv8UXuF3ASdENFYJFV7+nMWm6Pcu=kw8k1aQ@mail.gmail.com>
Subject: Re: [PATCH v14 20/39] pwm: tegra: Add runtime PM and OPP support
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 29, 2021 at 5:20 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 26.10.2021 01:40, Dmitry Osipenko пишет:
> > +     ret = devm_pm_runtime_enable(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = pm_runtime_resume_and_get(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       /* Set maximum frequency of the IP */
> > -     ret = clk_set_rate(pwm->clk, pwm->soc->max_frequency);
> > +     ret = dev_pm_opp_set_rate(pwm->dev, pwm->soc->max_frequency);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
> > -             return ret;
> > +             goto put_pm;
> >       }
> >
> >       /*
> > @@ -278,7 +294,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
> >       if (IS_ERR(pwm->rst)) {
> >               ret = PTR_ERR(pwm->rst);
> >               dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
> > -             return ret;
> > +             goto put_pm;
> >       }
> >
> >       reset_control_deassert(pwm->rst);
> > @@ -291,10 +307,15 @@ static int tegra_pwm_probe(struct platform_device *pdev)
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> >               reset_control_assert(pwm->rst);
> > -             return ret;
> > +             goto put_pm;
> >       }
> >
> > +     pm_runtime_put(&pdev->dev);
> > +
> >       return 0;
> > +put_pm:
> > +     pm_runtime_put_sync_suspend(&pdev->dev);
> > +     return ret;
> >  }
> >
> >  static int tegra_pwm_remove(struct platform_device *pdev)
> > @@ -305,20 +326,44 @@ static int tegra_pwm_remove(struct platform_device *pdev)
> >
> >       reset_control_assert(pc->rst);
> >
> > +     pm_runtime_force_suspend(&pdev->dev);
>
> I just noticed that RPM core doesn't reset RPM-enable count of a device
> on driver's unbind (pm_runtime_reinit). It was a bad idea to use
> devm_pm_runtime_enable() + pm_runtime_force_suspend() here, since RPM is
> disabled twice on driver's removal, and thus, RPM will never be enabled
> again.
>
> I'll fix it for PWM and other drivers in this series, in v15.

Well, for the record, IMV using pm_runtime_force_suspend() is
generally a questionable idea.

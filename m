Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD841EF1E
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Oct 2021 16:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354089AbhJAOJV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 1 Oct 2021 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354054AbhJAOJU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 1 Oct 2021 10:09:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8880BC06177C
        for <linux-pwm@vger.kernel.org>; Fri,  1 Oct 2021 07:07:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j5so34461205lfg.8
        for <linux-pwm@vger.kernel.org>; Fri, 01 Oct 2021 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ccy11Z40KixrI11cltYn5ZcJWVQJimHuRt26MAfNhAc=;
        b=mmVOZyqaAUMBtkBBuhdoApFSqfWX3cINwimlNhKZZQP7bUFuplZ9/aIK4LLMO7vJCr
         qyOqhGyIhI6KCEeiPZLwsC2b07LxNGLnpuzcmV6qFpBXMzpeNGktITcYb5/i+tzmqwrz
         7cx5/5peX588jl+VQ6N9Q3TMW7Iyn5I2zgmwHgFqykeahAizRFvqAC2iniw39z6abLEf
         On4jq92Ck02U2dkeqDjvca7VUTt4ZNUqTok0sAkszvDNL97AkFeYH3gKMQAjfU2Ojvja
         rqUwI5xXgPNFICuQzirzLNc0KSzY72zsy/ztBJ8fxgCLJn6zrD/25W2AyKPQmJOLsPTv
         M6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ccy11Z40KixrI11cltYn5ZcJWVQJimHuRt26MAfNhAc=;
        b=3H/5ewED4vYW09NPiuTcTSjhXroqkGrszDB2w/r51J8MG2qh+oKNfzRpIU/OKPf9PW
         0By3lnFhpWl6myov9NVcl+2XziS8U6+Cj7hpY5VwHH4dNj3M0MUJUFCQjECJaa1D/BFB
         KXrQcCjr0YCoEoZAKaJbh6Z8A0rK6ccTjksX948ivyZLcX0sh3d7r1DUUy+KmTv5/Uzn
         YSUTmQda0i58gBsFMWHsglKdA323pEoHxVqvhpIc+Ir8pogbwqnqw06CTm+KvFfj892F
         Tk/ejzXtdDOqxLp0raX1PQyiBK913TFcsmim2UrT4mXg8Y6iwag6SEF8CGifhPxdpqid
         gX8g==
X-Gm-Message-State: AOAM532V+P2AWS5QgoMTHe6hvJUH9bV480ymOWh7R/r9BpbdyBkWAkHJ
        LAKHH3zbCNci8g+54XaN4d19h78jh+QZFLI7CyXjfw==
X-Google-Smtp-Source: ABdhPJxCT1fIjn0eX7h16hKPoCW6SQiHV9gFT4j/a+Ne56Lp+H5G5HrNrutb2Cfj1iLro5ZcopboLjBeTUlfzWnHMBA=
X-Received: by 2002:a2e:898c:: with SMTP id c12mr12102788lji.16.1633097254789;
 Fri, 01 Oct 2021 07:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210926224058.1252-1-digetx@gmail.com> <20210926224058.1252-15-digetx@gmail.com>
In-Reply-To: <20210926224058.1252-15-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Oct 2021 16:06:58 +0200
Message-ID: <CAPDyKFoZdmnmcdoWsD36uQesSjz8KJOq0JxY5tNbHgO_xMy+_g@mail.gmail.com>
Subject: Re: [PATCH v13 14/35] drm/tegra: gr3d: Support generic power domain
 and runtime PM
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
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 27 Sept 2021 at 00:42, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Add runtime power management and support generic power domains.
>
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/gr3d.c | 388 ++++++++++++++++++++++++++++++-----

[...]

> +
> +static int gr3d_probe(struct platform_device *pdev)
> +{
> +       struct host1x_syncpt **syncpts;
> +       struct gr3d *gr3d;
> +       unsigned int i;
> +       int err;
> +
> +       gr3d = devm_kzalloc(&pdev->dev, sizeof(*gr3d), GFP_KERNEL);
> +       if (!gr3d)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, gr3d);
> +
> +       gr3d->soc = of_device_get_match_data(&pdev->dev);
> +
> +       syncpts = devm_kzalloc(&pdev->dev, sizeof(*syncpts), GFP_KERNEL);
> +       if (!syncpts)
> +               return -ENOMEM;
> +
> +       err = gr3d_get_clocks(&pdev->dev, gr3d);
> +       if (err)
> +               return err;
> +
> +       err = gr3d_get_resets(&pdev->dev, gr3d);
> +       if (err)
> +               return err;
> +
> +       err = gr3d_init_power(&pdev->dev, gr3d);
> +       if (err)
> +               return err;
> +
>         INIT_LIST_HEAD(&gr3d->client.base.list);
>         gr3d->client.base.ops = &gr3d_client_ops;
>         gr3d->client.base.dev = &pdev->dev;
> @@ -352,20 +552,36 @@ static int gr3d_probe(struct platform_device *pdev)
>         gr3d->client.version = gr3d->soc->version;
>         gr3d->client.ops = &gr3d_ops;
>
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 200);
> +
> +       err = devm_pm_opp_register_set_opp_helper(&pdev->dev, gr3d_set_opp);
> +       if (err)
> +               goto disable_rpm;
> +
> +       err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
> +       if (err)
> +               goto disable_rpm;
> +
>         err = host1x_client_register(&gr3d->client.base);
>         if (err < 0) {
>                 dev_err(&pdev->dev, "failed to register host1x client: %d\n",
>                         err);
> -               return err;
> +               goto disable_rpm;
>         }
>
>         /* initialize address register map */
>         for (i = 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
>                 set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
>
> -       platform_set_drvdata(pdev, gr3d);
> -
>         return 0;
> +
> +disable_rpm:
> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);

Similar comment as for patch13.

> +
> +       return err;
>  }
>
>  static int gr3d_remove(struct platform_device *pdev)
> @@ -380,23 +596,83 @@ static int gr3d_remove(struct platform_device *pdev)
>                 return err;
>         }
>
> -       if (gr3d->clk_secondary) {
> -               reset_control_assert(gr3d->rst_secondary);
> -               tegra_powergate_power_off(TEGRA_POWERGATE_3D1);
> -               clk_disable_unprepare(gr3d->clk_secondary);
> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);

Similar comment as for patch13. You may want to use
pm_runtime_force_suspend() in favor of pm_runtime_disable().

> +
> +       return 0;
> +}

[...]

I was looking for a call to dev_pm_opp_set_rate(), but couldn't find
it. Isn't that needed when changing the rate of the clock?

Kind regards
Uffe

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858D141EE89
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Oct 2021 15:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhJAN3o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 1 Oct 2021 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhJAN3n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 1 Oct 2021 09:29:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBCAC061775
        for <linux-pwm@vger.kernel.org>; Fri,  1 Oct 2021 06:27:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i4so39251752lfv.4
        for <linux-pwm@vger.kernel.org>; Fri, 01 Oct 2021 06:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnpGYuY4J1MVx4KDnwBO9exyn8J4DWmp5PYIqZLE1ug=;
        b=soKJl7cwWQ3W4UwDFjN+58V2v5RYuIU0YxRyxYMaINgwEK5Kb355awQUMWcroWHbJo
         Me+RUP02Enm/bzqDvehZEy7fQWF2sFk9LJqMd5m/oBPklwKMhRK7hJMny9eAuGu48VPg
         MSymtPMTr3GkgTLH1I0AnDMIx+ROIV7T3NCdZ0xbue3PhEXGHJsxVY0jL8xMzXcrMbrF
         kX9nrs5tMRkTdxtvQynLy7JVj76hAaAk5aVHedbxGyXGBw0WCCM+yzL88UZ1fDKJWz6p
         2U52t9cbC9WvtuCg3In2JTTZikJOCaAF8ZLYIYIgSv9a8V8aXXGALPL3LrFK+MyO1ntj
         GZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnpGYuY4J1MVx4KDnwBO9exyn8J4DWmp5PYIqZLE1ug=;
        b=qhx0crv/4leJiZPPlg/9NBJNmF2GlAoJoMoMTeZBh83MywGcFDFe7SNzu/PnZxKl/5
         mSlMQ86ke1108paJ+wq+TycwhZHdp9HVLptYiu961Npp7K/gTkCWfrEnjV/WI2Iw/8MT
         Q6m2MAy74HfhV3uRJ2+Mmj6dT9RalUUJJqeFVQNNmJJCENG4WxMjyoZzSQzZQT1jAVhq
         ha3R/DlfHtky7G4GisLqIO+F4CvJ5IdTrTC9/hBFJczgy1bDBewAP9e9cEMhMk0cTIBg
         M/VS7QCU1YrLiMxAYfwjW2w7XNLEpY6SRoaOzqna4hy41PMWzeAJ6YSXdEKj76idv/vG
         xqOw==
X-Gm-Message-State: AOAM532Faeneyj4AuB7O8pQCnaqYQgN0+KV72WAWymhGFV6omuDSA84A
        O+Sg1qa1yLSvLKSYP9bS/xGk5IVdoJBFTvk9u4pGDw==
X-Google-Smtp-Source: ABdhPJxX1GobNBTGZAnR139s5Ubq3WBZYj+/TS7clunNypQi+CGy+oUt/x9SJI6rsK1E9roKL3hS5JPL62b+VvMRdQw=
X-Received: by 2002:a05:651c:20b:: with SMTP id y11mr12340667ljn.463.1633094876449;
 Fri, 01 Oct 2021 06:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210926224058.1252-1-digetx@gmail.com> <20210926224058.1252-12-digetx@gmail.com>
In-Reply-To: <20210926224058.1252-12-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Oct 2021 15:27:20 +0200
Message-ID: <CAPDyKFobSsFOnmFc4BG353uYgECGD1U1U020oQwB7pX0mfCfvw@mail.gmail.com>
Subject: Re: [PATCH v13 11/35] drm/tegra: dc: Support OPP and SoC core voltage scaling
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
> Add OPP and SoC core voltage scaling support to the display controller
> driver. This is required for enabling system-wide DVFS on pre-Tegra186
> SoCs.
>
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c | 74 ++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tegra/dc.h |  2 ++
>  2 files changed, 76 insertions(+)
>
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index a29d64f87563..d4047a14e2b6 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -11,9 +11,12 @@
>  #include <linux/interconnect.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>
> +#include <soc/tegra/common.h>
>  #include <soc/tegra/pmc.h>
>
>  #include <drm/drm_atomic.h>
> @@ -1762,6 +1765,47 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
>         return 0;
>  }
>
> +static void tegra_dc_update_voltage_state(struct tegra_dc *dc,
> +                                         struct tegra_dc_state *state)
> +{
> +       unsigned long rate, pstate;
> +       struct dev_pm_opp *opp;
> +       int err;
> +
> +       if (!dc->has_opp_table)
> +               return;
> +
> +       /* calculate actual pixel clock rate which depends on internal divider */
> +       rate = DIV_ROUND_UP(clk_get_rate(dc->clk) * 2, state->div + 2);
> +
> +       /* find suitable OPP for the rate */
> +       opp = dev_pm_opp_find_freq_ceil(dc->dev, &rate);
> +
> +       if (opp == ERR_PTR(-ERANGE))
> +               opp = dev_pm_opp_find_freq_floor(dc->dev, &rate);
> +
> +       if (IS_ERR(opp)) {
> +               dev_err(dc->dev, "failed to find OPP for %luHz: %pe\n",
> +                       rate, opp);
> +               return;
> +       }
> +
> +       pstate = dev_pm_opp_get_required_pstate(opp, 0);
> +       dev_pm_opp_put(opp);
> +
> +       /*
> +        * The minimum core voltage depends on the pixel clock rate (which
> +        * depends on internal clock divider of the CRTC) and not on the
> +        * rate of the display controller clock. This is why we're not using
> +        * dev_pm_opp_set_rate() API and instead controlling the power domain
> +        * directly.
> +        */
> +       err = dev_pm_genpd_set_performance_state(dc->dev, pstate);
> +       if (err)
> +               dev_err(dc->dev, "failed to set power domain state to %lu: %d\n",
> +                       pstate, err);

Yeah, the above code looks very similar to the code I pointed to in
patch6. Perhaps we need to discuss with Viresh, whether it makes sense
to fold in a patch adding an opp helper function after all, to avoid
the open coding.

Viresh?

[...]

Kind regards
Uffe

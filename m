Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F0E2A7B27
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 10:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgKEJ6t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 04:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKEJ6s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Nov 2020 04:58:48 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513FC0613CF;
        Thu,  5 Nov 2020 01:58:46 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id w13so1697028eju.13;
        Thu, 05 Nov 2020 01:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/0+xGMrqmCQCrjRIhp34cgoVWyVPh+6Sc63/MCPbP8=;
        b=i+mDDBQGg9bf9ZIFzChyy7Rq+AK2ujK0vNsYtVg1phv8sxI4NYIxwWWLXmBO1AoPnr
         2uAFrojlzm/ql3PTMenBeK5Xq0Ad0WXHmPNn+Zt5r98YKoAxvp2wSLmxnWNwYgCvB4CN
         lRm9qRiNr4WJ1qN37G+/1M5YXyx4EmkOfDqMpjAfr9MPFTJ7M8zyrThQ9cssePg7fEGo
         5AAqlqj48wJIvqREQzT41ALbORJ0Ke8tq/ZFNwNADWHAos3p8LRY0+kFTfxfvmQpfEYt
         J2J4a7RvoVFp+QSO8Q29MM0YfPsa+NYD2yQ4RoaPzew1LRwJnQfhkx6+8bZPNJFsNw4N
         H0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/0+xGMrqmCQCrjRIhp34cgoVWyVPh+6Sc63/MCPbP8=;
        b=kzmvHvs3ZJroBVFHFZFT07r1boly2Z3teu4PGHAoeEkiUM0w1t+9LFjHfovCbkO8TY
         T6M3k/Qgau6HS1RuH2g+YvJc3DZXnLigkp7BLMmEiCfLVSZ78hJYeznmuI3bTXZvDGHb
         uXUPh8Xe87IFAikknPq/yg5F2NwMCcsYNi/w536H5JVnRARY1VrUhGfBnxaiz7E4q5cA
         B7bY971Z2nF1ew76nVkO1ba/d1XojGLadFpebylK7oB8NU4a/7Ql3vQrp7jsOspFepvM
         EmSXeCk9emuasIKU9+Olz9iP+xFA/e1Y3BP7pcBG353WjA9xdudWs5z6wtFDvdldGVac
         aE7Q==
X-Gm-Message-State: AOAM5321qAQuUb8Ps3CS3v1DO6wTLWJgMIai9OVu1LWSKx+t00D8exgt
        ZU2CwpKVfnowlEOP+ui2ikRvJ24ixXZTFffPcSQ=
X-Google-Smtp-Source: ABdhPJyn8dHU+iql4LIPEGykzYeJPOpKnFuZLrqcQJDf2Cin2XWenUKK05ejEnpNpXJIWT3fxGVNQdHuR8JyYUjfQ0g=
X-Received: by 2002:a17:906:3689:: with SMTP id a9mr1424841ejc.403.1604570325540;
 Thu, 05 Nov 2020 01:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20201104234427.26477-1-digetx@gmail.com> <20201104234427.26477-18-digetx@gmail.com>
In-Reply-To: <20201104234427.26477-18-digetx@gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 5 Nov 2020 15:28:34 +0530
Message-ID: <CAOh2x==sy1w7_oEV8=toC6uQnSN44wyOixbP_X0BrMsnm1AUFg@mail.gmail.com>
Subject: Re: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage scaling
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        driver-dev <devel@driverdev.osuosl.org>,
        linux-pwm@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 5, 2020 at 5:15 AM Dmitry Osipenko <digetx@gmail.com> wrote:

> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c

> +static void sdhci_tegra_deinit_opp_table(void *data)
> +{
> +       struct device *dev = data;
> +       struct opp_table *opp_table;
> +
> +       opp_table = dev_pm_opp_get_opp_table(dev);

So you need to get an OPP table to put one :)
You need to save the pointer returned by dev_pm_opp_set_regulators() instead.

> +       dev_pm_opp_of_remove_table(dev);
> +       dev_pm_opp_put_regulators(opp_table);
> +       dev_pm_opp_put_opp_table(opp_table);
> +}
> +
> +static int devm_sdhci_tegra_init_opp_table(struct device *dev)
> +{
> +       struct opp_table *opp_table;
> +       const char *rname = "core";
> +       int err;
> +
> +       /* voltage scaling is optional */
> +       if (device_property_present(dev, "core-supply"))
> +               opp_table = dev_pm_opp_set_regulators(dev, &rname, 1);
> +       else


> +               opp_table = dev_pm_opp_get_opp_table(dev);

Nice. I didn't think that someone will end up abusing this API and so made it
available for all, but someone just did that. I will fix that in the OPP core.

Any idea why you are doing what you are doing here ?

> +
> +       if (IS_ERR(opp_table))
> +               return dev_err_probe(dev, PTR_ERR(opp_table),
> +                                   "failed to prepare OPP table\n");
> +
> +       /*
> +        * OPP table presence is optional and we want the set_rate() of OPP
> +        * API to work similarly to clk_set_rate() if table is missing in a
> +        * device-tree.  The add_table() errors out if OPP is missing in DT.
> +        */
> +       if (device_property_present(dev, "operating-points-v2")) {
> +               err = dev_pm_opp_of_add_table(dev);
> +               if (err) {
> +                       dev_err(dev, "failed to add OPP table: %d\n", err);
> +                       goto put_table;
> +               }
> +       }
> +
> +       err = devm_add_action(dev, sdhci_tegra_deinit_opp_table, dev);
> +       if (err)
> +               goto remove_table;
> +
> +       return 0;
> +
> +remove_table:
> +       dev_pm_opp_of_remove_table(dev);
> +put_table:
> +       dev_pm_opp_put_regulators(opp_table);
> +
> +       return err;
> +}
> +
>  static int sdhci_tegra_probe(struct platform_device *pdev)
>  {
>         const struct of_device_id *match;
> @@ -1621,6 +1681,10 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>                 goto err_power_req;
>         }
>
> +       rc = devm_sdhci_tegra_init_opp_table(&pdev->dev);
> +       if (rc)
> +               goto err_parse_dt;
> +
>         /*
>          * Tegra210 has a separate SDMMC_LEGACY_TM clock used for host
>          * timeout clock and SW can choose TMCLK or SDCLK for hardware
> --
> 2.27.0
>
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

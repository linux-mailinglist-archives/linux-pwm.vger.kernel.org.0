Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10C03EE7DB
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 09:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbhHQHzx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Aug 2021 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbhHQHzw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Aug 2021 03:55:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A439C0617AD
        for <linux-pwm@vger.kernel.org>; Tue, 17 Aug 2021 00:55:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so3752874pjn.4
        for <linux-pwm@vger.kernel.org>; Tue, 17 Aug 2021 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6syxEk4ci6YIB/Nq5OYMmva/mb8yTCwuOVtI6kBv8o4=;
        b=ACQXwBJ7OYjyZRVhhS/c9nneyhB/7GFHh3dEptJSMrZINFg36aQMQ7Gt7s7mEUBpCw
         zQlnh/X4OgBYC+KUUJhyCLfP1qSGXkpJPWAGfJpM/INHjdAZ8/L1JkEYsFztN3Yjcf8Y
         CLx5rb8MRnnLnlOw941FjpRCL/gP5pp6YSMCeI+89Jy/Rd1+N1g4DWNkDQt5p2lrVfbf
         /2f4gxbIqWPYLcL72Mw6S4MUH55MP9SVIVTvv1bjke3ugxDHQALvD0J7WbGxZqFUjEZx
         7P1AM3kpvDdhJRiWVIeigZKSst/k+rzUIj9Law8crvuO6T67AGjOgt6Tme7gr0jaocjL
         3BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6syxEk4ci6YIB/Nq5OYMmva/mb8yTCwuOVtI6kBv8o4=;
        b=bsw5gCcampHVgH51+rycVKeVjMysRk6fE4zgnbz/EQLyLSghHF4kYT6oLYqxU/3rp0
         HS8miuS0p9wdnpw1Z6sO08h61H5qhPZFOh5Mk96CKmxN04AxGkodnHIfYWQyKphoC4th
         Cp1zE2ODR7djFcxcuVIPLadwDoA2SrDbHCfEtlfJzA62NXLCEnRfNx9fkGErjUjB84/v
         tWpdqgUF+Z5qhxuGxgQdSzDR08r/rkCOkU82MCtbMbwWV+okxWR9qi2ddSfTwLiu4/jh
         xrI5R1CBoKV9hBJhRZv2whHogz6Xr6QkEAyrXVe5Ll2QU/FygId3UqMmics5yQbKaxZg
         t2SQ==
X-Gm-Message-State: AOAM532ubYUCeCmNPq7Q0xzUCRkYrCPZ1M686SfZYjIi+gH07HdtBmXd
        q1PTtlHmWyUPH58e7cNoXpJbbw==
X-Google-Smtp-Source: ABdhPJy9z80wO3ZS4ZOBoRu271xrntCgw/Td4lOHD9BJvY7rOCcDAdlvae5dCy1DGcWdIK214rqywQ==
X-Received: by 2002:a17:90b:4a09:: with SMTP id kk9mr2300035pjb.163.1629186918789;
        Tue, 17 Aug 2021 00:55:18 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id c12sm1471425pfl.56.2021.08.17.00.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 00:55:18 -0700 (PDT)
Date:   Tue, 17 Aug 2021 13:25:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
Message-ID: <20210817075515.vyyv7z37e6jcrhsl@vireshk-i7>
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817012754.8710-2-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17-08-21, 04:27, Dmitry Osipenko wrote:
> Add dev_pm_opp_sync() helper which syncs OPP table with hardware state
> and vice versa.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c     | 42 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/pm_opp.h |  6 ++++++
>  2 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 5543c54dacc5..18016e49605f 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -939,7 +939,8 @@ static int _set_required_opps(struct device *dev,
>  	return ret;
>  }
>  
> -static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
> +static struct dev_pm_opp *
> +_find_current_opp(struct device *dev, struct opp_table *opp_table)
>  {
>  	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
>  	unsigned long freq;
> @@ -961,7 +962,7 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
>  		mutex_unlock(&opp_table->lock);
>  	}
>  
> -	opp_table->current_opp = opp;
> +	return opp;
>  }
>  
>  static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
> @@ -1003,7 +1004,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>  
>  	/* Find the currently set OPP if we don't know already */
>  	if (unlikely(!opp_table->current_opp))
> -		_find_current_opp(dev, opp_table);
> +		opp_table->current_opp = _find_current_opp(dev, opp_table);
>  
>  	old_opp = opp_table->current_opp;
>  
> @@ -2931,3 +2932,38 @@ int dev_pm_opp_sync_regulators(struct device *dev)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
> +
> +/**
> + * dev_pm_opp_sync() - Sync OPP state
> + * @dev:	device for which we do this operation
> + *
> + * Initialize OPP table accordingly to current clock rate or
> + * first available OPP if clock not available for this device.
> + *
> + * Return: 0 on success or a negative error value.
> + */
> +int dev_pm_opp_sync(struct device *dev)
> +{
> +	struct opp_table *opp_table;
> +	struct dev_pm_opp *opp;
> +	int ret = 0;
> +
> +	/* Device may not have OPP table */
> +	opp_table = _find_opp_table(dev);
> +	if (IS_ERR(opp_table))
> +		return 0;
> +
> +	if (!_get_opp_count(opp_table))
> +		goto put_table;
> +
> +	opp = _find_current_opp(dev, opp_table);
> +	ret = _set_opp(dev, opp_table, opp, opp->rate);

And I am not sure how this will end up working, since new OPP will be
equal to old one. Since I see you call this from resume() at many
places.

what exactly are you trying to do here ? Those details would be good
to have in commit log as well, I haven't really followed V7 of your
series.

-- 
viresh

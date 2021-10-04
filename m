Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA134207F4
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Oct 2021 11:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhJDJNt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Oct 2021 05:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhJDJNt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Oct 2021 05:13:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60890C061745
        for <linux-pwm@vger.kernel.org>; Mon,  4 Oct 2021 02:12:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s16so13971296pfk.0
        for <linux-pwm@vger.kernel.org>; Mon, 04 Oct 2021 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p/zt6Ihrdo7Rv/qMfG//6nHW1vz4Z3xHHD5M5I4jbOQ=;
        b=oEtv2Uyiaed2bmjIbuF/vB0QG9ocT4iPqv/zNYk4oCpeZ3YHAbxSLDzHY++HcFaeBW
         UmfNPQHY0UjD4ITXwNi3bpvEPUmYZANyXj8kPQ+yd9YpDZh/EuZJUYXqrJXbMXIgqOHs
         MOJwMYfTXWFXJFNMIvr0ESA5Rgotq1aXgXjBbgqndwCbKQdFUtx7/X+2FB67HXqo4EUM
         D0fejXbVrkt/jYQXA55NgdwmIRTOYC7jUSKdWhSNcqkUjvK4R8DENenI50eKlclRv3jJ
         zXCfmfV9tYeO303doLc9HPBs6G9mR7PD5vkndfNd5uijzfIEbNOfEC5aAEDG3D3j3LiK
         Gg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p/zt6Ihrdo7Rv/qMfG//6nHW1vz4Z3xHHD5M5I4jbOQ=;
        b=kh1Zfz3rbqD0KyhHaN53jBFx8du29gay3hxyn3d0gIeICGAJ5vHzze1W/pTE3/F3oe
         rW6HgntpGueh5XlhZhAbjaj4jGYnbnNGDlDMNCwZyUlJUjeZ6e3n05f08lBDmBMU0Niu
         odIHr+zbuoMw//eHsDBKmfbXNryB5zGwL69p1+f6JLl0O5XFO4W3bPjqNjI7ufW1B4dk
         qlWQGJs0PWa5/ErNg0Hi6s80BimL/ba5ajY4+dvWKTlhl2GN+OqaEmzRT+oyXNomlTMF
         TmGzr/g9jIDrlwiYwhCrLiC6MZ8TKnp6PYMxDpz8czen787xV7167rhYF/+WTrrulN9H
         0q5Q==
X-Gm-Message-State: AOAM531RdrJw2VcFujHJ4uXvLTNdZEl4WjfOETh/FPG24yQAsboxugxh
        eygkxdBgP54UQydDl9C242DsmQ==
X-Google-Smtp-Source: ABdhPJy0W8ugEcJOIW4QoiueG/Yc3HmOK62CHjUdLDNNiCUoCf91AnhaDt2fgr98vS9LG2/AQVVStQ==
X-Received: by 2002:a62:1610:0:b0:447:53fa:a27 with SMTP id 16-20020a621610000000b0044753fa0a27mr24163749pfw.39.1633338719957;
        Mon, 04 Oct 2021 02:11:59 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id o2sm14351598pja.7.2021.10.04.02.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 02:11:59 -0700 (PDT)
Date:   Mon, 4 Oct 2021 14:41:57 +0530
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
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v13 01/35] opp: Change type of
 dev_pm_opp_attach_genpd(names) argument
Message-ID: <20211004091157.uidbtrhpsl264xjs@vireshk-i7>
References: <20210926224058.1252-1-digetx@gmail.com>
 <20210926224058.1252-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926224058.1252-2-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 27-09-21, 01:40, Dmitry Osipenko wrote:
> Elements of the 'names' array are not changed by the code, constify them
> for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c     | 6 +++---
>  include/linux/pm_opp.h | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 04b4691a8aac..3057beabd370 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2348,12 +2348,12 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>   * "required-opps" are added in DT.
>   */
>  struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
> -		const char **names, struct device ***virt_devs)
> +		const char * const *names, struct device ***virt_devs)
>  {
>  	struct opp_table *opp_table;
>  	struct device *virt_dev;
>  	int index = 0, ret = -EINVAL;
> -	const char **name = names;
> +	const char * const *name = names;
>  
>  	opp_table = _add_opp_table(dev, false);
>  	if (IS_ERR(opp_table))
> @@ -2457,7 +2457,7 @@ static void devm_pm_opp_detach_genpd(void *data)
>   *
>   * Return: 0 on success and errorno otherwise.
>   */
> -int devm_pm_opp_attach_genpd(struct device *dev, const char **names,
> +int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names,
>  			     struct device ***virt_devs)
>  {
>  	struct opp_table *opp_table;
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index a95d6fdd20b6..879c138c7b8e 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -156,9 +156,9 @@ int devm_pm_opp_set_clkname(struct device *dev, const char *name);
>  struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
>  void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
>  int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
> -struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
> +struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
>  void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
> -int devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
> +int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
>  struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
>  int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
> @@ -376,7 +376,7 @@ static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs)
> +static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
> @@ -384,7 +384,7 @@ static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, cons
>  static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
>  
>  static inline int devm_pm_opp_attach_genpd(struct device *dev,
> -					   const char **names,
> +					   const char * const *names,
>  					   struct device ***virt_devs)
>  {
>  	return -EOPNOTSUPP;

Applied. Thanks.

-- 
viresh

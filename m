Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1964379501
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhEJRIS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 10 May 2021 13:08:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3052 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhEJRIR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 13:08:17 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff6lH00Jvz6rnGg;
        Tue, 11 May 2021 01:01:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 19:07:11 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 18:07:09 +0100
Date:   Mon, 10 May 2021 18:05:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Oleksij Rempel" <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <kernel@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-spi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 RESEND 2/6] clk: Provide new devm_clk_helpers for
 prepared and enabled clocks
Message-ID: <20210510180527.00006fbf@Huawei.com>
In-Reply-To: <20210510061724.940447-3-u.kleine-koenig@pengutronix.de>
References: <20210510061724.940447-1-u.kleine-koenig@pengutronix.de>
        <20210510061724.940447-3-u.kleine-koenig@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.123.16]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 10 May 2021 08:17:20 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> When a driver keeps a clock prepared (or enabled) during the whole
> lifetime of the driver, these helpers allow to simplify the drivers.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Given it's not hard to do, might be nice to keep the docs lines under 80 chars.
Other than that... Does what it says on the tin.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/clk/clk-devres.c | 31 ++++++++++++++
>  include/linux/clk.h      | 87 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 91c995815b57..b54f7f0f2a35 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -67,12 +67,43 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
>  }
>  EXPORT_SYMBOL(devm_clk_get);
>  
> +struct clk *devm_clk_get_prepared(struct device *dev, const char *id)
> +{
> +	return __devm_clk_get(dev, id, clk_get, clk_prepare, clk_unprepare);
> +
> +}
> +EXPORT_SYMBOL(devm_clk_get_prepared);
> +
> +struct clk *devm_clk_get_enabled(struct device *dev, const char *id)
> +{
> +	return __devm_clk_get(dev, id, clk_get,
> +			      clk_prepare_enable, clk_disable_unprepare);
> +
> +}
> +EXPORT_SYMBOL(devm_clk_get_enabled);
> +
>  struct clk *devm_clk_get_optional(struct device *dev, const char *id)
>  {
>  	return __devm_clk_get(dev, id, clk_get_optional, NULL, NULL);
>  }
>  EXPORT_SYMBOL(devm_clk_get_optional);
>  
> +struct clk *devm_clk_get_optional_prepared(struct device *dev, const char *id)
> +{
> +	return __devm_clk_get(dev, id, clk_get_optional,
> +			      clk_prepare, clk_unprepare);
> +
> +}
> +EXPORT_SYMBOL(devm_clk_get_optional_prepared);
> +
> +struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id)
> +{
> +	return __devm_clk_get(dev, id, clk_get_optional,
> +			      clk_prepare_enable, clk_disable_unprepare);
> +
> +}
> +EXPORT_SYMBOL(devm_clk_get_optional_enabled);
> +
>  struct clk_bulk_devres {
>  	struct clk_bulk_data *clks;
>  	int num_clks;
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 266e8de3cb51..b3c5da388b08 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -449,7 +449,7 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
>   * the clock producer.  (IOW, @id may be identical strings, but
>   * clk_get may return different clock producers depending on @dev.)
>   *
> - * Drivers must assume that the clock source is not enabled.
> + * Drivers must assume that the clock source is neither prepared nor enabled.
>   *
>   * devm_clk_get should not be called from within interrupt context.
>   *
> @@ -458,6 +458,47 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
>   */
>  struct clk *devm_clk_get(struct device *dev, const char *id);
>  
> +/**
> + * devm_clk_get_prepared - devm_clk_get() + clk_prepare()
> + * @dev: device for clock "consumer"
> + * @id: clock consumer ID
> + *
> + * Returns a struct clk corresponding to the clock producer, or
> + * valid IS_ERR() condition containing errno.  The implementation
> + * uses @dev and @id to determine the clock consumer, and thereby
> + * the clock producer.  (IOW, @id may be identical strings, but
> + * clk_get may return different clock producers depending on @dev.)
> + *
> + * The returned clk (if valid) is prepared. Drivers must however assume that the
> + * clock is not enabled.
> + *
> + * devm_clk_get_prepared should not be called from within interrupt context.
> + *
> + * The clock will automatically be unprepared and freed when the
> + * device is unbound from the bus.
> + */
> +struct clk *devm_clk_get_prepared(struct device *dev, const char *id);
> +
> +/**
> + * devm_clk_get_enabled - devm_clk_get() + clk_prepare_enable()
> + * @dev: device for clock "consumer"
> + * @id: clock consumer ID
> + *
> + * Returns a struct clk corresponding to the clock producer, or
> + * valid IS_ERR() condition containing errno.  The implementation
> + * uses @dev and @id to determine the clock consumer, and thereby
> + * the clock producer.  (IOW, @id may be identical strings, but
> + * clk_get may return different clock producers depending on @dev.)
> + *
> + * The returned clk (if valid) is prepared and enabled.
> + *
> + * devm_clk_get_prepared should not be called from within interrupt context.
> + *
> + * The clock will automatically be disabled, unprepared and freed when the
> + * device is unbound from the bus.
> + */
> +struct clk *devm_clk_get_enabled(struct device *dev, const char *id);
> +
>  /**
>   * devm_clk_get_optional - lookup and obtain a managed reference to an optional
>   *			   clock producer.
> @@ -469,6 +510,26 @@ struct clk *devm_clk_get(struct device *dev, const char *id);
>   */
>  struct clk *devm_clk_get_optional(struct device *dev, const char *id);
>  
> +/**
> + * devm_clk_get_optional_prepared - devm_clk_get_optional() + clk_prepare()
> + * @dev: device for clock "consumer"
> + * @id: clock consumer ID
> + *
> + * Behaves the same as devm_clk_get_prepared() except where there is no clock producer.
> + * In this case, instead of returning -ENOENT, the function returns NULL.
> + */
> +struct clk *devm_clk_get_optional_prepared(struct device *dev, const char *id);
> +
> +/**
> + * devm_clk_get_optional_enabled - devm_clk_get_optional() + clk_prepare_enable()
> + * @dev: device for clock "consumer"
> + * @id: clock consumer ID
> + *
> + * Behaves the same as devm_clk_get_enabled() except where there is no clock producer.
> + * In this case, instead of returning -ENOENT, the function returns NULL.
> + */
> +struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id);
> +
>  /**
>   * devm_get_clk_from_child - lookup and obtain a managed reference to a
>   *			     clock producer from child node.
> @@ -813,12 +874,36 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
>  	return NULL;
>  }
>  
> +static inline struct clk *devm_clk_get_prepared(struct device *dev,
> +						const char *id)
> +{
> +	return NULL;
> +}
> +
> +static inline struct clk *devm_clk_get_enabled(struct device *dev,
> +					       const char *id)
> +{
> +	return NULL;
> +}
> +
>  static inline struct clk *devm_clk_get_optional(struct device *dev,
>  						const char *id)
>  {
>  	return NULL;
>  }
>  
> +static inline struct clk *devm_clk_get_optional_prepared(struct device *dev,
> +							 const char *id)
> +{
> +	return NULL;
> +}
> +
> +static inline struct clk *devm_clk_get_optional_enabled(struct device *dev,
> +							const char *id)
> +{
> +	return NULL;
> +}
> +
>  static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
>  						 struct clk_bulk_data *clks)
>  {


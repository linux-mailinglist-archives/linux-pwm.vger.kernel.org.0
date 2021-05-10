Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819853794ED
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 19:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhEJRFc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 10 May 2021 13:05:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3051 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhEJRE5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 13:04:57 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff6gN1SSkz6rnFt;
        Tue, 11 May 2021 00:57:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 19:03:48 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 18:03:47 +0100
Date:   Mon, 10 May 2021 18:02:05 +0100
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
Subject: Re: [PATCH v6 RESEND 1/6] clk: generalize devm_clk_get() a bit
Message-ID: <20210510180205.000004dd@Huawei.com>
In-Reply-To: <20210510061724.940447-2-u.kleine-koenig@pengutronix.de>
References: <20210510061724.940447-1-u.kleine-koenig@pengutronix.de>
        <20210510061724.940447-2-u.kleine-koenig@pengutronix.de>
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

On Mon, 10 May 2021 08:17:19 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Allow to add an exit hook to devm managed clocks. Also use
> clk_get_optional() in devm_clk_get_optional instead of open coding it.
> The generalisation will be used in the next commit to add some more
> devm_clk helpers.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

If feels marginally odd to register cleanup that we know won't do anything
for the optional case, but it works as far as I can tell and it would be
a little fiddly to special case it.

FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/clk/clk-devres.c | 67 ++++++++++++++++++++++++++++++----------
>  1 file changed, 50 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index be160764911b..91c995815b57 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -4,39 +4,72 @@
>  #include <linux/export.h>
>  #include <linux/gfp.h>
>  
> +struct devm_clk_state {
> +	struct clk *clk;
> +	void (*exit)(struct clk *clk);
> +};
> +
>  static void devm_clk_release(struct device *dev, void *res)
>  {
> -	clk_put(*(struct clk **)res);
> +	struct devm_clk_state *state = *(struct devm_clk_state **)res;
> +
> +	if (state->exit)
> +		state->exit(state->clk);
> +
> +	clk_put(state->clk);
>  }
>  
> -struct clk *devm_clk_get(struct device *dev, const char *id)
> +static struct clk *__devm_clk_get(struct device *dev, const char *id,
> +				  struct clk *(*get)(struct device *dev, const char *id),
> +				  int (*init)(struct clk *clk),
> +				  void (*exit)(struct clk *clk))
>  {
> -	struct clk **ptr, *clk;
> +	struct devm_clk_state *state;
> +	struct clk *clk;
> +	int ret;
>  
> -	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> +	state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
> +	if (!state)
>  		return ERR_PTR(-ENOMEM);
>  
> -	clk = clk_get(dev, id);
> -	if (!IS_ERR(clk)) {
> -		*ptr = clk;
> -		devres_add(dev, ptr);
> -	} else {
> -		devres_free(ptr);
> +	clk = get(dev, id);
> +	if (IS_ERR(clk)) {
> +		ret = PTR_ERR(clk);
> +		goto err_clk_get;
>  	}
>  
> +	if (init) {
> +		ret = init(clk);
> +		if (ret)
> +			goto err_clk_init;
> +	}
> +
> +	state->clk = clk;
> +	state->exit = exit;
> +
> +	devres_add(dev, state);
> +
>  	return clk;
> +
> +err_clk_init:
> +
> +	clk_put(clk);
> +err_clk_get:
> +
> +	devres_free(state);
> +	return ERR_PTR(ret);
>  }
> -EXPORT_SYMBOL(devm_clk_get);
>  
> -struct clk *devm_clk_get_optional(struct device *dev, const char *id)
> +struct clk *devm_clk_get(struct device *dev, const char *id)
>  {
> -	struct clk *clk = devm_clk_get(dev, id);
> +	return __devm_clk_get(dev, id, clk_get, NULL, NULL);
>  
> -	if (clk == ERR_PTR(-ENOENT))
> -		return NULL;
> +}
> +EXPORT_SYMBOL(devm_clk_get);
>  
> -	return clk;
> +struct clk *devm_clk_get_optional(struct device *dev, const char *id)
> +{
> +	return __devm_clk_get(dev, id, clk_get_optional, NULL, NULL);
>  }
>  EXPORT_SYMBOL(devm_clk_get_optional);
>  


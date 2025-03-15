Return-Path: <linux-pwm+bounces-5201-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBF5A62D0E
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Mar 2025 13:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9472F3BAE47
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Mar 2025 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660671F8BAF;
	Sat, 15 Mar 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu0v8wfa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C71EA7CD;
	Sat, 15 Mar 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742043388; cv=none; b=StL32dGrkTTP/ra5D5NC2h0NNlmKAmTKgwmefoWg/6S0ExRpm+2cIG9eY9GBcA7XNTnsoFS97mz9h8dgVowXCXs9qWnmyozyuBsdl2BUh/oV7ATJCopVwFab9CWeL2gxzKxDLt9vlrpFWoVRVVp+PAqmXXh/W9sfafjFoUyfGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742043388; c=relaxed/simple;
	bh=vUMGwj9gT9qHilYD7FtR/OymYnAdU1AV9UfegnzOBB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYlo+7PYZjr9vZ8Y3fxTgwbZzO6y9CO/+CH5nr26wvEEGVB8Hn2QTUBicYI+xObWJww59uXEYFSzpzodqXFwwoW69lEdDKztP8uVHOtLX9KVKJQebcsJyOy/V/uiDUqXJVglwZ4QAbU0HLggiIfXufcyiGxBAVr7Kb4ZTyEaa7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu0v8wfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1B9C4CEE5;
	Sat, 15 Mar 2025 12:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742043387;
	bh=vUMGwj9gT9qHilYD7FtR/OymYnAdU1AV9UfegnzOBB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gu0v8wfakdKZX+cr2vPQvkM23dI7llOAY0lDvw2jFEsMvZ6nBHKKf92Vo5DQjZpX+
	 28FvQi8nmNe+TKF8fnL7Ivj9jqaN811TvMR29T+hmFCMPnbjDRlf0ujKiLPQgYCUmP
	 RJx0+V6/wCZUHTLGcch7n6M9fq031gBrOHgM/GxXlQpl5P9YZg97H62gkUF5fpuYNA
	 YuNpBnW4HlyLLOAC6MtwDQj2xphs+lmRyCcub02LWWBPsE3S7nRF+InDwOviAumR6U
	 7Bb9OmPcKCA3Jfum2eavkbrjUodoUAvQbsKMscpF4Mw8GpTHet7ljwrRGScObfmBqy
	 ppo0U/89Siudg==
Date: Sat, 15 Mar 2025 12:56:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <daniel.lezcano@linaro.org>,
 <tglx@linutronix.de>, <robh@kernel.org>, <catalin.marinas@arm.com>,
 <will@kernel.org>, <devicetree@vger.kernel.org>, <wbg@kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v4 3/8] iio: trigger: stm32-lptimer: add support for
 stm32mp25
Message-ID: <20250315125615.065a2e74@jic23-huawei>
In-Reply-To: <20250314171451.3497789-4-fabrice.gasnier@foss.st.com>
References: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
	<20250314171451.3497789-4-fabrice.gasnier@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 18:14:46 +0100
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> From: Olivier Moysan <olivier.moysan@foss.st.com>
> 
> Add support for STM32MP25 SoC. Use newly introduced compatible to handle
> this new HW variant. Add new trigger definitions that can be used by the
> stm32 analog-to-digital converter. Use compatible data to identify them.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

How do you want this to merge?   If it's going through mfd because
of dependencies, then
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I haven't checked if there are any dependencies so shout if I should
pick this up directly for next cycle.

Thanks,

Jonathan


> ---
> Changes in v4:
> - Jonathan's comment: simplify infrastructure by keeping
>   devm_iio_trigger_register. Don't need to cast compatible data.
> ---
>  drivers/iio/trigger/stm32-lptimer-trigger.c   | 75 ++++++++++++++-----
>  include/linux/iio/timer/stm32-lptim-trigger.h |  9 +++
>  2 files changed, 67 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
> index f1e18913236a..3dcc8d2fe093 100644
> --- a/drivers/iio/trigger/stm32-lptimer-trigger.c
> +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
> @@ -16,16 +16,43 @@
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  
> -/* List Low-Power Timer triggers */
> -static const char * const stm32_lptim_triggers[] = {
> -	LPTIM1_OUT,
> -	LPTIM2_OUT,
> -	LPTIM3_OUT,
> +/* Maximum triggers + one trailing null entry to indicate the end of array */
> +#define MAX_TRIGGERS 3
> +
> +struct stm32_lptim_cfg {
> +	const char * const (*triggers)[MAX_TRIGGERS];
> +	unsigned int nb_triggers;
> +};
> +
> +/* List Low-Power Timer triggers for H7, MP13, MP15 */
> +static const char * const stm32_lptim_triggers[][MAX_TRIGGERS] = {
> +	{ LPTIM1_OUT,},
> +	{ LPTIM2_OUT,},
> +	{ LPTIM3_OUT,},
> +};
> +
> +/* List Low-Power Timer triggers for STM32MP25 */
> +static const char * const stm32mp25_lptim_triggers[][MAX_TRIGGERS] = {
> +	{ LPTIM1_CH1, LPTIM1_CH2, },
> +	{ LPTIM2_CH1, LPTIM2_CH2, },
> +	{ LPTIM3_CH1,},
> +	{ LPTIM4_CH1,},
> +	{ LPTIM5_OUT,},
> +};
> +
> +static const struct stm32_lptim_cfg stm32mp15_lptim_cfg = {
> +	.triggers = stm32_lptim_triggers,
> +	.nb_triggers = ARRAY_SIZE(stm32_lptim_triggers),
> +};
> +
> +static const struct stm32_lptim_cfg stm32mp25_lptim_cfg = {
> +	.triggers = stm32mp25_lptim_triggers,
> +	.nb_triggers = ARRAY_SIZE(stm32mp25_lptim_triggers),
>  };
>  
>  struct stm32_lptim_trigger {
>  	struct device *dev;
> -	const char *trg;
> +	const char * const *triggers;
>  };
>  
>  static int stm32_lptim_validate_device(struct iio_trigger *trig,
> @@ -56,22 +83,33 @@ EXPORT_SYMBOL(is_stm32_lptim_trigger);
>  
>  static int stm32_lptim_setup_trig(struct stm32_lptim_trigger *priv)
>  {
> -	struct iio_trigger *trig;
> +	const char * const *cur = priv->triggers;
> +	int ret;
>  
> -	trig = devm_iio_trigger_alloc(priv->dev, "%s", priv->trg);
> -	if  (!trig)
> -		return -ENOMEM;
> +	while (cur && *cur) {
> +		struct iio_trigger *trig;
>  
> -	trig->dev.parent = priv->dev->parent;
> -	trig->ops = &stm32_lptim_trigger_ops;
> -	iio_trigger_set_drvdata(trig, priv);
> +		trig = devm_iio_trigger_alloc(priv->dev, "%s", *cur);
> +		if  (!trig)
> +			return -ENOMEM;
>  
> -	return devm_iio_trigger_register(priv->dev, trig);
> +		trig->dev.parent = priv->dev->parent;
> +		trig->ops = &stm32_lptim_trigger_ops;
> +		iio_trigger_set_drvdata(trig, priv);
> +
> +		ret = devm_iio_trigger_register(priv->dev, trig);
> +		if (ret)
> +			return ret;
> +		cur++;
> +	}
> +
> +	return 0;
>  }
>  
>  static int stm32_lptim_trigger_probe(struct platform_device *pdev)
>  {
>  	struct stm32_lptim_trigger *priv;
> +	struct stm32_lptim_cfg const *lptim_cfg;
>  	u32 index;
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> @@ -81,17 +119,20 @@ static int stm32_lptim_trigger_probe(struct platform_device *pdev)
>  	if (device_property_read_u32(&pdev->dev, "reg", &index))
>  		return -EINVAL;
>  
> -	if (index >= ARRAY_SIZE(stm32_lptim_triggers))
> +	lptim_cfg = device_get_match_data(&pdev->dev);
> +
> +	if (index >= lptim_cfg->nb_triggers)
>  		return -EINVAL;
>  
>  	priv->dev = &pdev->dev;
> -	priv->trg = stm32_lptim_triggers[index];
> +	priv->triggers = lptim_cfg->triggers[index];
>  
>  	return stm32_lptim_setup_trig(priv);
>  }
>  
>  static const struct of_device_id stm32_lptim_trig_of_match[] = {
> -	{ .compatible = "st,stm32-lptimer-trigger", },
> +	{ .compatible = "st,stm32-lptimer-trigger", .data = &stm32mp15_lptim_cfg },
> +	{ .compatible = "st,stm32mp25-lptimer-trigger", .data = &stm32mp25_lptim_cfg},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, stm32_lptim_trig_of_match);
> diff --git a/include/linux/iio/timer/stm32-lptim-trigger.h b/include/linux/iio/timer/stm32-lptim-trigger.h
> index a34dcf6a6001..ce3cf0addb2e 100644
> --- a/include/linux/iio/timer/stm32-lptim-trigger.h
> +++ b/include/linux/iio/timer/stm32-lptim-trigger.h
> @@ -14,6 +14,15 @@
>  #define LPTIM1_OUT	"lptim1_out"
>  #define LPTIM2_OUT	"lptim2_out"
>  #define LPTIM3_OUT	"lptim3_out"
> +#define LPTIM4_OUT	"lptim4_out"
> +#define LPTIM5_OUT	"lptim5_out"
> +
> +#define LPTIM1_CH1	"lptim1_ch1"
> +#define LPTIM1_CH2	"lptim1_ch2"
> +#define LPTIM2_CH1	"lptim2_ch1"
> +#define LPTIM2_CH2	"lptim2_ch2"
> +#define LPTIM3_CH1	"lptim3_ch1"
> +#define LPTIM4_CH1	"lptim4_ch1"
>  
>  #if IS_REACHABLE(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
>  bool is_stm32_lptim_trigger(struct iio_trigger *trig);



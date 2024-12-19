Return-Path: <linux-pwm+bounces-4400-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3369F7DBA
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 16:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4680616FF2A
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D11F226522;
	Thu, 19 Dec 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er9JUTVg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D422619D;
	Thu, 19 Dec 2024 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621068; cv=none; b=enKwNZaVoNVTsldjgV18ZekGV+dyaMBVRp33fEGPINo7XH2IFpB9i/gRM7iPPja2Ohnu0NpYxFOMXOe8Lmb7ajkzkJafOeqGsT3wWo9Oe7oARuijKLmLiHh83B+dLVDsCGXToFuchKhmsOoAoNbkhWkeNHygWSq3Fyr+bjs9uo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621068; c=relaxed/simple;
	bh=adQ2VPRcjtI/vVkO75YJreXNfLf5pJL1trNq2V/W/Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSsZ7OWPTYjhrny/EzRHyXUJYq4/TDvdEqXFXAF4+an3h+7puHoINF8kvkCJ9/o+vQjN8g8Hx9CsfKQO2L1jk6/uNoSgfHQ0TgpTNpQJE7OyLwPAb/N7f8a/xA5bbDadOGsJNRzbnzcQ46BUh1hZ1tRIkdmmFAk6l8MCZ19eFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er9JUTVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAA1C4CECE;
	Thu, 19 Dec 2024 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734621068;
	bh=adQ2VPRcjtI/vVkO75YJreXNfLf5pJL1trNq2V/W/Ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Er9JUTVg4DvjSBY76AzsEe7pZLpem8q8ZDx0p1KiGyI8kaQLiD0aBZa7dpUbQ5QCb
	 0fwpnEX4fShYuAGYPtG4pZKh9BR/cLSjTR9w2wpNdalMJGDUit5yiPACqp9R+EsoO1
	 MltCrnMSaHC8HQmll+vXXibFTnqg0uP3ZgQET+axUVqYONSw0mye0gtgsltoxnaCYa
	 hRiA2ebZsY3jPxeLXQl0GtTQB//0VTB7jiMoUpsiytLLF3AivthFoD2H1aZ+QYPQwf
	 0vsiqShNhqiRjXue2jaLwCl2LyJlqmUeOpXZYhqoB4RpXu279r5M9Zp6XGDB4rNF7C
	 0f3wN5eT1nBsQ==
Date: Thu, 19 Dec 2024 15:10:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>, <wbg@kernel.org>,
 <ukleinek@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 3/9] iio: trigger: stm32-timer: add support for
 stm32mp25
Message-ID: <20241219151056.26e21aed@jic23-huawei>
In-Reply-To: <20241218090153.742869-4-fabrice.gasnier@foss.st.com>
References: <20241218090153.742869-1-fabrice.gasnier@foss.st.com>
	<20241218090153.742869-4-fabrice.gasnier@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 10:01:47 +0100
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> Add support for STM32MP25 SoC. Use newly introduced compatible to handle
> this new HW variant. Add TIM20 trigger definitions that can be used by
> the stm32 analog-to-digital converter. Use compatible data to identify
> it.
> As the counter framework is now superseding the deprecated IIO counter
> interface (IIO_COUNT), don't support it. Only register IIO trigger
> devices for ADC usage. So, make the valids_table a cfg option.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Looks good to me.  Looks like I can just pick this up for IIO?

Or is thOre a dependency I'm missing?

Just in case it goes another route.
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan
> ---
>  drivers/iio/trigger/stm32-timer-trigger.c     | 21 +++++++++++++++++--
>  include/linux/iio/timer/stm32-timer-trigger.h |  6 ++++++
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index bb60b2d7b2ec..8aaf3abf044e 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -38,6 +38,9 @@ static const void *triggers_table[][MAX_TRIGGERS] = {
>  	{ TIM15_TRGO,},
>  	{ TIM16_OC1,},
>  	{ TIM17_OC1,},
> +	{ }, /* timer 18 */
> +	{ }, /* timer 19 */
> +	{ TIM20_TRGO, TIM20_TRGO2, TIM20_OC1, TIM20_OC2, TIM20_OC3, },
>  };
>  
>  /* List the triggers accepted by each timer */
> @@ -781,7 +784,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  
>  	/* Create an IIO device only if we have triggers to be validated */
> -	if (*cfg->valids_table[index])
> +	if (cfg->valids_table && *cfg->valids_table[index])
>  		priv = stm32_setup_counter_device(dev);
>  	else
>  		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -794,7 +797,8 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	priv->clk = ddata->clk;
>  	priv->max_arr = ddata->max_arr;
>  	priv->triggers = triggers_table[index];
> -	priv->valids = cfg->valids_table[index];
> +	if (cfg->valids_table && *cfg->valids_table[index])
> +		priv->valids = cfg->valids_table[index];
>  	stm32_timer_detect_trgo2(priv);
>  	mutex_init(&priv->lock);
>  
> @@ -886,6 +890,16 @@ static const struct stm32_timer_trigger_cfg stm32h7_timer_trg_cfg = {
>  	.num_valids_table = ARRAY_SIZE(stm32h7_valids_table),
>  };
>  
> +static const struct stm32_timer_trigger_cfg stm32mp25_timer_trg_cfg = {
> +	/*
> +	 * valids_table not used: counter framework is now superseding the deprecated IIO
> +	 * counter interface (IIO_COUNT), so don't support it. num_valids_table is only
> +	 * kept here to register the IIO HW triggers. valids_table should be moved at some
> +	 * point to the stm32-timer-cnt driver instead.
> +	 */
> +	.num_valids_table = ARRAY_SIZE(triggers_table),
> +};
> +
>  static const struct of_device_id stm32_trig_of_match[] = {
>  	{
>  		.compatible = "st,stm32-timer-trigger",
> @@ -893,6 +907,9 @@ static const struct of_device_id stm32_trig_of_match[] = {
>  	}, {
>  		.compatible = "st,stm32h7-timer-trigger",
>  		.data = (void *)&stm32h7_timer_trg_cfg,
> +	}, {
> +		.compatible = "st,stm32mp25-timer-trigger",
> +		.data = (void *)&stm32mp25_timer_trg_cfg,
>  	},
>  	{ /* end node */ },
>  };
> diff --git a/include/linux/iio/timer/stm32-timer-trigger.h b/include/linux/iio/timer/stm32-timer-trigger.h
> index 37572e4dc73a..1ee237b56183 100644
> --- a/include/linux/iio/timer/stm32-timer-trigger.h
> +++ b/include/linux/iio/timer/stm32-timer-trigger.h
> @@ -72,6 +72,12 @@
>  
>  #define TIM17_OC1	"tim17_oc1"
>  
> +#define TIM20_OC1	"tim20_oc1"
> +#define TIM20_OC2	"tim20_oc2"
> +#define TIM20_OC3	"tim20_oc3"
> +#define TIM20_TRGO	"tim20_trgo"
> +#define TIM20_TRGO2	"tim20_trgo2"
> +
>  #if IS_REACHABLE(CONFIG_IIO_STM32_TIMER_TRIGGER)
>  bool is_stm32_timer_trigger(struct iio_trigger *trig);
>  #else



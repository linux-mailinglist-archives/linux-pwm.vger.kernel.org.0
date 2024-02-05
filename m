Return-Path: <linux-pwm+bounces-1204-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D588493B8
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 07:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4ED1C20294
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 06:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289C88F40;
	Mon,  5 Feb 2024 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DZmGyesQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A38BE4B;
	Mon,  5 Feb 2024 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707113507; cv=none; b=J43P7GakV/+DHNHp6+TMWdgGVdRo1S+7Ah6mgYncDNZpjlktfjiSj2Cj3E5+iJ8VFbSM3O7p7zBkXUpWBM1A5fha5tm9e3JAHNx+MWJ4Diryd2lt8OOK27DzSULUsPHqcRCpz/piz/73CoHFYneHQlyq5KVHb4Inefh2i6oy2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707113507; c=relaxed/simple;
	bh=ItSlIA8NVCmgfDylE6k4JAco6UBNFP0ty0+VgpIMUjg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLdTNOjYupN6M4ok+ey/IlUWwxVby4dvNsktk2+0jb+DvJfJrfRpi9l1ricT4YaH70W5jL7b76w243rsXbdythxEtZzpTfnW4p2IrAzN2sSUblprqByacd2InixU1Jk0ekkaoM0IBnDOOeVhk3ms2cipd03BxD1+sAM5DAWW0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DZmGyesQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4156BU7d048622;
	Mon, 5 Feb 2024 00:11:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707113490;
	bh=9PyJN0I1HfyCQReZZvNiDjgnYiiZGOv2/FYL2yfIQc0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=DZmGyesQZroyAzU4T2bC7gqaLLMEYuEccmEf1pJCWQvbUsEOaTfpP/Xde/oPgAHeH
	 8Asw9PKv8CZoarV/Z95+X6XNMfhGbbGfv9s/tqfjkLC1xqivwZrK4u7RB/3rc4Te3q
	 XnsRj3XKll77dq9ikP5xXAg5xQAV1vQBeatL4U10=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4156BUh2122953
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 00:11:30 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 00:11:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 00:11:30 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4156BTL9018959;
	Mon, 5 Feb 2024 00:11:30 -0600
Date: Mon, 5 Feb 2024 11:41:29 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Stefan Wahren <wahrenst@gmx.net>
CC: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        Angelo Compagnucci
	<angelo.compagnucci@gmail.com>,
        Philip Howard <phil@gadgetoid.com>, Sean
 Young <sean@mess.org>,
        Linus Walleij <linus.walleij@linaro.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Vincent Whitchurch
	<vincent.whitchurch@axis.com>
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
Message-ID: <20240205061129.gdwzmpuxrzxj5cov@dhruva>
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240204220851.4783-3-wahrenst@gmx.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Feb 04, 2024 at 23:08:51 +0100, Stefan Wahren wrote:
> From: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> Add a software PWM which toggles a GPIO from a high-resolution timer.
> 
> This will naturally not be as accurate or as efficient as a hardware
> PWM, but it is useful in some cases.  I have for example used it for
> evaluating LED brightness handling (via leds-pwm) on a board where the
> LED was just hooked up to a GPIO, and for a simple verification of the
> timer frequency on another platform.
> 
> Since high-resolution timers are used, sleeping gpio chips are not
> supported and are rejected in the probe function.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/pwm/Kconfig    |  11 ++
>  drivers/pwm/Makefile   |   1 +
>  drivers/pwm/pwm-gpio.c | 228 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 240 insertions(+)
>  create mode 100644 drivers/pwm/pwm-gpio.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..7cfda2cde130 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -227,6 +227,17 @@ config PWM_FSL_FTM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-fsl-ftm.
> 
> +config PWM_GPIO
> +	tristate "GPIO PWM support"
> +	depends on GPIOLIB
> +	depends on HIGH_RES_TIMERS
> +	help
> +	  Generic PWM framework driver for a software PWM toggling a GPIO pin

>> a software PWM
Nit: remove the "a", as it's not required.

> +	  from kernel high-resolution timers.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-gpio.
> +
[..snip..]
> +
> +static int pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct pwm_gpio *gpwm = container_of(chip, struct pwm_gpio, chip);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gpwm->lock, flags);
> +
> +	if (gpwm->changing)
> +		*state = gpwm->next_state;
> +	else
> +		*state = gpwm->state;
> +
> +	spin_unlock_irqrestore(&gpwm->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_gpio_ops = {
> +	.apply = pwm_gpio_apply,

Kinda looks like this is setting state? Can we be consistent with the
naming then, like pwm_gpio_set_state?

This will help those contributing to the driver or referring to it to
understand better what each function is doing exactly.

> +	.get_state = pwm_gpio_get_state,
> +};

Otherwise, driver looks good to me,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>


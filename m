Return-Path: <linux-pwm+bounces-8498-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TsBWCg/f02lxngcAu9opvQ
	(envelope-from <linux-pwm+bounces-8498-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 18:27:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AE63A5492
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 18:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA92C3002FA6
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1B438AC7D;
	Mon,  6 Apr 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="2pDhEJYT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [45.141.101.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A149930EF9B;
	Mon,  6 Apr 2026 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.141.101.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492876; cv=none; b=L1vjHk8q/ov0hC2DZ8yzidgO35SHBGS9htYP7kRI9XMD3gToSsxTKqy5AcTVrzM40rE5N5SEfcY4aW0C35wDev+XPdjAdAdP2zccP7HpUluS1nkcnbQSYtxyuJlJk+mMEIiTKH2lKOjAQg3azjEiq/RD+QHhuw1t3KsZGOQ9Drg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492876; c=relaxed/simple;
	bh=RVnjW7CD2ecBRU87/pB8wigS1EWW6WYzVGDWe2uBPl0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YIXpicoJD6nkKPcmftNoFbfZwzKZqWzwbBYJA8p3jl/GxjTXkSpZL7mGV91BZxXjTCyGxWtdKXibfDmImIVDA9lNBCT1r7EaOfsycFzfqKoMA7qnIrBLJL0gOsRCzKIapOCnBClwzU2UZMdECbPFGAjfOTveinWNXVjv7B2hs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=2pDhEJYT; arc=none smtp.client-ip=45.141.101.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1775492416; bh=RVnjW7CD2ecBRU87/pB8wigS1EWW6WYzVGDWe2uBPl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2pDhEJYTGguKAHIryfNB3cWmhxeJK+qm9BERexNa8oWwmgCed72Ul3dn0XnaHKv7S
	 QQbjRu+ADwCj14p5f9Fna2OLxFc/oHhm2u2fwStLHCZubKp1/T2l7iwWA+//V64+C0
	 2GXoK1kLZ5Ua6p4w9b1fUhU8CUaa9kNUssOvXa+ygkqQirrwRueUsPLooObVeWi75D
	 n5YeiYUHh8bX81HTwTy1ojxQZ9PuS0ufkXsCOcvK3YKpPIAJ/epK0L0wlHtLYiTvHH
	 ssdD0LfBD6E4w8Tk8rwgs5K9kMGM/i7dqEOp1TYy9Pu0XfvjC42U0T1hwit997PIK5
	 HF84HSJ+dK/sg==
Received: from authenticated-user (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id DB5C871601;
	Mon,  6 Apr 2026 21:20:16 +0500 (+05)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Apr 2026 21:20:16 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Xilin Wu <sophon@radxa.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: clk-pwm: add GPIO and pinctrl support for
 constant output levels
In-Reply-To: <20260406-clk-pwm-gpio-v1-2-40d2f3a20aff@radxa.com>
References: <20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com>
 <20260406-clk-pwm-gpio-v1-2-40d2f3a20aff@radxa.com>
Message-ID: <41d54477e46354664360931ffcbeda11@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[trvn.ru,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[trvn.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trvn.ru:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8498-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikita@trvn.ru,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 63AE63A5492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Xilin Wu писал(а) 06.04.2026 20:50:
> The clk-pwm driver cannot guarantee a defined output level when the
> PWM is disabled or when 0%/100% duty cycle is requested, because the
> pin state when the clock is stopped is hardware-dependent.
> 
> Add optional GPIO and pinctrl support: when a GPIO descriptor and
> pinctrl states ("default" for clock mux, "gpio" for GPIO mode) are
> provided in the device tree, the driver switches the pin to GPIO mode
> and drives the appropriate level for disabled/0%/100% states. For
> normal PWM output, the pin is switched back to its clock function mux.
> 
> If no GPIO is provided, the driver falls back to the original
> clock-only behavior.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/pwm/pwm-clk.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 66 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
> index f8f5af57acba..99821fae54e7 100644
> --- a/drivers/pwm/pwm-clk.c
> +++ b/drivers/pwm/pwm-clk.c
> @@ -10,12 +10,15 @@
>   * Limitations:
>   * - Due to the fact that exact behavior depends on the underlying
>   *   clock driver, various limitations are possible.
> - * - Underlying clock may not be able to give 0% or 100% duty cycle
> - *   (constant off or on), exact behavior will depend on the clock.
> - * - When the PWM is disabled, the clock will be disabled as well,
> - *   line state will depend on the clock.

nit: I think those limitations would still stand for existing
users, perhaps we could just add "... unless gpio pinctrl state
is supplied" to these two?

>   * - The clk API doesn't expose the necessary calls to implement
>   *   .get_state().
> + *
> + * Optionally, a GPIO descriptor and pinctrl states ("default" and
> + * "gpio") can be provided. When a constant output level is needed
> + * (0% duty, 100% duty, or disabled), the driver switches the pin to
> + * GPIO mode and drives the appropriate level. For normal PWM output
> + * the pin is switched back to its clock function mux. If no GPIO is
> + * provided, the driver falls back to the original clock-only behavior.
>   */
>  
>  #include <linux/kernel.h>
> @@ -25,11 +28,17 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/pwm.h>
>  
>  struct pwm_clk_chip {
>  	struct clk *clk;
>  	bool clk_enabled;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pins_default;  /* clock function mux */
> +	struct pinctrl_state *pins_gpio;     /* GPIO mode */
> +	struct gpio_desc *gpiod;
>  };
>  
>  static inline struct pwm_clk_chip *to_pwm_clk_chip(struct pwm_chip *chip)
> @@ -45,14 +54,36 @@ static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	u32 rate;
>  	u64 period = state->period;
>  	u64 duty_cycle = state->duty_cycle;
> +	bool constant_level = false;
> +	int gpio_value = 0;
>  
>  	if (!state->enabled) {
> -		if (pwm->state.enabled) {
> +		constant_level = true;
> +		gpio_value = 0;
> +	} else if (state->duty_cycle == 0) {
> +		constant_level = true;
> +		gpio_value = (state->polarity == PWM_POLARITY_INVERSED) ? 1 : 0;
> +	} else if (state->duty_cycle >= state->period) {
> +		constant_level = true;
> +		gpio_value = (state->polarity == PWM_POLARITY_INVERSED) ? 0 : 1;
> +	}
> +
> +	if (constant_level) {
> +		if (pcchip->gpiod) {
> +			pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
> +			gpiod_direction_output(pcchip->gpiod, gpio_value);

Is this the same case as below where gpio state has to be set
before we can control it, or can we swap those so we first
put gpio into a known state and only then mux it to the pad?


Thanks for improving this driver,
Nikita

> +		}
> +		if (pcchip->clk_enabled) {
>  			clk_disable(pcchip->clk);
>  			pcchip->clk_enabled = false;
>  		}
>  		return 0;
> -	} else if (!pwm->state.enabled) {
> +	}
> +
> +	if (pcchip->gpiod)
> +		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_default);
> +
> +	if (!pcchip->clk_enabled) {
>  		ret = clk_enable(pcchip->clk);
>  		if (ret)
>  			return ret;
> @@ -97,6 +128,35 @@ static int pwm_clk_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
>  				     "Failed to get clock\n");
>  
> +	pcchip->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(pcchip->pinctrl)) {
> +		ret = PTR_ERR(pcchip->pinctrl);
> +		pcchip->pinctrl = NULL;
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +	} else {
> +		pcchip->pins_default = pinctrl_lookup_state(pcchip->pinctrl,
> +							    PINCTRL_STATE_DEFAULT);
> +		pcchip->pins_gpio = pinctrl_lookup_state(pcchip->pinctrl,
> +							 "gpio");
> +		if (IS_ERR(pcchip->pins_default) || IS_ERR(pcchip->pins_gpio))
> +			pcchip->pinctrl = NULL;
> +	}
> +
> +	/*
> +	 * Switch to GPIO pinctrl state before requesting the GPIO.
> +	 * The driver core has already applied the "default" state, which
> +	 * muxes the pin to the clock function and claims it.  We must
> +	 * release that claim first so that gpiolib can request the pin.
> +	 */
> +	if (pcchip->pinctrl)
> +		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
> +
> +	pcchip->gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, GPIOD_ASIS);
> +	if (IS_ERR(pcchip->gpiod))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->gpiod),
> +				     "Failed to get gpio\n");
> +
>  	chip->ops = &pwm_clk_ops;
>  
>  	ret = pwmchip_add(chip);


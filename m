Return-Path: <linux-pwm+bounces-2749-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F9792D40B
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 16:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63FA1F23D07
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971D719344A;
	Wed, 10 Jul 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UcuwsPbd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3828519247D
	for <linux-pwm@vger.kernel.org>; Wed, 10 Jul 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621043; cv=none; b=N/jn3RgjXTlVD51q84IdMOrS4qMxG8WTLbVZmCBgwoBnaxTRrUPV0hRNOosPVN+qX69ropQWcflRP+8nXHwZa5mGpduzIRHUUfRkTXoxQshhcZG9dogtZydNWdR0D55w+Kh+nHMaLaSbHayWazACjWwouxsjfRPQkLmXWT1KphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621043; c=relaxed/simple;
	bh=3i0gpBYEbr1ga80f1GSc2WyIhMWSqmnlOcPdyPhdaWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ShhBaAD2pdzAGlSnHCSoqy+KkIwXnds4Iv6dNBOL5nFWJD9Z5RhYSW5Ztfh4gOaPQ9zpcNXArdrGs9eyi7ld5XFBj/kmqJZRX8YCCSCo06RzSZEdx9KJ96TjMKgGyTkmOGTQ8vQpeZXAjy6RCZvxCmt4Y1O66FeB3QwoOVVP0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UcuwsPbd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720621041; x=1752157041;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3i0gpBYEbr1ga80f1GSc2WyIhMWSqmnlOcPdyPhdaWg=;
  b=UcuwsPbddvLCZ6QWummW762WUwozliFf2CeX46+9R3Q7giyHgFk9mBvO
   PBzeLWh/efCF6tkU2FzwMg9e+VMzipEhzjCpXgbCW0pA6dL6BaR0va7IP
   aNsDky50eJU64NfP9rHqh+1qz2FxBNJCDExmCWbNPmLpUClHCFBy9Lceh
   JQHjEExGD9ogFJ2MwZf9blMtb7Rhhm+Ah5deQfED8NjjRDhy2bvUNCcKu
   M0EOYvaT5T+x5oNighYTgeurr2jnMCBs85lUdkhLDgubSnSFixC/CQaOh
   BzsYaA6lyUWkqmoY4mssZpA7muqoYOXm3baeNzuymmgf9EgSIlH02H6to
   Q==;
X-CSE-ConnectionGUID: bOLOhLKwTCq0MdAY/y7jzg==
X-CSE-MsgGUID: 5R4nSA7nSl+QFSaZRBkwmA==
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="29035788"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2024 07:17:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jul 2024 07:16:47 -0700
Received: from [10.180.117.33] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Jul 2024 07:16:45 -0700
Message-ID: <bbb984a8-8815-45fb-8ddf-a5180f6e41c4@microchip.com>
Date: Wed, 10 Jul 2024 16:17:09 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pwm: atmel-tcb: Fix race condition and convert to
 guards
Content-Language: en-US, fr-FR
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Boris Brezillon <boris.brezillon@collabora.com>
CC: <linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240709101806.52394-3-u.kleine-koenig@baylibre.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240709101806.52394-3-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 09/07/2024 at 12:18, Uwe Kleine-König wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> The hardware only supports a single period length for both PWM outputs. So
> atmel_tcb_pwm_config() checks the configuration of the other output if it's
> compatible with the currently requested setting. The register values are
> then actually updated in atmel_tcb_pwm_enable(). To make this race free
> the lock must be held during the whole process, so grab the lock in
> .apply() instead of individually in atmel_tcb_pwm_disable() and
> atmel_tcb_pwm_enable() which then also covers atmel_tcb_pwm_config().
> 
> To simplify handling, use the guard helper to let the compiler care for
> unlocking. Otherwise unlocking would be more difficult as there is more
> than one exit path in atmel_tcb_pwm_apply().
> 
> Fixes: 9421bade0765 ("pwm: atmel: add Timer Counter Block PWM driver")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

And I like the conversion to the "guard" lock helper.
Best regards,
   Nicolas

> ---
>   drivers/pwm/pwm-atmel-tcb.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index 528e54c5999d..aca11493239a 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -81,7 +81,8 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
>          tcbpwm->period = 0;
>          tcbpwm->div = 0;
> 
> -       spin_lock(&tcbpwmc->lock);
> +       guard(spinlock)(&tcbpwmc->lock);
> +
>          regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), &cmr);
>          /*
>           * Get init config from Timer Counter registers if
> @@ -107,7 +108,6 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
> 
>          cmr |= ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO | ATMEL_TC_EEVT_XC0;
>          regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), cmr);
> -       spin_unlock(&tcbpwmc->lock);
> 
>          return 0;
>   }
> @@ -137,7 +137,6 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
>          if (tcbpwm->duty == 0)
>                  polarity = !polarity;
> 
> -       spin_lock(&tcbpwmc->lock);
>          regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), &cmr);
> 
>          /* flush old setting and set the new one */
> @@ -172,8 +171,6 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
>                               ATMEL_TC_SWTRG);
>                  tcbpwmc->bkup.enabled = 0;
>          }
> -
> -       spin_unlock(&tcbpwmc->lock);
>   }
> 
>   static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -194,7 +191,6 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
>          if (tcbpwm->duty == 0)
>                  polarity = !polarity;
> 
> -       spin_lock(&tcbpwmc->lock);
>          regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), &cmr);
> 
>          /* flush old setting and set the new one */
> @@ -256,7 +252,6 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
>          regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CCR),
>                       ATMEL_TC_SWTRG | ATMEL_TC_CLKEN);
>          tcbpwmc->bkup.enabled = 1;
> -       spin_unlock(&tcbpwmc->lock);
>          return 0;
>   }
> 
> @@ -341,9 +336,12 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>                                 const struct pwm_state *state)
>   {
> +       struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
>          int duty_cycle, period;
>          int ret;
> 
> +       guard(spinlock)(&tcbpwmc->lock);
> +
>          if (!state->enabled) {
>                  atmel_tcb_pwm_disable(chip, pwm, state->polarity);
>                  return 0;
> 
> base-commit: 120a528213b6693214e3cbc24a9c3052a4b1024b
> --
> 2.43.0
> 



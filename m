Return-Path: <linux-pwm+bounces-2747-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB4792D29B
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 15:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105E81F21680
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0A219004F;
	Wed, 10 Jul 2024 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gIE6SEPA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB6192B93
	for <linux-pwm@vger.kernel.org>; Wed, 10 Jul 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617597; cv=none; b=iKFrOmbiCSn7+LWKc+l6TdKxvCWg56wmVwyhANP9mCXqkc+s6xRdjEKXd5LzSwkPhz8p5oAm0SU502GIDPXsPIwn4vZWyU+s80OYncY6FLiJh/ikq4/u12Peiqb59Rmn9FDFoJcve0T0Vl1D7bDzrrpQqKEj7Wk+L1psD/zs8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617597; c=relaxed/simple;
	bh=JqnTyrAgam7XIAmjGiS6Yd/JKgCLunSTZRWdZlw0brM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kTNIEORo5jQbxqVp0Hvqbti1sJRIGv05LnKTymhGxEeGtXCJUFgmh/9VTgZdyFh+pojt96W/ea63R9twlaeapsPJbvto/AXDw7IvWWEEbc3pbvpWJ3kUq6W5iFwUJU4XGOuHSuHeBxvkfn5HeVW0mNAtU3yaKhy9webLeW7M/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gIE6SEPA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720617594; x=1752153594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JqnTyrAgam7XIAmjGiS6Yd/JKgCLunSTZRWdZlw0brM=;
  b=gIE6SEPAsO7duTN4KbQQ+baSLzi9dvIIQGzkttaG3ezyrH66k/xQkMmd
   lby6YK3aTxXlscbObaVJKNRKg8FhvWi+SCZxNRDIZm38iTdD8gwEYLIYh
   CqRFmH7qEZlfaLEZBANO17jJBWl9cGkKCLmaV6tXIXVVWhEAhu6A6n7uD
   yRFtB+6Zf0nLnkz4q5dH4XgBPk5xTFF819oecZH4BM+QE22IK744u8o2t
   l1nWJ2V5Y050YnuhzAzE0Pf0LQuwBSbZMIY+CJyIOWhHtHs+fypoYI2+d
   NZVNnXvuxKzuOgQHNKMnxFwz/dLU83nJ922H0kaLbDjdd12aNS29arC/b
   w==;
X-CSE-ConnectionGUID: cNhPtlnCR4mVrOuZvtXkow==
X-CSE-MsgGUID: C3AeQTT1QAW+52AnwKfQ3A==
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="29704327"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2024 06:19:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jul 2024 06:19:38 -0700
Received: from [10.180.117.33] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Jul 2024 06:19:37 -0700
Message-ID: <db038b7e-8864-43db-a4e0-5992ca01cdec@microchip.com>
Date: Wed, 10 Jul 2024 15:20:00 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: atmel-tcb: Make private data variable naming
 consistent
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240709092221.47025-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240709092221.47025-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 09/07/2024 at 11:22, Uwe Kleine-König wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Currently the variables of type struct atmel_tcb_pwm_device
> are named "tcbpwm", and variables of type atmel_tcb_pwm_chip are either
> named "tcbpwm" (too!) or "tcbpwmc". Rename the chips with device name to
> "tcbpwmc" to get a consistent naming.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Makes sense: thanks Uwe:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
>   drivers/pwm/pwm-atmel-tcb.c | 90 ++++++++++++++++++-------------------
>   1 file changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index 528e54c5999d..9470811e195c 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -389,17 +389,17 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>   {
>          struct pwm_chip *chip;
>          const struct of_device_id *match;
> -       struct atmel_tcb_pwm_chip *tcbpwm;
> +       struct atmel_tcb_pwm_chip *tcbpwmc;
>          const struct atmel_tcb_config *config;
>          struct device_node *np = pdev->dev.of_node;
>          char clk_name[] = "t0_clk";
>          int err;
>          int channel;
> 
> -       chip = devm_pwmchip_alloc(&pdev->dev, NPWM, sizeof(*tcbpwm));
> +       chip = devm_pwmchip_alloc(&pdev->dev, NPWM, sizeof(*tcbpwmc));
>          if (IS_ERR(chip))
>                  return PTR_ERR(chip);
> -       tcbpwm = to_tcb_chip(chip);
> +       tcbpwmc = to_tcb_chip(chip);
> 
>          err = of_property_read_u32(np, "reg", &channel);
>          if (err < 0) {
> @@ -409,20 +409,20 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>                  return err;
>          }
> 
> -       tcbpwm->regmap = syscon_node_to_regmap(np->parent);
> -       if (IS_ERR(tcbpwm->regmap))
> -               return PTR_ERR(tcbpwm->regmap);
> +       tcbpwmc->regmap = syscon_node_to_regmap(np->parent);
> +       if (IS_ERR(tcbpwmc->regmap))
> +               return PTR_ERR(tcbpwmc->regmap);
> 
> -       tcbpwm->slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
> -       if (IS_ERR(tcbpwm->slow_clk))
> -               return PTR_ERR(tcbpwm->slow_clk);
> +       tcbpwmc->slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
> +       if (IS_ERR(tcbpwmc->slow_clk))
> +               return PTR_ERR(tcbpwmc->slow_clk);
> 
>          clk_name[1] += channel;
> -       tcbpwm->clk = of_clk_get_by_name(np->parent, clk_name);
> -       if (IS_ERR(tcbpwm->clk))
> -               tcbpwm->clk = of_clk_get_by_name(np->parent, "t0_clk");
> -       if (IS_ERR(tcbpwm->clk)) {
> -               err = PTR_ERR(tcbpwm->clk);
> +       tcbpwmc->clk = of_clk_get_by_name(np->parent, clk_name);
> +       if (IS_ERR(tcbpwmc->clk))
> +               tcbpwmc->clk = of_clk_get_by_name(np->parent, "t0_clk");
> +       if (IS_ERR(tcbpwmc->clk)) {
> +               err = PTR_ERR(tcbpwmc->clk);
>                  goto err_slow_clk;
>          }
> 
> @@ -430,22 +430,22 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>          config = match->data;
> 
>          if (config->has_gclk) {
> -               tcbpwm->gclk = of_clk_get_by_name(np->parent, "gclk");
> -               if (IS_ERR(tcbpwm->gclk)) {
> -                       err = PTR_ERR(tcbpwm->gclk);
> +               tcbpwmc->gclk = of_clk_get_by_name(np->parent, "gclk");
> +               if (IS_ERR(tcbpwmc->gclk)) {
> +                       err = PTR_ERR(tcbpwmc->gclk);
>                          goto err_clk;
>                  }
>          }
> 
>          chip->ops = &atmel_tcb_pwm_ops;
> -       tcbpwm->channel = channel;
> -       tcbpwm->width = config->counter_width;
> +       tcbpwmc->channel = channel;
> +       tcbpwmc->width = config->counter_width;
> 
> -       err = clk_prepare_enable(tcbpwm->slow_clk);
> +       err = clk_prepare_enable(tcbpwmc->slow_clk);
>          if (err)
>                  goto err_gclk;
> 
> -       spin_lock_init(&tcbpwm->lock);
> +       spin_lock_init(&tcbpwmc->lock);
> 
>          err = pwmchip_add(chip);
>          if (err < 0)
> @@ -456,16 +456,16 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>          return 0;
> 
>   err_disable_clk:
> -       clk_disable_unprepare(tcbpwm->slow_clk);
> +       clk_disable_unprepare(tcbpwmc->slow_clk);
> 
>   err_gclk:
> -       clk_put(tcbpwm->gclk);
> +       clk_put(tcbpwmc->gclk);
> 
>   err_clk:
> -       clk_put(tcbpwm->clk);
> +       clk_put(tcbpwmc->clk);
> 
>   err_slow_clk:
> -       clk_put(tcbpwm->slow_clk);
> +       clk_put(tcbpwmc->slow_clk);
> 
>          return err;
>   }
> @@ -473,14 +473,14 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>   static void atmel_tcb_pwm_remove(struct platform_device *pdev)
>   {
>          struct pwm_chip *chip = platform_get_drvdata(pdev);
> -       struct atmel_tcb_pwm_chip *tcbpwm = to_tcb_chip(chip);
> +       struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> 
>          pwmchip_remove(chip);
> 
> -       clk_disable_unprepare(tcbpwm->slow_clk);
> -       clk_put(tcbpwm->gclk);
> -       clk_put(tcbpwm->clk);
> -       clk_put(tcbpwm->slow_clk);
> +       clk_disable_unprepare(tcbpwmc->slow_clk);
> +       clk_put(tcbpwmc->gclk);
> +       clk_put(tcbpwmc->clk);
> +       clk_put(tcbpwmc->slow_clk);
>   }
> 
>   static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
> @@ -492,14 +492,14 @@ MODULE_DEVICE_TABLE(of, atmel_tcb_pwm_dt_ids);
>   static int atmel_tcb_pwm_suspend(struct device *dev)
>   {
>          struct pwm_chip *chip = dev_get_drvdata(dev);
> -       struct atmel_tcb_pwm_chip *tcbpwm = to_tcb_chip(chip);
> -       struct atmel_tcb_channel *chan = &tcbpwm->bkup;
> -       unsigned int channel = tcbpwm->channel;
> +       struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> +       struct atmel_tcb_channel *chan = &tcbpwmc->bkup;
> +       unsigned int channel = tcbpwmc->channel;
> 
> -       regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, CMR), &chan->cmr);
> -       regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, RA), &chan->ra);
> -       regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, RB), &chan->rb);
> -       regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, RC), &chan->rc);
> +       regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(channel, CMR), &chan->cmr);
> +       regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(channel, RA), &chan->ra);
> +       regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(channel, RB), &chan->rb);
> +       regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(channel, RC), &chan->rc);
> 
>          return 0;
>   }
> @@ -507,17 +507,17 @@ static int atmel_tcb_pwm_suspend(struct device *dev)
>   static int atmel_tcb_pwm_resume(struct device *dev)
>   {
>          struct pwm_chip *chip = dev_get_drvdata(dev);
> -       struct atmel_tcb_pwm_chip *tcbpwm = to_tcb_chip(chip);
> -       struct atmel_tcb_channel *chan = &tcbpwm->bkup;
> -       unsigned int channel = tcbpwm->channel;
> +       struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> +       struct atmel_tcb_channel *chan = &tcbpwmc->bkup;
> +       unsigned int channel = tcbpwmc->channel;
> 
> -       regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, CMR), chan->cmr);
> -       regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, RA), chan->ra);
> -       regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, RB), chan->rb);
> -       regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, RC), chan->rc);
> +       regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(channel, CMR), chan->cmr);
> +       regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(channel, RA), chan->ra);
> +       regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(channel, RB), chan->rb);
> +       regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(channel, RC), chan->rc);
> 
>          if (chan->enabled)
> -               regmap_write(tcbpwm->regmap,
> +               regmap_write(tcbpwmc->regmap,
>                               ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
>                               ATMEL_TC_REG(channel, CCR));
> 
> 
> base-commit: 120a528213b6693214e3cbc24a9c3052a4b1024b
> --
> 2.43.0
> 



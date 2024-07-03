Return-Path: <linux-pwm+bounces-2693-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F81F926169
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 15:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A38828D8F2
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B7317967E;
	Wed,  3 Jul 2024 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Rj5CV6gj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482B13DDA6;
	Wed,  3 Jul 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012168; cv=none; b=nv7MEfG3FNCOvPbqzTVUwEgyghlZVtsMysLpL3piHkRemeXN5sJ1tCOX4hnnhvFxqhe0k83Dodi+BS1h44qpmNT2xrdkArfhaR6Ix7573N4sPpToFh4foNitjEJhThlngUsqXYS65ncUntsCzSFOUqEfRuO52fvw9WnEqSP582c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012168; c=relaxed/simple;
	bh=W8KnSELxoOeLFO4Bkg8ypBzvhOg9ofBU1heW/xaRe4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KUhXTWIBUcGJyrpGl9mRkHUag8woUY3otXdtjRNvvabYEdY73vcDJFBl9fA5XE6aFhbD2PrzCDHV6YWjq+3eFALhAP5PAzno3U2KyHs+nA2KruyiT3S8xqQIqoXyOGO7HSJLYrEnTXLOlP0GiTNkrw03jVXoNrDDzfwqmEgEo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Rj5CV6gj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720012167; x=1751548167;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W8KnSELxoOeLFO4Bkg8ypBzvhOg9ofBU1heW/xaRe4k=;
  b=Rj5CV6gjA7bdouczrb90jR05EmC8s1gMOWvzhsKmCBE2E7JT4vVZzOdS
   uBUAswn6AJt3J0nSb+5FoxsxGyLZ8Qjxbfu2zmiNjjSxvu3WcD7WYWqAw
   oaL948Izy4XK6SU6PNJj+gGWNskvdmGM16iSYixj+uE9bizQTgIeC96WQ
   jjhud9EqkR3dkpschvbXGcx6IIodTZym3NgjEus87t6wVzF7FWhj8WJbu
   N9q0TBlMOh7Imj2TJnnXptonwil+6DUI/YFI1Gcz2Bxy0O0NlYYzOOR1K
   jJPxapoEb0zIRrd1OwkSQ3tjgKtWYGanpCYw+DuuPYiytBf/vuZz1EKfX
   Q==;
X-CSE-ConnectionGUID: EqW5S7eWRE2aTexdHZiS+A==
X-CSE-MsgGUID: NasQoXC7S5Kaxo5UL3Vsag==
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="28777735"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 06:09:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 06:09:03 -0700
Received: from [10.180.116.202] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 3 Jul 2024 06:08:46 -0700
Message-ID: <a8cc31a9-d58f-4a4e-98fb-a7ba47bc744e@microchip.com>
Date: Wed, 3 Jul 2024 15:09:07 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] irqchip/atmel-aic: convert to
 of_property_for_each_u32_new()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Miguel Ojeda
	<ojeda@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan
	<saravanak@google.com>, Nathan Chancellor <nathan@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Bjorn Andersson <andersson@kernel.org>,
	=?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>, Krzysztof Kozlowski <krzk@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan
 Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Richard
 Leitner <richard.leitner@linux.dev>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Damien Le Moal <dlemoal@kernel.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
	<linux-clk@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-samsung-soc@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <patches@opensource.cirrus.com>,
	<linux-sound@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
 <20240703-of_property_for_each_u32-v1-11-42c1fc0b82aa@bootlin.com>
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240703-of_property_for_each_u32-v1-11-42c1fc0b82aa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2024 at 12:36, Luca Ceresoli wrote:
> Simplify code using of_property_for_each_u32_new() as the two additional
> parameters in of_property_for_each_u32() are not used here.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/irqchip/irq-atmel-aic-common.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
> index 072bd227b6c6..543ea249df53 100644
> --- a/drivers/irqchip/irq-atmel-aic-common.c
> +++ b/drivers/irqchip/irq-atmel-aic-common.c
> @@ -111,8 +111,6 @@ static void __init aic_common_ext_irq_of_init(struct irq_domain *domain)
>          struct device_node *node = irq_domain_get_of_node(domain);
>          struct irq_chip_generic *gc;
>          struct aic_chip_data *aic;
> -       struct property *prop;
> -       const __be32 *p;
>          u32 hwirq;
> 
>          gc = irq_get_domain_generic_chip(domain, 0);
> @@ -120,7 +118,7 @@ static void __init aic_common_ext_irq_of_init(struct irq_domain *domain)
>          aic = gc->private;
>          aic->ext_irqs |= 1;
> 
> -       of_property_for_each_u32(node, "atmel,external-irqs", prop, p, hwirq) {
> +       of_property_for_each_u32_new(node, "atmel,external-irqs", hwirq) {
>                  gc = irq_get_domain_generic_chip(domain, hwirq);
>                  if (!gc) {
>                          pr_warn("AIC: external irq %d >= %d skip it\n",
> 
> --
> 2.34.1
> 



Return-Path: <linux-pwm+bounces-2750-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B810192D412
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 16:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED92B20897
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C02219046A;
	Wed, 10 Jul 2024 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HntDZcAz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7AB1DDC5
	for <linux-pwm@vger.kernel.org>; Wed, 10 Jul 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621072; cv=none; b=F4CujaOWIaUKyWi4wXvjs9BQvPNB9orv+H1BBz9r5S7Xa4NI343qfdeHItraeUlYRg4J+k24Pn2SVU19twRolGEjoYrZApudzB6moCmC79/J3r4uX2WwprHvN2aNpLC6Egif3ozpm3Yw4Ys3p0Jt8b2NY5VHhOymmNGlpon4MoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621072; c=relaxed/simple;
	bh=Ek9MgjG4ggYliTHvwqDuczVPyWyQss6tCxF19qBQLV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pl9mODykRoW89bU/7VJ8vta/6GYrjwjIGXeiAYE7yoqqsHkSUUd32FONDd6+aEquw36PXwBWx7jCNmpTLr1ZNjB9eCULHWpQ/8DchD7R+s5Ni0jS0GfXY4VDak9BOcT98qGeMm33pOhq8BZg0VbcY6TEaudmCFdSfqdppZAtIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HntDZcAz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720621070; x=1752157070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ek9MgjG4ggYliTHvwqDuczVPyWyQss6tCxF19qBQLV8=;
  b=HntDZcAzcNfyzLqN1xcGV5hBSOfuW9XbtKiD7MnBWQF4hV5BenlxUyH/
   jjUmCGkmbwZeCojV+MtWqkGDPVlvQrNU/LipqDF3PacOBFjr6z5M2hTRM
   /LC53kzk6+kxY97TlNXfNXtYPk/9ap2KFTuIwYq+U+vgMXblWYYotjrqt
   0V7wEF2AFDXPP4YY9zpK7Be51zg1T+hz+zMJlMDvc8iI2i3zSyriozn/S
   YxsZ+M5L0QJXa/ie7KBmCp0gzIqzpzfr9r7XBCx71H5OSCC4nqHROKUri
   AhecgXBeu/4Uj2Xwjc0J1tJyOeA1ij3cVKGU53E6ekykAk6OnNqbtosMU
   A==;
X-CSE-ConnectionGUID: Fo9XeaNTSMG6lsDdAosVqA==
X-CSE-MsgGUID: 0OsNelAeTPWGKCgc30CDRQ==
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="31728912"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2024 07:17:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jul 2024 07:17:24 -0700
Received: from [10.180.117.33] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Jul 2024 07:17:22 -0700
Message-ID: <6db1de1b-cf0c-4acc-91dd-41dddfa36227@microchip.com>
Date: Wed, 10 Jul 2024 16:17:47 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: atmel-tcb: Simplify checking the companion
 output
Content-Language: en-US, fr-FR
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240709101806.52394-3-u.kleine-koenig@baylibre.com>
 <20240709101806.52394-4-u.kleine-koenig@baylibre.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240709101806.52394-4-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 09/07/2024 at 12:18, Uwe Kleine-König wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> The two outputs provided by the supported hardware share some settings,
> so access to the other PWM is required when one of them is configured.
> 
> Instead of an explicit if to deterimine the other PWM just use
> hwpwm ^ 1. Further atcbpwm is never NULL, so drop the corresponding
> check.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Thanks. Best regards,
   Nicolas

> ---
>   drivers/pwm/pwm-atmel-tcb.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index aca11493239a..2feee3744b50 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -260,7 +260,8 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   {
>          struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
>          struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
> -       struct atmel_tcb_pwm_device *atcbpwm = NULL;
> +       /* companion PWM sharing register values period and div */
> +       struct atmel_tcb_pwm_device *atcbpwm = &tcbpwmc->pwms[pwm->hwpwm ^ 1];
>          int i = 0;
>          int slowclk = 0;
>          unsigned period;
> @@ -305,11 +306,6 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>          duty = div_u64(duty_ns, min);
>          period = div_u64(period_ns, min);
> 
> -       if (pwm->hwpwm == 0)
> -               atcbpwm = &tcbpwmc->pwms[1];
> -       else
> -               atcbpwm = &tcbpwmc->pwms[0];
> -
>          /*
>           * PWM devices provided by the TCB driver are grouped by 2.
>           * PWM devices in a given group must be configured with the
> @@ -318,8 +314,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>           * We're checking the period value of the second PWM device
>           * in this group before applying the new config.
>           */
> -       if ((atcbpwm && atcbpwm->duty > 0 &&
> -                       atcbpwm->duty != atcbpwm->period) &&
> +       if ((atcbpwm->duty > 0 && atcbpwm->duty != atcbpwm->period) &&
>                  (atcbpwm->div != i || atcbpwm->period != period)) {
>                  dev_err(pwmchip_parent(chip),
>                          "failed to configure period_ns: PWM group already configured with a different value\n");
> --
> 2.43.0
> 



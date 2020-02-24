Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67894169F91
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2020 08:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBXHxI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Feb 2020 02:53:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60459 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgBXHxH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Feb 2020 02:53:07 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j68Y3-00081w-Ej; Mon, 24 Feb 2020 08:53:03 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j68Y2-000422-7S; Mon, 24 Feb 2020 08:53:02 +0100
Date:   Mon, 24 Feb 2020 08:53:02 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: Drop unused header file
Message-ID: <20200224075302.jd3vcrdl6fuqrkpb@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-2-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224052135.17278-2-lokeshvutla@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Mon, Feb 24, 2020 at 10:51:32AM +0530, Lokesh Vutla wrote:
> @@ -190,9 +190,8 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>  		load_value, load_value,	match_value, match_value);
>  
>  	omap->pdata->set_pwm(omap->dm_timer,
> -			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> -			      true,
> -			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);

This is unrelated.

>  
>  	/* If config was called while timer was running it must be reenabled. */
>  	if (timer_active)
> @@ -220,9 +219,8 @@ static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
>  	 */
>  	mutex_lock(&omap->mutex);
>  	omap->pdata->set_pwm(omap->dm_timer,
> -			      polarity == PWM_POLARITY_INVERSED,
> -			      true,
> -			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> +			     polarity == PWM_POLARITY_INVERSED,
> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);

ditto

>  	mutex_unlock(&omap->mutex);
>  
>  	return 0;
> @@ -244,7 +242,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>  	struct pwm_omap_dmtimer_chip *omap;
>  	struct dmtimer_platform_data *timer_pdata;
>  	const struct omap_dm_timer_ops *pdata;
> -	pwm_omap_dmtimer *dm_timer;
> +	struct omap_dm_timer *dm_timer;
>  	u32 v;
>  	int ret = 0;
>  

Other than that looks fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

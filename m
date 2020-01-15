Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D1013C875
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2020 16:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAOPy3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Jan 2020 10:54:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47821 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAOPy3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Jan 2020 10:54:29 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1irkzy-0000MJ-PR; Wed, 15 Jan 2020 16:54:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1irkzx-0002bh-TZ; Wed, 15 Jan 2020 16:54:25 +0100
Date:   Wed, 15 Jan 2020 16:54:25 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v1] pwm: lpss: Use positive condition in
 pwm_lpss_prepare()
Message-ID: <20200115155425.n6nt7srrh4kxuczg@pengutronix.de>
References: <20200115150849.74036-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200115150849.74036-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jan 15, 2020 at 05:08:49PM +0200, Andy Shevchenko wrote:
> For better readability and maintenance use positive condition
> in pwm_lpss_prepare(). No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 75bbfe5f3bc2..6930a1d99860 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -109,10 +109,11 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
>  	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
>  	ctrl |= on_time_div;
>  
> -	if (orig_ctrl != ctrl) {
> -		pwm_lpss_write(pwm, ctrl);
> -		pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
> -	}
> +	if (orig_ctrl == ctrl)
> +		return;
> +
> +	pwm_lpss_write(pwm, ctrl);
> +	pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);

I personally don't think that readability improved much and think that
the old code is more intuitive. ("If the wanted register value doesn't
match the actual value, write the value out.")

But I agree that the patch doesn't introduce a semantic difference.

What made you create that patch? Is it really that you read through the
driver and thought "Huh, this is more complicated than necessary."?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

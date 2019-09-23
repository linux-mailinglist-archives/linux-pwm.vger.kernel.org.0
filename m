Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E0ABAF7D
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2019 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404985AbfIWI1j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Sep 2019 04:27:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53637 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405555AbfIWI1j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Sep 2019 04:27:39 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCJh2-0007k8-EV; Mon, 23 Sep 2019 10:27:36 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCJh1-0000Cf-Vo; Mon, 23 Sep 2019 10:27:35 +0200
Date:   Mon, 23 Sep 2019 10:27:35 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] pwm: mxs: add support for inverse polarity
Message-ID: <20190923082735.tzxyhvjlnztsxhsc@pengutronix.de>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
 <20190923081348.6843-4-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190923081348.6843-4-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 23, 2019 at 10:13:47AM +0200, Rasmus Villemoes wrote:
> If I'm reading of_pwm_xlate_with_flags() right, existing device trees
> that set #pwm-cells = 2 will continue to work.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/pwm/pwm-mxs.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index 284107784dad..c46697acaf11 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -25,8 +25,11 @@
>  #define  PERIOD_PERIOD(p)	((p) & 0xffff)
>  #define  PERIOD_PERIOD_MAX	0x10000
>  #define  PERIOD_ACTIVE_HIGH	(3 << 16)
> +#define  PERIOD_ACTIVE_LOW	(2 << 16)
> +#define  PERIOD_INACTIVE_HIGH	(3 << 18)
>  #define  PERIOD_INACTIVE_LOW	(2 << 18)
>  #define  PERIOD_POLARITY_NORMAL	(PERIOD_ACTIVE_HIGH | PERIOD_INACTIVE_LOW)
> +#define  PERIOD_POLARITY_INVERSE	(PERIOD_ACTIVE_LOW | PERIOD_INACTIVE_HIGH)
>  #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
>  #define  PERIOD_CDIV_MAX	8
>  
> @@ -50,9 +53,7 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	unsigned int period_cycles, duty_cycles;
>  	unsigned long rate;
>  	unsigned long long c;
> -
> -	if (state->polarity != PWM_POLARITY_NORMAL)
> -		return -ENOTSUPP;
> +	unsigned int pol_bits;
>  
>  	rate = clk_get_rate(mxs->clk);
>  	while (1) {
> @@ -81,9 +82,12 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			return ret;
>  	}
>  
> +	pol_bits = state->polarity == PWM_POLARITY_NORMAL ?
> +		PERIOD_POLARITY_NORMAL : PERIOD_POLARITY_INVERSE;
> +
>  	writel(duty_cycles << 16,
>  	       mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
> -	writel(PERIOD_PERIOD(period_cycles) | PERIOD_POLARITY_NORMAL | PERIOD_CDIV(div),
> +	writel(PERIOD_PERIOD(period_cycles) | pol_bits | PERIOD_CDIV(div),

When will this affect the output? Only on the next start of a period, or
immediatly? Can it happen that this results in a mixed output (i.e. a
period that has already the new duty cycle from the line above but not
the new polarity (or period)?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

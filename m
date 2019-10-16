Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 763C0D8F14
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 13:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390935AbfJPLPZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 07:15:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39809 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfJPLPZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:15:25 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKhH1-0004kE-Bc; Wed, 16 Oct 2019 13:15:23 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKhH0-0003u9-Kf; Wed, 16 Oct 2019 13:15:22 +0200
Date:   Wed, 16 Oct 2019 13:15:22 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pwm: stm32: Validate breakinput data from DT
Message-ID: <20191016111522.vzsipskmt66q27bq@pengutronix.de>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
 <20191016110601.1765415-4-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016110601.1765415-4-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 01:06:01PM +0200, Thierry Reding wrote:
> Both index and level can only be either 0 or 1 and the filter value is
> limited to values between (and including) 0 and 15. Validate that the
> device tree node contains values that are within these ranges.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-stm32.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index db1d675b45fb..7ff48c14fae8 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -530,6 +530,7 @@ static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
>  				       struct device_node *np)
>  {
>  	int nb, ret, array_size;
> +	unsigned int i;
>  
>  	nb = of_property_count_elems_of_size(np, "st,breakinput",
>  					     sizeof(struct stm32_breakinput));
> @@ -551,6 +552,13 @@ static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
>  	if (ret)
>  		return ret;
>  
> +	for (i = 0; i < priv->num_breakinputs; i++) {
> +		if (priv->breakinputs[i].index > 1 ||
> +		    priv->breakinputs[i].level > 1 ||
> +		    priv->breakinputs[i].filter > 15)
> +			return -EINVAL;
> +	}
> +

maybe put this patch before patch 1 that relies on index not being
bigger than 1?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

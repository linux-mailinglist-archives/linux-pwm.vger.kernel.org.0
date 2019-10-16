Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9B6D8AD8
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 10:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfJPI0P (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 04:26:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56091 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfJPI0P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 04:26:15 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKedJ-0000QI-PM; Wed, 16 Oct 2019 10:26:13 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKedI-0006VN-8L; Wed, 16 Oct 2019 10:26:12 +0200
Date:   Wed, 16 Oct 2019 10:26:12 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: stm32: Remove clutter from ternary operator
Message-ID: <20191016082612.fwpig3pup6bor5cn@pengutronix.de>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
 <20191016073842.1300297-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016073842.1300297-2-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 09:38:40AM +0200, Thierry Reding wrote:
> Remove usage of the ternary operator to assign values for register
> fields. This removes clutter and improves readability.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-stm32.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 9430b4cd383f..b12fb11b7a55 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -493,11 +493,19 @@ static const struct pwm_ops stm32pwm_ops = {
>  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
>  				    int index, int level, int filter)
>  {
> -	u32 bke = (index == 0) ? TIM_BDTR_BKE : TIM_BDTR_BK2E;
> -	int shift = (index == 0) ? TIM_BDTR_BKF_SHIFT : TIM_BDTR_BK2F_SHIFT;
> -	u32 mask = (index == 0) ? TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF
> -				: TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
> -	u32 bdtr = bke;
> +	u32 bke, shift, mask, bdtr;
> +
> +	if (index == 0) {
> +		bke = TIM_BDTR_BKE;
> +		shift = TIM_BDTR_BKF_SHIFT;
> +		mask = TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
> +	} else {
> +		bke = TIM_BDTR_BK2E;
> +		shift = TIM_BDTR_BK2F_SHIFT;
> +		mask = TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
> +	}
> +
> +	bdtr = bke;

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Is index always in {0, 1}? Maybe a comment or a check about that would
be helpful. (-> separate patch I think).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE127D8F03
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392634AbfJPLLe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 07:11:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45305 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbfJPLLe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:11:34 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKhDI-00046n-Re; Wed, 16 Oct 2019 13:11:32 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKhDH-0003m3-93; Wed, 16 Oct 2019 13:11:31 +0200
Date:   Wed, 16 Oct 2019 13:11:31 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: stm32: Remove clutter from ternary operator
Message-ID: <20191016111131.n2rrmkjfju2sc72y@pengutronix.de>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
 <20191016110601.1765415-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016110601.1765415-2-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 01:05:59PM +0200, Thierry Reding wrote:
> Remove usage of the ternary operator to assign values for register
> fields. Instead, parameterize the register and field offset macros
> and pass the index to them.
> 
> This removes clutter and improves readability.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-stm32.c          | 21 +++++++++------------
>  include/linux/mfd/stm32-timers.h | 12 ++++--------
>  2 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 9430b4cd383f..a5b323432d8c 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -493,20 +493,17 @@ static const struct pwm_ops stm32pwm_ops = {
>  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
>  				    int index, int level, int filter)
>  {
> -	u32 bke = (index == 0) ? TIM_BDTR_BKE : TIM_BDTR_BK2E;
> -	int shift = (index == 0) ? TIM_BDTR_BKF_SHIFT : TIM_BDTR_BK2F_SHIFT;
> -	u32 mask = (index == 0) ? TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF
> -				: TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
> -	u32 bdtr = bke;
> +	u32 shift = TIM_BDTR_BKF_SHIFT(index);
> +	u32 bke = TIM_BDTR_BKE(index);
> +	u32 bkp = TIM_BDTR_BKP(index);
> +	u32 bkf = TIM_BDTR_BKF(index);
> +	u32 mask = bkf | bkp | bke;
> +	u32 bdtr;

It's not clear that

	(index == 0) ? TIM_BDTR_BKE : TIM_BDTR_BK2E

is the same as

	TIM_BDTR_BKE(index)

unless we know that index is 0 or 1. A word about that in the commit log
would be great, maybe even ...

>  
> -	/*
> -	 * The both bits could be set since only one will be wrote
> -	 * due to mask value.
> -	 */
> -	if (level)
> -		bdtr |= TIM_BDTR_BKP | TIM_BDTR_BK2P;
> +	bdtr = (filter & TIM_BDTR_BKF_MASK) << shift | bke;
>  
> -	bdtr |= (filter & TIM_BDTR_BKF_MASK) << shift;
> +	if (level)
> +		bdtr |= bkp;
>  
>  	regmap_update_bits(priv->regmap, TIM_BDTR, mask, bdtr);
>  
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index 067d14655c28..f8db83aedb2b 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -70,14 +70,11 @@
>  #define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
>  #define TIM_CCER_CC4P	BIT(13)	/* Capt/Comp 4  Polarity   */
>  #define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
> -#define TIM_BDTR_BKE	BIT(12) /* Break input enable	   */
> -#define TIM_BDTR_BKP	BIT(13) /* Break input polarity	   */
> +#define TIM_BDTR_BKE(x)	BIT(12 + (x) * 12) /* Break input enable */
> +#define TIM_BDTR_BKP(x)	BIT(13 + (x) * 12) /* Break input polarity */
>  #define TIM_BDTR_AOE	BIT(14)	/* Automatic Output Enable */
>  #define TIM_BDTR_MOE	BIT(15)	/* Main Output Enable      */
> -#define TIM_BDTR_BKF	(BIT(16) | BIT(17) | BIT(18) | BIT(19))
> -#define TIM_BDTR_BK2F	(BIT(20) | BIT(21) | BIT(22) | BIT(23))
> -#define TIM_BDTR_BK2E	BIT(24) /* Break 2 input enable	   */
> -#define TIM_BDTR_BK2P	BIT(25) /* Break 2 input polarity  */
> +#define TIM_BDTR_BKF(x)	(0xf << (16 + (x) * 4))
>  #define TIM_DCR_DBA	GENMASK(4, 0)	/* DMA base addr */
>  #define TIM_DCR_DBL	GENMASK(12, 8)	/* DMA burst len */
>  
> @@ -87,8 +84,7 @@
>  #define TIM_CR2_MMS2_SHIFT	20
>  #define TIM_SMCR_TS_SHIFT	4
>  #define TIM_BDTR_BKF_MASK	0xF
> -#define TIM_BDTR_BKF_SHIFT	16
> -#define TIM_BDTR_BK2F_SHIFT	20
> +#define TIM_BDTR_BKF_SHIFT(x)	(16 + (x) * 4)

... define the macros as:

	#define TIM_BDTR_BKF_SHIFT(x)        (BUF_ON(index != 0 && index != 1), 16 + (x) * 4)

?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

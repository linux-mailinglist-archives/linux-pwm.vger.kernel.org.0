Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4828AD8AFA
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfJPIbK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 04:31:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39055 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfJPIbK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 04:31:10 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKei4-0000xG-VI; Wed, 16 Oct 2019 10:31:08 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKei3-0006eM-T8; Wed, 16 Oct 2019 10:31:07 +0200
Date:   Wed, 16 Oct 2019 10:31:07 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/3] pwm: stm32: Remove confusing bitmask
Message-ID: <20191016083107.fetprdj7k52hkdvy@pengutronix.de>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
 <20191016073842.1300297-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016073842.1300297-3-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 09:38:41AM +0200, Thierry Reding wrote:
> Both BKP bits are set in the BDTR register and the code relies on the
> mask used during write to make sure only one of them is written. Since
> this isn't immediately obvious, a comment is needed to explain it. The
> same can be achieved by making explicit what happens, so add another
> temporary variable that contains only the one bit that is actually ORed
> into the register and get rid of the comment.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-stm32.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index b12fb11b7a55..8f1f3371e1dd 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -493,26 +493,24 @@ static const struct pwm_ops stm32pwm_ops = {
>  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
>  				    int index, int level, int filter)
>  {
> -	u32 bke, shift, mask, bdtr;
> +	u32 bke, bkp, shift, mask, bdtr;
>  
>  	if (index == 0) {
>  		bke = TIM_BDTR_BKE;
> +		bkp = TIM_BDTR_BKP;
>  		shift = TIM_BDTR_BKF_SHIFT;
>  		mask = TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
>  	} else {
>  		bke = TIM_BDTR_BK2E;
> +		bkp = TIM_BDTR_BK2P;
>  		shift = TIM_BDTR_BK2F_SHIFT;
>  		mask = TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;

Assuming in the else branch index is always 1, the following would be
IMHO nicer:

#define TIM_BDTR_BKE(i) BIT(12 + 12 * (i))
#define TIM_BDTR_BKP(i) BIT(13 + 12 * (i))
#define TIM_BDTR_BKF_SHIFT(i) (16 + 4 * (i))

..

	bke = TIM_BDTR_BKE(index);
	bkp = TIM_BDTR_BKP(index);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

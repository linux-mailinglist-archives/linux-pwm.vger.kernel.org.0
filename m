Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCC1A4A51
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2020 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgDJTU6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Apr 2020 15:20:58 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:28012 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbgDJTU5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Apr 2020 15:20:57 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Apr 2020 12:20:41 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 10 Apr 2020 12:20:41 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 617194BED; Fri, 10 Apr 2020 12:20:41 -0700 (PDT)
Date:   Fri, 10 Apr 2020 12:20:41 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v12 08/11] pwm: sun4i: Use nsecs_to_jiffies to avoid a
 division
Message-ID: <20200410192041.GC21571@codeaurora.org>
References: <cover.1586414867.git.gurus@codeaurora.org>
 <436e1a50e603eefb24c8e7b2bd7f7e4838b90e12.1586414867.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436e1a50e603eefb24c8e7b2bd7f7e4838b90e12.1586414867.git.gurus@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 08, 2020 at 11:52:37PM -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_state.period's datatype
> to u64, prepare for this transition by using nsecs_to_jiffies() which
> does away with the need for a division operation.
> 
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/pwm-sun4i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 5c677c5..1694e69 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -285,7 +285,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
>  	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
>  	sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
> -		usecs_to_jiffies(cstate.period / 1000 + 1);
> +		nsecs_to_jiffies(cstate.period + 1000);
>  
>  	if (state->polarity != PWM_POLARITY_NORMAL)
>  		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
> -- 

Hi Chen-Yu,

You had provided your "Acked-by:" [1] for an earlier version of this
patch but now that I've revised the patch based on a review comment I
received [2], could you please review this patch once again?

Thank you.

Guru Das.

[1] https://www.spinics.net/lists/linux-pwm/msg11755.html
[2] https://www.spinics.net/lists/linux-pwm/msg11956.html

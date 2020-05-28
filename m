Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F391E6C9A
	for <lists+linux-pwm@lfdr.de>; Thu, 28 May 2020 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407092AbgE1Udn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 May 2020 16:33:43 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:47667 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407020AbgE1Udm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 May 2020 16:33:42 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 May 2020 13:33:42 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg05-sd.qualcomm.com with ESMTP; 28 May 2020 13:33:41 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 40EB24CCF; Thu, 28 May 2020 13:33:41 -0700 (PDT)
Date:   Thu, 28 May 2020 13:33:41 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 04/11] pwm: clps711x: Use 64-bit division macro
Message-ID: <20200528203341.GA8065@codeaurora.org>
References: <cover.1590514331.git.gurus@codeaurora.org>
 <dd03cc467ac3fc470826aef523822b32e15dc929.1590514331.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd03cc467ac3fc470826aef523822b32e15dc929.1590514331.git.gurus@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, May 26, 2020 at 10:35:04AM -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by using DIV64_U64_ROUND_CLOSEST to
> handle a 64-bit divisor.
> 
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/pwm-clps711x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> index 924d39a..ba9500a 100644
> --- a/drivers/pwm/pwm-clps711x.c
> +++ b/drivers/pwm/pwm-clps711x.c
> @@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
>  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
>  {
>  	/* Duty cycle 0..15 max */
> -	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> +	return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
>  }
>  
>  static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> -- 

Hi Daniel,

Could you please review this patch when you get a chance to?

Thank you.

Guru Das.

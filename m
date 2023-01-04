Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA9F65CF81
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Jan 2023 10:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjADJ1D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Jan 2023 04:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbjADJWJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Jan 2023 04:22:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CC6333
        for <linux-pwm@vger.kernel.org>; Wed,  4 Jan 2023 01:22:02 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1pCzyB-00040r-9R; Wed, 04 Jan 2023 10:21:59 +0100
Message-ID: <a9e4c773-4cc3-60b7-d8fc-cf0956657209@pengutronix.de>
Date:   Wed, 4 Jan 2023 10:21:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] pwm: ab8500:
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Axel Lin <axel.lin@ingics.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
References: <20230103231841.1548913-1-u.kleine-koenig@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20230103231841.1548913-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 04.01.23 00:18, Uwe Kleine-König wrote:
> The .apply() callback only considered the 10 low bits of .duty_cycle and
> didn't check .period at all.
> 
> My best guess is the period is fixed at 1024 ns = 0x400 ns. Based on
> that assumption refuse configurations that request a lower period (as
> usual for PWM drivers) and configure a duty cycle of 0x3ff ns for all
> bigger requests.
> 
> This improves behaviour for a few requests:
> 
>   request  | previous result | new result
> -----------+-----------------+------------
>  1024/1024 |          0/1024 |  1023/1024
>  4000/5000 |        928/1024 |  1023/1024
>  5000/5000 |        904/1024 |  1023/1024
> 
> (Values specified as duty_cycle / period in ns)
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-ab8500.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
> index ad37bc46f272..a7f64371449b 100644
> --- a/drivers/pwm/pwm-ab8500.c
> +++ b/drivers/pwm/pwm-ab8500.c
> @@ -37,6 +37,7 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	u8 reg;
>  	unsigned int higher_val, lower_val;
>  	struct ab8500_pwm_chip *ab8500 = ab8500_pwm_from_chip(chip);
> +	unsigned int duty_cycle;
>  
>  	if (state->polarity != PWM_POLARITY_NORMAL)
>  		return -EINVAL;
> @@ -52,16 +53,25 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return ret;
>  	}
>  
> +	/* The period is fixed at 0x400 ns */
> +	if (state->period < 0x400)

If it's fixed, why < instead of == ?

> +		return -EINVAL;
> +
> +	if (state->duty_cycle >= 0x400)
> +		duty_cycle = 0x3ff;
> +	else
> +		duty_cycle = state->duty_cycle;

You can use duty_cycle = min(state->duty_cycle, 0x3ff); here

> +
>  	/*
>  	 * get the first 8 bits that are be written to
>  	 * AB8500_PWM_OUT_CTRL1_REG[0:7]
>  	 */
> -	lower_val = state->duty_cycle & 0x00FF;
> +	lower_val = duty_cycle & 0x00FF;
>  	/*
>  	 * get bits [9:10] that are to be written to
>  	 * AB8500_PWM_OUT_CTRL2_REG[0:1]
>  	 */
> -	higher_val = ((state->duty_cycle & 0x0300) >> 8);
> +	higher_val = (duty_cycle & 0x0300) >> 8;
>  
>  	reg = AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2);
>  

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


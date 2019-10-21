Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 577D9DEE7B
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfJUNzg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 09:55:36 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:52650 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbfJUNzf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 21 Oct 2019 09:55:35 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 65B47A28ED;
        Mon, 21 Oct 2019 15:55:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1571666134;
        bh=THebfvsMkcYIOyYv/5w/H4orM9JPOjtQd8emeIaXx8g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l6Ei1w0ll/KcFskD509lgbGYx7otEiEd/ePz6tvhhLfBzrfNIwCGJ9/zfWLF8/U/X
         LyD69dGWJkeFkswvIPc9BaechqaE2jRF+lh27ZYHYQoaaf3PMIWiJBVM2qnwZqm+8V
         ml0NGp+KzCnd8OJS2t6wsYtpoaTjbff3O5YV6SYo=
Subject: Re: [PATCH] Revert "pwm: Let pwm_get_state() return the last
 implemented state"
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org
References: <20191021105830.1357795-1-thierry.reding@gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <35885da4-4172-4d1f-a05e-d094669535c9@ysoft.com>
Date:   Mon, 21 Oct 2019 15:55:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021105830.1357795-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 21. 10. 19 12:58, Thierry Reding wrote:
> It turns out that commit 01ccf903edd6 ("pwm: Let pwm_get_state() return
> the last implemented state") causes backlight failures on a number of
> boards. The reason is that some of the drivers do not write the full
> state through to the hardware registers, which means that ->get_state()
> subsequently does not return the correct state. Consumers which rely on
> pwm_get_state() returning the current state will therefore get confused
> and subsequently try to program a bad state.
> 
> Before this change can be made, existing drivers need to be more
> carefully audited and fixed to behave as the framework expects. Until
> then, keep the original behaviour of returning the software state that
> was applied rather than reading the state back from hardware.

Backlight on our imx6dl-yapp4-draco board works fine again when
this is reverted.

Tested-by: Michal Vokáč <michal.vokac@ysoft.com>

> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>   drivers/pwm/core.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 6ad51aa60c03..f877e77d9184 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -472,14 +472,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
>   		if (err)
>   			return err;
>   
> -		/*
> -		 * .apply might have to round some values in *state, if possible
> -		 * read the actually implemented value back.
> -		 */
> -		if (chip->ops->get_state)
> -			chip->ops->get_state(chip, pwm, &pwm->state);
> -		else
> -			pwm->state = *state;
> +		pwm->state = *state;
>   	} else {
>   		/*
>   		 * FIXME: restore the initial state in case of error.
> 


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0DDEDA0
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfJUNdO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 09:33:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35718 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfJUNdO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 09:33:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2E0F428ABF9
Subject: Re: [PATCH] Revert "pwm: Let pwm_get_state() return the last
 implemented state"
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20191021105830.1357795-1-thierry.reding@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c56edf24-e3a5-3e00-1eb6-c7f4e9855f36@collabora.com>
Date:   Mon, 21 Oct 2019 15:33:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021105830.1357795-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 21/10/19 12:58, Thierry Reding wrote:
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
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric.

> ---
>  drivers/pwm/core.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 6ad51aa60c03..f877e77d9184 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -472,14 +472,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
>  		if (err)
>  			return err;
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
>  	} else {
>  		/*
>  		 * FIXME: restore the initial state in case of error.
> 

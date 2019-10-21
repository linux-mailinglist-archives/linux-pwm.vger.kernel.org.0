Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 992FFDEE3C
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 15:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfJUNq0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 09:46:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35914 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfJUNq0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 09:46:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9D32B2639ED
Subject: Re: [PATCH 1/4] pwm: Read initial hardware state at request time
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <121ab7d5-831c-5298-c747-b231e1e361ba@collabora.com>
Date:   Mon, 21 Oct 2019 15:46:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021105739.1357629-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 21/10/19 12:57, Thierry Reding wrote:
> The PWM core doesn't need to know about the hardware state of a PWM
> unless there is a user for it. Defer initial hardware readout until
> a PWM is requested.
> 
> As a side-effect, this allows the ->get_state() callback to rely on
> per-PWM data.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Tested on top of 5.4.0-rc4 with 2/4 applied this patch fixes the NULL pointer
dereference as expected. So,

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

> ---
>  drivers/pwm/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index f877e77d9184..e067873c6cc5 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -114,6 +114,9 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>  		}
>  	}
>  
> +	if (pwm->chip->ops->get_state)
> +		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
> +
>  	set_bit(PWMF_REQUESTED, &pwm->flags);
>  	pwm->label = label;
>  
> @@ -283,9 +286,6 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>  		pwm->hwpwm = i;
>  		pwm->state.polarity = polarity;
>  
> -		if (chip->ops->get_state)
> -			chip->ops->get_state(chip, pwm, &pwm->state);
> -
>  		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
>  	}
>  
> 

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B755A41E36D
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Sep 2021 23:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350086AbhI3VhK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Sep 2021 17:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349978AbhI3VhJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Sep 2021 17:37:09 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E17C06176D
        for <linux-pwm@vger.kernel.org>; Thu, 30 Sep 2021 14:35:26 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q16so9065371oiw.10
        for <linux-pwm@vger.kernel.org>; Thu, 30 Sep 2021 14:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=e0NcfULf3wNNjVF33uwiRx+dy6Dmhwkfi1qdAZs9US4=;
        b=DBjew3S0URka73F8hSVwAUYD20OGHDuGURaoBEn3oYxUADnCPbuh2AkHxd1rWzWBWb
         CT67tzsTYkVTDq03fcfZAEdnq8OfBHkIzO8dVmgq8aXWXDO+dr0qKnWkYc/iInzciKrI
         qf94lP+haQyQtcD/9YWmnGQz59MfjETnwL1VthNXS7D8tVXddyVGX8bxyasjYcZfATcC
         fjasSaMS8S72GOuG5glNpDe3++79AAN+UBKQaI0He99CT4idFjPqVbxMMzrgwELHkBnn
         ZxYBAVOCh0HJ+fgW1izeqqzlpAADFgXWh8RmiAIqS/5JHVLemV7NcIt5PHsXQfJ1dG6J
         ebBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=e0NcfULf3wNNjVF33uwiRx+dy6Dmhwkfi1qdAZs9US4=;
        b=WN1tMZpGhp7LTFxAhiWQadIGYGfwiHlQpvGEai+gcIc3yDHFpHYa43TwIqJKCEwawJ
         EAZmtL+y/nZcMOcEhSuMMTaWB+jiErpFjBzK4PRFXr3XifMJwwvK7YFPJl73e/8I3DCl
         5og7bKbTZCdxq0rYL1Js477lO/s4Fk98iS4NIoFQWsyT2cwnwfHq2H56vZvyohBb6sdt
         GOg7pxx/7qUW35XRl9SZLUoPPY2L9Xz4EaFJ1cQsIF+KQDruIhjd+FelNAc5scS2aTCJ
         283pA02Ei9ohgpJ/x7IbmBbxs1d+Em6zl4N+mKK214pELPzHYwZt6bHHUet2lSmdDor5
         w6Uw==
X-Gm-Message-State: AOAM5300zDTGmNJ0dgW8fu231iy4q8Hm14bE4snl72m3Th24ccTio8Xb
        JVZVagr4DuFhaz5inzJDrd96Mg==
X-Google-Smtp-Source: ABdhPJz6lc6vrB1jwZXEZfb6aq4lDeyCWpNlrFW0PbVZaw3Sux9WhXMMhsglFjUCTTV3T9ZfmG/FKQ==
X-Received: by 2002:a05:6808:107:: with SMTP id b7mr1237518oie.146.1633037725892;
        Thu, 30 Sep 2021 14:35:25 -0700 (PDT)
Received: from MacBook-Pro.hackershack.net (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id w17sm775133otu.54.2021.09.30.14.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 14:35:25 -0700 (PDT)
Subject: Re: [PATCH v6 1/3] pwm: Introduce single-PWM of_xlate function
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@google.com>
References: <20210930030557.1426-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <aa563e12-4c3c-1854-ce91-efa7676d1676@kali.org>
Date:   Thu, 30 Sep 2021 16:35:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210930030557.1426-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 9/29/21 10:05 PM, Bjorn Andersson wrote:
> The existing pxa driver and the upcoming addition of PWM support in the
> TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
> thereby a need for a of_xlate function with the period as its single
> argument.
>
> Introduce a common helper function in the core that can be used as
> of_xlate by such drivers and migrate the pxa driver to use this.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v4:
> - None
>
>  drivers/pwm/core.c    | 26 ++++++++++++++++++++++++++
>  drivers/pwm/pwm-pxa.c | 16 +---------------
>  include/linux/pwm.h   |  2 ++
>  3 files changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 4527f09a5c50..2c6b155002a2 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -152,6 +152,32 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
>  }
>  EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
>  
> +struct pwm_device *
> +of_pwm_single_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> +{
> +	struct pwm_device *pwm;
> +
> +	if (pc->of_pwm_n_cells < 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* validate that one cell is specified, optionally with flags */
> +	if (args->args_count != 1 && args->args_count != 2)
> +		return ERR_PTR(-EINVAL);
> +
> +	pwm = pwm_request_from_chip(pc, 0, NULL);
> +	if (IS_ERR(pwm))
> +		return pwm;
> +
> +	pwm->args.period = args->args[0];
> +	pwm->args.polarity = PWM_POLARITY_NORMAL;
> +
> +	if (args->args_count == 2 && args->args[2] & PWM_POLARITY_INVERTED)
> +		pwm->args.polarity = PWM_POLARITY_INVERSED;
> +
> +	return pwm;
> +}
> +EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
> +
>  static void of_pwmchip_add(struct pwm_chip *chip)
>  {
>  	if (!chip->dev || !chip->dev->of_node)
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index a9efdcf839ae..238ec88c130b 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -148,20 +148,6 @@ static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
>  	return id ? id->data : NULL;
>  }
>  
> -static struct pwm_device *
> -pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> -{
> -	struct pwm_device *pwm;
> -
> -	pwm = pwm_request_from_chip(pc, 0, NULL);
> -	if (IS_ERR(pwm))
> -		return pwm;
> -
> -	pwm->args.period = args->args[0];
> -
> -	return pwm;
> -}
> -
>  static int pwm_probe(struct platform_device *pdev)
>  {
>  	const struct platform_device_id *id = platform_get_device_id(pdev);
> @@ -187,7 +173,7 @@ static int pwm_probe(struct platform_device *pdev)
>  	pc->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
>  
>  	if (IS_ENABLED(CONFIG_OF)) {
> -		pc->chip.of_xlate = pxa_pwm_of_xlate;
> +		pc->chip.of_xlate = of_pwm_single_xlate;
>  		pc->chip.of_pwm_n_cells = 1;
>  	}
>  
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 725c9b784e60..dd51d4931fdc 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -414,6 +414,8 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
>  
>  struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
>  		const struct of_phandle_args *args);
> +struct pwm_device *of_pwm_single_xlate(struct pwm_chip *pc,
> +				       const struct of_phandle_args *args);
>  
>  struct pwm_device *pwm_get(struct device *dev, const char *con_id);
>  struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,


I've tested these v6 all 3 patches on the Lenovo Yoga C630

Tested-by: Steev Klimaszewski <steev@kali.org>


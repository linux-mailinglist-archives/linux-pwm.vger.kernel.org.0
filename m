Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC9F292948
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Oct 2020 16:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgJSO1m (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Oct 2020 10:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgJSO1m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Oct 2020 10:27:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA6AC0613CE;
        Mon, 19 Oct 2020 07:27:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x7so11737616wrl.3;
        Mon, 19 Oct 2020 07:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J4XrE9HXCwR/KsIjqo1txSO+XN0eoJhfpbzWewRFJS4=;
        b=uxS9qthpVn3xJuHFts06PWunbbuZJSC4Fc/PvBwMhICn2Na9aaKscOIwWYX/J4F3Al
         ZfO670d04wzxjcAKPJsXo7WatjigwbNqg0VIf/YF8KW717LoKsIJ/hQXex4GDfWXu4Jx
         Vz20/NPw1O9Aw/FQy50u8BSKb/YwGbWBoxlK3RtUk53KjAupDw58jIp+caYbrFGXGIdP
         RgAaMsRpeB2bGZxLdf8qcCFBcwRZzPFBrdx5rTYwpVFeUwKTKaEyZ6cM+gu0zcXgTLGo
         kSkxmM7HxUqAg9dqguSYzD98ZJ5I/1TUZKeIPW4Ipm0zZ1vy+45yI0i8NlSB6JpUkOYH
         NcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J4XrE9HXCwR/KsIjqo1txSO+XN0eoJhfpbzWewRFJS4=;
        b=ldza+qnsS1pE99vIY/0CELKtRyInTWIfZXdAZhTZh41bNXdqNDFNC6HOUl97Dqo8Wo
         lYFMRd4IeMj4rZ4VPZr/5L+b6M9JuADNKTvDE2pYwudIwKeOmimhWQBZtEAGyXZkWIvd
         SgizqbDUesUyx8hAoujjjTBsW0smq8nQzt2DUMo6ZVr6dGBNR6UVkzDz4t6ekCXgNiY2
         D6hoL0JqZDmn7KXWZrQTATH9QeeB2ikbacZumK0teZx1q1pWHOyfcqiHctkfChi42BbL
         tVU7NHzggNny4t7n1WWj383SCoszy1kjGdPa/tZ3XzzpG16fuByJ+8VkzYOm9wRLuett
         0rGw==
X-Gm-Message-State: AOAM531TOJAyPgAlR+uBICM4PRDd0bIPIpHoSdNNqJfTG6aLf0F/q2pq
        bSoTf/c4KAW9M2pPVmTuVA4=
X-Google-Smtp-Source: ABdhPJxclmK5tJHztft/7mXls1Pr5LGv+p9qBjz187C5S/MF0DBGSXopG+EkdGf+Fugo0q/XVD5QDg==
X-Received: by 2002:adf:8290:: with SMTP id 16mr21330161wrc.103.1603117660325;
        Mon, 19 Oct 2020 07:27:40 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id s185sm261888wmf.3.2020.10.19.07.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 07:27:39 -0700 (PDT)
Subject: Re: [PATCH 2/5] pwm: pwm-mediatek: always use bus clock
To:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com
References: <20201019140705.1518822-1-fparent@baylibre.com>
 <20201019140705.1518822-3-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <0f2dc182-868c-43c3-8ae8-999e7cf1d986@gmail.com>
Date:   Mon, 19 Oct 2020 16:27:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201019140705.1518822-3-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 19/10/2020 16:07, Fabien Parent wrote:
> The MediaTek PWM IP can sometimes use the 26MHz source clock to generate
> the PWM signal, but the driver currently assumes that we always use
> the PWM bus clock to generate the PWM signal.
> 
> This commit modifies the PWM driver in order to force the PWM IP to
> always use the bus clock as source clock.
> 
> I do not have the datasheet of all the MediaTek SoC, so I don't know
> if the register to choose the source clk is present in all the SoCs
> or only in subset. As a consequence I made this change optional by
> using a platform data paremeter to says whether this register is
> supported or not. On all the SoC I don't have the datasheet
> (MT2712, MT7622, MT7623, MT7628, MT7629) I kept the behavior
> to be the same as before this change.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/pwm/pwm-mediatek.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index ab001ce55178..108881619aea 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -30,12 +30,14 @@
>   #define PWM45DWIDTH_FIXUP	0x30
>   #define PWMTHRES		0x30
>   #define PWM45THRES_FIXUP	0x34
> +#define PWM_CK_26M_SEL		0x210
>   
>   #define PWM_CLK_DIV_MAX		7
>   
>   struct pwm_mediatek_of_data {
>   	unsigned int num_pwms;
>   	bool pwm45_fixup;
> +	bool has_ck_26m_sel;
>   };
>   
>   /**
> @@ -132,6 +134,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (ret < 0)
>   		return ret;
>   
> +	/* Make sure we use the bus clock and not the 26MHz clock */
> +	if (pc->soc->has_ck_26m_sel)
> +		writel(0, pc->regs + PWM_CK_26M_SEL);
> +
>   	/* Using resolution in picosecond gets accuracy higher */
>   	resolution = (u64)NSEC_PER_SEC * 1000;
>   	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
> @@ -281,31 +287,37 @@ static int pwm_mediatek_remove(struct platform_device *pdev)
>   static const struct pwm_mediatek_of_data mt2712_pwm_data = {
>   	.num_pwms = 8,
>   	.pwm45_fixup = false,
> +	.has_ck_26m_sel = false,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7622_pwm_data = {
>   	.num_pwms = 6,
>   	.pwm45_fixup = false,
> +	.has_ck_26m_sel = false,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7623_pwm_data = {
>   	.num_pwms = 5,
>   	.pwm45_fixup = true,
> +	.has_ck_26m_sel = false,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7628_pwm_data = {
>   	.num_pwms = 4,
>   	.pwm45_fixup = true,
> +	.has_ck_26m_sel = false,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7629_pwm_data = {
>   	.num_pwms = 1,
>   	.pwm45_fixup = false,
> +	.has_ck_26m_sel = false,
>   };
>   
>   static const struct pwm_mediatek_of_data mt8516_pwm_data = {
>   	.num_pwms = 5,
>   	.pwm45_fixup = false,
> +	.has_ck_26m_sel = true,
>   };
>   
>   static const struct of_device_id pwm_mediatek_of_match[] = {
> 

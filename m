Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5A429295C
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Oct 2020 16:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgJSOb0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Oct 2020 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgJSOb0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Oct 2020 10:31:26 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A57C0613CE;
        Mon, 19 Oct 2020 07:31:26 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cq12so10501483edb.2;
        Mon, 19 Oct 2020 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NK1LgREI0grlGA48q0LtomCwz/5B/5iMVXhRLFRzRu4=;
        b=ofu92/Wh94NyihEjSyRw0rLG9de1gsHCTSSgjasjE6Na9acvd3ZxxJgab97VVfNNin
         omety/hO40VF/gHPpSP0Tl/8tr2fpBWpoJhjyI3MgKsUvsh5XzdwW70nJqXnW28Czm/d
         fd5rzwwzX3JD2zAxgBSm9XLPsApb5W6AoGdxaLEg9gbOXYo8MtEz8q6+xF2Qm1rC+Vb9
         XliKMjBGys6QhbG+CxCPS6YQjunTfYd14nc1rw0z43knYdzuFhaN9/5g/RXpWhmaWkM0
         i43x7SjycFqzJBLo6XD/0Nav/9BM5pv+XAPTgxiy76GFfvoxVRjOMGVc8UujDyXd9Kj7
         XqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NK1LgREI0grlGA48q0LtomCwz/5B/5iMVXhRLFRzRu4=;
        b=CY+Hw86B/SjixSYi9AHLW1TjSnJDKMVgaWbRko6k7z9A6TG6RZ8R8UiU5Uh93TWIfQ
         H4ze2J0ayVd/tssyM6LJ0r3suaPTh1OYGE5NPf2JrHzvzHrAY2EG6ocUjit5EGyrtvHm
         W/kYtrPc9R4oSH9yM/Jiuh740PsVI2WVwF1aDdKHapdYVpksM+aiqq/YNBk0zE+l6SOw
         AX9BToJjHZLa5VxZ+oFlhGR87SE31FDw1NKmIZLZ4eIkpWnBY5YGnVssowADUkEldU5s
         4bR3Tz4vA0uFljCJeeIfl++SuCkE7P457HQ1KolmpzuPOjXe4Ce0W6CWO9npp0QxJvD3
         U1KQ==
X-Gm-Message-State: AOAM533fR4YRFKM1o3TcDaat8DK+yMnUWYRTYndtDZKBzYACqnl8tD6j
        4UEIrS9XAsQoJqjoJv6wcQw=
X-Google-Smtp-Source: ABdhPJytlnwdS3LMPlKFbzRg/UyWOvHdc461PBbrWGNT8bH7bBuodDLpq+6U4lGgDLrFxbJ+0Fif0Q==
X-Received: by 2002:aa7:d4d8:: with SMTP id t24mr32228edr.247.1603117884937;
        Mon, 19 Oct 2020 07:31:24 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id y32sm2459726edy.4.2020.10.19.07.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 07:31:24 -0700 (PDT)
Subject: Re: [PATCH 3/5] pwm: pwm-mediatek: Add MT8183 SoC support
To:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com
References: <20201019140705.1518822-1-fparent@baylibre.com>
 <20201019140705.1518822-4-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <53afa92c-b32f-eff7-95a8-3fe12db5e8fd@gmail.com>
Date:   Mon, 19 Oct 2020 16:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201019140705.1518822-4-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 19/10/2020 16:07, Fabien Parent wrote:
> Add PWM support for the MT8183 SoC
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/pwm/pwm-mediatek.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 108881619aea..9052b500b8f0 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -314,6 +314,12 @@ static const struct pwm_mediatek_of_data mt7629_pwm_data = {
>   	.has_ck_26m_sel = false,
>   };
>   
> +static const struct pwm_mediatek_of_data mt8183_pwm_data = {
> +	.num_pwms = 4,
> +	.pwm45_fixup = false,
> +	.has_ck_26m_sel = true,
> +};
> +
>   static const struct pwm_mediatek_of_data mt8516_pwm_data = {
>   	.num_pwms = 5,
>   	.pwm45_fixup = false,
> @@ -326,6 +332,7 @@ static const struct of_device_id pwm_mediatek_of_match[] = {
>   	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
>   	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
>   	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
> +	{ .compatible = "mediatek,mt8183-pwm", .data = &mt8183_pwm_data },
>   	{ .compatible = "mediatek,mt8516-pwm", .data = &mt8516_pwm_data },
>   	{ },
>   };
> 

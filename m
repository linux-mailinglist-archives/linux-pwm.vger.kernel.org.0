Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C20E2BBB68
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Nov 2020 02:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgKUBKA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Nov 2020 20:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKUBKA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Nov 2020 20:10:00 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41859C0613CF
        for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2020 17:10:00 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so9552031pfp.5
        for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2020 17:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ezw1GwCVc9UDYhrFeJBWYlueoLdPkQ8+bJt4wUsxqBQ=;
        b=Ggwu2CfwDHEEuto5V8D65StX/IdBUI5UgrKJKAPTLUfTGB+SYLjtejxkAE/ED45xhj
         BLb5seW14MhfeTjjCdrtd+OEoZmd8Oyn+baHslgEZWr9ENyTKf1pbkXkfjiFI7pn9QRl
         GI3u3zZMviM/x4mekes9KOZ0earTWsVLokMsE8hDo7pl1t6CKs9zKA2WqliXrhS10hEE
         qqzwTcwPj5eaca+E09/zHs83gA/I+leNxe7NbWVWQlEauhH/5LwrR6MJtYoHAGRDHQIy
         K7jjbI+RznrOMlRzyIUqKVRKnA/klw0jWJtIcYEFafewfToiklKYA2iqExrpeA5lUdfw
         9NLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ezw1GwCVc9UDYhrFeJBWYlueoLdPkQ8+bJt4wUsxqBQ=;
        b=c2bXq7bTLS+sID82fSlQK1tEtTN+KMvz4V4q+S/ulGV2NG5KOoWP4Xun8AOxZZ9g6M
         0/Y1hy6Hk2qvTFLPA3Ctoi7wJHMUu1BtzkvyWGGkPvld5w3Bj6alr66XDNQ4VJesBRDV
         FQX+s+S0NtODcWNQmJGkjHzJ19w9QDBBQymdcH/OZFIVv8zmT4jJ342QbPYv8BG2g3QB
         raBc/Ynr5R2ytQoxmlklXtSRcXWG551trun/ClPWB6rg9yWjzGib64Z80s3UDqnzJ5iR
         +zncundAdeXUYqBCHZDsjalghpV1QOOw8SMr7vF39AM7W4iKiG32AvwwbxGZkw9Whb17
         uT0g==
X-Gm-Message-State: AOAM532O4yzFTLwXDzCK8EwVEHQd2Qi8oa0Hsbgu9hbCa+kCgWQciqWU
        667Fnj2lxLt45bN6pkTXsm8=
X-Google-Smtp-Source: ABdhPJzQagWVawHi9ir4pR0X0TUQOrbMyOYjw40H8oqjG+OxjUJL9FfdQv+0LjfBh2Avnn+M59eFSA==
X-Received: by 2002:a17:90a:d495:: with SMTP id s21mr12892498pju.42.1605920999620;
        Fri, 20 Nov 2020 17:09:59 -0800 (PST)
Received: from zen.local ([71.212.189.78])
        by smtp.gmail.com with ESMTPSA id v191sm5060557pfc.19.2020.11.20.17.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 17:09:58 -0800 (PST)
From:   Trent Piepho <tpiepho@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, heiko@sntech.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Simon South <simon@simonsouth.net>
Subject: Re: [PATCH v2] pwm: rockchip: Keep enabled PWMs running while probing
Date:   Fri, 20 Nov 2020 17:09:58 -0800
Message-ID: <2177360.ElGaqSPkdT@zen.local>
In-Reply-To: <20200919193306.1023-1-simon@simonsouth.net>
References: <20200919193306.1023-1-simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Saturday, September 19, 2020 12:33:06 PM PST Simon South wrote:
> Following commit cfc4c189bc70 ("pwm: Read initial hardware state at
> request time") the Rockchip PWM driver can no longer assume a device's
> pwm_state structure has been populated after a call to pwmchip_add().
> Consequently, the test in rockchip_pwm_probe() intended to prevent the

> 
> @@ -362,7 +363,9 @@ static int rockchip_pwm_probe(struct platform_device 
*pdev)
...
        ret = pwmchip_add(&pc->chip);
...
>  	}
>  
>  	/* Keep the PWM clk enabled if the PWM appears to be up and 
running. */
> -	if (!pwm_is_enabled(pc->chip.pwms))
> +	enable_conf = pc->data->enable_conf;
> +	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
> +	if ((ctrl & enable_conf) != enable_conf)
>  		clk_disable(pc->clk);
>  

I came across this while trying to get a PBP working better.  It seems like 
the issue is the driver was calling pwm_is_enabled() without first requesting 
the pwm with pwm_get().  Which wouldn't even be possible normally, how would 
one get the pwm_chip to call pwm_is_enabled on, but the driver already has the 
pointer.

Anyway, it seems like this solution has a race.  Isn't the pwm live and 
requestable as soon as pwmchip_add() returns?  Which would mean that disabling 
the clock here could race with other code requesting and enabling the pwm.

Seems like it would be safer to check the initial state and turn off the clock 
before calling pwmchip_add.



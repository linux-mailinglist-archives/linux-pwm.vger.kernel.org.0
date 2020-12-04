Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C4D2CEEE0
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 14:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgLDNjA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 08:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgLDNjA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 08:39:00 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E785C061A4F
        for <linux-pwm@vger.kernel.org>; Fri,  4 Dec 2020 05:38:14 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so5353880wrt.2
        for <linux-pwm@vger.kernel.org>; Fri, 04 Dec 2020 05:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MivjrWXLboUIvmkW3zvTdPgE0kxGTbPXXdp04+8YVUE=;
        b=wPDX28DjlA9sRzStVTVVT01RacWCXIJKpirTkk37AS98hWDuqbhyzIer4JHSoW7BIH
         WJitPW4b8BtyMpXhISMjfVbau4hoANvReiKXhbzTCN5VlFrPtZuQ+0vicfceREazuZa3
         V0P46+zUaDqwLEgnKWY79FITR2UXZHL992v06SJ5E7rs5yh2Us/euMoluCWiSLL4pFDZ
         2ms/rwJ8HTR6KVarluz3rvfEuRJnGkawbjIdYEqBO8D+2rXcCxzvQQz6VOnnf0/w1bcS
         b3hUAnigScayXj1dzS2R7uJp0j8M1swoiKypLTVMzjhYcjLlpdn3pOVJVoN6WldjNfyM
         O5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MivjrWXLboUIvmkW3zvTdPgE0kxGTbPXXdp04+8YVUE=;
        b=Gz9VwK/fOAJl9+JfBJLIDSLtrJPldRDMwTyQHIQ1FvRD3Y4Qa1n0dt2SGTN7zcNewS
         jzpQPckT/Z20lsB3ncUZUCj8IqzriNy920EGiIocg1pwk6YjhTGBVFylDkvpivDOc8Hq
         UKtnuXz3t42lID+yoEqOlFt7hUdcr+YcmbMErFca82rHPbqHdAT749rLSnVrU/DrZDiG
         pIxWIANDqcz+SRM1Omo763qUSH+u8nFoYVG/kQnxqrXmeONBtLbhewmVZU2wZHlorx6e
         XVssEVIeR+15DhbNtqx71dW0k3jvfXAV2RgXx2yeDfKEH/MfNr1ne/iPzvMs+KKtmziy
         NGYA==
X-Gm-Message-State: AOAM532jhjkfHRJhR4cUDhL6c0WZle8MfbvxioiW0gt2aH6VC1xeOPkT
        s/yCkxKVFWnN41Vey9IpQPltKg==
X-Google-Smtp-Source: ABdhPJxeNGr1i+G9s5jOlOCnb3iToWLTnKYbVFwMYbqxoezh19s5xs2IvWcGQg65VxLbeKyb3633pw==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr5184122wrv.170.1607089092783;
        Fri, 04 Dec 2020 05:38:12 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id q16sm3629665wrn.13.2020.12.04.05.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 05:38:12 -0800 (PST)
Date:   Fri, 4 Dec 2020 13:38:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] pwm: sl28cpld: Set driver data before registering the
 PWM chip
Message-ID: <20201204133810.GP4801@dell>
References: <20201204125213.3426567-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201204125213.3426567-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 04 Dec 2020, Thierry Reding wrote:

> The PWM core code can call back into the PWM chip's implementation at
> any time after the chip has been registered. Since the driver uses
> driver data to store contextual information, registration must happen
> after the driver data has been set.
> 
> Reported-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-sl28cpld.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

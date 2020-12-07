Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2732D0CEE
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 10:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgLGJW7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 04:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgLGJW7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 04:22:59 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF13C0613D0
        for <linux-pwm@vger.kernel.org>; Mon,  7 Dec 2020 01:22:18 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a6so10840082wmc.2
        for <linux-pwm@vger.kernel.org>; Mon, 07 Dec 2020 01:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RjpX87LYgz+Ufk4R7Q2Jt/H9kwB3A1KtyZWzI6PaILc=;
        b=gS2hu2iNk7bs7Md6Fn93aM2iILKE/fpaVfjl4r2I+LF3v3MdQu2iLD7HLkr8jf9Js4
         kJhwVNY9VRm/vh2M6cBnXgOoRngRm+2ewU7YTku92+DsK/0QBzenQXkG5DtSlBjjH3Iv
         D5qBAm1MLrEV7RDR2bsB5R160xfD8cqR9BnDrooLsVUAsocazFQkOGaqXiwkWZqsnb6C
         2qo0Z8s+R/puBFKUM/x3wkg6iu0nVQM1BZoAtsawJPAwiduojxsy3XsPZW5RMv5zAHhT
         oL4wfV1aWyFhLPpKhjfwPzWIz+A45x4hsBUO8/RAFdldIjhpnXMsS68cPmTB8kU3B1DJ
         ERMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RjpX87LYgz+Ufk4R7Q2Jt/H9kwB3A1KtyZWzI6PaILc=;
        b=WWqojR81bXvTXbB2XNiOQukenTIpjvsPcKguz+ZhqP3sIhH0ZQ1FM1kmL++Kerlj4b
         jSGYgl5uwdJ6ZRNl8WI/CIqrzJyIxP4DgPQwqahj/jlvXGEX/9xwtMFQSIlHpWlIMaMT
         Z7CnXTLoCex3qLm1Oq9oma3RAdtdTVrZpuSacJ76Bx2kkTm8treEZ0DNF6m8ah6VqYME
         ukgB01EciS7pG5sNFIb84kzDcl7sOasrE2lRp3yd3flwrP6NGE0rSneegGcBTf6uhuOr
         NxlYElUrSeoNiX4Cvf/zgtpZ/u5O2J4k2Etqa7Ale1TFlayiuHBGPeC40Z+mB9nwO74t
         4a7A==
X-Gm-Message-State: AOAM532Iy4M9OTCObrNYYY2wsidzSmFi2BcDzEbEnx506stnnEVGvM4o
        5KUEaTq5vw2ogwvWxtih35CM/EJW24Fd0FE7
X-Google-Smtp-Source: ABdhPJzY+gbBF/I7WXSKJoQJ8jG4gzFfqorUzkgZc20NsWGSkGDMrh2ClxEoD0g7IOcYsFsTABk1Bg==
X-Received: by 2002:a1c:5603:: with SMTP id k3mr17510853wmb.151.1607332937343;
        Mon, 07 Dec 2020 01:22:17 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id 101sm7731937wrc.11.2020.12.07.01.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 01:22:16 -0800 (PST)
Date:   Mon, 7 Dec 2020 09:22:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Remove unused function pwmchip_add_inversed()
Message-ID: <20201207092214.GQ4801@dell>
References: <20201205161924.3864915-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201205161924.3864915-1-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 05 Dec 2020, Uwe Kleine-König wrote:

> This is only defined with CONFIG_PWM unset and was introduced together
> with pwmchip_add_with_polarity() (which is only defined with CONFIG_PWM
> enabled). I guess the series that introduced pwmchip_add_with_polarity()
> had a different concept in earlier revisions and the !CONFIG_PWM part
> was just not updated accordingly.
> 
> Given that there is no implementation for pwmchip_add_with_polarity()
> without CONFIG_PWM, just drop pwmchip_add_inversed() instead of renaming
> it to pwmchip_add_with_polarity().
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  include/linux/pwm.h | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

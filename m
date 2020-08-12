Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC112242692
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Aug 2020 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHLILn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Aug 2020 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgHLILn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Aug 2020 04:11:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE4AC06174A
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2020 01:11:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so1070970wma.2
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2020 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sg6aqXE9GsdZ+Rx2JA1PyirqHFfvT1Ole1HN6HxiKC0=;
        b=U866Xlm+nvKc4MtrS948KgFYyvvHKh7NljlYqqciPLvwtI4lo3emz5UZJwbLH6oNQD
         /kBG+umZw7Q+Gfwi0dXY7+/NXrcvevssZBZPIQy4Dc/F1JF62l2PPTN5OcLPvUXih6Si
         8APTpMRLQVgQnhrcM0Db7Dc9S8odg45ndw8xistHEa8zGW108GIC22aLef6fpKD22+NB
         uJTQYF7SXUkKb0z4A6VNBvX13b5AjaIPMQEDc3ogZYgluUbI3rR0tPTO33NK9QcnwQ7Y
         UyH1gALyXNcX1pZ+V5l5jSYf732JfGIW1J1TCcZqga242y//Gm/iVA6mPKfXVN4Ptgy8
         uj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sg6aqXE9GsdZ+Rx2JA1PyirqHFfvT1Ole1HN6HxiKC0=;
        b=d1Aj/+c6bZ3oEJA511fnh5PYCC3GpOtdEBuE8bB9/4mOfiOxz9+KQN0dbC+jojnshx
         h5qmktpvFnVxObxmVzMrHLpeoQsNvO3jPG1+oRM83ktJFBafuhkZCCRhEHNz+aq25BFw
         Jpgx4aQm8bTA3NjXzfIsUaLhBaKkOfSGpz99DEWlMrG1eSX7Nfhn19lXEYel/LwcP71n
         uDJp2PUDOeWzClwAsMdzxviGIn3uj4db779KrTYQxmDAhgsSDdbB3ZNZ4L+iiVkpUlYw
         T5OwruModM15EU/ljszcCiq+TzJqfkaOjlXZN6U1xd4FAN39sHrg5JqobFnTFeVw0Zhp
         Sipg==
X-Gm-Message-State: AOAM532kfQkNPokdJX8hEvM/aMIcGnLultZ4jD+IrPnddXeURT/J59Yv
        6L8fIqomW/3ZlnaZ/RdYCGf/eg==
X-Google-Smtp-Source: ABdhPJzPGxEKVPMvJf0+zK2shFQBS7faelJWoN4mLt33Y1S7KSiDXN7qHsKMZfzKu+kUSNb6ZeBbBg==
X-Received: by 2002:a1c:5416:: with SMTP id i22mr7482755wmb.172.1597219901566;
        Wed, 12 Aug 2020 01:11:41 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id a10sm1439908wrh.36.2020.08.12.01.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 01:11:40 -0700 (PDT)
Date:   Wed, 12 Aug 2020 09:11:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: ab8500: Add error message if pwmchip_add() fails
Message-ID: <20200812081139.GC4354@dell>
References: <20200812075214.499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812075214.499-1-u.kleine-koenig@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 12 Aug 2020, Uwe Kleine-König wrote:

> pwmchip_add() doesn't emit an error message, so add one in the driver.

Maybe placing one there would be a good idea.

It would certainly cut down on a lot of superfluous strings.

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-ab8500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
> index fdf3964db4a6..4b6f9e24e11d 100644
> --- a/drivers/pwm/pwm-ab8500.c
> +++ b/drivers/pwm/pwm-ab8500.c
> @@ -106,7 +106,7 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
>  
>  	err = pwmchip_add(&ab8500->chip);
>  	if (err < 0)
> -		return err;
> +		return dev_err_probe(&pdev->dev, err, "Failed to add pwm chip\n");
>  
>  	dev_dbg(&pdev->dev, "pwm probe successful\n");
>  	platform_set_drvdata(pdev, ab8500);

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

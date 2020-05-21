Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C461DCAE1
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2020 12:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgEUKTj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 May 2020 06:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgEUKTi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 May 2020 06:19:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508AC061A0E
        for <linux-pwm@vger.kernel.org>; Thu, 21 May 2020 03:19:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e1so6124198wrt.5
        for <linux-pwm@vger.kernel.org>; Thu, 21 May 2020 03:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3soTLfyyUCy3fHQF1Qq2HbNRuRlLZGtCqlLrm7bKL0k=;
        b=iLefinM5WVMUYeWn89hjMmw6P3rJcMvMcXGCYe/sPgv01lWlMMB6pDIB7tTH5QdpRI
         J/wIHKRyTUiez45dT4rX+OBVoYtcQQpgm7r0oTowL2cwl2a8tyLfUBgdrchiF1JegdUC
         YA7oaI86mntloZ/obWxbf9I3aZTSG6xz1WTi4w5++XKbIBVVGmJHg9e+RQV4z1MTwZ2W
         qHbGdTUTZHwlOrigGy25G6d+X6N/lGlufcaLIyrCbHRV+66izSyZ+Gg08QmXz03eW6LK
         ysjJrOAJIR1Yhr3JDE9XVyyIQNpNUk6UhbAnuQATqftrKL4zpiKpAQXoMxry6OlhUtqY
         Fmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3soTLfyyUCy3fHQF1Qq2HbNRuRlLZGtCqlLrm7bKL0k=;
        b=uQiLzagYVxlYGNH5iVkv+9mFUPV2jDXzhCmr1X62648CGV0fWAm1Uy34Rc9DWzZFka
         BADZASDSDIszrLaHl0PUtDwMqKbAB5unnd8uFeh6TZzsNDSkk5YL1EbCzmYPueRMDJsw
         oyQAt5HxOiIfNn0Y8NDJXs9eXHX/hIZmgqnmYK5YDXRun1jPP5wObeCzGhnFhfn8K7FY
         gDaD8oSlpIAnb+0UtaTtPkIvmCcqE3DrZyLjrMepQrHK395vb/4NCnp22HVZVAiFlREE
         uIAfGO8wrbpkoWo0mArAgvEioyj6jIF/CYTGmGnuBkwc3wvyIgaZW0ruNK47Tranb8MY
         SR1g==
X-Gm-Message-State: AOAM530zrA5bbk6uvlqry+RASU63fsyDkV4iQ5H8pIqLrtB9jBFjXFSx
        ay9ipiGfJwiQa/9nDp6NIkZhuw==
X-Google-Smtp-Source: ABdhPJxJaiGlRiaRseMV6CWsbw437c84sE7FLFpur3F+323zkr+qz4VJbqsUD3MeZIdVLu0xE6coNw==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr7594889wrj.45.1590056377059;
        Thu, 21 May 2020 03:19:37 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v126sm6842237wma.9.2020.05.21.03.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 03:19:36 -0700 (PDT)
Date:   Thu, 21 May 2020 11:19:34 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v14 04/11] pwm: clps711x: Cast period to u32
 before use as divisor
Message-ID: <20200521101934.j5ivjky4e6byveut@holly.lan>
References: <cover.1589330178.git.gurus@codeaurora.org>
 <1d6918c3fc2976bdbdb687bf54a2ef09fc1558db.1589330178.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d6918c3fc2976bdbdb687bf54a2ef09fc1558db.1589330178.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, May 20, 2020 at 03:55:57PM -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by typecasting it to u32.
> 
> Also, since the dividend is still a 32-bit number, any divisor greater
> than the numerator will cause the quotient to be zero, so return 0 in
> that case to efficiently skip the division.
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/pwm-clps711x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> index 924d39a..da771b1 100644
> --- a/drivers/pwm/pwm-clps711x.c
> +++ b/drivers/pwm/pwm-clps711x.c
> @@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
>  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
>  {
>  	/* Duty cycle 0..15 max */
> -	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> +	if (pwm->args.period > (v * 0xf))
> +		return 0;

This doesn't look right to me.

DIV_ROUND_CLOSEST() does rounded division and the short circuit doesn't
implement that.


Daniel.

> +
> +	return DIV_ROUND_CLOSEST(v * 0xf, (u32)pwm->args.period);
>  }
>  
>  static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

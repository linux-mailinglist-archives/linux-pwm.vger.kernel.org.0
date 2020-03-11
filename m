Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68473181C0E
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 16:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgCKPIW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Mar 2020 11:08:22 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36504 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbgCKPIW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 11:08:22 -0400
Received: by mail-pj1-f67.google.com with SMTP id l41so1187934pjb.1;
        Wed, 11 Mar 2020 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kp5zJ2ysFKh24+YHZFPVwSCrUnRzsthrhWZcH1rhgpA=;
        b=Jlkb90BDIk6viWTEcr+XbiDlOlgvCoNSNA3cPvgZFv5t7lyhih7Fd/zgE+NrScUWsJ
         To9v450mZKq0By+654ht1wEhw1egRGlfrOu6FMPWYiz9fe/orK/Gb6hd/uK7F0mByedk
         g0nc5R0/H0eIqbXfbqRnFqLD3jebvyZZO/5gx+13e8RtBmuiwRNry1qIcpTslwKX7HtU
         QzPT+1d7scA5SRpAjbNEXg9zkicS8varzfVHRsmu+mY3Zc0PS3IdqezoseJaQlKiz4kl
         b75o8HLf4iU6A/02l9q5933bzaxKxJ0D8T8I+k0d4WQGRmlCTQWLLmcBByLTCWKmA5Iq
         udAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kp5zJ2ysFKh24+YHZFPVwSCrUnRzsthrhWZcH1rhgpA=;
        b=avx0+GMX22UknMI2Rs2OAsrC8cpA6yvdjaDs26XJJ312tRO9DxtGiY2XXovXUW9GYq
         WJ3gfWsFqH42Qqh8f/6/+r4QWcBo5QZGtLQK46YbkkGpeGcoUKDXlct/fjQk9KEcoTdW
         wqGSJYWphicJaXFPgp5AY1k/XzRDVdaqhCsUH39gGwnjvSzJJ/tIdvDFDEUiS021KZMZ
         fbj1MSIcAtalEg8QZA1SjpQb8UTd/btdYqlaFcB+U0b8xQKr9VcG5PM/Fo9w+nM67tIJ
         ig1nM6+K+m2v+Q8NL2ckUBaAEezi2W8jZcGZ00X3/X2z/CL0gtH5ymrKjHhSP2Mxia99
         wBRA==
X-Gm-Message-State: ANhLgQ0OB5pFOo7Z86Ljhpp4kTqxRlhprHpIiM+M18cpF26/cU86HT3P
        B81U+86l+WTAYpmcfSwxfNg=
X-Google-Smtp-Source: ADFU+vuT3JLfQr7qfI1Vrt0oNhE2Z21SEZ6Furlp715VtRyBCZ9OGxN9rUtxGcdryM2zugwHoPR9fw==
X-Received: by 2002:a17:902:728d:: with SMTP id d13mr3473134pll.92.1583939300278;
        Wed, 11 Mar 2020 08:08:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q21sm53738468pff.105.2020.03.11.08.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 08:08:18 -0700 (PDT)
Date:   Wed, 11 Mar 2020 08:08:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v8 03/12] hwmon: pwm-fan: Use 64-bit division macro
Message-ID: <20200311150816.GA10018@roeck-us.net>
References: <cover.1583889178.git.gurus@codeaurora.org>
 <237b1b5ae59d072b576d300cdc0c2a1242b18516.1583889178.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <237b1b5ae59d072b576d300cdc0c2a1242b18516.1583889178.git.gurus@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 10, 2020 at 06:41:12PM -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by using DIV_ROUND_UP_ULL to handle
> a 64-bit dividend.
> 
> Cc: Kamil Debski <kamil@wypas.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-hwmon@vger.kernel.org
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

Not sure if I entirely buy the use case, but then the performance
impact is minimal, at least for this driver, so

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  drivers/hwmon/pwm-fan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 42ffd2e..283423a 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -437,7 +437,7 @@ static int pwm_fan_resume(struct device *dev)
>  		return 0;
>  
>  	pwm_get_args(ctx->pwm, &pargs);
> -	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
> +	duty = DIV_ROUND_UP_ULL(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
>  	ret = pwm_config(ctx->pwm, duty, pargs.period);
>  	if (ret)
>  		return ret;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

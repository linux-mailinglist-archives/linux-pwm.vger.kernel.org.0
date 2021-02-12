Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1790631A116
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Feb 2021 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhBLPF0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Feb 2021 10:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhBLPFV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Feb 2021 10:05:21 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2F1C061574;
        Fri, 12 Feb 2021 07:04:41 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id y11so8641890otq.1;
        Fri, 12 Feb 2021 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xRzerL37rg751TyU6bwXPn/hRqxwdJLt22EE4yM78/4=;
        b=j0WkHcMOOzWY/E3hEIbBqWVhP61NJS+ElQp3uyCDAaBTrsRTvWtVMlar/6dldtCW6w
         za+krt4gwUcQwrJ9CmHgvH4hQzTx2JcDDcpI8alfHRvEQg6Io8BPG2KMLtBgDNx72sVr
         ep1LdF/xlc4gHDCXqpvyKI0AkEPG5NlLJllerkYO8OSFEBPsUQuUtCbyAXGk1ihAOkDg
         D4GgArL+3pGLhJKGqSDD1KDo+FYGnUj3c4qOlfpFQ7X72oUTlv9uNYrFlsW9qoS+n26a
         LzmmWBSZKUdV3Z0RegIvYcPQjCy6z0bokX0XZ2uPSiFZUSvmLIDQaDCqFJPXzuM03lgz
         SsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xRzerL37rg751TyU6bwXPn/hRqxwdJLt22EE4yM78/4=;
        b=D70OESNNXOt6KuL+NzaUcinQ9l6y0G4+kcooS1MnGdXvIXWJD3l9JVSstbQMK9So0B
         wnPjHJdVoXWzQ6juTZ2Mu5ZI+rYeTf7DWi8tExgQ8CsrqtvFv/IpOnyTF7w/fbtQVqOo
         YZKf+M5zjsHS3miIspLpBhpwNjX2zw8xdQwQM1cyU4ZoyHcEfITuKySiL01cMyhHShAl
         cCU2IGmhi+nAIm1BJdP5w9ruNVDxFEdnh+NRHKIh8hYwLWWW8FqtDWVa+TSbQqWaLUR+
         AiVHnEodaEzoML9KFIS6Ub+CFMv+0vLDnssxzxLaV+ILOswwHMvgYq9GqW8/PaTdZHZ0
         5kLQ==
X-Gm-Message-State: AOAM533fij7rV7QJGHlDARpBUleF9HCftjLdpz55SMVSCYrwTvjOcGc4
        utW6ZuPKB6L5aOXU+fiu6Qb8i6zD1PY=
X-Google-Smtp-Source: ABdhPJxf3Qr9yjbuYZKxXoTyvphmL4Ozh4W7q4PN+aSXIhb1tq4VcD2KjSIvAttFzuA8f5/xd2OYIg==
X-Received: by 2002:a9d:6f93:: with SMTP id h19mr2285387otq.236.1613142280425;
        Fri, 12 Feb 2021 07:04:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 18sm1698700oti.30.2021.02.12.07.04.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Feb 2021 07:04:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 12 Feb 2021 07:04:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     jdelvare@suse.com, thierry.reding@gmail.com, lee.jones@linaro.org,
        openbmc@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] hwmon: (npcm750-pwm-fan): replace spin_lock_irqsave by
 spin_lock in hard IRQ
Message-ID: <20210212150438.GA32815@roeck-us.net>
References: <1612696333-50502-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612696333-50502-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Feb 07, 2021 at 07:12:13PM +0800, Tian Tao wrote:
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Now dropped. Quite obviously you have not even compile tested,
much less runtime tested this patch.

Guenter

> ---
>  drivers/hwmon/npcm750-pwm-fan.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
> index 11a2860..6c27af1 100644
> --- a/drivers/hwmon/npcm750-pwm-fan.c
> +++ b/drivers/hwmon/npcm750-pwm-fan.c
> @@ -481,12 +481,11 @@ static inline void npcm7xx_check_cmp(struct npcm7xx_pwm_fan_data *data,
>  static irqreturn_t npcm7xx_fan_isr(int irq, void *dev_id)
>  {
>  	struct npcm7xx_pwm_fan_data *data = dev_id;
> -	unsigned long flags;
>  	int module;
>  	u8 flag;
>  
>  	module = irq - data->fan_irq[0];
> -	spin_lock_irqsave(&data->fan_lock[module], flags);
> +	spin_lock(&data->fan_lock[module]);
>  
>  	flag = ioread8(NPCM7XX_FAN_REG_TICTRL(data->fan_base, module));
>  	if (flag > 0) {
> @@ -496,7 +495,7 @@ static irqreturn_t npcm7xx_fan_isr(int irq, void *dev_id)
>  		return IRQ_HANDLED;
>  	}
>  
> -	spin_unlock_irqrestore(&data->fan_lock[module], flags);
> +	spin_unlock(&data->fan_lock[module]);
>  
>  	return IRQ_NONE;
>  }

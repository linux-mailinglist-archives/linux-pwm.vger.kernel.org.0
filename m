Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB2319923
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Feb 2021 05:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhBLEbA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 Feb 2021 23:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLEa7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 Feb 2021 23:30:59 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A9BC061574;
        Thu, 11 Feb 2021 20:30:18 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id s23so935340oot.12;
        Thu, 11 Feb 2021 20:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aOeCDqDzBA3dsZYfJecar357cM/2/of0V8qDCALwWfY=;
        b=i4f4fMqcZZXCsUdY9/WeSgZIgObL9iEP6Bvy0U7zXUmBUNtk8UWtFI0rF1fxusFDtp
         kjN9lvIQ1AkzCPHWpnbpOXpFO83pq4182mSK+uEVXR8pkdLyN/XJMc043TPXDC5yejii
         OvnhGe0TaHiWDZeJ8x7ZGEAbJ5HzWYxYIQXTCgTYaWAcdg7M6g+FUmwx7GmphOOeuSs/
         LH6IhGDoPD0PXCSRRd9qvkX4wOUoVq2U14IZQdMXnnHeP0muEomAyuiLCM53MlpoPltX
         QMDFtL46QVeFsxVQWSUDGPyMQs+XT4c/VxG59SNIoHbFVAyz1l++eYseWyyLT+2wpXVe
         vE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aOeCDqDzBA3dsZYfJecar357cM/2/of0V8qDCALwWfY=;
        b=PV1Ai0lNQnQY2NVJL8cE74+y33mzlq5oo/GLOyLnusTie1Ok6v2alsavjxGgYPJaq7
         7PoXirU9g2GWnp804CDi6O/xPIpEJzFfGEThdDbiZLKETi+GjRlfPVmO+yaTpSjUcQ8X
         LKZ2I/ldc/KnpxnpiyUi1LMALJa1viKhxeBk7J39UI1SGhXNiZizE8voLZkhpyd/7gLz
         nNnbjDqNdu3Co4ako8ux59tOILSsgPh1c+dtFimIIzeZ9qCx7yPTJGMlWUx292Pl9Mzg
         IuwFHSn93Erhk5De38/kXyAJRSSppuY9jsLrj7kN38/3DucHlnt2Tox0Jrr2FcXauIdO
         WOyA==
X-Gm-Message-State: AOAM532FhZR8o8ncM4Vf9PHmsVV/5RYaLV0cvU1J+gjfbn0pHfur38vj
        l0NSSfxlAAHFQPu0N+aLAZY=
X-Google-Smtp-Source: ABdhPJzxdhJXCakra3xPLLVyujacVXook4u1jf93dBk65e5glZOkHxhDKOK61G5iCM81gs4+m4teoQ==
X-Received: by 2002:a4a:4958:: with SMTP id z85mr775192ooa.38.1613104218273;
        Thu, 11 Feb 2021 20:30:18 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 88sm1449171otx.15.2021.02.11.20.30.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Feb 2021 20:30:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Feb 2021 20:30:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     jdelvare@suse.com, thierry.reding@gmail.com, lee.jones@linaro.org,
        openbmc@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] hwmon: (npcm750-pwm-fan): replace spin_lock_irqsave by
 spin_lock in hard IRQ
Message-ID: <20210212043016.GA104680@roeck-us.net>
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

Applied.

Thanks,
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

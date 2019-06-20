Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209B74D01E
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2019 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfFTOOy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jun 2019 10:14:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33042 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfFTOOy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jun 2019 10:14:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so7021314wme.0
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jun 2019 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=q7jwy11egcagMy56Q4RINT2g2musC3c1RDt03S0pqMw=;
        b=BUFHXEjNT/ht/oD46jTldLitbupFR43nppBZONHwvlp7cGnP3fUkMtUCZHgqRi3sQc
         A0/HPMnKwmhbiiMBmdAoaghUd/x5xsY0zmJu3b9mSANPn5RLLF0gW4nE0PI4GSXYQuDf
         VcXAFQsL5kK5c6RgQnxzMkG4pSSvlWWE7+o32thwh+xbIB0dLtTXny4HcCaT164g1mQ4
         N7P4C3eVGast8z86KNzln9nyx/+oyQpD98c07+e5lIbi1fFzCd+uiCTU9VY0Opbh53KL
         D/KAQ8Au98hHRVLfrP405jzqvmWtgCXhhEQYSLY6pvoZHQcL++FOTtT3pf6RS4g8Y99I
         Cmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q7jwy11egcagMy56Q4RINT2g2musC3c1RDt03S0pqMw=;
        b=A7NHqU0DvhwQgFoej5OEvbpmw0aB1j6mZ3cZBof++lf4fEALdvfi68gxy0F/ob3Eyi
         Pni6T1rQa9+QbD6IeMVQcyDrLm73FBdcGoWAfxrtA+wNJqCMfZTz48tuUPCXzZnEDFws
         KV3E3jE3dGFR/ugHrOq/2kmf8AhaNYxO8g57Dm/aGz1NTXY9l6NqN8PSiO2pwUlx9Lpb
         HvBCV/+P/KWFqu8r58jieTdoDMLh/KVqViPeGtwhBGp367a5qIP/PRY6mZYw26uFYbLH
         bNy48XLxPmyzStri+uKejNuBTBMzHT4aK78M1O56fYUxLdbMG1Ks48bnraAUGZIQeNWH
         5rkA==
X-Gm-Message-State: APjAAAW7wldYrn5qbkNU0P+LwGF6N3mEov+4uYbX7VhwD8aUZQ9LzcFo
        LqfFzBlY37n0xdOL3xp2JpBZHg==
X-Google-Smtp-Source: APXvYqxqRzpBmVz3KREIxv39cWfG4a3RC5ziRat7SYUIceIqSEakc4dzRiKMDbxzzUKSp3YUpe4/Zw==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr3171175wmf.7.1561040091892;
        Thu, 20 Jun 2019 07:14:51 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id w67sm6122260wma.24.2019.06.20.07.14.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 07:14:51 -0700 (PDT)
Subject: Re: [PATCH v1] backlight: pwm_bl: convert to use SPDX identifier
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20190619135927.29745-1-andriy.shevchenko@linux.intel.com>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <a0644417-0870-6af2-8604-89e08fd2035e@linaro.org>
Date:   Thu, 20 Jun 2019 15:14:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619135927.29745-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 19/06/2019 14:59, Andy Shevchenko wrote:
> Reduce size of duplicated comments by switching to use SPDX identifier.
> 
> No functional change.
> 
> While here, correct MODULE_LICENSE() string to be aligned with license text.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>   drivers/video/backlight/pwm_bl.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index fb45f866b923..1f7f8d5c0bf1 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -1,13 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
> - * linux/drivers/video/backlight/pwm_bl.c
> - *
> - * simple PWM based backlight control, board code has to setup
> + * Simple PWM based backlight control, board code has to setup
>    * 1) pin configuration so PWM waveforms can output
>    * 2) platform_data being correctly configured
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>    */
>   
>   #include <linux/delay.h>
> @@ -708,5 +703,5 @@ static struct platform_driver pwm_backlight_driver = {
>   module_platform_driver(pwm_backlight_driver);
>   
>   MODULE_DESCRIPTION("PWM based Backlight Driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>   MODULE_ALIAS("platform:pwm-backlight");
> 


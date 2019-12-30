Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F77D12D3F8
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Dec 2019 20:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfL3TdI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Dec 2019 14:33:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35628 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfL3TdI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Dec 2019 14:33:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so13273898pfo.2
        for <linux-pwm@vger.kernel.org>; Mon, 30 Dec 2019 11:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=URa23zWwHmTgfra6HgtXnWWSzjV/YRx3GZJuoonIAgc=;
        b=SrvjdYgbEXeFWKgHXKfqVbv5owBd8rG60Vh+Q/fWe0GpgYzeP5zymf+qVHF7GLQtAC
         zMXa7Usrq2MqLq4g5WQ36+62NRZ8zipR2WE5MGPjoUXS0P31cSPobhY+1ksHGvSHdSJ+
         sG3OUsbHlngjJq4TG78el47rsFacUqfJSIft8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=URa23zWwHmTgfra6HgtXnWWSzjV/YRx3GZJuoonIAgc=;
        b=dWXQUXAAJnJkMbt+nD1OdZTKp+AS1KA3mx36KR7aI/WfEWEWPJO/g/P1FEbdBmK+pS
         0Xh2JVABo/pP0Hkv7OUdeELR2oETj0GK0sPwzg6/d5AysIHrKiNBOSLU/zBaqlngTxpw
         Src14tFotl8xYwL7y/ioEcXmxw0pWOx90q5qViWjOMWio2jZ5699Ihj8WzlDddCyHYIO
         tLIdphoODFPY9jRw46O0jmnSSYtFSNb95wIA1cMiDEP9Q782JHM9JGfCXLWZ/MMSr5Uk
         g4q9Q4Km2XMzxvxd706WhLkOL0RB8b6v1BIpOzlCQV6vXZfTyrT4cptQdMoIGueLC+vn
         Owlg==
X-Gm-Message-State: APjAAAV0GJuj6M4liuYMF89EhizlMcsnbNszmqrRZbNOUv4tM/Ym+AoI
        LwQBNZy2oF2+lD0YJX0l8tM5mGiDntcwxyV3L09HpPlGaLr2CRgSSo37FF9079Go9K/s8/2yUTQ
        pUj4fPGsmatmiecMCnBuSMPPapJjdDYLaM+9p1uXVujoLWFU3Wd29q4cFcgiElyKX7HW7AzText
        yX4BeWcg==
X-Google-Smtp-Source: APXvYqx20Eera11wSCGiMj06DTUkK5XgEr8triU7YEu0Fga/OqWolNx7du6Bb6kon6zBbeDmEJqOuQ==
X-Received: by 2002:a63:6d0e:: with SMTP id i14mr75705666pgc.12.1577734386912;
        Mon, 30 Dec 2019 11:33:06 -0800 (PST)
Received: from [10.67.50.49] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u7sm50502725pfh.128.2019.12.30.11.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 11:33:05 -0800 (PST)
Subject: Re: [PATCH] pwm: bcm2835: Allow building for ARCH_BRCMSTB
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
References: <20191209232503.7252-1-f.fainelli@gmail.com>
 <20191210065229.hopmnq5qlwtl7gzw@pengutronix.de>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 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
 OXY+VnhOn2EcREN7qdAKw0j9Sw==
Message-ID: <73451521-a4d3-d945-2c86-cceef4cc6781@broadcom.com>
Date:   Mon, 30 Dec 2019 11:33:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210065229.hopmnq5qlwtl7gzw@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/9/19 10:52 PM, Uwe Kleine-König wrote:
> On Mon, Dec 09, 2019 at 03:25:03PM -0800, Florian Fainelli wrote:
>> BCM7211 is supported using ARCH_BRCMSTB and uses this PWM controller
>> driver, make it possible to build it.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/pwm/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index bd21655c37a6..0bb8a40c8d6c 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -100,7 +100,7 @@ config PWM_BCM_KONA
>>  
>>  config PWM_BCM2835
>>  	tristate "BCM2835 PWM support"
>> -	depends on ARCH_BCM2835
>> +	depends on ARCH_BCM2835 || ARCH_BRCMSTB
> 
> It would be nice to allow this driver to be compiled with COMPILE_TEST,
> too. But also without this:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Krysztof just submitted a patch doing that [1], which will conflict with
this one. Thierry would you be able to resolve that conflict while applying?

[1]:
https://lore.kernel.org/linux-arm-kernel/20191230172113.17222-2-krzk@kernel.org/
-- 
Florian

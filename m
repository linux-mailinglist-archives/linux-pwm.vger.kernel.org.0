Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67845BAFDE
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2019 10:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfIWIqD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Sep 2019 04:46:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33814 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731460AbfIWIqC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Sep 2019 04:46:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so9461694lfm.1
        for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2019 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BJHjML3SI9D2+EbTLuvMPDk5GTC8ZZ5KbbxFlhyt+ws=;
        b=UsZPbcuZRmE+Z3GSClH5/Mu9pa0xactT8q65lCY9ZQRMxMBG6shGQrEFWmS0QPKePT
         NbH/aWlJIVV/9FnXQijrVB5eG14WBp07hOFwnBLnZojOsILfMyD9JEsCCB6pT1OcWCp4
         eMpNQCu4hZN0omTdSXytMm98/IpN8fCAY9LZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BJHjML3SI9D2+EbTLuvMPDk5GTC8ZZ5KbbxFlhyt+ws=;
        b=kdLCxaJG5ULVt6V8nSxtS/w5CUj9uc7yX4khhqCZ9pX+Nlu+uYIGCCmQneabRXlgkg
         rfsoFnCz8hrI3SBjPPRvnsgAehBY3zciDza6JZfZWhAj2SZSzGVopFO8QlKIdgi1gFec
         0XiUAIdValK4+HR/4MQlyapC0PoQr2M7VfNq4m2fatrli4TMYa3cmu+TsTg1kpjrrd1k
         OqB1Ewd+q6ayj3Ww/8PkvtFXiHJWc3Qsl16ck9wSZLha1L8IvtCSH4JHmy++1k3OHcsm
         pVjJ4/nzRPZd0ZJZw15JOblzUSeFeDcy1ONA9gnYTMoaI+j/EnFe4p1Ynx93ZrsYplyo
         k7kA==
X-Gm-Message-State: APjAAAWrWgR8QUIiPF8mnPDekfbXhoaGPKEup1YGTiY0lyfQ8br8Dik2
        sAVxirVAQA0ejVnVjCMc9g0QrQ==
X-Google-Smtp-Source: APXvYqwfwYktaF6d2R/jJPuhIAVMBaQ1LbNQL8tbVJGh4whnsoZQo/JOgdIOZpuQji6Y+7cNLWAfXQ==
X-Received: by 2002:a19:4f5a:: with SMTP id a26mr15849533lfk.116.1569228358242;
        Mon, 23 Sep 2019 01:45:58 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 134sm2072003lfk.70.2019.09.23.01.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:45:57 -0700 (PDT)
Subject: Re: [PATCH 3/4] pwm: mxs: add support for inverse polarity
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
 <20190923081348.6843-4-linux@rasmusvillemoes.dk>
 <20190923082735.tzxyhvjlnztsxhsc@pengutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d2b29144-3de8-4561-3292-49db7e697aca@rasmusvillemoes.dk>
Date:   Mon, 23 Sep 2019 10:45:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923082735.tzxyhvjlnztsxhsc@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23/09/2019 10.27, Uwe Kleine-König wrote:
> On Mon, Sep 23, 2019 at 10:13:47AM +0200, Rasmus Villemoes wrote:
>>
>>  
>> +	pol_bits = state->polarity == PWM_POLARITY_NORMAL ?
>> +		PERIOD_POLARITY_NORMAL : PERIOD_POLARITY_INVERSE;
>> +
>>  	writel(duty_cycles << 16,
>>  	       mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
>> -	writel(PERIOD_PERIOD(period_cycles) | PERIOD_POLARITY_NORMAL | PERIOD_CDIV(div),
>> +	writel(PERIOD_PERIOD(period_cycles) | pol_bits | PERIOD_CDIV(div),
> 
> When will this affect the output? Only on the next start of a period, or
> immediatly? Can it happen that this results in a mixed output (i.e. a
> period that has already the new duty cycle from the line above but not
> the new polarity (or period)?

The data sheet says "Also, when the user reprograms the channel in this
manner, the new register values will not take effect until the beginning
of a new output period. This eliminates the potential for output
glitches that could occur if the registers were updated while the
channel was enabled and in the middle of a cycle.". So I think this
should be ok. "this manner" refers to the registers being written in the
proper order (first ACTIVEn, then PERIODn).

Rasmus

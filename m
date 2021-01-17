Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D652F9558
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Jan 2021 22:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbhAQVHF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 Jan 2021 16:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbhAQVHE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 Jan 2021 16:07:04 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1E6C061574;
        Sun, 17 Jan 2021 13:06:24 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id u17so29154337iow.1;
        Sun, 17 Jan 2021 13:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cZ5CzqR6FHC8SFBm9OPNqcdI+zSFrw+LNNyzBre+mNw=;
        b=lGrsv+fAWJAiFARhfVtpuwrmv5paBIcu/pnVy6Khbm4A3sazKaaroxX0KsBXqi/Pw2
         s1VWSXFdF0fJqZhxAcU+R3ldDE4lB8vQqTjnr9kgOGHxRNZq9fVeBVkVrdYquijD7krQ
         XGWLSUunmMOvbZ+8PO9MImmgVouvi7/QnziGuaYdtQpqq/FnlVut4WY2GYOZA/mxvNO8
         MopVBfn5IBgvOAd26YgJTWs9bEHStZ+AvVd0JkAOo8YXeL1W3PH0v41nA0mIOpowdltq
         wgxFGjF+mDE1sjWUFrgHmJfgwe42nghl+zvpktaezSaNuSkpKYVfJ5Sp17vc853ea4H/
         epFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cZ5CzqR6FHC8SFBm9OPNqcdI+zSFrw+LNNyzBre+mNw=;
        b=jpgcQEFs8pxMnDPHI2yJr5tqYmCfV7/K3tkf2wQmV0KXYa8armK8HV0J0bUqpwEHpm
         H5AqLk2YrgVf9JBDZISMZpjxZIQDHT7/X3GzQgzB4ZCp4kj14A3XKWuvr7jONcBkVboW
         ceZWCRB9bcV57g5WoVIzbEJ5tDBk4CyeOcGa/LGcI+teTMtCXIQzlictoIlzDLkKN8JZ
         sEIyLJ9CSwDpVdWZWkeU+HMev5nI/4xgZ1XGkpKAMHiVxJU65NFK0txRLEQC0s6qQStE
         GrWYapkhrmjTues4AZfbZCf3VcF/inoK/Zv6M04z50uqCrPXmzdmyErt4E35T62w7BvH
         o5qA==
X-Gm-Message-State: AOAM531rzF1ZQfGfxzUUEpxJlKIP38aQXqHrTHIbgByBhu7IDd2tFIi+
        nFA8IjWADgJUxMhoRw2Ay1tb9Z6dQyr6cw==
X-Google-Smtp-Source: ABdhPJwOvMykMbuKTMebYd1ePJZmIm78C9XrvCq4JCcIcHXlAPZNTQPgSUrYChJBm1LrcgbXK6OvDA==
X-Received: by 2002:a02:1d0a:: with SMTP id 10mr9356430jaj.122.1610917583539;
        Sun, 17 Jan 2021 13:06:23 -0800 (PST)
Received: from einstein.dilieto.eu (smtp.dilieto.eu. [188.68.43.228])
        by smtp.gmail.com with ESMTPSA id f19sm3011475ioc.51.2021.01.17.13.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jan 2021 13:06:22 -0800 (PST)
Date:   Sun, 17 Jan 2021 22:06:18 +0100
From:   Nicola Di Lieto <nicola.dilieto@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
Message-ID: <20210117210618.ptnypp4zgk4lfuab@einstein.dilieto.eu>
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com>
 <20201211170432.6113-2-nicola.dilieto@gmail.com>
 <20210117130434.663qpp6noujptdyt@pengutronix.de>
 <20210117135803.gt2zgta5pv7o6t6t@einstein.dilieto.eu>
 <20210117184556.7huqlkxykjwionok@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210117184556.7huqlkxykjwionok@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Sun, Jan 17, 2021 at 07:45:56PM +0100, Uwe Kleine-König wrote:
>> > > +	pwm_gpio->output = pwm_gpio->state ^ pwm_gpio->cur.invert;
>
>So far I understood also only comment. What wasn't obvious immediately
>is the state member.

Would it become clear enough by adding: "state is the logical PWM 
output; the actual PIN output level is inverted by XORing with 
cur.invert when the latter is true" ?

>> Would it be ok to cancel the timer first and then "return
>> pwmchip_remove(...)"?
>
>No. The PWM must stay functional until pwmchip_remove() returns.
>

Could you please clarify what I should do when pwmchip_remove returns 
non-zero? In my original implementation

- if pwmchip_remove returns a non-zero error code, I return it to the 
  caller and do not cancel the timer.
- if pwmchip_remove returns zero, I cancel the timer and return zero to 
  the caller

So under no circumstance I return a different code from what 
pwmchip_remove does...

Best regards,
Nicola


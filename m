Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06A422D1F6
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Jul 2020 00:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGXWrP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 18:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgGXWrP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 18:47:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27D5C0619D3;
        Fri, 24 Jul 2020 15:47:14 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dg28so8079628edb.3;
        Fri, 24 Jul 2020 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNSJrSp1TUgM0wwhmUslDh2V7fqpgFVhfMDCxW4mnVU=;
        b=d58fSml8Av/54E84yPUHmxd2sEOOswgra7qj+1gG+jle0sA05l6SSFQ8Y9m0vUZ/Yz
         Pa0vcAotLu63pAaRcpdjTT7b2Xzl4RfE0V41E9xZn9dYsgsAvxq48gsEAbpeRO1ljpLr
         /Iim5Y1RxmyJqFc6sLbgAHGReBFv3Ia0MibvG8ksj+MKBW5YyR2OLGiFghWFKQDI0i4i
         69keseER2Kmt9Fun/YyA7AtCOobgkdHQry90Ve3Tz7qHzY8y4qjPMzl7XTMvdQqn58j1
         EIYA+oy/TVG+u4jeY6FwioZr/RwlYRXUWFo42aReRAIb2I7zZc6y4+EKasY1WzPJWNgo
         FQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNSJrSp1TUgM0wwhmUslDh2V7fqpgFVhfMDCxW4mnVU=;
        b=aE8w2SXaWBL4COGt1d4/iApJXv34/JZJEQxrshYAgT3PHev24ee57wpBSEac6OFmTh
         A1QLTVCwbvjXRtXJ2j1jPQxO67h8D2N2PE3s54JUH/PgqLdSimKwnyAWsHd81zYiuwiT
         jABZjCmqPjymiQSiebWaqSvxo8+jgMvUcFBO1JzGzmWPw04eTei64h7s3CFRLJ4n2LsT
         dnH9cysRcVajxo54kgWBKZ8gyfoSrsxBrqUV+2iaf42Uh9GtJ543n44vMDYN2zGCBePN
         raXckHPj153bzKQGtKeMT9EcsvO6lltIL+a9eiQ9O0QDRUFu7AmHLdh7GnNykjtdX3w3
         1JOA==
X-Gm-Message-State: AOAM531M7wqY/BQfcFNI6usY9ZjVE8NRNd5ADfVFayv+dZDvCsLYs39b
        zFm5rpVNY1hc/3dWIbx63+00UD6EEiJs9uCQvWQ=
X-Google-Smtp-Source: ABdhPJxyq2va4/5ayN8xqmxRJ3AEZwyieX4tzpOLtd+pSDDG4r6/v5fP3oz9hDLOS8GDIWHpM7TTxkY6d/0mnZ6DbQ8=
X-Received: by 2002:a50:a6da:: with SMTP id f26mr424803edc.4.1595630833518;
 Fri, 24 Jul 2020 15:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724220516.GA21965@amd> <CADQ2G_HbysJbiQKSRmA6HDRfjPYPiDjbZfeuUjM1mNV-BBBC-A@mail.gmail.com>
 <20200724223150.GB21965@amd>
In-Reply-To: <20200724223150.GB21965@amd>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Sat, 25 Jul 2020 00:46:38 +0200
Message-ID: <CADQ2G_HkL3HLjsjMyM1vO-AT6bBP9C0BGO4WjpR0PjQrnhaf_Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Add QCOM pwm-lpg and tri-led drivers
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Vitej do klubu :-).

Dakujem

> Please double check. Actually, is the series for one chip or for two
> of them? LED framework should is happy to talk to generic pwm driver...

I'm not sure on that one. I will have to talk to some people about that.
I will get back to you on that when i find out how it actually is.
But i think its one single chip. Not sure tho.

> Ok. Check multicolor framework in -next.

I will look into it. Thank you

> Aha, ok. I assume they are still quite far away from being usable with
> mainline kernels.

Actually no.
While Konrad didn't send the patches yet we have some stuff working as:
Panel
Touchscreen
LEDs with this series
Flash light

You can check https://github.com/konradybcio/linux/commits/ninges_labs
for the current progress on those phones.

Best Regards,
Martin

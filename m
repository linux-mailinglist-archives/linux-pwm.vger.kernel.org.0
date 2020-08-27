Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CD3254F7D
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Aug 2020 21:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgH0Tzd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Aug 2020 15:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0Tzc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Aug 2020 15:55:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F1DC06121B
        for <linux-pwm@vger.kernel.org>; Thu, 27 Aug 2020 12:55:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t6so7798818ljk.9
        for <linux-pwm@vger.kernel.org>; Thu, 27 Aug 2020 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lebedev-lt.20150623.gappssmtp.com; s=20150623;
        h=from:autocrypt:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=C/HvJGUgaEvDTWfSUh0PFFcl8NQJMw4IIUkLqtTJ2Cg=;
        b=WKvCNMogThRVXjIRkPHDi7hpXPbznRlDqXiXr4mvZScyrGKwrlnCL7PgYJx+uRq0hc
         lLo9RL781uKM6bka18GSpnoVvJAK59n+RH4DOQj4X653kbaRDWJCY+U0JJSRs4TXXg2N
         raUjsBKQFmZZJBrym8nsj6wODVnmMTWpY+tP5gy4+OGYGSit10r/h/XpPY6qEBg2Q/xP
         +AKdL/j8y618gm/02uigbGlAeVx4XVx5NUmmN58C2GZDpAgLwNoIH+R6Rl3E9iHQ2Ue+
         S2D5iUXQYUriNRAa5kI7M7c9XnUHYO6lA6ZlUqIMbd6lztcDaP1T7T+bcmAtF75bCSiV
         VHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:autocrypt:to:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=C/HvJGUgaEvDTWfSUh0PFFcl8NQJMw4IIUkLqtTJ2Cg=;
        b=UXVUWj4bcXTudDM+oOrw4vUD+cd40+hkuu3Dd+SrSNDnNho8obL90yoFw/F91zu384
         7I7Vq8wMKH/Xu8q4TD0NiZg3PU4KciYBkxvWCeoSNEtVpgPuDq4Z08TpOz0N178+iao7
         9wIJQQF27epVmloN7QwvE1b2qvX3PUNV4BVVgNcv1mfywiowKb+c4edu4tIX/oZuHEXw
         lgEsl9NH4PWlF8AfNisRAQKmMRENoZq/2pa+QPRtfUgIvUvMBVwuOPSO0/2daihgET0i
         wlh7gBzP+ClwQkAoZF4ah6H/pKUNTUtf3O78f/ZYeqDBW/37kOAyqQaUNrF2To0muFJH
         6DiA==
X-Gm-Message-State: AOAM531j4NoHMgJZBMrIBW83cQySTrYJ217wmXCULAtZ/r3E9drh0q3y
        Vu8OelYEwGkmvtzHKXuLEUBT3g==
X-Google-Smtp-Source: ABdhPJzHgig42TY0lx5y4uo6AWxEBaZeDZyxIprdlZPybvfZNxzVlWgXGXKUka7DtGiQ+DnTkS/vNg==
X-Received: by 2002:a2e:7504:: with SMTP id q4mr10588200ljc.41.1598558129747;
        Thu, 27 Aug 2020 12:55:29 -0700 (PDT)
Received: from [192.168.1.108] ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id f12sm432626lfj.50.2020.08.27.12.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 12:55:29 -0700 (PDT)
From:   Andrey Lebedev <andrey@lebedev.lt>
Autocrypt: addr=andrey@lebedev.lt; keydata=
 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 c1I=
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: pwm-sun4i: PWM backlight is not turned off on shutdown
Message-ID: <ae58976c-a8d7-0d00-fe72-d21579b37240@lebedev.lt>
Date:   Thu, 27 Aug 2020 22:55:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

I think I'm experiencing problem with pwm-sun4i module. I'll describe
the symptoms first.

I have a device, based on Allwinner A20 (Cubieboard 2) with LVDS display
that has a PWM-based backlight. The problem is: when linux shuts down,
the backlight stays on. I expect it to be turned off. This used to work
as expected on kernel 5.2-rc2, but after upgrade to 5.8 the backlight
does not turn off anymore (most of the times, see below).

The backlight is configured in the device tree [1]. The brightness can
be changed by writing to "brightness" file on sysfs. So, linux can
control the PWM line. Backlight sysfs directory also has a "bl_power"
file, which can accept "0" to power on or "4" to power off the backlight
(according to [2]).

Now, writing "4" to bl_power sometimes turns the backlight off and
sometimes not. I've found that the probability of backlight turning off
pretty much correlates with the current screen brightness: on 100%
brightness it will never turn off, on 50% brightness it will turn off on
about half of the times. When backlight does not turn off, it goes on
full brightness. It feels like the line, controlled by pwm stays in
whatever state it was the moment backlight was powered down - either
full 1 or 0.

The pwm backlight device driver (pwm_bl) requests to set the duty cycle
to 0 and disable the pwm with the same request [3], but I suspect the
implementation driver (pwm-sun4i) does not actually set the duty cycle
to 0 before disabling the pulse width modulation.

Is there anything that can be done to fix this?


[1]
https://github.com/Openvario/meta-openvario/blob/warrior/recipes-kernel/linux/linux-mainline/openvario-common.dts#L21-L27


[2]
https://www.kernel.org/doc/Documentation/ABI/stable/sysfs-class-backlight

[3]
https://github.com/torvalds/linux/blob/master/drivers/video/backlight/pwm_bl.c#L81-L83

-- 
Andrey Lebedev aka -.- . -.. -.. . .-.
Software engineer
Homepage: http://lebedev.lt/

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660B02E02C9
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Dec 2020 00:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgLUXFK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Dec 2020 18:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUXFK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Dec 2020 18:05:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545D4C0613D3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Dec 2020 15:04:30 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id lj6so293165pjb.0
        for <linux-pwm@vger.kernel.org>; Mon, 21 Dec 2020 15:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LEGkK3+lTXXv2zMJW3SaID5AuNIrLM/Ypa7E1mbU3/s=;
        b=L5kkgDbCqxqhozZFjoqtGPJcoaG+KRUPMCC5MR8a9m5hVKIIw0bUdXM9MD6a+TUu4s
         WaILaMe1/Wn9No2XsWVln1gS37/pt2gok0TlRFChJCDmK+1AATQwIwxurA6yVfTlgA6a
         nqQJOwR5upX0uQY6U44lz7sATEtJ/dSM8KQPDrVpXC+FJtj50HIV35FBGJ8UUQHa1/Wn
         ibHsmh4oT73rOFy6KJ97Lp/ZqWW4l2XcwVPVKmyj6mRePWLBzHFcCDhAJ/QMrXd1BfJ4
         2cyg/J/2aYudtKZvzWeMOPC7bUHQvc/zEcEKy47/jVKrbyzITcsUtVZmUQXSZwK9m4OL
         H9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEGkK3+lTXXv2zMJW3SaID5AuNIrLM/Ypa7E1mbU3/s=;
        b=UZ1HXOsNor/F/OfV0FwK+1SYhor6b1M14+8Hf+IO2V214cBZwrgetOoZTN3vLPlJPP
         ep3juZOqbdi8kbU0dwIOiqIcB5dSY7jqg21tmkGRpOJsDO2wnzeVsk//+OxM5iOgR9QD
         0UrzUirU3kBAC4b0Z9fVGXRQFxlYN7kGpISLsbvPXCWWoQt5WtAXtnBhJK7knwtFUd6I
         /LL7sUgGoZzC2d/W+j6dZkNjoNJHnXUV1IRuiiRT0zI2Q/Mz+VYjWLvaI7X9DiWZgSv1
         RrzUkST4SJjzCakq7zZhp5HK2tkT/bwtTSO0W9nXvFMebZRGUo9JiJkuiNi04GKYg/0K
         cnFg==
X-Gm-Message-State: AOAM531NIj2FYgIclXeqtBSlyGjZ1lbstm8ic2md8jzzNRHFNsccRmUt
        ATJrLEyf4iqwPlB4v10e/vM=
X-Google-Smtp-Source: ABdhPJz7TLaoOC7pcaQz5X6PJQbZJ0whM1mzUuUib2WnrVAIZk0Y2NhyphA/p/ZBoAAKP+BQRV6Fag==
X-Received: by 2002:a17:902:8c89:b029:dc:1e79:e74b with SMTP id t9-20020a1709028c89b02900dc1e79e74bmr18349314plo.58.1608591869560;
        Mon, 21 Dec 2020 15:04:29 -0800 (PST)
Received: from [10.230.29.166] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c184sm17801353pfb.11.2020.12.21.15.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 15:04:28 -0800 (PST)
Subject: Re: [PATCH] pwm: bcm2835: Improve period and duty cycle calculation
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Sean Young <sean@mess.org>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20201221165501.717101-1-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6742ade7-8ed4-a778-38a8-4433d4854ba0@gmail.com>
Date:   Mon, 21 Dec 2020 15:04:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201221165501.717101-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 12/21/2020 8:55 AM, Uwe Kleine-König wrote:
> With an input clk rate bigger than 2000000000, scaler would have been
> zero which then would have resulted in a division by zero.
> 
> Also the originally implemented algorithm divided by the result of a
> division. This nearly always looses precision. Consider a requested period
> of 1000000 ns. With an input clock frequency of 32786885 Hz the hardware
> was configured with an actual period of 983869.007 ns (PERIOD = 32258)
> while the hardware can provide 1000003.508 ns (PERIOD = 32787).
> And note if the input clock frequency was 32786886 Hz instead, the hardware
> was configured to 1016656.477 ns (PERIOD = 33333) while the optimal
> setting results in 1000003.477 ns (PERIOD = 32787).
> 
> This patch implements proper range checking and only divides once for
> the calculation of period (and similar for duty_cycle).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> during review of the bcm2835 driver I noticed this double division.
> 
> I think the practical relevance is low however because the clock rate is
> fixed to 10 MHz on this platform which doesn't result in these
> deviations. (Is this right, what is the actual rate?)

Currently this is correct but the PWM input clock can be configured from
the divider of a PLL that runs at 500MHz so this change is potentially
useful in that regard.
-- 
Florian

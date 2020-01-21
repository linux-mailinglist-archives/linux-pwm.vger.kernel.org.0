Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D28144587
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2020 20:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgAUT7Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 21 Jan 2020 14:59:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46174 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgAUT7Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jan 2020 14:59:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so4240985edi.13;
        Tue, 21 Jan 2020 11:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uhJ95Ie/Yb8Dbq3RWjp7bO5gpLNFCl4QU9krsyTd1e4=;
        b=okx0hnDXLuTKUQhLpgzPBOChyI46T5tdKyejTEpwUCCEZF1rvNpFfb8651e4Chxpnu
         cZ6LryZDY3uMt9+7UCDloZY107gMbZDvS6Ij1reCqCO8C9mYdQN9g5KRXZmdHB0mnOJd
         niFdTTJkKfhrJhFIj+nKHtM254Zvxi8/VlQCvUi6fDH2EPGjrX43Q8Cumld0N9iMWdCE
         EFe/qSYlmFXu5K4nyjzol4V76QbYmyM10rDWjvZRFpJvOk3sagjsuUm8CQRIVgPkmj/y
         Acl1tTXcqD3XhL98mpN0BJuvU7hUod98zwD2IDiOESK/3KiYwHmE7vVcCGoerIVrf5JQ
         HS8A==
X-Gm-Message-State: APjAAAWf+1FuNhPVdKlocrcV+BGWGt38jyjbT8pmfi8vC8GI/Zt37PlX
        VWHqJYqxE0sNOgLEUe7WTc8=
X-Google-Smtp-Source: APXvYqy5oKpC5VbO57NNFXXW4t25xYdgBIF+hM+FYIhxJRDJvlHiKDyjWIptp4kr1V4nPuREunpnYg==
X-Received: by 2002:a17:906:e083:: with SMTP id gh3mr5866963ejb.231.1579636754353;
        Tue, 21 Jan 2020 11:59:14 -0800 (PST)
Received: from kozik-lap ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id f9sm1429279edr.66.2020.01.21.11.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jan 2020 11:59:13 -0800 (PST)
Date:   Tue, 21 Jan 2020 20:59:11 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] ARM: s3c24xx/rx1950: switch to atomic pwm API
Message-ID: <20200121195911.GA24380@kozik-lap>
References: <20200120193328.17007-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200120193328.17007-1-uwe@kleine-koenig.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jan 20, 2020 at 08:33:28PM +0100, Uwe Kleine-König wrote:
> Stop using the legacy PWM API which only still exists because there are
> some users left.
> 
> Note this change make use of the fact that the value of struct
> pwm_state::duty_cycle doesn't matter for a disabled PWM and so its value
> can stay constant simplifying the code a bit.
> 
> A side effect of the conversion is that the pwm isn't stopped in
> rx1950_backlight_init() by the call to pwm_apply_args() just before
> reenabling it when rx1950_lcd_power(1) is called.
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  arch/arm/mach-s3c24xx/mach-rx1950.c | 19 ++++++++++++-------

Thanks, applied.

Best regards,
Krzysztof


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5F146BE5
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2020 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAWOxq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jan 2020 09:53:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35932 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbgAWOxq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jan 2020 09:53:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so3777475ljg.3
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2020 06:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP2rc3sKgqYT9el7f1WHPuLRZRmFlraniNcLzRTh1pc=;
        b=IoZ+hHh9hNTkHT2YdnouTrYjcsSt8gBQuva/8HSDudsOjNdpBl4/AY6qjsAHBlriLV
         nTHyHpV+MwD85kPFu8T95GN+dtKdP69SnHaFGu9mMcuxKzDrxWNde1TNydE3OP+B1pDi
         YdKXnPtMUKfYQz+qEHDPX1SXImBIn5SKSC5ld3HA4mRE8mwoPRm2KAblSga8TJUt8lEV
         HUCMahOwnl0Qgb5YsPjJK+Uf3STpWDbV5hPuSUlPye0aJKEqyc5myrXRWOe/3odRhFVy
         gF8bxp2wwGmuv/sSJ77ptgBBO+GfpuXC/w9pS0s942Qk6Q5hbrRW5/BrbI+px+OdoBA5
         ddQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP2rc3sKgqYT9el7f1WHPuLRZRmFlraniNcLzRTh1pc=;
        b=ukjrtrqzsMr4P3sBXY4FVEl2YBWQYZF9MBSncS/pk8sQhIBvaaOSHnMU9WoZIhw1rV
         R/JZqaaAnK/Y+++92owpw0xPxOoDEdbHoixNRwdKkxLlcCFziiQpCL4bxJ3fJwYIjDh/
         iHnpuvtRSbjjaCVxHbJNNXB4FGIXN78IOCyq5cT6uqcEqieIe+VjlyJcx54YssprXV5t
         jctnnCxvU5UF40SVGbAsaVhbooHn6n0mxsd+NH/tIf5M69aYy/F6NbdtEO72coanv98X
         e30J2Qp2BJolDdG1JtufglZhZS5J8+11EtwNoVDLn+roRIe+Xtj8kg6akKuMgxehlPtG
         z7jg==
X-Gm-Message-State: APjAAAUpH/5aCSZXiDrSnp7Td/3sywTGxJl6ldgAH3g1RZnh5+1EEe3w
        o09zmsqIYgllQfYEmlE5fq6QhDt1diyXNsddSrXZDw==
X-Google-Smtp-Source: APXvYqwfj7WWn0juBVOB8AF0fnjeeNkmI+4iRvbuJD3XjPlxz72XbJT6NEb8X5O+9ai22dAUSazBreWyIu9u9mNdGqM=
X-Received: by 2002:a2e:98c4:: with SMTP id s4mr23335397ljj.102.1579791224055;
 Thu, 23 Jan 2020 06:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20200115073811.24438-1-bigunclemax@gmail.com>
In-Reply-To: <20200115073811.24438-1-bigunclemax@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jan 2020 15:53:33 +0100
Message-ID: <CACRpkdYqTCmG1=HM0QphPou43HFSXBNB5HH1R8xH0KEb=zxC1Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: clear irq in edge cause register before
 unmask edge irq
To:     Maxim <bigunclemax@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-pwm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jan 15, 2020 at 8:40 AM Maxim <bigunclemax@gmail.com> wrote:

> From: Maxim Kiselev <bigunclemax@gmail.com>
>
> When input GPIO set from 0 to 1, the interrupt bit asserted in the GPIO
> Interrupt Cause Register (ICR) even if the corresponding interrupt
> masked in the GPIO Interrupt Mask Register.
>
> Because interrupt mask register only affects assertion of the interrupt
> bits in Main Interrupt Cause Register and it does not affect the
> setting of bits in the GPIO ICR.
>
> So, there is problem, when we unmask interrupt with already
> asserted bit in the GPIO ICR, then false interrupt immediately occurs
> even if GPIO don't change their value since last unmask.
>
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

Since there is no feedback from the MVEBU maintainers I have
tentatively applied the patch for v5.6 so it gets some testing.

Yours,
Linus Walleij

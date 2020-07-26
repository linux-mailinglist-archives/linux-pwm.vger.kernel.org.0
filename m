Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3748122DD74
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Jul 2020 11:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGZJEf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jul 2020 05:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZJEf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Jul 2020 05:04:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF266C0619D2;
        Sun, 26 Jul 2020 02:04:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so7751796pgm.2;
        Sun, 26 Jul 2020 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHrlTd85XWK3pOyfmvZVnMsTMYRkRM8sEaTNqMrlEeE=;
        b=EiWMvIYCNZgUKEDR7GpvZnnTJeeR7ZjPdWr8N1i8AoOH7JGkF8PT+QofBwapvlO8dv
         6hnoUmoHjdjfRXtLJJCo+pHnYu3InarkFRdO/uDqc5c98Jdq07D8sG9/JqTRsGUoZ5s8
         2PFEIfeDDU3b0y3FTYlKwL1x0ZEV+X0SD8mWE/KWYci1QlbCTRq0BIB5TmKqt08n7Qt4
         QBubCt8GTHUwAkN1uza4fnADPYGc1pxnPmFDjPUFgLQjbW1ZlN0p2Gqw4zFoKZAVX7Fr
         hT4dZwdYIiHkfyNEtN4au4s1LpNUsOwQ5STEld5fyAfxxQdz8ze2Mce12kGxOJE3gQir
         vO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHrlTd85XWK3pOyfmvZVnMsTMYRkRM8sEaTNqMrlEeE=;
        b=Yf3ItFlPJoSPw0KlwbMjBFOwfzH8O5DIwkKPOImVUP06yB45umGuRx+SvuhwRxJ02X
         KlfTIbEc/jzROu4UbCM8xjnnsQF12/azsY0OxY8fnpiBEnYMjCQmMTsDcznIGDQblUQU
         YXgn0/eHCJhAtnnVed8tU35A02pHiKZDGEhcooU0UYfbnYHw1ZnAlxxTcHRopiOcbkIx
         rSKbpWYiqDrgLbknRQGkejtTQoG+S+E81XOdSQb0/ELczM/CURdsrGvvLvvrg0VTtAq4
         HKrJ93+3PZEbdXq23Zt7/yy8b7tbYSj8nqFqMtXgVTjkZgGqAaweD8L7bMjkkee44akl
         2lGQ==
X-Gm-Message-State: AOAM532cmVqYPg/kLeKb4M5urVi6MCASpDwyZdTzCOKDN0cLhUOemUW8
        UUDPX9qojDOgsJv/uQe6zLLQYFZ1dAM4lXUMzGpY8axa5eY=
X-Google-Smtp-Source: ABdhPJx44ZrFZhNwXvgVe5Vd2Tea/ss8TkWcGSr7Z4Vl0BaVUKWkQCX6jehzcWJuvlQufdTtdrXtQWmbeKdaJx7L/2A=
X-Received: by 2002:aa7:8bcb:: with SMTP id s11mr15288366pfd.170.1595754274348;
 Sun, 26 Jul 2020 02:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com> <20200724213659.273599-3-martin.botka1@gmail.com>
In-Reply-To: <20200724213659.273599-3-martin.botka1@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Jul 2020 12:04:18 +0300
Message-ID: <CAHp75VdJ14p+_+XqxrgRrjXF7m6L4nGr5vB03NTM=0xjgw4c7Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] pwm: core: Add option to config PWM duty/period
 with u64 data length
To:     Martin Botka <martin.botka1@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jul 25, 2020 at 12:40 AM Martin Botka <martin.botka1@gmail.com> wrote:
>
> From: Fenglin Wu <fenglinw@codeaurora.org>
>
> Currently, PWM core driver provides interfaces for configuring PWM
> period and duty length in nanoseconds with an integer data type, so
> the max period can be only set to ~2.147 seconds. Add interfaces which
> can set PWM period and duty with u64 data type to remove this
> limitation.

And all divisions go mad on 32-bit CPU, right?
Please, if you thought about it carefully, update a commit message to
clarify that.

-- 
With Best Regards,
Andy Shevchenko

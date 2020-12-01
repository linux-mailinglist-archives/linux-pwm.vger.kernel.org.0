Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F532CAA99
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 19:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgLASRg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Dec 2020 13:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgLASRg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Dec 2020 13:17:36 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E0CC0613D6
        for <linux-pwm@vger.kernel.org>; Tue,  1 Dec 2020 10:16:56 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id r5so1311026eda.12
        for <linux-pwm@vger.kernel.org>; Tue, 01 Dec 2020 10:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/syJ22a7pW9UW70CpIkZYiyUgRG7SInot7yd6BD7U8=;
        b=CVx56aS+gy5rI7qQSyuavnHAdlDpFsbemK8vMOXXUNa4lUVMCM2PapwdtDHkKVh4FT
         Re6W1840rMxQTWTtch+pXJqo3XrBTFC82M5ltQpmr9LDYzp6PvPzth7h7A7ZPRE4uYm0
         lca6HzE7y7PbW6rxBkEmWsA52XJSOSA+KOfAwDGJuaF+FoROBRUyWkJm1kwk2wBJk0tI
         cskTotCWOxzUjvyHYOBYPPTr9PadeXR1CXo42k3MH2mO9N9KNO/8krF9oqPI6yn6QFHn
         Z7zwL2Pzv/yZHP8Jsog1jUyPLopceJzUHnNxUlYxFswA/PRogYzJqPFSmsP0SJXDqyGP
         UL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/syJ22a7pW9UW70CpIkZYiyUgRG7SInot7yd6BD7U8=;
        b=hnqxeIZNEirkKF/8ZznSlKRuWaI7+NWplzI9R9PLXyKSeXR4URHT6L53StClpeSO/E
         zqbflvCyRLibKRwMDlIVQYvoQqcd41bCvGU8VgBL9TPJ0g0nsoU9/jQ24BkNb+vQqmll
         Zp+kdAp2cmDzAThC1vtVF+V8S1X1Ad0mzc/pbKB+WFxbYOL+UY6hfHlv0qVIr3EHbEWS
         9T58PV7y4P0RQotkCc1AMY0Oqz2YQfKyu2VX52tCwkeWXi8C9P3ji8KIvaND7Q49IPU8
         pVOsWH+XF8YTkiIff1APHBX3OLc7NslERbkX5OVwYwcm4QURjC1+ewWMj69I872eBqOP
         acpw==
X-Gm-Message-State: AOAM531DEBoXckWmG60pTnA9wnpNt3Vpfrgc5zAWyWAipC1vhhm+p7zO
        c1YKBC/WF6Y+kfMJMehjLIkkqHw+te9PqndDOzliag==
X-Google-Smtp-Source: ABdhPJzZBcB/VgZ5zRSb8ttjziMnVObAH4snT/eaRIi4824W7GO7AWHS1kW6s5I8UCf/qQ7fK3eV5oZO15A2zl5vw/U=
X-Received: by 2002:aa7:d54b:: with SMTP id u11mr4333357edr.341.1606846614778;
 Tue, 01 Dec 2020 10:16:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605694661.git.baruch@tkos.co.il> <db0d6d619a0686eef1b15ca7409d73813440856f.1605694661.git.baruch@tkos.co.il>
 <20201118231811.GH1853236@lunn.ch> <878sax6f43.fsf@tarshish>
 <20201119133429.GS1804098@lunn.ch> <877dqhfogp.fsf@tarshish>
In-Reply-To: <877dqhfogp.fsf@tarshish>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 1 Dec 2020 19:16:44 +0100
Message-ID: <CAMpxmJXKDhB1fOGaY_+bmZ=4X6du0n6aoYVTMKnGXvTd8PdUNg@mail.gmail.com>
Subject: Re: [PATCH 3/5] gpio: mvebu: add pwm support for Armada 8K/7K
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 19, 2020 at 2:47 PM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Hi Andrew,
>
> On Thu, Nov 19 2020, Andrew Lunn wrote:
> >> >> @@ -1200,6 +1235,13 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
> >> >>
> >> >>   devm_gpiochip_add_data(&pdev->dev, &mvchip->chip, mvchip);
> >> >>
> >> >> + /* Some MVEBU SoCs have simple PWM support for GPIO lines */
> >> >> + if (IS_ENABLED(CONFIG_PWM)) {
> >> >> +         err = mvebu_pwm_probe(pdev, mvchip, id);
> >> >> +         if (err)
> >> >> +                 return err;
> >> >> + }
> >> >> +
> >> >
> >> > The existing error handling looks odd here. Why is there no goto
> >> > err_domain when probing the PWMs fails? I wonder if this a bug from me
> >> > from a long time again?
> >>
> >> What would you release under the err_domain label? As far as I can see
> >> all resources are allocated using devres, and released automatically on
> >> failure exit.
> >
> > The IRQ domain is still registers. So once the memory is automatically
> > freed, don't we have a potential use after free?
>
> This patch moves PWM registration before IRQ domain registration for
> another reason as mentioned in the commit log. So this might
> incidentally fix the bug.
>
> Would you prefer a separate patch for that with a 'Fixes:
> 757642f9a584e8' tag?
>
> baruch
>

Baruch: does this series conflict with the fix you sent? I'm thinking
about how to take it through the next and fixes trees.

Bartosz

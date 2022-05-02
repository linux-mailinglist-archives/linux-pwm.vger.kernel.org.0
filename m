Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5C516D67
	for <lists+linux-pwm@lfdr.de>; Mon,  2 May 2022 11:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384314AbiEBJe6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 May 2022 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384341AbiEBJev (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 May 2022 05:34:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0E18351
        for <linux-pwm@vger.kernel.org>; Mon,  2 May 2022 02:31:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bv19so26694470ejb.6
        for <linux-pwm@vger.kernel.org>; Mon, 02 May 2022 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuZuLvdtXsTMMZQUAbDPqb/0pC+19gYcn3vELZlj3YY=;
        b=A6MegasgaijMoinERJiBZdVFBLJsYvo4+gsnWe+1dXv3PJsub6/T8aH0BGZbvUDUWI
         6kZkO2AoO+SFBNdeSMVk3GWWhGjq3arKjB570bDNbdt7wmlkfLatoNyas1rBM2gRlVNn
         G6uNUx2inpu4qAwapcFaMsRGtm7gAX4f+wkkJq/8/JV15NWc+bavEWjKb9GHiQYznAs1
         mTS1fLEz/nhFHtHd4WDNE4TudneWL6qsjo6lNO2UskrzSmKbKQ+AXQoWPaFgV/5BLusT
         aW+0vny9NPo/XEWc3Ll+dB61/z0AYLLzjssZ6jmV2nA/Yxg25sl8BXWiteD+Oang6D5u
         f2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuZuLvdtXsTMMZQUAbDPqb/0pC+19gYcn3vELZlj3YY=;
        b=MasY+OmE9WNxtLzAaqmCSj+0SdQG1Vm12gJPO1oEbFZWTmdLbUm/+dwdQOAl9KqXxL
         bbbdilHUaLPBZpQkQ+/zqaQQF+mTzODTXXcREuq/4DYmSplOWMSO90ng4naNyrfTErU9
         3DfNpcVT0YOWg33voiD4XaRhFMChEl8uUuADNLOm1YbmhN7RGD2q5+5MTKQy57zpjQkO
         dJwAq4EIlSAzaRmvE+vQzPPbV0yHUfgSZLvy1IhiziiCNKu8VUyzlUouiaWMcTawYsKT
         vyMKTiQFjRKNHceN4VGxzCwml3oQYjcMeYUIo06oeh4Pq56M7rTHJVL4S8oKfkP+DYQw
         D3vw==
X-Gm-Message-State: AOAM531JATCc2qwSXrg3gdaHzh4+kBdlv7hG+LrCz9Sgc/lvhSOHbj2o
        iu0sIjoGkSQEYcJ0gI0iWsslF49UNZs1gujNzLzPWw==
X-Google-Smtp-Source: ABdhPJw8PWfvgMoClO8VIo1Xm7UiZd7z4qS5dlpuHz2yxjXzcwHbTu/kPrgHASBwXsSI4iiprFJ3L6Gyx9323HBwPSE=
X-Received: by 2002:a17:907:3e28:b0:6f4:3900:78f8 with SMTP id
 hp40-20020a1709073e2800b006f4390078f8mr5844440ejc.736.1651483869159; Mon, 02
 May 2022 02:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
 <CAMRc=Mei_ZWPzSMHpC1Ao8nU487_SUq7qQGEDkxwdRb0jmx7cQ@mail.gmail.com> <87ee1cxpmb.fsf@tarshish>
In-Reply-To: <87ee1cxpmb.fsf@tarshish>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 2 May 2022 11:30:58 +0200
Message-ID: <CAMRc=MdfaTE_9ptYSV6ZcO3BNg8UVuppkkmb_ahQJtAYAGioZQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: drop pwm base assignment
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 2, 2022 at 11:14 AM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Hi Bartosz,
>
> On Mon, May 02 2022, Bartosz Golaszewski wrote:
> > On Mon, Apr 11, 2022 at 8:25 AM Baruch Siach <baruch@tkos.co.il> wrote:
> >>
> >> pwmchip_add() unconditionally assigns the base ID dynamically. Commit
> >> f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
> >> dropped all base assignment from drivers under drivers/pwm/. It missed
> >> this driver. Fix that.
> >>
> >> Fixes: f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>
> [...]
>
> > Queued for fixes, thanks!
>
> Thanks. I see it's in your tree (brgl/linux). Is that the main GPIO
> development tree now? The MAINTAINERS entry for GPIO SUBSYSTEM currently
> lists linusw/linux-gpio.
>
> baruch

Thanks for spotting that! Yes, that's the main tree, I will send a fix.

Bart

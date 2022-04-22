Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58F750C3CB
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Apr 2022 01:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiDVWzx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Apr 2022 18:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiDVWzV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Apr 2022 18:55:21 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104FD1E1DC4
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 15:18:37 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r189so16927488ybr.6
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 15:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4FyEq0J4+nC0MTe8qO25P0tPU2l2IpDCHzyMQrJqNA=;
        b=AAmRV3w2Oc227kK2N6ru2O1CgaiHjqSP3HFhcCzwEyHL63jqnF+tp6a/J7AnfYPpEk
         sU6za6lHhI0EfxX1Sr4kXFK5DFYX9gawJmC7xIIPqTuKrSenR6itm/L9dVv5I4cGUyeG
         qqK//g/xd6wTf/46k30vG0AByPbyk7dLaqanNU1AXDRlH0bVbjnCilOkUcm8mhFpmPry
         1dj2R6Qn4LMgvOZSjO2o5uFUL31JtGG2EgiR9FndNLkQTYiDd5+ColScDGU7vUKNr58U
         RBO+nvxeiXF4cunLxrjv3r8CtJCNq+nbFIEwgUMqUs574oVSGjw5ahp2eOoD7s5J90cW
         7o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4FyEq0J4+nC0MTe8qO25P0tPU2l2IpDCHzyMQrJqNA=;
        b=fDTdqCWZaJh7cWv5kFeyL5/0rDdqpWSSTVcspdLaaOZUAlJxmcJDbzIuJwvmi5b3JU
         BR0m2gt6wUqHU/nNqzawnJDEjRiKKs0/4QMhPbgS3GMEoqqe7pqckbG4cpYD0iI7W5XQ
         rF30eQwj0J9bKU4ERyyPajgl1nf0bPRrwbfjGQv5Fgn6r9U3rqD5Sy7LOFtlM6zYTdsQ
         l1/oftuJT7zLny4TvuGNSL6fhOtemalBz9rbQkymgnLCU+UqZSYQAEvL1cfQAZTPcEaO
         YbSoF1XIUsNLRmY0bnoMRK5ouo7gTR+rvZseuKMAFXwIfpFvblmE3/yvEba0W0HrP2ry
         H8bw==
X-Gm-Message-State: AOAM532gL4lb6l8BT2v09Bc0J4uPjZwYpdPLqvgieqkfFC5x0oDXLxCd
        HwXxWwRCE/dqQKN0q1CfUrPUVr99gvIKoBPv93O3RQ==
X-Google-Smtp-Source: ABdhPJxqHo4RT34Ay1885+QQSd4dTrKwzDUBhzWyFIJoDUQ47o50iRXzILq9yYWWAXScqMAu7RkHJ5kgMRUN1s8dZbc=
X-Received: by 2002:a25:4e82:0:b0:633:68d7:b864 with SMTP id
 c124-20020a254e82000000b0063368d7b864mr6962271ybb.514.1650665911106; Fri, 22
 Apr 2022 15:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
 <YmLcdmQrO4+0tEiJ@orome>
In-Reply-To: <YmLcdmQrO4+0tEiJ@orome>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 23 Apr 2022 00:18:20 +0200
Message-ID: <CACRpkdaqRe8HgPvm-YH9p=ZDetX6jcVHFRgvqk064KW=2-a-mQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: drop pwm base assignment
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Baruch Siach <baruch@tkos.co.il>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Apr 22, 2022 at 6:48 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> > -     /*
> > -      * There may already be some PWM allocated, so we can't force
> > -      * mvpwm->chip.base to a fixed point like mvchip->chip.base.
> > -      * So, we let pwmchip_add() do the numbering and take the next free
> > -      * region.
> > -      */
> > -     mvpwm->chip.base = -1;

I don't see why this is removed. I understand why the comment is removed
but all contemporary GPIO chips should use dynamic assignment of numbers
i.e. base = -1.

Yours,
Linus Walleij

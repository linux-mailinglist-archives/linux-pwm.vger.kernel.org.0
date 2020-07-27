Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF37322E71C
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgG0H6m (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 03:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0H6l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 03:58:41 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB4C0619D2;
        Mon, 27 Jul 2020 00:58:41 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b13so9033331edz.7;
        Mon, 27 Jul 2020 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/REZwXRz5HY7fev5AIX1xp+FPLMsQ7CaayNFnZrrTs4=;
        b=E44rSvPDKHSJX+gzJpv/MuvSGtQjfA11R0Nh4HxsD6D1B5bHRPLrkBH/vfDoZksV83
         KsSWhzHTRZo0Rww/ofA+K5yQKW1aK/xVe5AoztxOw7HbSy/gedDM5c3cg4U0sejJpgUs
         L284SKbEPvZ9oC7+Qkf3jPB9mH7i8w1kTu6VIcKGXZBSgCcPR+GVUdqII/E7ZVwsZGqo
         yQE8GVLKAn3SA6J/4ebOZ/a7264TG3A+cMu4rLHy0hPG9lsal2aHAavjUUsEYWSOoq31
         YEguXeDWgrFftAuF7xlHV4Ax8OXRBLt1pBzq/yAKq8nWIfmTA0IT5g400Sksqt/2AeKY
         Xbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/REZwXRz5HY7fev5AIX1xp+FPLMsQ7CaayNFnZrrTs4=;
        b=ZOKO49eS8GZa+zR5IjKGAB0gyG8RGqxyWsQMO/2KamomWXYh8YwSj92wNYrXjoJq4Y
         QtnuXG3nzVAc6iuSOGUGncQ3dvO5iFXstmG93XBPdTsUZwgppzCg9/qIcNtr0tJpsnS2
         e0MSMBvRMrSTgG2jgg/opgMhs6fKNlWz13Upj8vnkqnwl5BiTlyt61DPG6HSh4x7IZ1Z
         AAdSNBElLy0UjBKrscKgTUwXP8aQIF7B8QB6rzn0uLfTpLd0Q0VTQ2Jmsk7yRsXLIB/r
         o5iyyRm+5CX6ERK9ZrNiN6axBhFSovZ2J3bvKeFDItBanKJ4E2HEZ+aNO6FRNrgJOquX
         9iEg==
X-Gm-Message-State: AOAM530bpWDojYtO79z/E15mB+MbW9F1YDvIK2g6FkfRbo4ivOfKtkQf
        doCeXiS+qWkclbhsla0JXFp5YjuuCTAzE/hLZts=
X-Google-Smtp-Source: ABdhPJxmdLhj0c/I/e6nCS/GkX9N03ZFRIjfJxIDkT8JXKbvvnm424ImsRXPevmDiHhJhXEiXih0lG99CTDFI8Na8CQ=
X-Received: by 2002:aa7:d4c1:: with SMTP id t1mr20176260edr.253.1595836719999;
 Mon, 27 Jul 2020 00:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-3-martin.botka1@gmail.com> <CAHp75VdJ14p+_+XqxrgRrjXF7m6L4nGr5vB03NTM=0xjgw4c7Q@mail.gmail.com>
 <CADQ2G_HkiAZx8OhfQ_jeizveMaB-QN9dfN6Tcwfk9XuF97rmOg@mail.gmail.com>
 <CADQ2G_HYTE6cd=PM2JzCTadkPe2DDb8dxObPdPJtz1626ktE9Q@mail.gmail.com> <20200727075243.cjkxblsivgnn6jsk@pengutronix.de>
In-Reply-To: <20200727075243.cjkxblsivgnn6jsk@pengutronix.de>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Mon, 27 Jul 2020 09:58:01 +0200
Message-ID: <CADQ2G_GcYh13CGbApCqvi3xcHU-Ur2ej98VccKFOUSOZPrQZnQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] pwm: core: Add option to config PWM duty/period
 with u64 data length
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

> I hit "reply-to-all" and the mail only was sent to you because you wrote
> to only me.

Yes my reply was only to you. But your original message was sent only to me too.
So when i clicked reply to all it was only you as you sent it only to me.

> Also threading is somehow strange because your reply to my mail

Yes Gmail would not allow me to reply to your message and also send it
to everyone so i had to reply to Andy's email which is why the
threading is broken there. Sorry for that.

> So I assume all the strange things happened on your side until proved
> otherwise. :-)

I think i just proved otherwise :)

Best Regards,
Martin

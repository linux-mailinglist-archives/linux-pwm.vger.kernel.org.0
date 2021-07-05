Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9503BC3EF
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Jul 2021 00:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhGEWig (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Jul 2021 18:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhGEWig (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Jul 2021 18:38:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70867C061574
        for <linux-pwm@vger.kernel.org>; Mon,  5 Jul 2021 15:35:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p24so26478442ljj.1
        for <linux-pwm@vger.kernel.org>; Mon, 05 Jul 2021 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xUECkDf/a8o/vs9ygXMuRL9WWFvv6vtOhCiPTdPHGU0=;
        b=Np4IcvF3otxnjj556tFyCBxuH5eQpDBAY9JVCYu3zJrWUz4uI3Nup2m08z8khBFAgK
         YdJezYVLqKh6pkX155VpumFa4yDqnNTGWgfnx3ivCMnAhz5j8qc+UU0XESpR4nNxh/p8
         JTVeqt1ZIXKHcKxtua8+W3W8UE+MxKiLeYhmSgbaToST5Dpohgwz17Hjse4ItdD4yjbb
         YYdFlXsa4FOpn0PNtnYF8+6Dv10duJIG4GuUOjpCbDTZFCq4VYI6nLL0K+jwf1VHeC/n
         We75odtaKS4zKYHzrkHpi7+Kxk/oTipzRDDdVaJH6X63VPmc0lHxGrS0kb+3Sp0VeKW+
         L4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xUECkDf/a8o/vs9ygXMuRL9WWFvv6vtOhCiPTdPHGU0=;
        b=Auk0vZqJY5gQANaHEn2QSITCXuSUbCDvq4EPekes4MroTs/gT7l+3WfojXT2hyhSsC
         7jtmHcxRo2Li2QvwA2ZUtIbgyHR11w/SYYxZBte4q3i5X3OQLUt2Lp1fZZErCE37L99Q
         +MOms7gIo93ezx3VTxeBJRDWEO0W/O6euYKTeW1h1l6DiZ7fbL2IaXQS9ap+LNUlcUR+
         LY9pR19UX0OjHptas09gz50spvN9TAGwthizBz0xwDEfXTPy0jAe1AZWOgD+BYDXIUmD
         EJd9LVjvkLhdxQTO+E77MwUET6w7n2OmkAxL4VgW5m/N/M9UuiVYe2gFKn+oRUXkUr5s
         QJVQ==
X-Gm-Message-State: AOAM531kq9I/XD6Pj/+3ohUG0elxVcAON4ky7OfiOUckaDlShNmQSCJW
        NEeW+0GFFwOc73Pgx6KCiBU4XZvMP7hLOUAqi9ypLA==
X-Google-Smtp-Source: ABdhPJwvyyrAmKxL5ccSom0cQDAHjehbsnGUdUQ4M3scn0KqhI6P8eM426mAP4jDU4CYi/uBtqC1V2vzAIjgZgmkSL8=
X-Received: by 2002:a2e:888f:: with SMTP id k15mr4840907lji.368.1625524555806;
 Mon, 05 Jul 2021 15:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210705165510.443580-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210705165510.443580-1-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Jul 2021 00:35:45 +0200
Message-ID: <CACRpkdYz2aUZKSrMSzcAK2o1JJSXUFgHdYhVWdtKHt1N6_-rZg@mail.gmail.com>
Subject: Re: [PATCH] pwm: ab8500: Fix register offset calculation to not
 depend on probe order
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arun Murthy <arun.murthy@stericsson.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pwm@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 5, 2021 at 6:55 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> The assumption that lead to commit 5e5da1e9fbee ("pwm: ab8500:
> Explicitly allocate pwm chip base dynamically") was wrong: The
> pwm-ab8500 devices are not directly instantiated from device tree, but
> from the ab8500 mfd driver. So the pdev->id isn't -1, but a number
> between 1 and 3. Now that pwmchip ids are always allocated dynamically,
> this cannot easily be reverted.
>
> Introduce a new member in the driver data struct that tracks the
> hardware id and use this to calculate the register offset.
>
> Side-note: Using chip->base to calculate the offset was never robust
> because if there was already a PWM with id 1 at the time ab8500-pwm.1
> was probed, the associated pwmchip would get assigned chip->base =3D 2 (o=
r
> something bigger).
>
> Fixes: 5e5da1e9fbee ("pwm: ab8500: Explicitly allocate pwm chip base dyna=
mically")
> Fixes: 6173f8f4ed9c ("pwm: Move AB8500 PWM driver to PWM framework")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

This looks good to me so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

It seems we may have a vibrator motor connected to this on one
of our reference designs, so I am trying to figure out if I can test
this properly.

Yours,
Linus Walleij

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3660F338A67
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 11:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhCLKlp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 05:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbhCLKla (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Mar 2021 05:41:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12F7C061574
        for <linux-pwm@vger.kernel.org>; Fri, 12 Mar 2021 02:41:29 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g25so3496956wmh.0
        for <linux-pwm@vger.kernel.org>; Fri, 12 Mar 2021 02:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+gXo8IhvV19zxxTo+ZvjWxKQs290uFHYLxm7t4YCZME=;
        b=Pi0qFID++gpWxIB4A33jz9wllnikXC2zG6qCInezMfEbq6UtK9SaGnp9U2Q0j49Wxb
         IaqwRgyM06p356jWimSHgZhhngb6zBE8IRzKDbKjMeGhqIo3jugeEEVSJKBNjIQ0FgKj
         FeZ8nR+slHTR/ID5mYBh8cX0pzq/srdhJXQ52rW7EjZhtTVLBMbiXWfD7r+pACmRthb3
         pZODCvVpuA4XcgFB9VvGm+AupS/D2veJA49Hj6HElsJlDIVHsTqq+iZh2AZSP5nRDmkA
         TKms1Iyz5HQ8urEJpd5lmzHvN8qMkYRFiSR6Pxi/tHgYj+iz6EQixnHnH7NBKvi8B5iv
         V+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+gXo8IhvV19zxxTo+ZvjWxKQs290uFHYLxm7t4YCZME=;
        b=EiEn1ouMXzuemqUPo7wBaSOl5WI2yCARRN/kLDRoKKReQqlZQKpGI4J+2+pGIuwE0l
         tD+HwPPusYio6gqhWN2+4sR6RYkHDL0Hz61puhYvhClAoWGWi001elZib9lKNCRMmXTt
         JhbbAPdtgHGJ5uCNJVY2a5oIRwuyJHrwZGdx0FlaDO3tuvFUH3AZC4v+S4zEeJ1JyTZN
         /aO2SoJyxrFl41OKWz0t7FMcSkHyjrXdfYB5JLt/8AYO26X/iani4L6NOVZ4zmn/JreL
         jOVvJMnSPaXUQPrwkxWidAxTDk/uUJfIkIhbqOdehFD0QDucSf/uAMF4HfokNxBiAJ+4
         2/kQ==
X-Gm-Message-State: AOAM531cP5ikK7acaYIv1pzEgzrNDRbbmy5l8myGkd/ZYdTuxeRAbFOF
        5ayzf6d7kDODhJx2LpwiM6eFmfnOVynIjTcZQtg=
X-Google-Smtp-Source: ABdhPJy/9Eb8dqlSvo+81A5JKICvmLwtQtRRvC2Tus+Rz8pTovn8yyaKdO2iAYe4IHgSrBQHXV4dAWxUJlwdiSKm8aI=
X-Received: by 2002:a1c:7402:: with SMTP id p2mr12103714wmc.43.1615545688495;
 Fri, 12 Mar 2021 02:41:28 -0800 (PST)
MIME-Version: 1.0
References: <20210312085916.386422-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210312085916.386422-1-u.kleine-koenig@pengutronix.de>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 12 Mar 2021 18:40:52 +0800
Message-ID: <CAAfSe-uN-U8OqPErRUWmt8CUHGW+8PVZTZN1UACynozzWFA9Rw@mail.gmail.com>
Subject: Re: [PATCH] pwm: sprd: Refuse requests with unsupported polarity
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-pwm@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 12 Mar 2021 at 16:59, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The driver only supports normal polarity and so should refuse requests
> for inversed polarity.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-sprd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> index 5123d948efd6..bd6087cfb0b2 100644
> --- a/drivers/pwm/pwm-sprd.c
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -164,6 +164,9 @@ static int sprd_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>         struct pwm_state *cstate =3D &pwm->state;
>         int ret;
>
> +       if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +               return -EINVAL;

Should we use EOPNOTSUPP instead?

> +
>         if (state->enabled) {
>                 if (!cstate->enabled) {
>                         /*
>
> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
> --
> 2.30.1
>

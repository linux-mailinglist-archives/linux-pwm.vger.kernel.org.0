Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F975440882
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Oct 2021 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhJ3LXc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Oct 2021 07:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhJ3LXc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Oct 2021 07:23:32 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DD7C061570
        for <linux-pwm@vger.kernel.org>; Sat, 30 Oct 2021 04:21:02 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x9so5753280ilu.6
        for <linux-pwm@vger.kernel.org>; Sat, 30 Oct 2021 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fzrPWdrYK+uGIZVarnBib+gCZxAPn922Wg+8PFfxUYY=;
        b=hV54KDjgIxufXu2nlKaNsKyOfyFdkMFTxuESLgZDLcZGzORWjUCZGPmiV36nrZifXu
         now2fZpFn3iBm2cOniogtpXbg8JKzpgy0sNyFGPQ6DWOfcXOq/DrhNyEai+pq7ci6Q5O
         En4ot6pZd2hSDgERZPTSsFvefeTdLrWRSecqHS4P18dD7AI+1Axvh0gFvmxuLs1V8O2q
         fXkXKIEVepkOWH3Tc97RBf2XeS2FGpWv8TmNjD4h8+4OjVAhgLfnSZL5LuJMCf0Hs7dW
         PdpQGH6h462Xl37NZbF/3BtDMB8v1Qu3SVVdLF7ZunpEVPK/buy3zAJZNkrFx/EX51hx
         9MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fzrPWdrYK+uGIZVarnBib+gCZxAPn922Wg+8PFfxUYY=;
        b=5ku/X0iuAMnV51wFwY3wy41VJNHi1bm1tzVaC3LseciFKxTj7GbtChHDz/h8fSAIfF
         XNns2mtjPmxI/4emYHydx0fuFTuPgpUa0PNZoXI+6yDSzDAjM9U70+QmAUE7xYrR59Yn
         NQoZLCEZ0CWWfdUzTgD4r/KjyTYT33TxQ7YNotS8Ww8nFGGwRXh6BkrotyKnGoWhOVso
         CoqBJfBHpzp4v7zfOGR/R9c8SkxSXWJ9/7KEIx/nza/bXP9eElIP4eSPlkqG4YxLsPw5
         wg6xoIhfKegxBduv44JVdtPQRT3Nx+fO9NUTbBicmz6xRQFZOZ7JGUYPLf34Uw78DqxA
         xXuw==
X-Gm-Message-State: AOAM531FweP/TeF5Ak6KIC1F+L5flfZy1OKewbPr86otvMOVhpis8CUl
        cEFUWDVOOwwaaL2aI5Csn6SQDd3cy5MRo47C7lm+tA==
X-Google-Smtp-Source: ABdhPJw/kzqj41zeqc4IU3MmFJ/HjzaIYIBb1AsGPPQtCFEpf+XRw7egBEmj0MwxE2dp/sHgp6UXzfxES4guaa1wvQw=
X-Received: by 2002:a05:6e02:2187:: with SMTP id j7mr6049830ila.323.1635592861248;
 Sat, 30 Oct 2021 04:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <YXqv339PJTHcGxJg@fedora> <20211029111232.soknq7mu3r65laar@pengutronix.de>
In-Reply-To: <20211029111232.soknq7mu3r65laar@pengutronix.de>
From:   =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Date:   Sat, 30 Oct 2021 08:20:50 -0300
Message-ID: <CAH7FV3md_SBTHu9sTp-hLtLd0ERBdXx8HzM=W9hF79X5V=twQA@mail.gmail.com>
Subject: Re: [PATCH] media: ir-rx51: Switch to atomic PWM API
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sean Young <sean@mess.org>, mchehab@kernel.org,
        thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

> Doing this here introduces a change in behaviour. Better do this after
> pwm_get().

I didn't really get this feedback. Isn't pwm_init_state after pwm_get?
Or should it be before the error treatment of pwm_get?

> Conceptually this last hunk belongs in a separate patch. And you don't
> need to repeat PTR_ERR(pwm), as dev_err_probe already emits this
> information. So
>
>         return dev_err_probe(&dev->dev, PTR_ERR(pwm), "pwm_get failed\n")=
;
>
> should be fine.

Thank you for the suggestion! I will fix it on v2.

Ma=C3=ADra

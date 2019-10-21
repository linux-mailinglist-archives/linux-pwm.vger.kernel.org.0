Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9167FDEF56
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 16:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfJUOVc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 10:21:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41688 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbfJUOVc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 10:21:32 -0400
Received: by mail-io1-f65.google.com with SMTP id r144so4243589iod.8
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M8TxkGCBrZ94ssUK3IwKsn6W2BiCIxjI5bhMjceU0gI=;
        b=T9c2jhWXK6mZYPBhDM6huYQxzS8aHgSEVoxEsRNawnbs534jhuD61wf+KpdbjDeQaF
         WQMw6z8EhXHQ/nJq+ZDyrPotmtl0ZGSfTeqcqIvdtuj6sPANihZqAdu2jX8yDaPbLse0
         cuD2E2JEy19BYgHCrj3gaNEmumE6gpOgy0j8kUpEHPRQXVDEiDWBxrTUyWoVxNSzQi9s
         r+CRkjkLM6nzOTc3+KofBZ1Ri+G7962krucMbuXoVOH7qWSlZEt4N3TzxhCsp3YjwG45
         +RQhiP9ZrNxiq0BQngZPXDVIj5iNpXGImzyPaWCSx+y1H/zfO9x5Nhm8hZwI+Wc3e/D3
         Tfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M8TxkGCBrZ94ssUK3IwKsn6W2BiCIxjI5bhMjceU0gI=;
        b=kKtjO7WZqG0p6Uua7jf6DQ4tTdNf3C46ov8siz0CPUk/ymsCGnqteBh5FFgOQ6vwSU
         U574Sq4FVwy4vKGuC3sn901JZDuvcgbZERtPZs3cwnUfvitYzpXH+7ihWg0/ovGbqJhj
         4fXjBDf/QRAiIpGoJ0g1N3CfwPWBrn2wiWdicMZMfm7qPxgwE+l+yVumaxKh0H0z7InQ
         2FFfRXK0VE4ksSO/2tjTT6pz0JRnCZMQ/561VWSbAXGIkv8yAv0Qpx6HbZgMgFAdBblw
         YmmguXypzZIdtd/eQO94sM30EDadSGIu88DoZyUwxgJzqLefoIFJsTOssXeBw4C5gwk9
         M2PA==
X-Gm-Message-State: APjAAAXHTyqO07ODbNpoe/8wcx2WQ1eTedekjdcM3iyOaYl+cpfs9oF0
        55GRiv7zB+AB3dNZNd5AbVCeomt0uXakeyBpmS8=
X-Google-Smtp-Source: APXvYqz5Mx6/WkrQqa0gTOBRitwMXbg1/9vr8nYmRsE2+o0ATCijIc83vcUju5TmxbjP+4O/1rtoBg3xdRmGTYG08qc=
X-Received: by 2002:a5e:9245:: with SMTP id z5mr17596735iop.205.1571667691319;
 Mon, 21 Oct 2019 07:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
 <20191021105739.1357629-3-thierry.reding@gmail.com> <5e6c86a1-932c-77ce-3501-f03d03e4c963@ysoft.com>
In-Reply-To: <5e6c86a1-932c-77ce-3501-f03d03e4c963@ysoft.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 21 Oct 2019 09:21:19 -0500
Message-ID: <CAHCN7xKrGwWcdP79YbS924ACi6Sggds7J31i7HiE5rNHMkbt0w@mail.gmail.com>
Subject: Re: [PATCH 3/4] pwm: imx27: Cache duty cycle register value
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Oct 21, 2019 at 8:46 AM Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.=
com> wrote:
>
> +Adam
>
> On 21. 10. 19 12:57, Thierry Reding wrote:
> > The hardware register containing the duty cycle value cannot be accesse=
d
> > when the PWM is disabled. This causes the ->get_state() callback to rea=
d
> > back a duty cycle value of 0, which can confuse consumer drivers.
>
> Me and Adam Ford already tested the patches [3/4] and [4/4] and gave ours
> Tested-by tags in the previous thread but do not see those here.
> I re-tested these again and have no issues.
>
> Tested-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>

Tested-by: Adam Ford <aford173@gmail.com>

>
> Thank you Thierry,
> Michal
>
>
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >   drivers/pwm/pwm-imx27.c | 31 ++++++++++++++++++++++++-------
> >   1 file changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index ae11d8577f18..4113d5cd4c62 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -85,6 +85,13 @@ struct pwm_imx27_chip {
> >       struct clk      *clk_per;
> >       void __iomem    *mmio_base;
> >       struct pwm_chip chip;
> > +
> > +     /*
> > +      * The driver cannot read the current duty cycle from the hardwar=
e if
> > +      * the hardware is disabled. Cache the last programmed duty cycle
> > +      * value to return in that case.
> > +      */
> > +     unsigned int duty_cycle;
> >   };
> >
> >   #define to_pwm_imx27_chip(chip)     container_of(chip, struct pwm_imx=
27_chip, chip)
> > @@ -155,14 +162,17 @@ static void pwm_imx27_get_state(struct pwm_chip *=
chip,
> >       tmp =3D NSEC_PER_SEC * (u64)(period + 2);
> >       state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
> >
> > -     /* PWMSAR can be read only if PWM is enabled */
> > -     if (state->enabled) {
> > +     /*
> > +      * PWMSAR can be read only if PWM is enabled. If the PWM is disab=
led,
> > +      * use the cached value.
> > +      */
> > +     if (state->enabled)
> >               val =3D readl(imx->mmio_base + MX3_PWMSAR);
> > -             tmp =3D NSEC_PER_SEC * (u64)(val);
> > -             state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk)=
;
> > -     } else {
> > -             state->duty_cycle =3D 0;
> > -     }
> > +     else
> > +             val =3D imx->duty_cycle;
> > +
> > +     tmp =3D NSEC_PER_SEC * (u64)(val);
> > +     state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
> >
> >       if (!state->enabled)
> >               pwm_imx27_clk_disable_unprepare(chip);
> > @@ -261,6 +271,13 @@ static int pwm_imx27_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >               writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> >               writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> >
> > +             /*
> > +              * Store the duty cycle for future reference in cases whe=
re
> > +              * the MX3_PWMSAR register can't be read (i.e. when the P=
WM
> > +              * is disabled).
> > +              */
> > +             imx->duty_cycle =3D duty_cycles;
> > +
> >               cr =3D MX3_PWMCR_PRESCALER_SET(prescale) |
> >                    MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITE=
N |
> >                    FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HI=
GH) |
> >
>

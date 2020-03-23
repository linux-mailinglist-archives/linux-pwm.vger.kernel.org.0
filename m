Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0839E18F165
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 10:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgCWJFl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 05:05:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40846 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgCWJFl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 05:05:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so13604297ljj.7
        for <linux-pwm@vger.kernel.org>; Mon, 23 Mar 2020 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UeQUAcdMZxn26RtbUmldtq49KvGfHbMzwTxg6ahzu8Q=;
        b=gj67rIhc9xmtkaXHqF2aKuKpPzYsq6nRprfC6gX/IIfe2bFxncqRx4LENZfh1WRp3Q
         OD6IItiqpkArFZmgK3PCQKt0vuhkduXH9aRT1J30TeWACtsHmjVjB+jefTtkmyXe/svS
         IUOwswoEXf+4gP8/NR1KJqeG6PZs1vnX1Q6KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UeQUAcdMZxn26RtbUmldtq49KvGfHbMzwTxg6ahzu8Q=;
        b=jv8LRKlOuClgoa1HtGjfYTCCSIAVyY7v/WEpi/G41p9gJGmDKk601JZixDkOt++F3Y
         S125mw9OtzL9BGlxmzc4+lg0Olx7DpR8Ks2ibZZk/Hx4xpUDGX19S8Sd2dc7RllkjUZS
         PcZurwRBIbjpsTHG9soseUZdNGL7M7M2cfDdugxm59tyc+HOpUVRtNEJOg2XDJFBg/8H
         2RagXNWEVI7eoDdrQ3jGC+cEcKiEhAr/p+8ezieumOGvwFrHvMFjGw9/3Mc3s9y6Ek6H
         +4Y4lM9tC/DduTcd5sWBhip8Vv/r5oJXstNjjfp+JyqjEvk8Cnp8PZ71WR3uzbxq5Vdi
         KX6A==
X-Gm-Message-State: ANhLgQ0cqgvv1waNwoKpy1jKGanh1bRQoSj5kD4C3bC3SIxkfIF0r6io
        +tb6rxzVEwlU25G0tTReGOJ4lEdkSPreP2zRnR8Pxw==
X-Google-Smtp-Source: ADFU+vsThDf7qqsHDVU9kt7C92bwqzK+m2HTPz3VsgWRN3a2xVl/c7U7hQNsOxfPHdo8nHSIOPur05m8x4B3/bbbdgs=
X-Received: by 2002:a2e:a483:: with SMTP id h3mr8739201lji.264.1584954338871;
 Mon, 23 Mar 2020 02:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
 <20200323065318.16533-2-rayagonda.kokatanur@broadcom.com> <20200323082540.2gvbbxtwadvzeeos@pengutronix.de>
In-Reply-To: <20200323082540.2gvbbxtwadvzeeos@pengutronix.de>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Mon, 23 Mar 2020 14:35:27 +0530
Message-ID: <CAHO=5PFBcgmnpA8D6prEo4WCu235Mr9jh8=_Y6pdM8R9=ShfXw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pwm: bcm-iproc: handle clk_get_rate() return
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 23, 2020 at 1:55 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Mar 23, 2020 at 12:23:17PM +0530, Rayagonda Kokatanur wrote:
> > Handle clk_get_rate() returning <=3D 0 condition to avoid
> > possible division by zero.
>
> Was this noticed during a review and is more theoretic. Or does this
> (depending on pre-boot state) result in a kernel crash?

This is reported by internal coverity tool.
>
> > Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controlle=
r")
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > ---
> >  drivers/pwm/pwm-bcm-iproc.c | 32 +++++++++++++++++++-------------
> >  1 file changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> > index 1f829edd8ee7..8bbd2a04fead 100644
> > --- a/drivers/pwm/pwm-bcm-iproc.c
> > +++ b/drivers/pwm/pwm-bcm-iproc.c
> > @@ -99,19 +99,25 @@ static void iproc_pwmc_get_state(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> >       else
> >               state->polarity =3D PWM_POLARITY_INVERSED;
> >
> > -     value =3D readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
> > -     prescale =3D value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
> > -     prescale &=3D IPROC_PWM_PRESCALE_MAX;
> > -
> > -     multi =3D NSEC_PER_SEC * (prescale + 1);
> > -
> > -     value =3D readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
> > -     tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > -     state->period =3D div64_u64(tmp, rate);
> > -
> > -     value =3D readl(ip->base + IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm=
));
> > -     tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > -     state->duty_cycle =3D div64_u64(tmp, rate);
> > +     if (rate =3D=3D 0) {
> > +             state->period =3D 0;
> > +             state->duty_cycle =3D 0;
> > +     } else {
> > +             value =3D readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
> > +             prescale =3D value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm=
);
> > +             prescale &=3D IPROC_PWM_PRESCALE_MAX;
> > +
> > +             multi =3D NSEC_PER_SEC * (prescale + 1);
> > +
> > +             value =3D readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->h=
wpwm));
> > +             tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > +             state->period =3D div64_u64(tmp, rate);
> > +
> > +             value =3D readl(ip->base +
> > +                           IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
> > +             tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > +             state->duty_cycle =3D div64_u64(tmp, rate);
> > +     }
>
> The change looks fine.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

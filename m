Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D88138D92
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2020 10:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgAMJTL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Jan 2020 04:19:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35767 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMJTL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jan 2020 04:19:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so8738522wmb.0
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2020 01:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WJisxQZ9O/eYcnMNZ0LMJL5vPrbZS+2bKF2olTYPt1k=;
        b=n4gWeM3p4mDYR3LkoODxn8AxHyDBZkaiuwfYhZxBdPHJ6oN+QtUE3Uev5YQpV7TIGe
         HCFI8e9MTA3OMOOp2Dgw7N8SPI7JJUxI8x2cRcfjPY+6whkUYOYd666RGG5r00ha5Gde
         qOGGYkUJs3M8aPaEvchh+oPb7XunnqDVP2/HpB4gqAZQJkwYu5DUYyZF0J0sUAy77b1P
         1xZsS+vMiXd/9Tx71Qn8SPfGIDppGwoJ0pi8xdl0A90qM+8KLIHoew57LWypv9LHC83r
         96IobpfXlTwHIj3xUqBiZ93l9FwJYsLt/daiomUm5oNmfW8MJ32ZvT6lhZSlwyFG8uFn
         d+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WJisxQZ9O/eYcnMNZ0LMJL5vPrbZS+2bKF2olTYPt1k=;
        b=L5p4wfZ21/7hXK+U+/oqiKXoX+SfPMlgvFmhcIBdZBMuUvAMTwtJHd/0UlepduJ0DX
         BORGGXETXHIv6Q3CRhcGo4nSEosAhfsENyXzDPjarB5FbzztUlJTYinA2EgdNQtH7jZB
         +CVIIiwdrwFE7ovo8ymOhenhZbmx+nMMSXSBJ503rTI5mALJnwEag+RPpUB0LD+gIUzb
         SN/aMtO5Teq8qkqTffispk3RTDGihHEQIqddCXUdO8dll9CzXdHZS4Fau13Mugw/V4Nb
         fI1g590xBoHmgC28RhsAi1O9up2cxokdl2vU8Zsq/G+1Vs7epxX8sSqOBUETrglbd/52
         vf2g==
X-Gm-Message-State: APjAAAUwfdaSfGPGkxyPY7WNKUQ1CyUtRIsgqSQXctdTAeyJwMJrh1FS
        ZxUu1DHPdOkzyDscBC/xCWbzQa6abjr36m58CXyEmPC5
X-Google-Smtp-Source: APXvYqwAKgNbTXHlSquoXeaUKmNOGfTg9InaoBkHHSaAN8TN4L00GpyO126rvjYMIXzAMXayoaGeYzDMEgixJXqD8Yg=
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr18970172wmj.130.1578907149178;
 Mon, 13 Jan 2020 01:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20200109233106.17060-1-peron.clem@gmail.com> <CAGfOxi2vUVLv1_PGynu_53=DvuMBKFE6UTFUoTPTqjW1VvotLg@mail.gmail.com>
In-Reply-To: <CAGfOxi2vUVLv1_PGynu_53=DvuMBKFE6UTFUoTPTqjW1VvotLg@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 13 Jan 2020 10:18:58 +0100
Message-ID: <CAJiuCcc3nSKGseDdWCEm4qtQj1HzbU95dFeJGxVgWEBZAynBXw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] pwm: sun4i: Move pwm_calculate out of spin_lock
To:     Alexander <alex.mobigo@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, 13 Jan 2020 at 01:40, Alexander <alex.mobigo@gmail.com> wrote:
>
> On Thu, Jan 9, 2020 at 8:31 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.=
com> wrote:
> >
> > pwm_calculate calls clk_get_rate while holding a spin_lock.
> >
> > This create an issue as clk_get_rate() may sleep.
> >
> > Move pwm_calculate out of this spin_lock.
> >
> > Fixes: c32c5c50d4fe ("pwm: sun4i: Switch to atomic PWM")
> > Reported-by: Alex Mobigo <alex.mobigo@gmail.com>
> > Suggested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >
> > Hi,
> >
> > this issue has been reported on linux-sunxi Google groups.
> >
> > I don't have a board with PWM to confirm it.
> >
> > Please wait a tested-by.
> >
> > Thanks,
> > Cl=C3=A9ment
> >
> >  drivers/pwm/pwm-sun4i.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 1afd41ebd3fd..6b230029dc49 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -248,19 +248,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> >                 }
> >         }
> >
> > -       spin_lock(&sun4i_pwm->ctrl_lock);
> > -       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > -
> >         ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &=
prescaler,
> >                                   &bypass);
> >         if (ret) {
> >                 dev_err(chip->dev, "period exceeds the maximum value\n"=
);
> > -               spin_unlock(&sun4i_pwm->ctrl_lock);
> >                 if (!cstate.enabled)
> >                         clk_disable_unprepare(sun4i_pwm->clk);
> >                 return ret;
> >         }
> >
> > +       spin_lock(&sun4i_pwm->ctrl_lock);
> > +       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > +
> >         if (sun4i_pwm->data->has_direct_mod_clk_output) {
> >                 if (bypass) {
> >                         ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > --
> > 2.20.1
> >
> """""""""""""""""
> Tested on my board Pine64+, problems occurs before the patch but not afte=
r...
>
> Tested-By: Alexander Finger <alex.mobigo@gmail.com>

Thanks, I will send a v2 with your proper name for the Reported-by tag

Regards,
Clement

> """""""""""""""

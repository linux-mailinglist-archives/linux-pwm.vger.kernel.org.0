Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5203138919
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2020 01:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbgAMAkI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Jan 2020 19:40:08 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34766 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387514AbgAMAkH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Jan 2020 19:40:07 -0500
Received: by mail-yw1-f66.google.com with SMTP id b186so4875947ywc.1
        for <linux-pwm@vger.kernel.org>; Sun, 12 Jan 2020 16:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WabAjrSzUiDu1CmRicqBS8U4GR3RBwbP81ffSSwow40=;
        b=TxCHv299Sm/bUuj7k4G7GGjq1ij84ttb4AuTnFcQARVQNaRYF90Tl0u1u3ATclzN5K
         dAYqoyCa7oU29h8vU1DoAhdLCKaMjfEYFeroQoJXHyEtCDXs0kp7NfsjuLNtzGpJJ98u
         T3wVlbApYXRT81QRLd6inrLOe+QsQUTQsiUfgjFeDAayGP55r1Qxf+H/WP0ibEMwQjTk
         5pqmgqwylH9xQf75VHWALMr+fpUgKfMm0YS7yDQXEiwO0v0SVcF0scRM0ZFGxAz1VxAe
         O8UH+CW/ExT6XcPeMpQJL3BlOEshz6gyDL3cbDiK8BkOxONtFNenvt/tf2opzKpDGr9I
         tvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WabAjrSzUiDu1CmRicqBS8U4GR3RBwbP81ffSSwow40=;
        b=jWoixU4SxAAZkO/58diFe+0xLyX19LgMlh7FvycZWUtVj0VyU3BOX18wbXjL2uhk8P
         Nf+Vjahqmor7fqmH2geHm6eRmlW6yCJj6dPyJ66TgrG/TvwiTp8U8DG3+EIFCGa6BGap
         cB0OAx7ztaAF6Q5wyZ6zomAlYhHDxIWfzt2TaWzHJiSEyIqu5gcX414plPksITc7jOcf
         sZQlXPeV3jsnOvAzey35F36yaGmFasBaaxaOdTN7YpOlwvmifHa5xWQWRY2/rPmwMRJd
         1YPnhnRB1XGZ5pJFXb1xIZedyqhcAlAtKvIVwjT2tkvRdVlwSU2m2wDw1wBWhzlQrUqG
         l0hA==
X-Gm-Message-State: APjAAAUR9WG7ry9A7BRg+6ra9uq92ELIsbPiei3Ouq4az0noRWrYwtn6
        wX2ef7O/qj272sDcQRzbwLgvRDVDkwKw9vUb/L/bqPa2
X-Google-Smtp-Source: APXvYqzYfBnSxhzMeYhjwjq3ePB6rAWQRUB53+XUYzPcHedj1y7f+9B6BBZcaMJ/yGll/TCAjpi9y+TTaR//LaeNFao=
X-Received: by 2002:a25:90b:: with SMTP id 11mr12082242ybj.0.1578876006988;
 Sun, 12 Jan 2020 16:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20200109233106.17060-1-peron.clem@gmail.com>
In-Reply-To: <20200109233106.17060-1-peron.clem@gmail.com>
From:   Alexander <alex.mobigo@gmail.com>
Date:   Sun, 12 Jan 2020 21:39:55 -0300
Message-ID: <CAGfOxi2vUVLv1_PGynu_53=DvuMBKFE6UTFUoTPTqjW1VvotLg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] pwm: sun4i: Move pwm_calculate out of spin_lock
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vasily Khoruzhick <anarsoul@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jan 9, 2020 at 8:31 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.co=
m> wrote:
>
> pwm_calculate calls clk_get_rate while holding a spin_lock.
>
> This create an issue as clk_get_rate() may sleep.
>
> Move pwm_calculate out of this spin_lock.
>
> Fixes: c32c5c50d4fe ("pwm: sun4i: Switch to atomic PWM")
> Reported-by: Alex Mobigo <alex.mobigo@gmail.com>
> Suggested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>
> Hi,
>
> this issue has been reported on linux-sunxi Google groups.
>
> I don't have a board with PWM to confirm it.
>
> Please wait a tested-by.
>
> Thanks,
> Cl=C3=A9ment
>
>  drivers/pwm/pwm-sun4i.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 1afd41ebd3fd..6b230029dc49 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -248,19 +248,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>                 }
>         }
>
> -       spin_lock(&sun4i_pwm->ctrl_lock);
> -       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> -
>         ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &pr=
escaler,
>                                   &bypass);
>         if (ret) {
>                 dev_err(chip->dev, "period exceeds the maximum value\n");
> -               spin_unlock(&sun4i_pwm->ctrl_lock);
>                 if (!cstate.enabled)
>                         clk_disable_unprepare(sun4i_pwm->clk);
>                 return ret;
>         }
>
> +       spin_lock(&sun4i_pwm->ctrl_lock);
> +       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> +
>         if (sun4i_pwm->data->has_direct_mod_clk_output) {
>                 if (bypass) {
>                         ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> --
> 2.20.1
>
"""""""""""""""""
Tested on my board Pine64+, problems occurs before the patch but not after.=
..

Tested-By: Alexander Finger <alex.mobigo@gmail.com>
"""""""""""""""

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD8913555B
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2020 10:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgAIJOO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jan 2020 04:14:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38046 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgAIJOO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jan 2020 04:14:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so1945887wmc.3;
        Thu, 09 Jan 2020 01:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q4yS4IGenv3/gEDlUctN0Q4HaJsYtWMJsBPlv/baTQU=;
        b=TX/GkSfEBRFP1nnhEGSi1wG0knrm+FxWatwSTMUMCvy+sv3/OvCCdKYr514Rd4b26n
         bc3lSc93r52GhiMh5kA99zMZUkeAEzfDY8/rjSjX5k5zK6pMiECY/p8KP/Yd2TMC3Gs1
         +omuXnbsBSgCiiKB7yConsjrX5IVZCb85IQnavHVnJ832Z+fLBAHBSSEl3dyCKyiCT2A
         dc8XLcEyp6PFwH+NxnXYFstx5gn79ZyDu9ckL96qgdY+xxVFmztKeaqI5szIxrbAOWvg
         zVtqTHdPLi3pCW+UI39ml4oiAkgfOhqIooRm4oXpndCyXskqYHyneztO3bYD0iYQSKod
         76PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q4yS4IGenv3/gEDlUctN0Q4HaJsYtWMJsBPlv/baTQU=;
        b=JI1f7EQWp1knWCU/ECB5cQn76e4Xjvbm9TQs3Ujzw/A6N66+YXgov6A3FNHnafP61o
         8kK50YUIrTwDSuvYnX+gynUf7PgVGTB2B40W35+1XIflCtW3LQQe5UakVBsdj70wF/gN
         ksevCdFZB9zsmVpVKW+wdxE8K5s6+M/WgvJ94sg+MQKle2dGC/bg9t+ns0l99XZlobHw
         McYG2znoc+SSy4iDZPDidjJIgPJHgF+TVFT6+RtcQJ9w1vJtG4DavluYM6l5/zIknCmR
         VwUiokbPHoYmMw2q8ZPd3dVSX3FSWW+qpIrbLI6fJuncvSXDq7wtbMDT2G80lyUShTEP
         l34Q==
X-Gm-Message-State: APjAAAXp1GjsHN2cJlCp1gR/qkH1nMyGqFKmKk/JZqkWcHXX+wpqBv0c
        CD1lAj/SAlKdHdZ1OwtbSBBmnfVHk5v+WzHm63E=
X-Google-Smtp-Source: APXvYqw1Dr8ZnFhNDYyE8/xD6l0tv796f3qQo2kP+dYqYva7kvb44dgGurdSMGFOvo08reMnzvFpWtQqUZta7f406XM=
X-Received: by 2002:a1c:44d:: with SMTP id 74mr3638479wme.53.1578561252011;
 Thu, 09 Jan 2020 01:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20200109072735.GA22886@embeddedor> <20200109074445.73n3vapjl4vfjtsu@pengutronix.de>
In-Reply-To: <20200109074445.73n3vapjl4vfjtsu@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 9 Jan 2020 10:14:00 +0100
Message-ID: <CAJiuCcdFiXVtECtVGz3N9oUM38ca=MDmdK4+T+peUKKzNr_5KQ@mail.gmail.com>
Subject: Re: [PATCH] pwm: sun4i: Fix inconsistent IS_ERR and PTR_ERR
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe, Gustavo,

On Thu, 9 Jan 2020 at 08:44, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Gustavo,
>
> On Thu, Jan 09, 2020 at 01:27:35AM -0600, Gustavo A. R. Silva wrote:
> > Fix inconsistent IS_ERR and PTR_ERR in sun4i_pwm_probe().
> >
> > The proper pointers to be passed as arguments are pwm->clk and pwm->bus=
_clk.

Thanks for the catch.

As these patches are still in next should we update them or apply a fix ?

Regards,
Clement

> >
> > This bug was detected with the help of Coccinelle.
> >
> > Fixes: b8d74644f34a ("pwm: sun4i: Prefer "mod" clock to unnamed")
> > Fixes: 5b090b430d75 ("pwm: sun4i: Add an optional probe for bus clock")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 1afd41ebd3fd..a805c347ee84 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -423,7 +423,7 @@ static int sun4i_pwm_probe(struct platform_device *=
pdev)
> >        */
> >       pwm->clk =3D devm_clk_get_optional(&pdev->dev, "mod");
> >       if (IS_ERR(pwm->clk)) {
> > -             if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +             if (PTR_ERR(pwm->clk) !=3D -EPROBE_DEFER)
>
> How embarrassing that I didn't notice these. Thanks for catching.
>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

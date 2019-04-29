Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB3C1E9AD
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Apr 2019 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfD2SEk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Apr 2019 14:04:40 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34328 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2SEk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Apr 2019 14:04:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id n17so6467442vsr.1
        for <linux-pwm@vger.kernel.org>; Mon, 29 Apr 2019 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+9QVRcGn/MFPa3DTAgauHJb15LdY1O4WQocTfoHxH9I=;
        b=O5OWxqT0Mf66qPTnLp0thOnby1i3TVz2gYj3yoMCnRdjSPGncE7+uXsKJCeBLbegTM
         MszISVuqi5lCv5Pzt8bMCCQTsXrt0Hs768nn2/DI6/aTtBPmsemDBB3zaN1ex7dixTJp
         aij+cyi/8aBTQEnC+8Wp77GODHPiaF9gd7hyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+9QVRcGn/MFPa3DTAgauHJb15LdY1O4WQocTfoHxH9I=;
        b=azhjTsJuGSvzbNn5+NJF1du8dQBzh4IAD2lytcdSK0b+4WCbcSnLE4L8KuXtlHGktR
         sh+gyvMLSgyhIwVLppuQyMpFfd+4CJqdoRJs1EcCPCT/7SCw3UnTF28J8CpBBJqfUc6y
         fhNSw2LQkKS9Q7Euju6mejGbGUa1+1zeTOK7aefkm726z/862wLyNRHNUfI5ZYEMDAGw
         +U/vrfKPBahHHhakUKqFEAsdH8GGIVC09epibT5TbSrZU83yCr/3zVdh8OsLtCY3EAr3
         eXez9kGkivrg6qugjVqFjw8GZvi9lUF7d5OQfUnmDf5gzIEYq8cWnp2+fBdJN5zry2Vo
         tJZQ==
X-Gm-Message-State: APjAAAX1LIriOBPhIzuOcjDy25xeF/wknmj6lxlNHF3pHtNI72kW2MNp
        u+BJzWjLOF2b0N+ebh9lqG9XF1wgz6c=
X-Google-Smtp-Source: APXvYqw4lEZNXCbHDfNyKF/gFiIAbR0a3OVrzmHrG7Tnmy6Di4puM6rZ46Gfk+/bLeFxDyF4N3k5qA==
X-Received: by 2002:a67:ef83:: with SMTP id r3mr33054081vsp.177.1556561078837;
        Mon, 29 Apr 2019 11:04:38 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 8sm8898017vkw.38.2019.04.29.11.04.32
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 11:04:32 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id e2so6415274vsc.13
        for <linux-pwm@vger.kernel.org>; Mon, 29 Apr 2019 11:04:32 -0700 (PDT)
X-Received: by 2002:a67:bc01:: with SMTP id t1mr33993904vsn.149.1556561072079;
 Mon, 29 Apr 2019 11:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de> <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de> <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
In-Reply-To: <20190429065613.n52uwgys5eugmssd@pengutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Apr 2019 11:04:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
Message-ID: <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Sun, Apr 28, 2019 at 11:56 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Apr 18, 2019 at 05:27:05PM -0700, Brian Norris wrote:
> > Hi,
> >
> > I'm not sure if I'm misreading you, but I thought I'd add here before
> > this expires out of my inbox:
> >
> > On Mon, Apr 8, 2019 at 7:39 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > My intention here is more to make all drivers behave the same way and
> > > because only two drivers updated the pwm_state this was the variant I
> > > removed.
> >
> > To be clear, this patch on its own is probably breaking things. Just
> > because the other drivers don't implement the documented behavior
> > doesn't mean you should break this driver. Maybe the others just
> > aren't used in precise enough scenarios where this matters.
> >
> > > When you say that the caller might actually care about the exact
> > > parameters I fully agree. In this case however the consumer should be
> > > able to know the result before actually applying it. So if you do
> > >
> > >         pwm_apply_state(pwm, { .period =3D 17, .duty_cycle =3D 12, ..=
.})
> > >
> > > and this results in .period =3D 100 and .duty_cycle =3D 0 then probab=
ly the
> > > bad things you want to know about already happend. So my idea is a ne=
w
> > > function pwm_round_state() that does the adaptions to pwm_state witho=
ut
> > > applying it to the hardware. After that pwm_apply_state could do the
> > > following:
> > >
> > >         rstate =3D pwm_round_state(pwm, state)
> > >         pwm.apply(pwm, state)
> > >         gstate =3D pwm_get_state(pwm)
> > >
> > >         if rstate !=3D gstate:
> > >                 warn about problems
> >
> > For our case (we're using this with pwm-regulator), I don't recall [*]
> > we need to be 100% precise about the period, but we do need to be as
> > precise as possible with the duty:period ratio -- so once we get the
> > "feedback" from the underlying PWM driver what the real period will
> > be, we adjust the duty appropriately.
>
> I admit that I didn't understood the whole situation and (some) things
> are worse with my patches applied. I still think that changing the
> caller's state variable is bad design, but of course pwm_get_state
> should return the currently implemented configuration.

Regardless of the pros and cons of the current situation, hopefully
we're in agreement that we shouldn't break existing users?  In general
I'll probably stay out of the debate as long as we end somewhere that
pwm_regulator is able to somehow know the actual state that it
programmed into the hardware.

+Boris too in case he has any comments.


> > So I don't see that "warning" would really help for this particular cas=
e.
> >
> > > But before doing that I think it would be sensible to also fix the ru=
les
> > > how the round_state callback is supposed to round.
> >
> > I'm not quite sure I grok exactly what you're planning, but I would
> > much appreciate if you didn't break things on the way toward fixing
> > them ;)
>
> There are currently no rules how the driver should behave for example if
> the consumer requests
>
>         .duty_cycle =3D 10, .period =3D 50
>
> and the hardware can only implement multiples of 3 for both values. The
> obvious candidates are:
>
>  - .duty_cycle =3D 9, .period =3D 51 (round nearest for both)
>  - .duty_cycle =3D 12, .period =3D 51 (round up)
>  - .duty_cycle =3D 9, .period =3D 48 (round down)
>  - .duty_cycle =3D 9, .period =3D 45 (round duty_cycle and keep proportio=
n)
>  - return error (which code?)
>
> And there are some other variants (e.g. round duty_cycle to nearest and
> period in the same direction) that might be sensible.

I will note that I had to deal with some of this recently when I
wanted to try to replicate the exact voltage levels for "vdd_log" from
downstream in rk3288-veyron devices.  See commit 864c2fee4ee9 ("ARM:
dts: rockchip: Add vdd_logic to rk3288-veyron") in Heiko's tree (or
just look in linux-next)


> Also it should be possible to know the result before actually
> configuring the hardware. Otherwise things might already go wrong
> because the driver implements a setting that is too far from the
> requested configuration.

Later in this thread Thierry didn't like the "round rate" idea due to
races.  One way to solve that could be to indicate to the PWM
framework which direction you'd like it to error in: a higher duty
cycle or a lower one.


-Doug

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625D319A00D
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2020 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgCaUqG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Mar 2020 16:46:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52094 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaUqG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Mar 2020 16:46:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id z7so1404480wmk.1;
        Tue, 31 Mar 2020 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6pGGh8thrIa0GryZbGioyjh/cLiHar/6v6kxCJ7Zax4=;
        b=tp4B9kbTY+DY7WRWdxUebMQhc5iVzxM/nBNMZdJZgSanztCKmkrLkwesVyyFXJD7Y2
         QRzxoTzMgYD2E0zEL7mraezeBGqaQR9TAKQecOqu4rB0F5wf/FlyCLWdj9B8supSralv
         HIYmcun11E3veBznvyUNEq2hDbj29Rzx0sUZANBXDWng+bdbCFdSWpylFyfKktq5oR5k
         oa4ViAaGIVzyJA8aIlae5Fddo6vKhGxU3r8lNgIqqALYg2Sbcjh+lAQ9g12OGZCZQRMA
         HlxyRCLyuw+8yvI4DlvAnOTTf4xPaGO2IQ9H+6q56AnNmSxQRAhTabkGMCCdr2w8LoHB
         LG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pGGh8thrIa0GryZbGioyjh/cLiHar/6v6kxCJ7Zax4=;
        b=AUMZpdxDgyJsdlzkR7RN9nCCng1xbepZ6KAG5AbdqGzfGwuc62oigAtddjKPdc/rlg
         qdLqx2+kWpLDzufQAb8J9xAJGMhkZBiXepX7S9fm/bWyMvk+ephk68W2fNNHPEr15Zi/
         zKfWuHpirlxTPmz+0euuxQ+D1hYqWM8t//AM8ayvsrLShz4fZ4h/lnbg2fvPQHrHIZQ0
         M+fLSJnUe7nlChb2aOMdUBPFjCBIdPKiZ0k3TaCjY/857jd2AIhScMVGbiPM/Pg3W8fd
         +GB7Yh1FJfVsZrGrPnM10YbLRbDmIoWtYis4MovWK6RBwj7Wch0QN/anrcLkvVxyl6Qu
         uzDg==
X-Gm-Message-State: AGi0PuaKfIpiG99ofzdQ+VjOthuWDI8wqMM61ErAu4CkK2ttxWtwuIpn
        xUDAOuX+VLJQLaGj4x483F4=
X-Google-Smtp-Source: APiQypLXxc5GJ5smoVD6fqviuHe2EI83IiRgBkix7kBU2greUpKrR2xVr1FFtcHilgljIJ2tD9hjvQ==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr688282wme.107.1585687562586;
        Tue, 31 Mar 2020 13:46:02 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id x6sm5065715wmi.2.2020.03.31.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:46:00 -0700 (PDT)
Date:   Tue, 31 Mar 2020 22:45:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200331204559.GB2954599@ulmo>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
 <20200330191654.waoocllctanh5nk5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <20200330191654.waoocllctanh5nk5@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 09:16:54PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Mar 30, 2020 at 04:14:36PM +0200, Thierry Reding wrote:
> > On Thu, Mar 12, 2020 at 07:40:42AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
> > > > Only the Timer control register(TCLR) cannot be updated when the ti=
mer
> > > > is running. Registers like Counter register(TCRR), loader register(=
TLDR),
> > > > match register(TMAR) can be updated when the counter is running. Si=
nce
> > > > TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> > > > timer for period/duty_cycle update.
> > >=20
> > > I'm not sure what is sensible here. Stopping the PWM for a short peri=
od
> > > is bad, but maybe emitting a wrong period isn't better. You can howev=
er
> > > optimise it if only one of period or duty_cycle changes.
> > >=20
> > > @Thierry, what is your position here? I tend to say a short stop is
> > > preferable.
> >=20
> > It's not clear to me from the above description how exactly the device
> > behaves, but I suspect that it may latch the values in those registers
> > and only update the actual signal output once a period has finished. I
> > know of a couple of other devices that do that, so it wouldn't be
> > surprising.
> >=20
> > Even if that was not the case, I think this is just the kind of thing
> > that we have to live with. Sometimes it just isn't possible to have all
> > supported devices adhere strictly to an API. So I think the best we can
> > do is have an API that loosely defines what's supposed to happen and
> > make a best effort to implement those semantics. If a device deviates
> > slightly from those expectations, we can always cross fingers and hope
> > that things still work. And it looks like they are.
> >=20
> > So I think if Lokesh and Tony agree that this is the right thing to do
> > and have verified that things still work after this, that's about as
> > good as it's going to get.
>=20
> I'd say this isn't for the platform people to decide. My position here
> is that the PWM drivers should behave as uniform as possible to minimize
> surprises for consumers. And so it's a "PWM decision" that is to be made
> here, not an "omap decision".

I think there's a fine line to be walked here. I agree that we should
aim to have as much consistency between drivers as possible. At the same
time I think we need to be pragmatic. As Lokesh said, the particular use
case here requires this type of on-the-fly adjustment of the PWM period
without stopping and restarting the PWM. It doesn't work otherwise. So
th alternative that you're proposing is to say that we don't support
that use-case, even though it works just fine given this particular
hardware. That's not really an option.

> > I know this is perhaps cheating a little, or turning a blind eye, but I
> > don't know what the alternative would be. Do we want to tell people that
> > a given PWM controller can't be used if it doesn't work according to our
> > expectations? That's hard to argue if that controller works just fine
> > for all known use-cases.
>=20
> I'd like have some official policy here which of the alternatives is the
> preferred cheat.
>=20
> The situation here is that period and duty_cycle cannot be updated
> atomically. So the two options are:
>=20
>  - stop shortly
>  - update with hardware running and maybe emit a broken period

I think we can already support both of those with the existing API. If
a consumer wants to stop the PWM while reconfiguring, they should be
able to do pwm_enable(), pwm_config(), pwm_enable() (or the atomic
equivalent) and for the second case they can just do pwm_config() (or
the atomic equivalent).

Some hardware may actually require the PWM to be disabled before
reconfiguring, so they won't be able to strictly adhere to the second
use-case.

But as discussed above, I don't want to strive for a lowest common
denominator that would preclude some more specific use-cases from
working if the hardware supports it.

So I think we should aim for drivers to implement the semantics as
closely as possible. If the hardware doesn't support some of these
requirements strictly while a particular use-case depends on that, then
that just means that the hardware isn't compatible with that use-case.
Chances are that the system just isn't going to be designed to support
that use-case in the first place if the hardware can't do it.

The sysfs interface is a bit of a special case here because it isn't
possible to know what use-cases people are going to come up with. It's
most likely that they'll try something and if it doesn't work they can
see if a driver patch can improve things. If not, perhaps the hardware
just isn't up to the task and that'll be the end of it.

I haven't yet come across a case where things actually fail because we
are too flexible in what the API permits, so I don't see a need to add
arbitrary restrictions.

> I tend to say "stop shortly" is the better alternative.

That's clearly subjective. In this particular case it's certainly not
the case. If the API had that assumption baked in there'd be no way to
support this use-case, even though hardware evidently supports it.

So I certainly think that there are areas where we need to find common
ground for abstraction, but I think being overly restrictive can make an
API completely useless.

One possible extension that I can imagine would be to introduce some
sort of capability structure that drivers can fill in to describe the
behaviour of the hardware. Drivers like pwm-omap-dmtimer, for example,
could describe that they are able to change the period and/or duty cycle
while the PWM is on. There could be another capability bit that says
that the current period will finish before new settings are applied. Yet
another capability could describe that duty-cycle and period can be
applied atomically. Consumers could then check those capabilities to see
if they match their requirements.

But then again, I think that would just make things overly complicated.
None of the existing consumers need that, so it doesn't seem like there
is much demand for that feature. In practice I suspect most consumers
work fine despite potentially small deviations in how the PWM behaves.

Thierry

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6DrAUACgkQ3SOs138+
s6HeQQ/+NgM/YuaCE72oyuDDrK2bui7Ix20v0pnyIjTlTiNMrI1ExZcTqB7AbiBu
UILX8+0IWjMHZrvB0l7QHQcOeTIyOCVhzSkRSsiPskbXEb+zg+hOuXvSwR483/bI
UcIowFSxFAF+cGoGgGtl+PbrCUNwiD4h9NONzX9NiLAzsxpwDQuMrTlje1JcWlhu
+rOco2QZLGCfiakzxim/sovv1ALF5G2aAYK9bTkrjnY05Ko98/EjMG4vrMHj5Olc
Gj3kKB4Z16hhq44igzLjq3afLAb4JuV8vZQ0aamh0Ob6jvQ8NuDw/b+mAuTbmCZY
qUVAud5gJHCABecxfFav5WXSSF8sKPlh5vpAJvYQ5o/I/s5QNOSpLPdhUSuHOsbE
6cfCWNXXwRDR5xTKlRqEw/pA56ttGlqjPfLvx/nKW99cQKoKY5IjznefWXhqnnXd
Ev6vTfRgtXphJQLcW1EPfAmG1ZOWtUaUlAgn1tGYsQFJRjjAZqyAnKC0JDAye8TJ
ujAS2pDhMQpSn9m62NNW5+kb4+7Yyxdc82NbBgCqBiJFwbB/bV5quk3VepwVfOje
pGJsxHBiSv0JseKwZldEXSjVeeeE8QANAMnWzGIkYniWxd16WfXOPMjBQzqAKXUO
mitq6V6Ax52gh/k5qHuxHmeRrc2Qji6oOfNNeeyjEcBHeCJAoug=
=byzS
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

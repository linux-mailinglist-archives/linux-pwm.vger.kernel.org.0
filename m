Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB96E19B4D4
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Apr 2020 19:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbgDARpp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Apr 2020 13:45:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42930 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732196AbgDARpp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Apr 2020 13:45:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so1080965wrx.9;
        Wed, 01 Apr 2020 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZSJJ+Q+Ziclj/cQkTYnMDfSQOn6JccqOQoTiTuwUPA0=;
        b=Xa66GkYF43a2mE/B83Nl6ayzDJOGxZ31wbe6wehpGBWeJEC8ZWfbz2YYQqFbp3xvcd
         wn8/aAqPnd4eolqnDRl91FDv4IG83zBcgK/GHIJtWQyQUhgxy0FAEztjcWfJIfEsFWyg
         2uMW/DEhsvVeOCC29ljYcRfbOFWXgkMaiVdMOCBvcIn6m/aQcuYuKESiOEbBdbHYnaXD
         xzQQOSGgY1gH+dJDYJhuSwatpH7OrCgEgDYHHmwyiJaXz/5I1YKVDyiYKh7YHhkNaqbO
         fzHSWVoUfc2G81VnwaqBW8PNd3hIkvgOG2R9I50yb6uxiXMrGKJUOQkEDEzLCW0yaYde
         rjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZSJJ+Q+Ziclj/cQkTYnMDfSQOn6JccqOQoTiTuwUPA0=;
        b=OU9FuBPwWjDrmGs9VWHTja7lJmyDiGvpB8qYRpVjE5qPn8qyi8dEG5tE414BE5Ntdi
         rGAkZWIj7mjxSXdBg7xcjqkG+aFVPv6CmSwPdV6oBV7oRp8/pzdCXzz+X/3CgXYKrQt0
         LzWpUnNcwB8asgUqQ8SSODIDjeGLT/6zaR6KrH/vYVjTUJpKCPrBhvmXjkqW16W7Dx+4
         bpDx7aLNJasupBcOZPx2Xf6Nvk5KAexddUKXuGsWgwok+ivdcPIFe3/NRBV7arLmBtWU
         d9uqcuf8OYvPAdN3pczJw4oh9KUOBZXuZcjU6z2OePiGapEhFYas+QVPmKtDTgUurSqE
         4RTw==
X-Gm-Message-State: ANhLgQ1TqrGXmfHD+OyDeuT/MPekqN7/mLo5ma/QS6MMSJ0wVs40AsWX
        64kDHLhhUgAk1wK4j0oYw24=
X-Google-Smtp-Source: ADFU+vvfciUHAzKgUaOaFzvd9hSfxq8cyoaUlhv/CPd5Gi5OAwxSs9/z+p5cQtDk/VVHbF3L3e+oGQ==
X-Received: by 2002:a5d:67cb:: with SMTP id n11mr27318022wrw.104.1585763142726;
        Wed, 01 Apr 2020 10:45:42 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id u22sm3545881wmu.43.2020.04.01.10.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 10:45:41 -0700 (PDT)
Date:   Wed, 1 Apr 2020 19:45:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Van Asbroeck <TheSven73@gmail.com>
Subject: Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Message-ID: <20200401174540.GA2978178@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200330130743.GB2431644@ulmo>
 <CAHp75Vc_=czuRtyqgnmnYfie50gDnzrNqq3Bt+Gp_42MikX6VA@mail.gmail.com>
 <20200330160238.GD2817345@ulmo>
 <20200401163640.GA91358@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20200401163640.GA91358@workstation.tuxnet>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 06:36:40PM +0200, Clemens Gruber wrote:
> On Mon, Mar 30, 2020 at 06:02:38PM +0200, Thierry Reding wrote:
> > On Mon, Mar 30, 2020 at 04:18:22PM +0300, Andy Shevchenko wrote:
> > > On Mon, Mar 30, 2020 at 4:09 PM Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > > >
> > > > On Wed, Feb 26, 2020 at 02:52:26PM +0100, Matthias Schiffer wrote:
> > > > > duty_cycle was only set, never read.
> > > > >
> > > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.c=
om>
> > > > > ---
> > > > >  drivers/pwm/pwm-pca9685.c | 4 ----
> > > > >  1 file changed, 4 deletions(-)
> > > >
> > > > Applied, thanks.
> > >=20
> > > I'm not sure this patch is correct.
> >=20
> > What makes you say that? If you look at the code, the driver sets this
> > field to either 0 or some duty cycle value but ends up never using it.
> > Why would it be wrong to remove that code?
> >=20
> > > We already have broken GPIO in this driver. Do we need more breakage?
> >=20
> > My understanding is that nobody was able to pinpoint exactly when this
> > regressed, or if this only worked by accident to begin with. It sounds
> > like Clemens has a way of testing this driver, so perhaps we can solve
> > that GPIO issue while we're at it.
> >=20
> > The last discussion on this seems to have been around the time when you
> > posted a fix for it:
> >=20
> >     https://patchwork.ozlabs.org/patch/1156012/
> >=20
> > But then Sven had concerns that that also wasn't guaranteed to work:
> >=20
> >     https://lkml.org/lkml/2019/6/2/73
> >=20
> > So I think we could either apply your patch to restore the old behaviour
> > which I assume you tested, so at least it seems to work in practice,
> > even if there's still a potential race that Sven pointed out in the
> > above link.
> >=20
> > I'd prefer something alternative because it's obviously confusing and
> > completely undocumented. Mika had already proposed something that's a
> > little bit better, though still somewhat confusing.
> >=20
> > Oh... actually reading further through those threads there seems to be a
> > patch from Sven that was reviewed by Mika but then nothing happened:
> >=20
> > 	https://lkml.org/lkml/2019/6/4/1039
> >=20
> > with the corresponding patchwork URL:
> >=20
> > 	https://patchwork.ozlabs.org/patch/1110083/
> >=20
> > Andy, Clemens, do you have a way of testing the GPIO functionality of
> > this driver? If so, it'd be great if you could check the above patch
> > from Sven to fix PWM/GPIO interop.
>=20
> Looks good. Tested it today and I can no longer reproduce the issues
> when switching between PWM and GPIO modes.
> It did not apply cleanly on the current mainline or for-next branch, so
> I'll send a fixed up version of the patch with my Tested-by tag shortly.

Awesome, thank you!

> I noticed an unrelated issue when disabling and enabling the channel
> though, for which I will either send a patch or maybe try to convert the
> driver to the atomic API first and then look if it is still a problem.
> (Issue is that if you disable the channel, the LED_OFF counter is
> cleared, which means you have to reconfigure the duty cycle after
> reenabling. It's probably better if only the FULL_OFF bit is toggled in
> enable/disable as it has precedence over the others anyway and then the
> previous state would not be changed..?)

Converting to the atomic API would certainly be beneficial because it
gives you much more control over what you want to program to hardware.

Other than that, yes, if ->enable() called after ->disable() doesn't put
the PWM into the same state that it was before ->disable(), then that'd
be a bug. From what you're saying this will make the driver only work if
there's a ->config() call after ->disable(). That's wrong.

So yes, setting only that LED_FULL bit in ->disable() and clearing it in
->enable() sounds like a better option than the current implementation.

Thierry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6E00EACgkQ3SOs138+
s6FPzQ/9Ev2jfZ6TUgRlYiSbq5Ko3pB8kpHoJMG5Q2cAZVA9cLusVZNpuNvj5Vtt
yAWbXGmWtJLPV5/e4S0fvUMAQG9zVkK42NJ5OzN8SeFPY98ILUmkka3b+eGFuspU
g0HksnC1Gi30UtrtHvx/Vy9WYrMnOJZbUwScaBZvNQI2/6HfXgcgsiaOvBuR67mw
pyMHk2Zj5wTBLSn6ufqOBN+hETAx/mV+Ned6YALaMGja0FgnGE4hl3ewJdkSWfeT
Fjik/c1+3UPkBMlZxC54t4V6/h8JUz283m8c8lHs2I5T59YM11enA0j6i+LS2kJa
YwjUd7Va0Bbr7h+4RMMOYSQY66Xa1n60xJqcxXmd3+QVE4/SpD6PwvSBzghhV+GZ
lxovaH+tjopt7Hmn8ZmQWB9Wa58H5ZiMpJwn2NdwSp6eVPganKf15Tn+NMyGJBA7
B8JDyI0iMhE3c1S7JNHSx7uyP2Z1YM+MG1dhJ768Ep/4Mbt7C7G8nmYVRgdoJOxb
HNzCXJ3dvHPFRauNXFzMvoFNcfwVylJeGTb9pYsbyiQz7ksQJ6ZKrycyRV9wjVEH
vV9jUJD0MW8441zrvh1rl5fSDrjneVGpzsFu+009cGU6iSX6CndDE5wU8a6xziTK
0wxVABuONYe26+GlRgUZF3mUjnv1rQR1ohNZPSbXeBQySmgixBU=
=b+5S
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

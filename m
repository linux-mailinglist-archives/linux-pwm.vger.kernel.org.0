Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CDF2D305D
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 17:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgLHQ56 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 11:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgLHQ56 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 11:57:58 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E4FC061749;
        Tue,  8 Dec 2020 08:57:17 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id b73so18251607edf.13;
        Tue, 08 Dec 2020 08:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9AnOR1hiuLxVT3H/k1lCaVtV+vVanxaSnzK4hQCylB4=;
        b=YGOW45x2wxDp5TI7DpKcJa1DmokeMaGvDmEu7ey1HrDKa8MSNy4wjdex2xX9tRbz4y
         qoaQ6XCxShdiwwN99tM7CAmh7ADo22TOlttLQ8AQbUL9h5xfIa/1282BuuZMNGgJTHwC
         jJX+wSdt5lhShrni8nSHYEEQHmhFonRUIL3NQ/bTbLVwV3LxXPIMqsSUVs3G5CA3xXIh
         diyZCVT6KqorLIUJpv5Z0BjcXYiRLRdgaaUI/7YBCLeEdnenxK5X8ylFB+eZCCBrKt7j
         hJ1OAl0R1Idztw31b9w+rU4OOphpvwzmE/yJXC+oQy1Ey1iRkkgAutPv7MMH/KLQaG4x
         8fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9AnOR1hiuLxVT3H/k1lCaVtV+vVanxaSnzK4hQCylB4=;
        b=msbISk6WccBQJ2vi2VXVPdZAtQ0arnhU+/PIDSuUCACXKYM8QfliBbOlCIVmkdH/O5
         qX9qyzSBNrFylGhKelgA0cpsfIpm/jsOJGeO1hn3mph6LhlSu4Rzo2D8FZJ0g7CIEvU1
         gIzTE+w7QFMo07hQPLmQ/UpZFeCAC0i0h/3MXIN3IRnMa+ijLvZUxJ/B6NJd6DwGqzrB
         lylxfn6qFG7ufUtImNxq4HCSAAOQvsz5VgZudubYzhLJYSJr7/KpGhzuSyWin3oryqgr
         FzY/lwWQWXpBo09W3n7ZojXO9fvtUS59RkpvHP+JZyGpfyBysRkj+UmabmDbeNgLQKrh
         xMog==
X-Gm-Message-State: AOAM53224g9uFp0OTYQZhCE1nrvlN2hhXL+3cdAd3D8P6MOZsVL2aDwZ
        y1g3tdjyIfjebq8tDliPVzY=
X-Google-Smtp-Source: ABdhPJyyGyqoRaqTMXekb0WPili99mdF2AyxQfdbnN85G2fsdNwUDUP7yaMZmTyxMWnr7AheLDTWlg==
X-Received: by 2002:a05:6402:366:: with SMTP id s6mr13810083edw.44.1607446635913;
        Tue, 08 Dec 2020 08:57:15 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c14sm17593173edy.56.2020.12.08.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:57:14 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:57:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X8+waLH58pOaMI06@ulmo>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cFjP0YjuAt47HFtb"
Content-Disposition: inline
In-Reply-To: <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cFjP0YjuAt47HFtb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2020 at 09:44:42AM -0500, Sven Van Asbroeck wrote:
> Uwe, Thierry,
>=20
> On Tue, Dec 8, 2020 at 4:10 AM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > If this is already in the old code, this probably warrants a separate
> > fix, and yes, I consider this a severe bug. (Consider one channel
> > driving a motor and reconfiguring an LED modifies the motor's speed.)
> >
>=20
> I think you are 100% correct, this would be a severe bug. I have only used
> this chip to drive LEDs, where the actual period is not that important. B=
ut
> for motor control, it's a different story.
>=20
> Basically you are suggesting: the period (prescaler) can only be changed =
iff
> its use-count is 1.
>=20
> This however brings up a whole load of additional questions: consider the=
 case
> where the chip outputs are also used in gpio mode. the gpio functionality
> only sets "full on" and "full off" bits. On a scope, a gpio output will l=
ook
> identical, no matter the value of the period. So when a gpio output is in=
 use,
> does it increment the prescaler use-count ?
>=20
> Example:
> 1. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=3D1/2=
00Hz)
> 2. output 2: set led mode (full-on bit set)
> 3. output 1: change period(enabled=3Dtrue, duty_cycle=3D50%, period=3D1/1=
00Hz)
>=20
> Do we have to make (3) fail? I would say no: although output 2 is in use,
> it's not actually using the prescaler. Changing prescale won't modify
> output 2 in any way.
>=20
> Which brings us to an even trickier question: what happens if a pwm output
> is set to 0% or 100% duty cycle? In that case, it'll behave like a gpio o=
utput.
> So when it's enabled, it does not use the prescaler.
> But! what happens if we now set that output to a different duty cycle?
>=20
> Example:
> 1. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  period=3D1/=
200Hz)
> 2. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, period=3D1/=
400Hz)
>   fail? no, because it's not actually using the period (it's full on)
> 3. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, period=3D1/=
200Hz)
>   fail? no, because it's not actually using the period (it's full on)
> 4. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  period=3D1/=
400Hz)
>   fail? no, because only output 1 is using the prescaler
> 5. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=3D1/4=
00Hz)
>   fail? no, because output 2 is not changing the prescaler
> 6. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=3D1/2=
00Hz)
>   fail? yes, because output 2 is changing prescaler and it's already in u=
se
>=20
> IMHO all this can get very complicated and tricky.

Is this really that complicated? I sounds to me like the only thing that
you need is to have some sort of usage count for the prescaler. Whenever
you want to use the prescaler you check that usage count. If it is zero,
then you can just set it to whatever you need. If it isn't zero, that
means somebody else is already using it and you can't change it, which
means you have to check if you're trying to request the value that's
already set. If so, you can succeed, but otherwise you'll have to fail.

> We can of course make this much simpler by assumung that gpio or on/off p=
wms
> are actually using the prescaler. But then we'd be limiting this chip's
> functionality.

Yeah, this is obviously much simpler, but the cost is a bit high, in my
opinion. I'm fine with this alternative if there aren't any use-cases
where multiple outputs are actually used.

Thierry

--cFjP0YjuAt47HFtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/PsGYACgkQ3SOs138+
s6F58g//fjdAZQdgMNMoEzeSO2PrDmMvoL4Um8uwBGKODwFjC6r8LkK86n5SCsI3
6swNMHyRL7bmy/1Xk2MNWATejd19qFp7f66JLp4bWY1M1R9N7qcECwmJKWJ67iaj
vlK+1ZWoVmJfF1rdP5bResP0V/jy/sVZeXSL5r9MNpEAK4uGabkgjQWHrP6ePkul
2ZCtrlXoKP8tzOf781/gIyrJ4xENfl842eV+/2KESAvRQDoI6ijqDvclrgYaOYck
4TaC4uE0gmQEdNKw03j16/X6dRJa9EbZH1xBoTGlJTM5m01rqFdxTaz1WdyNWhYm
b+FcjZCaBMSJV2i6OG4mcHzNgIngnqySiFWQJLNtiH35EUpapM/gf6UXBvizocDR
jR6d9Am0TJ8pmH95JcAAFZHbU+TaeaV98tdxWCQmMy3pzZVzu0mmVEsVTvaJdVFx
U0vd16X3oxit+bFF6jvscT/ShR3x2+ylIB3mDDTlBMe9YA5fmc/qAWX9Lbg34NPn
y9cCd783VeLaWg7swSANBGX2XWfYAuy2SsdrciEUCRav0G9yyvv0xniITwiHvgQd
OhxLRuUdSDYwAgK7TA2aGLYrC5aYmFtAdQ0afOOPutjY+FK7r/G1Cs/t0PnQFTeM
coVdc/AwhyCPQb6KsPMMqLnJprWKVItL/mi4ekkNk34zc0a7kdQ=
=4g8Y
-----END PGP SIGNATURE-----

--cFjP0YjuAt47HFtb--

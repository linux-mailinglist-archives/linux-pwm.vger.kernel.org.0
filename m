Return-Path: <linux-pwm+bounces-5215-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BABCA66FA1
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 10:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952FC17F2F1
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531A207640;
	Tue, 18 Mar 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x5ElA/cs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8977E146D6A
	for <linux-pwm@vger.kernel.org>; Tue, 18 Mar 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289812; cv=none; b=sjdDfGHQU5SumOSLQqoYCz16KqQ3tFoRZUcryKPH7iIULt2jImIHKwFgdYuHUbya2cPOhDHdPS72FodSRQhhfGRrCvL7qom1wbmLIHfNqfWnCdA3D34OhtMDKyOd23v8vEgU468zrzwht0PJq6Ic5Otsyx1H0EPQvjunbH0MpP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289812; c=relaxed/simple;
	bh=mqJkX5QPsnI/Jodj+L1e6td28KWmnJsJKJ83SXtVVpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnVzXjP3Khrrub+DHz++lG3uHYoKclSKl8ihxGi369V7oy9jbSaLvSa+TTR1cgC2LlMKUL8xYSP/GnCsf8amhSg+mY1oIJ3kHxGlGazpJFRimBfJpNjeQ9N8rEHnhkDWe1GGCvBvFhtWlr2ItHKsKMP+56lSyjFiqYKBgerfAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=x5ElA/cs; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso9151839a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 18 Mar 2025 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742289804; x=1742894604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU/vvHDuGhTduZB0clQayUgjj8LXd6feyCcIDz4QkME=;
        b=x5ElA/cseQPOwCsRNCy4SPJXC1U2rvpbmpPPsoZin9CQOZ+NbUzNVAHIwqcNePvAE/
         pGxhEUbYZ3PdKKLle1qUfsdhWv4iwPLX/Nx7XYY3DdrveEVGNDdcqJV9fS9ZFbMXhYgP
         Lhj5sJ43J9RYsVrHW7Pw/6sGUZEt+ucIkHjxRo5r9JNqA20v8eFhy6xsNfyRzSnYeC/6
         BdBYa5cfjG8wiAn1hWIPzNCC0/gauJU8eXm8tbRl5oZgeZunf7dMVFSqUgoPMyl61Kco
         dBHYc+QCQngnQ3yJ2BahX5vqSPuwY1E0wEhZiWnDdqV796QTIpIc6XsW8ipAodb0DGHL
         UoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742289804; x=1742894604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZU/vvHDuGhTduZB0clQayUgjj8LXd6feyCcIDz4QkME=;
        b=CARr2yl7ukhPFGkgBv1vojhuBU9qdeeje0xA3cP6yzn6zIQdriDAWtK0nh+4oVi8lr
         2i2o7Ofwhr5tY4IPQYJCJdfiEZ5Y2fJh4GBYsMdEBUQLR/iycYflugilvMVyAtir+3JE
         Eh/Bs1ik5PVY/6wTNDl71cE4plVvAKTcs1isVwLbMAWy8+/XNKaTZyuu0ioIT0e8f/Vu
         WrApPUYaGIR5U7XoHI51K5pbO6Uqd2sas8DPJtxyJ7Mev/DrTJRAsycpbn02qdMiKh3Z
         fEB7e63oDZ7dCmgBlNdWdVeDHh+xq7pk1jKJoqnoLd2qfku2P0+roX5embPHRug+spjc
         V1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXmmy9hBVMpN1p5PirK8ECg6LjEKgE95yUaewUAJqAVWoshjpQHIw0yPYqYqu1YBimMSyBiqPQ04xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZa1PWR2Vy5sEpr7yElXmpZ2Akf9HgYjSdyYMuQtZx1qcmKj3X
	g2emFqzYS/N8nKL6IqqgGVf8+qkc6Uslm3clsWCyg6emzYkY+kYHrwQQytFCqsg=
X-Gm-Gg: ASbGnctX8O/QvNRrA4GKPLtf3R59udwPQ9d8brBWDyNmz1Kn5rhjR3J4GLqQbxkzUzP
	ynAWHfGIv8yRTCihjKYyr2KGTt15s8yGCNHKr0nRct7rE2VDngVsHePM6FLU6fnyyMu8tK0YZYU
	iL4TdRDn62H8BWFwnZcxreICO18mzV+ob6DA9uK/trhWbVFnFrh9jrRamlfyP9b7okWQ+1IU9Rq
	fZVDFru5hv4Sd7S81Vhgl6W8M2dAgPWNyZQ4pRUsl+eE57fSQU2xMV3BsEcGXifdmZ75Dp8yPY5
	7/XQeyFov1d4bK06MQ9jBQ3MDbXzP+5VOWEj42WcPTVPDfZd2AGADOy3hJDRHCxe9JSwCaj57kG
	kp2XDvN7haLg=
X-Google-Smtp-Source: AGHT+IFwtT4t5BJ31fMOagUfAPcPJQ9nOWEjcwUgulSB82NQzjLhdlaZFO+fufBv9ePXiB8ie77s9g==
X-Received: by 2002:a05:6402:354a:b0:5e7:b00f:9fe6 with SMTP id 4fb4d7f45d1cf-5eb1df95a3dmr2487075a12.26.1742289803650;
        Tue, 18 Mar 2025 02:23:23 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e8169b021bsm7635128a12.33.2025.03.18.02.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 02:23:22 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:23:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <ghdqkv33owyqngxlwuwjogqgaasilnakcqq3znv7ae5hsdi763@dpqzqtypgtkq>
References: <20241224093902.1632627-1-nylon.chen@sifive.com>
 <zqkx7cx5nalslfmxeoxdnsjbvrvzajrjybsmsyeyc65a64sntr@gpc5qp6aoyp7>
 <CAHh=Yk-_0rKB=FG6Voif2MDjtRxzUA5vXDP2J-o5=8ru1ewt0w@mail.gmail.com>
 <CAHh=Yk-TosOmwEughfK9mMx-=DgzWK5H_bf6H641SGh1ue8BrA@mail.gmail.com>
 <zneb3qwgf52zitcbq4wz76shnmhwfkabbsts3sussjpc5s5tsz@uneaxdfp4m2f>
 <CAHh=Yk_oTdURhkna_saF6mrA9gDY=+v_j5NoY_7jTDLuZ=EXtg@mail.gmail.com>
 <7bcnckef23w6g47ll5l3bktygedrcfvr7fk3qjuq2swtoffhec@zs4w4tuh6qvm>
 <5robb7ipl346daf3lqaqnsi3fcgj3wzmch5dqit2dczdyeknmv@dqft77bhwryg>
 <CAHh=Yk-p69ppWWspEzzznhDnuk3i6dRGKzUaqZCwg_uAxB3FVA@mail.gmail.com>
 <CAHh=Yk8kC1+D4dPQ7iAtn1WSPSk+OU6vwEyGF9VZAS5o5gPHmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7zj2eh5wo3yw56vr"
Content-Disposition: inline
In-Reply-To: <CAHh=Yk8kC1+D4dPQ7iAtn1WSPSk+OU6vwEyGF9VZAS5o5gPHmA@mail.gmail.com>


--7zj2eh5wo3yw56vr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
MIME-Version: 1.0

Hello Nylon,

On Tue, Mar 04, 2025 at 05:02:13PM +0800, Nylon Chen wrote:
> Nylon Chen <nylon.chen@sifive.com> =E6=96=BC 2025=E5=B9=B41=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=888:20=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =E6=96=BC 2025=E5=
=B9=B41=E6=9C=8822=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:44=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > >
> > > Hello Nylon,
> > >
> > > I took another look in the driver and found another problem:
> > Hi Uwe, Thank you for the information.
> >
> > I'll need some time to verify and understand these details, as well as
> > conduct the relevant tests
> > >
> > > On Tue, Jan 21, 2025 at 07:12:10PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Tue, Jan 21, 2025 at 04:47:46PM +0800, Nylon Chen wrote:
> > > > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =E6=96=BC 20=
25=E5=B9=B41=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:47=
=E5=AF=AB=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On Sun, Jan 19, 2025 at 03:03:16PM +0800, Nylon Chen wrote:
> > > > > > > I ran some basic tests by changing the period and duty cycle =
in both
> > > > > > > decreasing and increasing sequences (see the script below).
> > > > > >
> > > > > > What is clk_get_rate(ddata->clk) for you?
> > > > > 130 MHz
> > > >
> > > > OK, so the possible period lengths are
> > > >
> > > >       (1 << (16 + scale)) / (130 MHz)
> > > >
> > > > for scale in [0, .. 15], right? That's
> > > >
> > > >       2^scale * 504123.07692307694 ns
> > > >
> > > > So testing period in the range between 5000 ns and 15000 ns isn't
> > > > sensible? Did I get something wrong? If the above is right, switchi=
ng
> > > > between period=3D1008246 ns and 1008247 ns is likely to trigger a
> > > > warning.
> > >
> > > The possible periods are of the form
> > >
> > >         2^scale * A
> > >
> > > where A is constant and only depends on the input clock rate. scale
> > > ranges over [0, ... 15]. (If I got it right in my last mail, we have =
A =3D
> > > 504123.07692307694 ns.)
> > >
> > > If you request say:
> > >
> > >         .period =3D 3.9 * A
> > >         .duty_cycle =3D 1.9 * A
> > >
> > > the period actually emitted by the PWM will be 2 * A. But to calculate
> > > frac the originally requested period (i.e. 3.9 * A) is used. So frac
> > > becomes 31927 resulting in .duty_cycle being ~0.974 A. A better value
> > > would be frac =3D 62259 which results in .duty_cycle =E2=89=85 1.9 * =
A.
> > > (Depending on A the values for frac might be off by one due to roundi=
ng
> > > differences.)
> > >
> > > So I would expect that PWM_DEBUG is angry with you if you go from
> > >
> > >         .period =3D 2 * A
> > >         .duty_cycle =3D 1.9 * A
> > >
> > > to
> > >
> > >         .period =3D 3.9 * A
> > >         .duty_cycle =3D 1.9 * A
> > >
> > > .
> > >
> > > Best regards
> > > Uwe
>=20
> Hi Uwe, Based on your suggestions, I conducted relevant tests and
> corrected algorithm errors.
>=20
> According to this test program, I can make the system generate related
> error messages on v10's patchset.
>=20
> e.g.
> [ 75.043652] pwm-sifive 10021000.pwm: .apply is supposed to round down
> duty_cycle (requested: 360/504000, applied: 361/504124)
> [ 75.055042] pwm-sifive 10021000.pwm: .apply is supposed to round down
> period (requested: 504000, applied: 504124)
>=20
> PWMCHIP=3D1
> PWMCHANNEL=3D0
> PERIOD=3D504000
> STEP=3D1
> MAX_DUTY=3D504000
>=20
> echo 0 > /sys/class/pwm/pwmchip${PWMCHIP}/export
>=20
> echo $PERIOD > /sys/class/pwm/pwmchip${PWMCHIP}/pwm${PWMCHANNEL}/period
> echo "Set period to $PERIOD ns (scale=3D0 region)"
>=20
> COUNT=3D$((MAX_DUTY / STEP))
> echo "Testing duty-cycle from 0 to $MAX_DUTY in step of $STEP..."
> echo "Total steps (forward): $((COUNT+1))"
>=20
>=20
> CURRENT=3D0
> while [ $CURRENT -le $MAX_DUTY ]; do
>     echo $CURRENT > /sys/class/pwm/pwmchip${PWMCHIP}/pwm${PWMCHANNEL}/dut=
y_cycle
>     CURRENT=3D$((CURRENT + STEP))
> done
>=20
> echo "Now do a backward test from $MAX_DUTY down to 0 in step of $STEP..."
> echo "Total steps (backward): $((COUNT+1))"
>=20
>=20
> CURRENT=3D$MAX_DUTY
> while [ $CURRENT -ge 0 ]; do
>     echo $CURRENT > /sys/class/pwm/pwmchip${PWMCHIP}/pwm${PWMCHANNEL}/dut=
y_cycle
>     CURRENT=3D$((CURRENT - STEP))
> done
>=20
>=20
> echo 0 > /sys/class/pwm/pwmchip${PWMCHIP}/pwm${PWMCHANNEL}/enable
> echo ${PWMCHANNEL} > /sys/class/pwm/pwmchip${PWMCHIP}/unexport
>=20
> echo "Done!"
>=20
> Based on your previous suggestions, I have made the following related
> modifications, and now I'm able to fix the relevant errors.
>=20
> But I want to make sure my understanding aligns with your suggestions,
> so I'd like to discuss with you first before sending the patch.
>=20
> - In .apply, use "round down" for calculations to ensure the value
> doesn't exceed what the user requested. (Never set a duty cycle higher
> than what the user requested.)
> pwm_sifive_apply() {
>     - frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
>     +frac =3D num / state->period;
> }
> - When converting hardware values back to duty_cycle in .get_state,
> use "round up" to compensate for the errors introduced by .apply.()
> pwm_sifive_get_state() {
>     - state->duty_cycle =3D (u64)duty * ddata->real_period >> PWM_SIFIVE_=
CMPWIDTH;
>     + state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)duty *
> ddata->real_period, (1U << PWM_SIFIVE_CMPWIDTH));
> }

That sounds right.

Best regards
Uwe

--7zj2eh5wo3yw56vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfZO4cACgkQj4D7WH0S
/k5aSgf/S+7QjofA+CHDa6zV1OUJbLv3VBQS1gX1YK4Mps+QnOK2hlrMQQOVDVk3
t28rjpcMJD8m70ZClOt+kfHM3O6DqlWJd2tl/AX/Wq0rETMNq2F3YFRecGs91xku
OF4rZwQVaSl5wr2VZP6j0k/8AilXmIHg6kHfvnMQrIqJwA4W/aVFbnt0sNlo+eGf
nB2Ju3+GNzUw6AiEUEgCHvIiD71aagqD90G772pT+OpGaiZmj8GIX0MxpaRiQ2V0
ZkdcM8lWic/7IbMkYoyHz4g6edbTJ+yhn9/RIAKeRNw+N6aK3VjZkOT/6WgggzZo
QzJe/nGspANnzvsW8QcLUPvEe+eVuQ==
=Mvcc
-----END PGP SIGNATURE-----

--7zj2eh5wo3yw56vr--


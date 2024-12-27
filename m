Return-Path: <linux-pwm+bounces-4527-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702629FD5A5
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 16:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17C4164031
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015541F7554;
	Fri, 27 Dec 2024 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FQAxe7JS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDB320B
	for <linux-pwm@vger.kernel.org>; Fri, 27 Dec 2024 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735313967; cv=none; b=nN+ibBM9ymbWdVYaF+E+QCJl8VAjPpajG5PGO4n3Ne3PopMZplKfSfXBWnOaUfknKqiLGx0PJl5gddtPKzc7iYK5K3M3OMV1uJZaukXzAgsXJ90d4FFkFvnGhJJhFVlALqBwGyw8i3kjXt2oIM89rll52G4CVny8uW+7huLLjCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735313967; c=relaxed/simple;
	bh=qUhKPYq0roUXkJLdPe4QOfJOS+ev/tWLuE4nGMPZwCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT2FtWSq9/YjeFdFugwIytsvMu5rxm/2hAUet04KBvS4Qfc1vtNYOzXxZZGKSIqpNhHIO5R5V83Z7opYQqtM47uMHTr6gyEpSOyF6o86vzROIGgW6yxlrBgxyhiSeQqd/N36m8UPSF8FXVzRwQgQLnRa4K8/1WmSomiMDGC6NQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FQAxe7JS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaec61d0f65so971217166b.1
        for <linux-pwm@vger.kernel.org>; Fri, 27 Dec 2024 07:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1735313962; x=1735918762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0lMXEa6Tw7TwkHA1VHSoSpcx/RWhq+InGvdon8glzk=;
        b=FQAxe7JSGlyeoYJEFp1lkPqSYl14DTbMBI2A2gABxzxoi6jb9OG2itxUIj1RYH0+EU
         4YRHT94V/LqIlUKc6q82GqO9PUqeGtTbqQg8vEX9aDVaumMNroiC8XYKWt8YaDhPSR1s
         5kES0vChLyxhNc42MCVOvNM5KfWgYOhw/JVAZWBbPP/YVX/9GnDxDr+VpVyhCKxh/W71
         07Hjh1sem1MUJNuJhmN8kBWrt93tavcyAnFg5tlWHtlWwebxt9WlBFSnmRYh4wT8NeEp
         lLGLV2fqaN1XHpyz1iJul2BhGhLds8A4eN46YsovGf+vS+z0JLWXSKjLArFJhmCDc/V4
         dzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735313962; x=1735918762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0lMXEa6Tw7TwkHA1VHSoSpcx/RWhq+InGvdon8glzk=;
        b=HU1qTrZU+9EN+TSKAuRiKt8jgSX4HLXvstJRvCKGQmij0WUFlchfbgX3diOC1BzfbV
         h8RtTYOGCcwFMeyr4zIMsbC0g2mJUYcolsJpN/IfP34WgMgEOEnHuki96F4Z+IFnMegG
         EOa1Yc92nkH+5fzxIfCzW96sKgznypxB1X9bRFagA4QfFVJP/zGIxzWyq9VVlnsg9KD7
         d+WLujt3vuf1RBxecL0qEK6pEDLms2eW4fh2zB0f3kOCEU/aZ5Us1u2moZLRpYWeCCj7
         M/asilwb3lEj2XxUNW09qCULaxU47KnAo9wKL0XTmDj6em7kldp/KB2eE+2nnkogRsDS
         RJxA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1cTK93GnXEEVnPlBRZToy9NELVC3UDSSi7+t9DnXA0rsC5UFNW1QEjmc3uJw5J4Utifcqy+Pc/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQLO43nykuqh6DQskj+ThO12XRRdAADpmdtX2bagEmbqgaYI/
	awNMMsSN08Zc/bIa2QzAK2YG9HwgWVnIyeGYGtTA3qmahdQgCmBCp0/oxE+dgEo=
X-Gm-Gg: ASbGncs3tBrL8NewBhBNOFmiEOLdIdBaZ8O91VzfvaI4Leerh5zUlJ1OQfWvl8Dmf0P
	+ayl1VIiYRk+HCdu6bNCwb5fea/OsffS6OP+Ky8398QvqiH/dL3ynuxXVhjtdLaIfGd/MTvrsU9
	b+f8oJJCeqTmlYinXtEt6UcM8Ofq2FX0snPkX75sbE0gRMYT+Nam+t/bt4XxUrUsop9D96Vb/KB
	yzMbbTLD4s7yCJKAASaVuzOJnMUvXN38PcCHJ/RG6o7bEvleCz8g10BZ5tcXboYsUlt1aKzhsW4
	4dsElfPpwA==
X-Google-Smtp-Source: AGHT+IFr3iUy4FGCuYXw8gRc/suwxBNXvcAeKXPjd4u4k4dosH+FSGQNRDV0VYyIoG59cU0IzeV0Ug==
X-Received: by 2002:a17:907:7205:b0:aa6:7785:5485 with SMTP id a640c23a62f3a-aac334e5327mr2884724566b.38.1735313962555;
        Fri, 27 Dec 2024 07:39:22 -0800 (PST)
Received: from localhost (p50915bc6.dip0.t-ipconnect.de. [80.145.91.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e89490dsm1117792466b.45.2024.12.27.07.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 07:39:21 -0800 (PST)
Date: Fri, 27 Dec 2024 16:39:19 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nylon Chen <nylon7717@gmail.com>
Cc: Nylon Chen <nylon.chen@sifive.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	conor@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, 
	thierry.reding@gmail.com, vincent.chen@sifive.com, zong.li@sifive.com
Subject: Re: [PATCH v9 3/3] pwm: sifive: Fix the error in the idempotent test
 within the pwm_apply_state_debug function
Message-ID: <p6rqpx3yrn2ib4ulmby7tbnpbg4bjyt4dt6snrmhuyw6hx6izl@lywssban54et>
References: <20240222081231.213406-1-nylon.chen@sifive.com>
 <20240222081231.213406-4-nylon.chen@sifive.com>
 <jvwgsszvs4jtcytcphsdjulzgqfqzdp4sisu236ddwsqgmvriw@ngi4ljgh5b74>
 <CAHh=Yk92=hp+kaTJWL13_jwJ5gzAAi8gbRF=Ns9=yq2trRUQEg@mail.gmail.com>
 <xf6ympnaljfjztptb5w5qdpuluckptozdz5a7gtuycsev32ngr@x2ovibqv6evr>
 <CAGKtFavQAZOof5QSTFCEaRJEPETm5aBqzkV4g24n3ioiBAOgDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ac6tsvvravmk4q2"
Content-Disposition: inline
In-Reply-To: <CAGKtFavQAZOof5QSTFCEaRJEPETm5aBqzkV4g24n3ioiBAOgDA@mail.gmail.com>


--5ac6tsvvravmk4q2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 3/3] pwm: sifive: Fix the error in the idempotent test
 within the pwm_apply_state_debug function
MIME-Version: 1.0

On Tue, Dec 24, 2024 at 04:34:53PM +0800, Nylon Chen wrote:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2024=E5=
=B9=B44=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:05=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > On Tue, Apr 02, 2024 at 10:01:39AM +0800, Nylon Chen wrote:
> > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2024=
=E5=B9=B43=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:17=E5=
=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > Hello,
> > > >
> > > > On Thu, Feb 22, 2024 at 04:12:31PM +0800, Nylon Chen wrote:
> > > > > Round the result to the nearest whole number. This ensures that
> > > > > real_period is always a reasonable integer that is not lower than=
 the
> > > > > actual value.
> > > > >
> > > > > e.g.
> > > > > $ echo 110 > /sys/devices/platform/led-controller-1/leds/d12/brig=
htness
> > > > > $ .apply is not idempotent (ena=3D1 pol=3D0 1739692/4032985) -> (=
ena=3D1 pol=3D0 1739630/4032985)
> > > > >
> > > > > Co-developed-by: Zong Li <zong.li@sifive.com>
> > > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > > > ---
> > > > >  drivers/pwm/pwm-sifive.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > > > index a586cfe4191b..bebcbebacccd 100644
> > > > > --- a/drivers/pwm/pwm-sifive.c
> > > > > +++ b/drivers/pwm/pwm-sifive.c
> > > > > @@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pw=
m_sifive_ddata *ddata,
> > > > >
> > > > >       /* As scale <=3D 15 the shift operation cannot overflow. */
> > > > >       num =3D (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMP=
WIDTH + scale);
> > > > > -     ddata->real_period =3D div64_ul(num, rate);
> > > > > +     ddata->real_period =3D DIV_ROUND_UP_ULL(num, rate);
> > > > >       dev_dbg(ddata->chip.dev,
> > > > >               "New real_period =3D %u ns\n", ddata->real_period);
> > > > >  }
> > > Hi Uwe
> > > >
> > > > pwm_sifive_apply has a DIV64_U64_ROUND_CLOSEST(). I wonder if that =
needs
> > > > adaption, too?!
> > > According to my experiments, no adjustment is necessary.
> >
> > Did you enable PWM_DEBUG and tested with something like:
> >
> >         seq 5000 100000 | while read p; do echo p > /sys/class/pwm/pwmc=
hipX/pwmY/period; done
> >
> Hi Uwe,
> I apologize for the significant delay in responding to your query,
> I've now completed a thorough verification of the PWM_DEBUG
> functionality.
>=20
> The Period Testing:
> seq 5000 5000 100000 | while read p; do echo $p >
> /sys/class/pwm/pwmchip0/pwm0/period echo "Testing period: $p" done
>=20
> The Duty Cycle Testing:
> for percent in 0 25 50 75 100; do duty=3D$((100000 * percent / 100))
> echo $duty > /sys/class/pwm/pwmchip0/pwm0/duty_cycle done

This is unlikely to find the issues that I have in mind. If doing ~100k
assignments is too much, please keep the +1 step but restrict the
interval.

Best regards
Uwe

--5ac6tsvvravmk4q2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmduyiUACgkQj4D7WH0S
/k58Wwf+LsAIYA7z5wl6BOdBApHwQXrQvFR+k8eZuODCKOlEz7+UAULywJzQsgtT
+WdckQF+y0+WvZes7SrycVvJXT68/3vC/rwLiTY8B9LHURsksEQIF6ubh1KlRjN5
3+Tim9NMEKYHTfu1WSz2Vx4Ej7b/VP4/ed3IVvdQdcN89qlQBYRCGw/n4kiBblc6
akItNdWHdhOmM5JRUKit8f6OLGmmN31KSZRY9FHpa10iZ/sQTNUDpTvW+jFMDwaz
acs+UYOX/ekUiBxdZHOhHSlg9ZRt+naWXWJAFjQhAUTgf2lN+bO+1vu9gqO6S2d4
ZWY+uWK/qAqtcXTGP8VVeDQC3h342A==
=Kthl
-----END PGP SIGNATURE-----

--5ac6tsvvravmk4q2--


Return-Path: <linux-pwm+bounces-2968-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B311294896A
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2024 08:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C7D1F23DAD
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2024 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E772515E5BA;
	Tue,  6 Aug 2024 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aIVOR8k3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056B1C32
	for <linux-pwm@vger.kernel.org>; Tue,  6 Aug 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925929; cv=none; b=MEtt7wCz7IugfhEglXTXZl+VYCJ95eVWWU8fT7aLLLMHbMDHKIOwcaHptIUMYE8IEZpuycBATgZJfSsmulZhpq1NNiTv07rR6a8PPwN9t5AsSXiYHHABpql1+bwSbrdzUuO6pqw+/TQjerA4s7XTsSq14/icbuf/beoRWq3JzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925929; c=relaxed/simple;
	bh=CcwNAS5t4PpUTArHaTOrI7Uce/v3706foKbFQ5FIvlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moGdJzVbEUX822CQwEtkdsVydrvDQnZmUvuiNdY2dQHjZ9ISVb5ACv2KJBJ5WdgVoby9fbwhEess1fgM06beMsKra2+kcTsY+oYHo8AsJJTN6BMmcEdsCjrCVAiItFRrvyxjEQPFvkmbMVLrTF7KXRVOCAnJkzOY4GjZKmjT5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aIVOR8k3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so1653535e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 05 Aug 2024 23:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722925925; x=1723530725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28uc5KktWeMaHHoBOnWKpTdV+/G2B65GuLbD8msyplA=;
        b=aIVOR8k3LH17igjnK9/FqPERS1zzHxXOOGC2wZsDxRLxGhjLS2+NoGuargCJMmP5qv
         ZgUuNlCIbVD/Ix/Sqw0SYrs9IwTX7Aohdn1e4Skl98fp8b7d0aLO5H2y6qHBiZhzqpvs
         33oEn4gXTjRJtQiS9s0tfHFJoYketupqVmzCjbh3P0NKIETXclMdqF0l3eHAD27xWAY+
         tSacZif5ziknSI/2HogtHRCKnPSpGGr7HrydSzeaM+VSXqjcXpmENgprdEFAKhKIQXZX
         Qm9Iko7kh7+HXF5AtYQdNZjX5O3j+DiGSqhC7W/b/Oba5NPfKf+nStCC+HZpFrfHG4oL
         kcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722925925; x=1723530725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28uc5KktWeMaHHoBOnWKpTdV+/G2B65GuLbD8msyplA=;
        b=kdi2QCFJ/qjOw7GBDqxu+YXYkH/IJJPBgiwfkaC2Ri0oWgK88ee4uGSteQcyvs9TsS
         Iow8nOpau3ccIstr3Oj/fpRpIAuzSv98zX+T6txIAWeq5qmyQy6x0F3aOR7T6Gq9RA1o
         7avAyHx2job+84QloCqPVoHQ8i/uBXkhgGzg+rr/0LjnfFpu/4MsaJCNiLaShG8e5H6l
         TzmjnuwwzmD4hZdCcMZmaVSUOQ0yvKhFEx8EgKAKZ7H0A0zav9cxXRZGHGHazO0I+0QI
         EAEOXmz1YeKdXvQycygVwUbJNTFfphN43t8FynAFzGMgxinXuA9okU6FYA5W20w/oxC/
         fi+A==
X-Gm-Message-State: AOJu0YzLJp4bc2OY3oWDolkROzI3Oq9xQfSPhTrffv/PfRpTTUM96Jpl
	leVesgsyNXR/ZJEgY0GFxEDJD0kBI6Dj8Eiarvx6bAXz5Igkvnf1ZpEl7wa4K+Y=
X-Google-Smtp-Source: AGHT+IFoKYujpzDFkRmU2Q0wVctZckNCmUXBPGYDZ8dPp4n7Jan46n8eBSsiBjHQYbZrdBjdnYNRfQ==
X-Received: by 2002:a05:600c:4fcb:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-428e6b30cc7mr95848575e9.17.1722925924705;
        Mon, 05 Aug 2024 23:32:04 -0700 (PDT)
Received: from localhost ([193.196.194.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6403bsm228309185e9.35.2024.08.05.23.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 23:32:04 -0700 (PDT)
Date: Tue, 6 Aug 2024 08:32:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	broonie@kernel.org, lgirdwood@gmail.com
Subject: Re: [RFC PATCH v2] regulator: pwm-regulator: Make assumptions about
 disabled PWM consistent
Message-ID: <y7svv2jvcof3fnezvjbirkian5b7ajic7ajxgtyiejj3364ie7@uvmqlpjj6tv5>
References: <20240622191504.38374-1-martin.blumenstingl@googlemail.com>
 <s6lapsx6dukr4ebknbbalbhi7232ivxl2apaqtardfi6f2ybbf@zvlhxlngbgx3>
 <CAFBinCANKBcttSEhc_0-+D0G3fO0CV67R41y-C7xEwhAXtA+LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lwuvkzra6xmuxxcm"
Content-Disposition: inline
In-Reply-To: <CAFBinCANKBcttSEhc_0-+D0G3fO0CV67R41y-C7xEwhAXtA+LA@mail.gmail.com>


--lwuvkzra6xmuxxcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On Sun, Jun 23, 2024 at 11:09:08PM +0200, Martin Blumenstingl wrote:
> On Sun, Jun 23, 2024 at 11:32=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Sat, Jun 22, 2024 at 09:15:04PM +0200, Martin Blumenstingl wrote:
> > >       drvdata->state =3D selector;
> > >
> > > @@ -115,17 +129,26 @@ static int pwm_regulator_list_voltage(struct re=
gulator_dev *rdev,
> > >  static int pwm_regulator_enable(struct regulator_dev *dev)
> > >  {
> > >       struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> > > +     struct pwm_state pstate =3D drvdata->pwm_state;
> > >
> > >       gpiod_set_value_cansleep(drvdata->enb_gpio, 1);
> > >
> > > -     return pwm_enable(drvdata->pwm);
> > > +     pstate.enabled =3D true;
> > > +
> > > +     return pwm_regulator_apply_state(dev, &pstate);
> > >  }
> > >
> > >  static int pwm_regulator_disable(struct regulator_dev *dev)
> > >  {
> > >       struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> > > +     struct pwm_state pstate =3D drvdata->pwm_state;
> > > +     int ret;
> > > +
> > > +     pstate.enabled =3D false;
> > >
> > > -     pwm_disable(drvdata->pwm);
> > > +     ret =3D pwm_regulator_apply_state(dev, &pstate);
> > > +     if (ret)
> > > +             return ret;
> >
> > With that part I'm a bit unhappy. You don't know what the pwm does when
> > disabled (it might yield a 100% relative duty cycle). So the safe bet is
> > to use .enabled=3Dtrue, .duty_cycle=3D0 here.
> >
> > The only code that "knows" if it's safe to disable the PWM is the
> > lowlevel pwm driver.
> Here I don't know the regulator framework enough. Let's make two assumpti=
ons:
> 1. the optimization you suggest is implemented (I'm not against it,
> it's just different from what pwm_disable() does)

In general you cannot know how a disabled PWM behaves. The objective of
=2Eenabled =3D false is to save power and don't care about output. The
typical implementations yield the inactive level, but there are
exceptions that are hard to fix -- if at all. These include High-Z and
the active level. So if the pwm-regulator relies on the PWM emitting the
inactive level, .enabled =3D false is wrong. I guess in general you don't
know and .enabled =3D true + .duty_cycle =3D 0 is the right thing?

> 2. regulator core does not expect the set voltage to change in a
> .disable() callback
>=20
> In that case disabling the PWM output is fine. Since we're now
> updating the cached pwm_state with duty_cycle =3D 0 the next time the
> regulator core calls the .enable() callback (without calling
> .set_voltage() between disabling and enabling) we end up enabling the
> PWM output with duty_cycle =3D 0 (and thus likely changing the voltage
> output).
> I see three options here:
> - my assumption about the regulator core is incorrect, then your
> optimization works just fine
> - we only write enabled =3D false to the cached pwm_state but not duty_cy=
cle =3D 0
> - we drop the suggested optimization here (and maybe let PWM core handle =
this)
>=20
> What do you think?

I'm unsure. I can tell the effect of .enabled =3D false, but I don't know
if this effect is ok for the pwm-regulator. I also don't know if
disabling and reenabling the regulator is expected to keep the voltage.
Who can tell? I'd hope Mark?

Best regards
Uwe

--lwuvkzra6xmuxxcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaxw1MACgkQj4D7WH0S
/k5ZYAf+LJ7i7pO+FW4FK0Mfr5W6uWz25nIycCkrNh3GWfXgCh7WFayQ3yePgtci
Jzt0MSrOF2VMbdZs8u2dxC7G6f17VymcdZvqpgp4t30073rvj51HtJo3nz2k6G44
7CJgeeZ1phGs4QbgzymI+ishOB9rMc1ZmApqioclbvPgHLLQDcZMNQj2CVTSj08H
NkxyddIKmlnqL1YQrl9vUpAcMQUpfHvWz9afGv9EkFCpb9b9lOqehN0yZgff/N0t
ubJBMgE7SvqaKnRmTRsCfx8XeDACFR7fDUvJBSSe0vYe1yTMg8/XfgeypAwoIpsz
+Bx2SoeUxKIxrsyI6fBjYpIR9Y26Xg==
=ZSzP
-----END PGP SIGNATURE-----

--lwuvkzra6xmuxxcm--


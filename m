Return-Path: <linux-pwm+bounces-2787-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3124992FE8A
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B7A1F23A2D
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208B175567;
	Fri, 12 Jul 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MdY2RqYX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D1173345
	for <linux-pwm@vger.kernel.org>; Fri, 12 Jul 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720801740; cv=none; b=UZM1Fze/OAakOTnzwWJUixNXZCRp6S1wqvTuq8sclOEeigFsawQHYyNdWORy3/hXX8IOMdWHkFpki1XgpsRunN21LE2LnbBVTWzyyp4lkdp4RuOp/GKzZgFC4riON8FD4oGm9sfZR//0PPh4dG8RbKcjzTzYNtSBXRIP8Kz1El0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720801740; c=relaxed/simple;
	bh=0hC4+8k7KgddI+mj9vy1HLjJ7Eiog0c76Z/OStKOMOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPQ8QEONdM9rWsCYgldJ+1xEQ/AP7mXYN0i3XCQEEzw+CiQ7ZkXLbMk35jsvQjZiVKurWGfFxMRAAIKwLg1aBEb0hfcB71/2GIJ0yPKLdOc+dVrvgd+1xfgujnyl9ubCJvREj05wgUPPvoYS0ZtXOnq3ctsbPaM9qkeHS2uSxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MdY2RqYX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58b447c519eso2969325a12.3
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jul 2024 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720801736; x=1721406536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLbDj6WenJao7KJoLRxFWrmWsBncRgLRIPDzBRaAH64=;
        b=MdY2RqYX2XffakDWBowLu2VsXPJkV5eSMaAySD4r6UJDeidj+j9rH5knLRFCnMJVuL
         +5vCeRRxy04OvQ4LK0HS7T6J80VRyt+fS33CfepUgLqkGU2EgKc821AJ600bt+PyGbb2
         UHXb+sYR8AWgRy6M9OrdAuhSVtdyIT9LlUGE/h5FNvr2eqe5yRcmJHjIDLjcm2Uyf3xx
         oinPyf5PqweNAPwyTcWqzjyGPGfVQ2vnUCF3wwh8fxhEfEdZTmudajEqLLR8FJAhq7Lr
         4NzBV1MUF/3Rz137SqGHL7IY5SSXG99O3GvIElgp4G2CXd3jpZCvDDMQ+z6cKGCH8oVw
         CNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720801736; x=1721406536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLbDj6WenJao7KJoLRxFWrmWsBncRgLRIPDzBRaAH64=;
        b=dbSljssIzOwsTUAtI8emi9dP0inKE/lp4vWyw4Kuq20ATqZMmqFbKcUsOnzIGEnGq2
         qBGO95WRoJUEpJgCJXsZSCfiV3e+WZEdDvEDfCl9BIeXYGI3H3j1hT4i0C92PsM9zkv+
         gLiSdp2fXa9/5xJQ61CAx1mSlWOCXkkLMIhRszFUBzujjom5fIZlHHzOl+5LcWvLocK1
         kBZ8uVpddztmMW9M8G5HJrNSQ08xY68dKqQq7Hyf7C2lWKhhkEWAAUsLLYit4/1t8vAT
         HgCSOYu0lc9r/Hc/2OVk6P3pxUl5gducjuaXiOPzg2J82BLfXZ8h0aG0yzyk5DoIGrja
         ypiQ==
X-Gm-Message-State: AOJu0Yzy59nWJ2H7Z9ufLbQym5OivXjihllwFwyH47bImNCrLays4dk7
	XT4vsDqLB+8209PsdRfHSWWgrz+zTviLioM9RzCT2KE5BxCgOEk0ZGNeWdSAk/SLmBLAq7TtF6Q
	E
X-Google-Smtp-Source: AGHT+IEA10HynvBUuRRDt4YiHGzlmd54sv2AwbGnFZlxEKQ0JbIcWwZBFnl+yWAJzHiHWK0LzSHWAA==
X-Received: by 2002:a17:906:6c93:b0:a75:2387:7801 with SMTP id a640c23a62f3a-a780b885f65mr688091566b.61.1720801736026;
        Fri, 12 Jul 2024 09:28:56 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7fefb5sm356906966b.104.2024.07.12.09.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:28:55 -0700 (PDT)
Date: Fri, 12 Jul 2024 18:28:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-pwm@vger.kernel.org
Subject: Re: [PATCH 3/6] pwm: Add support for pwmchip devices for faster and
 easier userspace access
Message-ID: <lsl34pvo3vbnqwnzrv36fguasxxb3brrgq44e2w3flgrdjzlx6@5vx53mvpi5fi>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
 <7490e64bbe12e2046d92716dadef7070881592e6.1720435656.git.u.kleine-koenig@baylibre.com>
 <86fdb6409c8f439bf75d2ed31d1031fb910aa435.camel@gmail.com>
 <hogxczszsbqtxu7b2dgllyclnr2pztellxzq3figkhdlajhowi@6vmjvyoifkjk>
 <d625777dfeb5a53a232835e9abb1f39de55e6a17.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qxpqwalmvkjrglht"
Content-Disposition: inline
In-Reply-To: <d625777dfeb5a53a232835e9abb1f39de55e6a17.camel@gmail.com>


--qxpqwalmvkjrglht
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 01:01:04PM +0200, Nuno S=C3=A1 wrote:
> On Fri, 2024-07-12 at 11:48 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Jul 09, 2024 at 11:37:13AM +0200, Nuno S=C3=A1 wrote:
> > > On Mon, 2024-07-08 at 12:52 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > With this change each pwmchip can be accessed from userspace via a
> > > > character device. Compared to the sysfs-API this is faster (on a
> > > > stm32mp157 applying a new configuration takes approx 25% only) and
> > > > allows to pass the whole configuration in a single ioctl allowing a=
tomic
> > > > application.
> > > >=20
> > > > Thanks to Randy Dunlap for pointing out a missing kernel-doc
> > > > description.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > > ---
> > >=20
> > > I didn't looked very carefully at the patch but one thing did caught =
my
> > > attention
> > >=20
> > > ...
> > >=20
> > > > +
> > > > +struct pwmchip_waveform {
> > > > +	unsigned int hwpwm;
> > > > +	__u64 period_length;
> > > > +	__u64 duty_length;
> > > > +	__u64 duty_offset;
> > > > +};
> > > > +
> > >=20
> > > I do not think we should have holes in the struct given this is an us=
erspace
> > > interface.
> >=20
> > Ack, will add explicit padding (and a check that it is zeroed).
> >=20
>=20
> Why not having the __u64 coming first :)? It also save you 4 bytes (yeah,=
 should
> not make a difference)

Well no. First conceptually hwpwm should come first and second there is
https://www.kernel.org/doc/html/latest/process/botching-up-ioctls.html
which recommends:

	Align everything to the natural size and use explicit padding.
	32-bit platforms don=E2=80=99t necessarily align 64-bit values to 64-bit
	boundaries, but 64-bit platforms do. So we always need padding
	to the natural size to get this right.

> > > If that is expected we should probably think in adding some
> > > __reserved__ parameters or maybe to modify the interface so we could
> > > make use of:
> > >=20
> > > https://elixir.bootlin.com/linux/latest/source/include/linux/uaccess.=
h#L348
> > >=20
> > > Like wrapping struct pwmchip_waveform in another struct with an extra=
 member
> > > forcing userspace to specify pwmchip_waveform size. But I agree it's =
a bit
> > > awkward and ugly (but it could be hidden in libpwm).
> >=20
> > The size is already encoded in the ioctl request constants. So I think
> > we're set to use copy_struct_from_user() if my expectation about
> > pwmchip_waveform not growing turns out to be wrong.
> >=20
>=20
> Oh, indeed. I had to go and remember the IO* macros...

I did that recently and fixed a thing I considered wrong/unintuitive:
https://lore.kernel.org/all/20240712093524.905556-2-u.kleine-koenig@baylibr=
e.com/

Best regards
Uwe

--qxpqwalmvkjrglht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaRWcIACgkQj4D7WH0S
/k6guwf/SyKagj1oNtxfVGj42oHmiep6DjeuZZ6ZBMcJMgkYGRxsC496BS6VIJAf
tRNoiEzX2YomjE50NzAqSuhN9Wv6LoBrGmMJQOikmOdF2TSH94CoNI1qJnxchWBc
7O2xKxUKsSiq3TL7ygObFD/bGonQiTcv/Fz+WJ1UfBAVywwouHYeInkgSMwPhd0p
1hUYolSOSUrJ+ov8pSG/eGrRgiuBXon3Sg1bw3e/778SwISWPUkX29k+4X6wsv6O
Fpx0xPjAJmNRCBO4snrfrJxnvMlAZptp45wcy9rszx+OTrfOI+A6ytTBT+xvjTxP
YbGKB6Nn0SkmBYVmCZMatn22nqH1Xg==
=e6ho
-----END PGP SIGNATURE-----

--qxpqwalmvkjrglht--


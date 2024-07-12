Return-Path: <linux-pwm+bounces-2779-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8A492F84F
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 11:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B35B22EF6
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDBA14B978;
	Fri, 12 Jul 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JMZHEZ9r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4314F9D0
	for <linux-pwm@vger.kernel.org>; Fri, 12 Jul 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777690; cv=none; b=IJ0zF7FufDTWJZRV7JbzqHLyNF+kJKxGatO1Uma3YUi4b+5SUzT4cX9fMLHTdEiMCwmTmDFDHhnNB/d0MeW4IdHxuH/OJr/dGFvMBZEyPvsvtPsK7ITAYGd6A8CczNk5paw+NCb4mAaW/qk59pJ3Ygoz+RSAETQzqK7cxlqZgfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777690; c=relaxed/simple;
	bh=RqqPqvqhFneugyGPrsEZb/uzeB2KVVSMw5/pLDStMUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3RqPQY89nSNazAnbdnnsyZPz7sn8G9a35qHeYsHrSJ0ywjGVQ5oeTmcxKjAFbqIvaOtw84QYXlJeSFMMdS+99cW3hanW6Od206y0LgNmr79+b01DS4R8YM+kFWyWGebuV+Ht97258/+XLjOTb+Bf7WIhLVtUDWYvOh9lE9BixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JMZHEZ9r; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3679f806223so1726867f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jul 2024 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720777685; x=1721382485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TfE+QxG/7xQbEPzMIECuLodMKEXTlymvgtgOa1Lswoo=;
        b=JMZHEZ9rmo0B4MMYu0xnwjL23TblSm4ZvLlpddhk0mPwZG4iTxCu16g3B25AkRILoD
         lAhd1N1W7+2Ud7JaXbPAXQmXsoBRk9dChnN5vEFFVUn754CJce2EcIMyuo6Xp7Z1HDsd
         cWq6gaS8vTxwT8wMpFxwXKZYKWRneVyc7fxOQiVvzbjQsxTFXaKV1ZSxvYUj3oGdbcqO
         T3oIvIwV3xpiErQvoxV5ESeCJmfFkCTWHOjBM4VyvfYI5lfY3AZwY9lumESr7Pe/0tts
         6sV0Yc8qWHLDIraoXMD7rBlkN8olsyc7EwfKO/Qz3FrpRc6zvurEMwLIL4JGs7puk7yW
         OrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720777685; x=1721382485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfE+QxG/7xQbEPzMIECuLodMKEXTlymvgtgOa1Lswoo=;
        b=EohAfy87VwmPPsnU8cA+7+GzCfed1x/Fx8/kLEfLM0iUz699x5IVc7QSR0MIxGH9Em
         zAGhC2sxjuHvHAFai7BYfqTeHfHitpbXQ5u7jOxrf/C7OFl4tppNyMcR3xysolT4T1xC
         2kMyt8A6krXRMWyLa05il5qYc2Fl20W9W8X+n9kzMuVW0mDc0VOpeMB5hh/eJ+BikedY
         v6yaK1udse8myhjm/z30oIND+PLQNlOoNI6Is5Yr5G52GQ0blyllhc4XF1ofy/tpxjnm
         IFKmpyt7BUfEqCIZ2lG938ZJxXk3T8Om90P9I/lO7f7nwWpHB5ZCSp9HUOXCv1QHIocd
         FbIA==
X-Gm-Message-State: AOJu0Yy8UR4fbA1sy4/kTzpOSKWy6sbYULzZNg4BNiUDimIHX9VJMGcb
	oRxxuGZBWiHuh3P8ncdmqgthAJkXoRCuQyxqUbzkbeB21BcPvwrnOiqdA8TKP8yZ7RPIYDAWffa
	M
X-Google-Smtp-Source: AGHT+IFQktmFncHti9jtoLNtAp8diK3kRkq7Ipzq5ZwS3ttoF71cXWSpBcyDbF+FY3myl9U0Mr4NhQ==
X-Received: by 2002:a5d:55ca:0:b0:367:89ae:c204 with SMTP id ffacd0b85a97d-367ff6ee07emr1534425f8f.12.1720777685514;
        Fri, 12 Jul 2024 02:48:05 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25babbsm17579085e9.20.2024.07.12.02.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 02:48:05 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:48:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-pwm@vger.kernel.org
Subject: Re: [PATCH 3/6] pwm: Add support for pwmchip devices for faster and
 easier userspace access
Message-ID: <hogxczszsbqtxu7b2dgllyclnr2pztellxzq3figkhdlajhowi@6vmjvyoifkjk>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
 <7490e64bbe12e2046d92716dadef7070881592e6.1720435656.git.u.kleine-koenig@baylibre.com>
 <86fdb6409c8f439bf75d2ed31d1031fb910aa435.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bwevc6qqyfwt477b"
Content-Disposition: inline
In-Reply-To: <86fdb6409c8f439bf75d2ed31d1031fb910aa435.camel@gmail.com>


--bwevc6qqyfwt477b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 11:37:13AM +0200, Nuno S=E1 wrote:
> On Mon, 2024-07-08 at 12:52 +0200, Uwe Kleine-K=F6nig wrote:
> > With this change each pwmchip can be accessed from userspace via a
> > character device. Compared to the sysfs-API this is faster (on a
> > stm32mp157 applying a new configuration takes approx 25% only) and
> > allows to pass the whole configuration in a single ioctl allowing atomic
> > application.
> >=20
> > Thanks to Randy Dunlap for pointing out a missing kernel-doc
> > description.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
>=20
> I didn't looked very carefully at the patch but one thing did caught my
> attention
>=20
> ...
>=20
> > +
> > +struct pwmchip_waveform {
> > +	unsigned int hwpwm;
> > +	__u64 period_length;
> > +	__u64 duty_length;
> > +	__u64 duty_offset;
> > +};
> > +
>=20
> I do not think we should have holes in the struct given this is an usersp=
ace
> interface.

Ack, will add explicit padding (and a check that it is zeroed).

> One other thing is how likely is this struct to grow?

I don't expect it to grow. Extensions I could imagine only concern
things like:

 - request the currently running period to be completed
 - block until the hardware is programmed

and these don't fit into pwmchip_waveform and would require a different
ioctl command and parameter struct anyhow.

> If that is expected we should probably think in adding some
> __reserved__ parameters or maybe to modify the interface so we could
> make use of:
>=20
> https://elixir.bootlin.com/linux/latest/source/include/linux/uaccess.h#L3=
48
>=20
> Like wrapping struct pwmchip_waveform in another struct with an extra mem=
ber
> forcing userspace to specify pwmchip_waveform size. But I agree it's a bit
> awkward and ugly (but it could be hidden in libpwm).

The size is already encoded in the ioctl request constants. So I think
we're set to use copy_struct_from_user() if my expectation about
pwmchip_waveform not growing turns out to be wrong.

Best regards and thanks for your feedback,
Uwe

--bwevc6qqyfwt477b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaQ+9EACgkQj4D7WH0S
/k48KwgApw/cuElk2YIfJCMYm0SFy3TkNxsvN3niHc9BrA0gYsKxyp7O/mASk2V2
P20r8dv3TSLzUd2KiNocIlETit+CAmum/z+6L7PfyfXSOjv+dqS2PioPEWcbTwaj
I3Ca6wVnLmiqLnOV2LgtieCChA/3HEfQn7dV0g7PnV54cyt28Km0hEQq7c/dmSjV
j/hi4YSSoyxBUvbZARBDgkbD2SK6+PKtFbxogkQZPX6AM+VYFMfvA3fJIta8+LiS
hTsha3qUAR2Cy65ZRfauWS+FTFThJW+ow5FG/IRf4G9auclurlknB2FF14l5GnRZ
qJND2sv5jsDFgfUxhKCw0uFEtGJaEg==
=SIu2
-----END PGP SIGNATURE-----

--bwevc6qqyfwt477b--


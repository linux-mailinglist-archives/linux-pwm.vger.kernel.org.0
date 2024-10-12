Return-Path: <linux-pwm+bounces-3614-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9892C99B4E5
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 14:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89031C21A11
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD818859B;
	Sat, 12 Oct 2024 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w5dNrZpB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C8175D5E
	for <linux-pwm@vger.kernel.org>; Sat, 12 Oct 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728736822; cv=none; b=HAE5a6NIL2WdqUI7ZECc/TN1Tw/BkhAvq0tL1IHbiNPy5JvVVa40gL/SG1JThYQ2TdDrLU8F/wO1Mf4htiQfG6b+++FC6DPHouWGYZY/6MjvnwsX6lAuRDhMFbWmcf7fljle9xo82qHqfPmujwU43r2M49o//x+hfNMhE7TWRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728736822; c=relaxed/simple;
	bh=V1Puqdghk72pzDDFphZLuyqAk3pi1ZW07Pb9Y7Gz9b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WidkFMVszCxxbMbKa/U3cWR+uXFKbOljD6lrCMuiZWIV5DBsKaXJ3sUmwUsgFClIjHrcOS/w71DWLNgY88LOHaKNQZNC38ETTf3yUtWQM1lTsjnUJJ0Y0YmWXB7zDSIODCdS2B6Lbdep3nutSQsuWilyKoT/ZJR5dVgNdgfqOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w5dNrZpB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9951fba3b4so451171766b.1
        for <linux-pwm@vger.kernel.org>; Sat, 12 Oct 2024 05:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728736818; x=1729341618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+rG8KtQ9bLGvJOAcuyD/foz5GNktrddWbP01zgWiWtI=;
        b=w5dNrZpBVao0XjXiLeCYcyWon0yR5VDETwYAyjR0bjx8fmaEy5z7jCENKUXnFMa8dI
         xBNk+ursdyNYZuuOpGn1BQaAIigrEOsJBqwkFMokriyM6LnW28koMKHlst9gLkNtJ2Fi
         e8cJF0CzxFpYRIQOz4/doPimFblKxnGoUv5RAdHuGBxdEvjcBUVcK/WYIf5TWge/NRbb
         0o8+gsnJWbPWj3g5x1Jw70hc0c7YNphHYVGdDpEPcBo54OvQ0oZNAtF/0CKZ7Y5nkNp3
         7eDLcHZR3ChJyfXR9H6nfPYEDjCg5GvQVqKa3Gtg+Y9Fk5wYE78/MoUOEDASlKR2Tpzm
         CZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728736818; x=1729341618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rG8KtQ9bLGvJOAcuyD/foz5GNktrddWbP01zgWiWtI=;
        b=bntjRYNPMJwDDVI9y7IqKVSZ7lBbwHjpl4iNuYzd4sh3Qh7c89/r1GWvtTUWPI3CNS
         X2HBDiQVWsrc0wuM/snJjz5YZ8LeZRi49xqj/FB7KegkS6slULy+QTIL/+CKy8leAunE
         lOidMu+t1w2+ZirslH4hO8d9acxfcxZ/4oXs+KaDjriWJDhOT4zatBkkg3d4SQP1Kb1N
         WJkBNiXEV90j57NvUvFG0l2Z/ITfPE6AFJSx+fbQSuCG5uop3WtL91c3fPdLqRmBbyyz
         Dos7IcwapRevK/W2V52PIrp8YgmhPzCDtCPrN9HKpphVzrFzJoDBo358nizznE0pVh0F
         lhBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCcCrEg9pf9QJNcgk67+FZcTY5u2yzgutleHDS68npN/A5Cd6kpK4duPbbVoR+2hJtAGF6YxRbRMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHcRwjp8gxfHKa7aauqsGuHTc1YPwFrdeoy7iCfyh5Gs4LgawR
	vt6bPNuufTo4Renum0NpUlB+UD3LJA6hdFfDLp5oAzE+MoWSxDwHD10WgpeoKoUjw9rv3fK2IR7
	N
X-Google-Smtp-Source: AGHT+IF4mu9w8S9hKbzqQm4czFhZ2yVLNuU9Fl98nzVzJRXAZ3huvwGn2C81CVNaqQGtSqCqQCmiYQ==
X-Received: by 2002:a17:907:f70b:b0:a8d:4d76:a760 with SMTP id a640c23a62f3a-a99b95e86c3mr493081066b.35.1728736817861;
        Sat, 12 Oct 2024 05:40:17 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:eee4:9efa:9b7d:f254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f8bdadd1sm12231766b.153.2024.10.12.05.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 05:40:17 -0700 (PDT)
Date: Sat, 12 Oct 2024 14:40:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: William Qiu <william.qiu@starfivetech.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v15] pwm: opencores: Add PWM driver support
Message-ID: <b6izzukutuhrbgxrhyu6be2wcs364rtrpvp4lenxsq47f5nwjv@bb2d54hjw6ao>
References: <ZQ0PR01MB12538557D7C48C3B2ABEFBA89F7A2@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="onmps4ud7ka742jx"
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB12538557D7C48C3B2ABEFBA89F7A2@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>


--onmps4ud7ka742jx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v15] pwm: opencores: Add PWM driver support
MIME-Version: 1.0

On Sat, Oct 12, 2024 at 08:02:57AM +0000, William Qiu wrote:
>=20
>=20
> > -----Original Message-----
> > From: William Qiu
> > Sent: 2024=E5=B9=B410=E6=9C=8811=E6=97=A5 18:43
> > To: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > Cc: linux-kernel@vger.kernel.org; linux-pwm@vger.kernel.org; Hal Feng
> > <hal.feng@starfivetech.com>; Philipp Zabel <p.zabel@pengutronix.de>
> > Subject: RE: [PATCH v15] pwm: opencores: Add PWM driver support
> >=20
> > > +static void __iomem *starfive_get_ch_base(void __iomem *base,
> > +					  unsigned int channel)
> > >
> > > Would be great if all functions had the same prefix. This simplifies
> > > debugging with tracing, because you can just enable traces for
> > "ocores_pwm_*".
> > >
> > Will update.
>=20
> I want to explain something about this. This interface only works on
> StarFive boards, so the "starfive" prefix is used, I don't think the
> "ocores_pwm" prefix is appropriate here.
>=20
> Uwe, what do you think?

This function is part of the opencores pwm driver, so ocores_pwm_ is an
appropriate prefix.

Best regards
Uwe

--onmps4ud7ka742jx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcKbiwACgkQj4D7WH0S
/k79EAf8CgFKy4qpPxymtEsbDtSCyBfT2/4bNhOd3D4eyZEUnd5Oci2lTa6Na/PA
KQsBzzGZHfDZg+Bd9hm3H2Ly9bx+vwLyaepI7L2FpCbXMXvxlPoNfmyq7oSzIN7D
Pmue1JT0GodFxECQZTOQm+ul4MlV7M0vy1fjgj0JbhxicsE00gpNNO+BCRLJH3rS
70BbyJoGmXlot4OuWENDleWhcwvRbWwfZ2Dybe48BrufUuE7u4zfXi71kD4wb4Ey
ntSmmRRGDIDB0SHaHiEFsRJbjbGRXuGBs63Q4TIgVpD1aaUl8NHSB6fcuiDxzZPz
3gvjDWfpdWnTC/yUf5jRk67F0z85wA==
=P7Y/
-----END PGP SIGNATURE-----

--onmps4ud7ka742jx--


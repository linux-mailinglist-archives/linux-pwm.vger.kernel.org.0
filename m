Return-Path: <linux-pwm+bounces-6910-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7953B150F9
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 18:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065111880509
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2AB1D9346;
	Tue, 29 Jul 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O0GVoZEJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9F186295
	for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805507; cv=none; b=fA+dpUybVRyJV64fDlfnzNLXbFs5CtWOPo/iCIqubgoGkQGYfgDgH4/EIpRVDl4vaxKrH+NyWJCgxrWSvdT2p5mY62YWIVphT11PsKFAFJldrTcpM7BbjrPI7omGH25+34r0hvT2r+R1j9Xr3xlCRIkbQumCXKycsZPVIhsNc/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805507; c=relaxed/simple;
	bh=VDtPTKqTc5z/jqP/+uh8ORCsNOPfoYWtzoB09pyCPhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO/AZ8RJ/nC2sBGryTu5hq2oiSJ3EHV0rBHAUPyJe1dSatD24t5kLi3LpSB44eMeXvT8rhTEtcsybIaNjdSm5RtA310EkudA4psdYeFEdOG1bNLXqFfP5Bsxgqdr+dMdhrii68mcYn1aetDmywGMtQlaC7LaJOU9wPvvO/0LPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O0GVoZEJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so35331135e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753805503; x=1754410303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NE/MXzUMZS+44xcmHH89HI/9f+w1SgEl87LO7gVP//E=;
        b=O0GVoZEJjtHAZa/hV12vxtRnbydpi31Cxo+mdEFhbU1mjWxxBjHRMfrfdYnpZXoZSQ
         6Vuovi+ljPLydjqEu2Of819+34V9GPVgvrfq24LcKSxapVV+5a8CXNNYm9xwl9CDJBBR
         KsnwJtWzVtuEba/syjtO8PUqbqc63AMre5+/CMYgofSUGm+UENyFNwyzZ07yMa8nX7IC
         TZkacIWV4fJy31CsrktgT62krKDWO4AQCn7OKljp5VnO1toT5d2Vw/0LTerB5bCkfLkK
         W9qkVyz3HG/RQqZIWZYbVvcowhcONaSCJTqckcYneu63GAedM848C5PQPOijSUXobw+l
         UiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753805503; x=1754410303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE/MXzUMZS+44xcmHH89HI/9f+w1SgEl87LO7gVP//E=;
        b=hX+F18UD/vtvuD+rTmgMYjjASBgWdptKI1zi/uvj6ab2MivKKDEz5E+K73b2hxgkn/
         aNqTgPQKcEGbmFioScs7h/2udbzc8odjRwXo+LnI3J075GveZgs7l9gJQJ7GaqgXd9IU
         R0PKNNe65pHls9HPFVxVNAOlx42ILe4/7ZW8sl830Iyk3TTJkGy6tZViuj/i9UPT4lKA
         sKM4hK+prhFefUcZKsF/Cfjkn7+hQW98WfCXo99tphQbB/seFtJ9wVFhMBztvkPLw0Fo
         zuRGBBsCOgo1cFQCnfR+R7KaxiNPfehbnDRsLUJnvyUQDeLrIcPsqiBRVrhYCbF7EsNb
         xgSA==
X-Forwarded-Encrypted: i=1; AJvYcCXxqBGAXR6XxbxgegTMZYdQPKNTNfTXw6uL3JoC+M7WOC0ASwy1wbcO+ecSEI3RNmF8sxFLZkmIjg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5zAAIGFH7UaSuVFql3zf9QRvuoGfPu7/ljK8EjJWwAEYGx85
	6IQKWnwrPbx4OWV34a3PtiMdJubSusO5zE5LXXZcUJFS2lQc6B5rSlong/BPIam+P+0gfe9JcKc
	Bkrsc
X-Gm-Gg: ASbGncu1j/fetcT6mV6DrjhXmBJMsjlf2NRgdljHpGVx+2ZI4OSy7hDJ7Ned05NTV/X
	0XTQZMQzZmvxY0d0+WMPPQU2XpB3tU914WLVkuiuc3+OgY/Da3iCqRqKMSXhi2KVlQSSFHQU046
	wUqpS0btmDZDzTLWjVY1LmF5JR6i+27jD2Gj1AEH8gUj59u69c+6uIDnFfbhZFlr3dN0rRyA2X7
	eBY+aromDiEuJ0uiK78JfijCBXbaAFZ3NiJhW3zXQljdsUDE4CQ35rO5zXt7mPzGEMRI+4VhVpE
	7dVRtVJFveqQMzMMJEPghSl5iH2Fk8qwKLQEltO0L7RAafLfjlaFzRd+6Q8dRf1Eb6YQSrIyver
	CdvgX/PwfAeeXtj4lp78qUWr20pFbZZ+MkNVeW1Xl05KGqSNQ6OL2jVgE/DjIJvyx
X-Google-Smtp-Source: AGHT+IHiv1ekgWGQ9lIBRubNcJRWHtn+F6BZSVr06aOsETrpLIQ4sL11Zd7N187ZXHB8fb0D1LxR2w==
X-Received: by 2002:a05:600d:15a:10b0:456:24aa:958e with SMTP id 5b1f17b1804b1-45892d3779dmr2509355e9.0.1753805503409;
        Tue, 29 Jul 2025 09:11:43 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4587054f686sm199914665e9.14.2025.07.29.09.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:11:42 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:11:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 0/2] pwm: mediatek: Fix duty and period setting
Message-ID: <uqazab4e4srnpw3lh7ewxmlywbdvjgl54idhqi25n5oegfd7oe@7nskmsyftfr6>
References: <cover.1753717973.git.u.kleine-koenig@baylibre.com>
 <bb4d8100-ceb2-4ce1-bf27-86fe21ce2aad@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qjtsiiolmtxft4yv"
Content-Disposition: inline
In-Reply-To: <bb4d8100-ceb2-4ce1-bf27-86fe21ce2aad@collabora.com>


--qjtsiiolmtxft4yv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/2] pwm: mediatek: Fix duty and period setting
MIME-Version: 1.0

On Tue, Jul 29, 2025 at 12:07:43PM +0200, AngeloGioacchino Del Regno wrote:
> Il 28/07/25 18:00, Uwe Kleine-K=F6nig ha scritto:
> > Hello,
> >=20
> > here comes v3 of the (formerly patch, now) series to fix duty_cycle and
> > period setting for the mediatek PWM driver.
> >=20
> > v2: https://lore.kernel.org/linux-pwm/20250724210041.2513590-2-u.kleine=
-koenig@baylibre.com
> >=20
> > Changes since v2:
> >=20
> >   - Split changed clock handling into a separate patch (suggested by
> >     AngeloGioacchino)
> >   - Drop
> >=20
> > 	if (err < 0)
> > 	        return err;
> >=20
> >     just before an unconditional
> >=20
> > 	return err;
> >=20
> >     .
> >=20
> >=20
> > I didn't add a R-b for AngeloGioacchino yet, as it felt wrong to do that
> > for a patch that he didn't see before. So assuming you're happy, please
> > provide the tag again for this v3.
> >=20
>=20
> For the whole series
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Thanks, I added a Cc: stable and applied it to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fixes
=2E Will give it a bit of time in next and then send it to Linus for
6.17-rc1.

Best regards
Uwe

--qjtsiiolmtxft4yv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiI8rYACgkQj4D7WH0S
/k42wQf+LyIe+PzHJ/dc2HatljzBygTMblA26mlrv0teYNlNBdKlX7PnqbDXfUWP
vMC2CPTlk6JPJFCmjSHo/vNDb8EEnkmntXlsl/eYes3Hcp1VBUqsc0BoKy2NjGJk
z90KVF7RsaJuKX9mb+1noo4LK/fPydLHzuwNBlPQJs7upZWxWxUe21Qzz97vJlhn
VKru19L8uGvL8rN+anZzv5Vx+DLHOBO8ukE6MDQ+znDgsjxoWCByhUrPDfXNOhK0
BzoaF203kjqj7LzOxNKqYG26vZTXhZc+qe3BtZMziqyIgZP3rAa05jFaZdsqGZ+K
rOvtkC+kH0yS/cU5Q5XSS7HhqsyNZQ==
=mMtw
-----END PGP SIGNATURE-----

--qjtsiiolmtxft4yv--


Return-Path: <linux-pwm+bounces-189-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E7A7F7401
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 13:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523DD281788
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DBC1A708;
	Fri, 24 Nov 2023 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsB3oVb1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6949610F3;
	Fri, 24 Nov 2023 04:43:05 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a0029289b1bso265410166b.1;
        Fri, 24 Nov 2023 04:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700829784; x=1701434584; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMErWZrHTt3cloUIdPXWfcnvwVtdPhBsLJxO7JmzfjI=;
        b=YsB3oVb1GxUztA507xBQP/TfTW8p+iycypbDsX+cWINx6453gw7PpHLiqrIO2BwYlT
         9FewjEpDq3K8/ODdh3i7zU7AqE1+5HICujn5rVLIzmx4vfYElw2p6UVKFL4B7W0CriZ0
         sBkVrYb2q89/+WTdB2y5NjawRQ9/4Og1zfjYxIWhpLXmaLZJ8ZCpcGCs8MxIowis3uaL
         oROpjaQvPtRRIgm+oXPfUSjoSnBR2yRXSmehpg6KFF0wzJ6+K7/lyG+fUL1sXqCaZaIc
         jGx+m8r7DLEiG1NEF/XTZbCIQUSO/KXPWGdUv4kawiL+6SgINoSF6a1jtMRcpKodOSNJ
         B8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700829784; x=1701434584;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMErWZrHTt3cloUIdPXWfcnvwVtdPhBsLJxO7JmzfjI=;
        b=woSVa66NUwIjNBsBLiSgbiz0sJJ9Y72XnZjRvMdQudiFH+KpjHpUorrm5uvQUOIcOv
         XJeVzTIm76g8yRclh8t3cKNTgRHg40Xa83EX4Sc93IeaHAk1N1TYb5zcvGNZQT4CXUAr
         5c51wWbnANBSh1cidn93wxb+TUARYLLXqRiCHOplBkapz9w3fzM4dpxtpX29rujO9gJ9
         /1UMIrVWTapWUB6FeuM8koj+YFH6eHFjJ2lZX431ZpSVF2V9b8RaK16hjZq1oIV4Pqg9
         39/1Tdom0a2prFd0GLhlci43MVOcTZUqY97tQG7HR47C7hSSHOlE6m/wowU6kcAMwhMb
         lNiw==
X-Gm-Message-State: AOJu0YyAE0DBRAghSNJ0ND+1Uq9Kw8cTlGQHHDrWJUuM7nhJnb04dan9
	4ppXwfDQ4Ab/cInWhMrDnOzBhe3VnO8=
X-Google-Smtp-Source: AGHT+IE63XXr3Ab/N/AfUN1orWPUu9PZPQZBLkVwDrlTTw/T1+DMwP7B7PWEHI6L6vkT4BWNQ9Q0Tg==
X-Received: by 2002:a17:906:5c3:b0:a07:bf30:aad2 with SMTP id t3-20020a17090605c300b00a07bf30aad2mr1889725ejt.70.1700829783628;
        Fri, 24 Nov 2023 04:43:03 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906594e00b009fc6ac28110sm2010048ejr.20.2023.11.24.04.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:43:03 -0800 (PST)
Date: Fri, 24 Nov 2023 13:43:01 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
	linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: jz4740: Add trailing \n to error messages
Message-ID: <ZWCaVQXjlBHMW8Jf@orome.fritz.box>
References: <20231123083322.405390-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zxQAM6/8SI+n8N3I"
Content-Disposition: inline
In-Reply-To: <20231123083322.405390-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--zxQAM6/8SI+n8N3I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 09:33:23AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Error messages are supposed to end in \n. Add the line terminator to the
> two error messages that lack this.
>=20
> Suggested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> this was noticed by Paul in
> https://lore.kernel.org/linux-pwm/ba21c20b20364a39d5ffff81dac8bd300a746db=
b.camel@crapouillou.net.
> Instead of sneaking this into a patch that probably won't get applied
> quickly, make this explicit.
>=20
> I based it on top of my PR that can be found at
> https://lore.kernel.org/linux-pwm/20231121112029.gyv3gqirlycysyr4@pengutr=
onix.de,
> but applies just fine to v6.7-rc1.
>=20
> If you want a fixes-line, that would be:
>=20
> Fixes: 485b56f08f33 ("pwm: jz4740: Improve algorithm of clock calculation=
")
>=20
> for the first hunk and
>=20
> Fixes: ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver")
>=20
> for the second. If this is backported to something before
> v5.10-rc1~57^2~11, there is another instance with a missing \n.
>=20
> Best regards
> Uwe

My recollection is that the newlines aren't strictly required because
printk will typically insert them itself (unless KERN_CONT is involved
at some point). So I don't think this really fixes anything, but I'm
willing to pick this up for consistency.

Thierry

--zxQAM6/8SI+n8N3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVgmlMACgkQ3SOs138+
s6HQ7Q/+PRsUZtwRYInEotcw2KDEZ+cX3yUhsSpuvrwh904N8Uwz+i7+Y2cfdfBP
Fk6wydqd688NAMSfNguwTNP4R3tSYFamumTuG7nK+0ULqpuK4GQWuHXUXACMo21L
WMnb1c6mQcRNS6lUf8lH1ZYpDUlrF3ThQANTHq8Ta6DKmZECmMf9N8zxvbLO6P2q
Fd+F0mcjA3V63cAWTDGM84ctD2IbaK1OlaKfYzG6V/iuD69lsfHGOZP/5H1JrGg1
jVwXcFJErvw8o4KO3pPRkR7UuAGbBdUDdmQrgxbNnEY5TQfCph7no5xZfDJx9eMB
T+PG54uDhd1TBbZ9H5Z1DhIOp6z89QwC4E7Ju2W0XHmhKK7IhnlD+jkJUVn7g55C
BDt2XP916MyAlcpAHM143nqj25AVBFK28eBbXzu+wHejpWSD5WJZ99fmlH0X6Dup
33ksQcQHBl6rcQkFBhPkax0Ujw7LCwCiROGj8XFMynZj5nbR0D1kLhAUITZDadt9
dmYOq9DcB2LSFJxBTNtdXmTE4CR4J+vezLk6Bhv/oUnDHXVwNwIGvrecuY6oh3yG
lubz4gCGLTyzOHYUdE980saXPTcUaEu0RL55kF+4v9HF0c3Xabjpd6oWP4migp6S
dB3gz6EvPGLLtuRytaeUpTQt0ta5Ps9hMkOavyJddaGnUZDLzho=
=4Eno
-----END PGP SIGNATURE-----

--zxQAM6/8SI+n8N3I--


Return-Path: <linux-pwm+bounces-2479-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20238909C58
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Jun 2024 09:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAAD1F214D6
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Jun 2024 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3562517E8E5;
	Sun, 16 Jun 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k333oxvK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1C16193C
	for <linux-pwm@vger.kernel.org>; Sun, 16 Jun 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718524056; cv=none; b=ktPKI9gvaftajQvvaiP9LxhEw6vKxZAJp8qnSO9aukuzQUZE/ri8xZBgLjJNJOoE+8yl1kkHN5rKIJ7Q3qeIPdO5C5C4X4+9ZTCPeBQtzDYs9lC9C5xUrzrOZFa5Y40Wcbxma7V6Yh0TIaEw1pjY8fIWqLWqFtErfiQsKq5IFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718524056; c=relaxed/simple;
	bh=cbRwOGpTQAw7QyQMXY2e/GRZYittWxawomsr1hSyWCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzaqkuMkx0KdWlr4OD+IOrNjWZKD8x/1ovY/+MnT6nz/zlHr+rl0QyE111ix0DzxhCsXs0qY9KOh/jBf06Mx//vZhl/PA9WUWk5tEV2wOurLlBmGQHcjE9bkBJ29uCsTlVxqmU2xxJZmShOPN/k/Qn5evuJAiyqUklN7KBYvLas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k333oxvK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c73a3b3d7so3900814a12.1
        for <linux-pwm@vger.kernel.org>; Sun, 16 Jun 2024 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718524051; x=1719128851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbRwOGpTQAw7QyQMXY2e/GRZYittWxawomsr1hSyWCU=;
        b=k333oxvKYvboe4gURntJ5Jr/2sxUZmkQedMeqZyhJ7xrL2x2dx4CwVeKt4AS8oWOTC
         PIC/ifwPN7LU5D+32YREPQtcaABAiTKC4rV4qlN2XpnMVteMmXfiKPRRu/D0HoY1wQdT
         drOayEZiXjKm+3WddaXhgaTMWFGalNsfxZnAZUtTnaln5shmWg8BAylImXrcop+vf/MC
         zI++Iuq3Tzi6m8YI4RN6aXRgd088yFBZpBdO6Y/brjb+3p+T2+yeOHpSg8xCPhr1EcT2
         q70C7Vxj3fQT8YK4qslZ/X1sqk4n02fps2UwcwdXkvcCA+USMr3IuzXoI247rgqEFYGG
         jaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718524051; x=1719128851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbRwOGpTQAw7QyQMXY2e/GRZYittWxawomsr1hSyWCU=;
        b=gdXcs4s9L31ScIvv8RNSRi5I/hXtqboOjJzxMesHzrLqkBNVrSyxEwWt9eFMiyH2zV
         b/oBwTnAEDERNVYeLllzCX0FZnMx5+snrsqLp0pw5zIbYEwo1l3yxpqwuLleLYpnzIIi
         r2yqruaPhNVO527L8E8d4LZjfKp7xb7465wnGjMqTE4wlGzKsDEcWKDrz+uVIPAUbPZC
         Boe37Baq7JtpYbcf7J+P5ggpjQ6NihM+4tOuMqIwvEitpd8Qnh8tWajAPPDOENhYhsA+
         U4EQ8s45A2iJCKcPfmhbCLoAHwbFj8PQN0ScF7szk5VT1O0lX90Kf6udOxxHxp/n9roT
         FMig==
X-Forwarded-Encrypted: i=1; AJvYcCWbcpMuSAAbSXzaIZL/CFqN8GfDI7EnbnNKeQmrMyBT4/KwR+LG2RFoDa0ekmtKbOcZI/i5DaAgOhs2KMv2B+cA0xXRwzHCCOjZ
X-Gm-Message-State: AOJu0YyBzXU278kqQcKJY34eckQUagLqJWpDdnDIG/RGiHEAPBKZJLHk
	S2MG/NDraw4iPDfvSgC0Xl/yJc2Ymaza8jo6BWvIltKmgQGWmlr+E7bMNIJLH/0=
X-Google-Smtp-Source: AGHT+IHa/rf4EI962S3HpLXedVKT5xj1yJxkZ7J2wW4h1OWkMAOVQAbsR1cG8yjaBasIsvn47d0zFw==
X-Received: by 2002:a17:906:2697:b0:a68:a137:d041 with SMTP id a640c23a62f3a-a6f60cf384bmr406033166b.12.1718524051309;
        Sun, 16 Jun 2024 00:47:31 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:3886:c8fd:3fff:b697])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da4136sm383728566b.36.2024.06.16.00.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 00:47:30 -0700 (PDT)
Date: Sun, 16 Jun 2024 09:47:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [RFC PATCH] regulator: pwm-regulator: Make assumptions about
 disabled PWM consistent
Message-ID: <htgmpafra7fehqfbsusiraed7eny5linma3hrvv3nkuqp3bmuw@zisvojdwymee>
References: <20240610104600.458308-2-u.kleine-koenig@baylibre.com>
 <CAFBinCB+S1wOpD-fCbcTORqXSV00Sd7-1GHUKY+rO859_dkhOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncc5iil27kc3ytrv"
Content-Disposition: inline
In-Reply-To: <CAFBinCB+S1wOpD-fCbcTORqXSV00Sd7-1GHUKY+rO859_dkhOA@mail.gmail.com>


--ncc5iil27kc3ytrv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On Sun, Jun 16, 2024 at 01:10:32AM +0200, Martin Blumenstingl wrote:
> On Mon, Jun 10, 2024 at 12:46=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> [...]
> > this is my suggestion to fix the concerns I expressed in
> > https://lore.kernel.org/all/hf24mrplr76xtziztkqiscowkh2f3vmceuarecqcwnr=
6udggs6@uiof2rvvqq5v/
> > .
> >
> > It's only compile tested as I don't have a machine with a pwm-regulator.
> > So getting test feedback before applying it would be great.
> Unfortunately this approach breaks my Odroid-C1 board again with the
> same symptoms as before the mentioned commits: random memory
> corruption, preventing the board from booting to userspace.
>=20
> The cause also seems to be the same as before my commits:
> - period (3666ns) and duty cycle (3333ns) in the hardware registers
> the PWM controller when Linux boots, but the PWM output is disabled
> - with a duty cycle of 0 or PWM output being disabled the output of
> the voltage regulator is 1140mV, which is the only allowed voltage for
> that rail (even though the regulator can achieve other voltages)
> - pwm_regulator_enable() calls pwm_enable() which simply takes the
> period and and duty cycle that was read back from the hardware and
> enables the output, resulting in undervolting of a main voltage rail
> of the SoC

Ah, indeed. pwm_enable() looks so innocent, but in fact the details are
difficult. One more reason to drop that caching of parameters in the pwm
core.

> I hope that this (especially the last item) also clarifies the
> question you had in the linked mail on whether updating
> pwm_regulator_init_state() would help/work.
>=20
> Regarding your alternative and preferred approach from the other mail:
> > Alternatively (and IMHO nicer) just keep the pwm_state around and don't
> > use the (mis) feature of the PWM core that pwm_get_state only returns
> > the last set state.
> I tried this to see if it would work also for my Odroid-C1 board and
> I'm happy to report it does - see the attached diff.
> In case you are happy with this approach I can submit it as a proper patc=
h.

Yes, I like it. From a quick glance, I only wonder about the dropped
error message in pwm_regulator_set_voltage(). Probably it's right that
this function is silent, but then this is orthogonal to the patch
we're discussing and should go in a separate patch.

Thanks for your valuable cooperation.

Best regards
Uwe

--ncc5iil27kc3ytrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZumI4ACgkQj4D7WH0S
/k4Txwf/f9Fb540sNFCp2PnXCtk5/OiMtk1Vctv3I6yS+cRb9ifz+NIvu7doQHhe
BLS+bk2Hayvr24rts1jVJ70ElCM8MwthQE6xMQExMzBJmjuXrQuKoKKnicKTMciz
bw6ByBnaeaOczYuWQ8aihPTAs4MD6HJ/04hVNX9JiSJ8h7jNd3AnOPMTTI/C6ttS
HoDVPMCKlY+rMoIkfvgv5rniQJDpLkCN1aqYL91WK0YW3/eu5o3tfgNxMjgYu25K
EqVzjPmyh+s1VCJbXFOuSMkJFxq1jgHIjQtfzyM84KuvLD6+6nEmlB3sYrOFS+KU
QZ6L4ciDfY19HFbY+BEN8TOK8vtulw==
=WQXL
-----END PGP SIGNATURE-----

--ncc5iil27kc3ytrv--


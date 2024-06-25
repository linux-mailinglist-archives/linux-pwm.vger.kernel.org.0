Return-Path: <linux-pwm+bounces-2611-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC696916AF3
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jun 2024 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F007B1C22D68
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jun 2024 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBB216D4F6;
	Tue, 25 Jun 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qYfM3O/c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2710A16D33B
	for <linux-pwm@vger.kernel.org>; Tue, 25 Jun 2024 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327016; cv=none; b=C2yu00k3Mtv14T7dp/4E+AvgmUNtD2Xef9HyUoyaeHz1DazeftGW6AhQ6J/XfX0nqKCokiwH2bg/QlIraXwahCHp/KE2xfZJISS0IyuIeQtZWK7twPle2h1wqs+hhAgCN7Q23HvksPgh4gdHHy0NeYOVStOBNt1UAi14texabso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327016; c=relaxed/simple;
	bh=jWqxo3mchFiP1MenyU8LEUTbrCGM0e3VDgqj6/yFdZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5c1egNwHG5OVEY5pCH6US3cNdJpHkJeHM9codFPr8Zrirub9DLgw18E9Tc5U4dDa4yA1cy2Etp1iGrttvNqReQAUZ4CswCo3CSvlq91sFMCOFvAQXUdWst2CgGGTWEI4CQRnHotWAzPv4cg2cYOPGhOc6sCqgokdUhuq3Y8B18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qYfM3O/c; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7241b2fe79so366340466b.1
        for <linux-pwm@vger.kernel.org>; Tue, 25 Jun 2024 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719327012; x=1719931812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWqxo3mchFiP1MenyU8LEUTbrCGM0e3VDgqj6/yFdZw=;
        b=qYfM3O/cTetPun2wmSIA5WBfU5YLvzRKVPMT5RZezoyhxu09FO6WTaC1JPSrVY/89k
         /c/iKot5HxBCtuoIT3djg6QuDV+4qDcFuUwVOlQcsNqZpgY/7oCMCMmOsDKrSOYsugj/
         cUtOM9O21jY7HeEzeoq44hj0eCGDwnXa5moL/VwvBmXs71aC0lGpz5UDnsiub/6Yol52
         eddjPhLGU1vjTOMMQGLjijo6tC0xXyaHLpDuJIUm53mKatOD0GXx924mSMvybTPWG98v
         gRFkcTIF/aK13mtBhIuMf9YySXZUkMZyliDvy3atp+KN5TC/XIY5Sat4k/7zcWntDVf5
         Eryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719327012; x=1719931812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWqxo3mchFiP1MenyU8LEUTbrCGM0e3VDgqj6/yFdZw=;
        b=mM0/PTNQvxj/SlhxOJ36krismcrV1PirVxh33g4pYW6jdujhu7ibQAJUP/yq1odnxe
         u9PugVFoavNMdmSky77NaNHNu4EgXkAF/CkfkeZHBZUU0k6RoNSI7syefz3kBDii7pOA
         zhobiJ9Tk53tf/Cc+/2vH74ov8eOrswqJa7FWF+cKsalHQ9Ge8Xnqsyq5MZQy33F/dPE
         U+DH7jPgCrtp1/c3tnMaLBuqWfrkbzq+X4frYZryo3iACkRb7WyTfVePTBzEpt1y1nXR
         fi23lONiNHiFkpAVwaU6OiW6MZbBTFlvzWtQjHKsHNjjF8H4Dxt7pCmZ2e6nxDxfqF+F
         xuQw==
X-Forwarded-Encrypted: i=1; AJvYcCV7JkqWxz2Ir4Xupun4SKGy3aaRLOVhmsA5++q9KXWQ9wcKnKB/Cu5ojKmsDL6EV/UgLmvWQRX9Fz3/ZakpUswcR/EyuwVFDfnC
X-Gm-Message-State: AOJu0Yy6FrFa9OGc5m7TVgxjRZBHhEqpbKEMGuk5ho1gUQeTuc7P/XrO
	8uFFSa7/bu9cXW6UlYTBbJV44/2Jq46UsEKdi/dFw4rwtqhz0awfgE+3RGuOGjc=
X-Google-Smtp-Source: AGHT+IEwnwBd/P6t2ddwhrLb8bvz6kYx+1hLSg0mmfREs2jeseCHj5DRkS89BkTTTiW651tXR4AAuQ==
X-Received: by 2002:a17:906:70d6:b0:a6f:e8ee:9e3c with SMTP id a640c23a62f3a-a7242c39107mr509610266b.22.1719327012436;
        Tue, 25 Jun 2024 07:50:12 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:aab0:97bd:4d50:ddf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7120187c22sm373994466b.110.2024.06.25.07.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:50:12 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:50:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Kelvin Zhang <kelvin.zhang@amlogic.com>
Cc: Junyi Zhao <junyi.zhao@amlogic.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 1/2] pwm: meson: Add support for Amlogic S4 PWM
Message-ID: <coriionza2db7jqz23bcig3zwufktgdbfakixcrlllxrqkomcj@zle67mswm346>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
 <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
 <1jfrtgj0so.fsf@starbuckisacylon.baylibre.com>
 <tnwdnwiruoty5yd42bmkupgg6hjxib5lblhqcyouoyx5y3zvnq@2d7cnrei24m4>
 <1jbk44htqr.fsf@starbuckisacylon.baylibre.com>
 <948ba34a-1e05-45c4-8ba7-66c72bdb6fa5@amlogic.com>
 <6bzysc3jwugo3epcxsef7uupk536prsc3phlf3m64n3jjwpxus@2uigg44uotuh>
 <9b457c30-6093-437b-b9af-44c3a768020f@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="be37srvqrjutjyvd"
Content-Disposition: inline
In-Reply-To: <9b457c30-6093-437b-b9af-44c3a768020f@amlogic.com>


--be37srvqrjutjyvd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Kelvin,

On Tue, Jun 25, 2024 at 05:33:22PM +0800, Kelvin Zhang wrote:
> On 2024/6/17 22:11, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jun 17, 2024 at 04:44:13PM +0800, Junyi Zhao wrote:
> > > > > So yes, please use dev_err_probe() also to handle
> > > > > devm_add_action_or_reset().
> > > > My point here is also that devm_add_action_or_reset() can only fail=
 on
> > > > memory allocation, like (devm_)kzalloc. Looking around the kernel, =
we
> > > > tend to not add messages for that and just return the error code,
> > > > presumably because those same 'out of memory' messages would prolif=
erate
> > > > everywhere.
> > > Hi Uwe, I didnt get the clear point.
> > > So, if we need "return ret" directly? or keep "dev_err_probe()" to pr=
int?
> > Please keep the dev_err_probe(). There is a problem with that approach
> > (as Jerome pointed out), but that is about to be addressed in driver
> > core code.

FTR, this is done in
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/comm=
it/?h=3Ddriver-core-next&id=3D2f3cfd2f4b7cf3026fe6b9b2a5320cc18f4c184e

> For this patchset, is there anything that needs improvement?

It's on my (not particularily short) todo list to review this patch. I'm
aware there are several people waiting for that one. I intend to work on
this one later this week.

Best regards
Uwe

--be37srvqrjutjyvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ62R8ACgkQj4D7WH0S
/k5S+Qf/SNvnQBfAaVksxx8eIEYT2jY0QUITMY+QWmZsieNi/glkSoIaiy+VWXyg
Pzfhjo4Z+GwYudqoI7gq/mzllhM1I4H2O4poOEw6YXjZxjdAbq2FfBdljtlOzHIn
W1uQnE6r0UYEPpfMQH4GIZ1VrxhluhAzz7dPcn7Ja71Tqj34pCP7Z2zFI6vXlJHa
AHEx28lK05wnnWMYqBElrZsEe0Jqj0KfrL9Dc87NNzvA/MAdqqe9MUIt6/8V59D1
VRpFgVhCGXve2l+TtRvB5gpkRAJ4DaBV9WNxoph8+9Tis+IB5efxsCFXrDR/ym5f
Xxco7/DhoBatXM8sLd8EYHf73vxhmQ==
=87Qb
-----END PGP SIGNATURE-----

--be37srvqrjutjyvd--


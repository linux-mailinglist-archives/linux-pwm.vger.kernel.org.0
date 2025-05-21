Return-Path: <linux-pwm+bounces-6072-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D04ABF7E2
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 16:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCB84E677D
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C531DACB1;
	Wed, 21 May 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv1yJImk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AB1D86D6;
	Wed, 21 May 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837965; cv=none; b=n9OxD9JXbt3Lbg7NAYUaFsKYpcqAYgWY+l+7NC0SpRy65MqzGCEguBwu4WtxQpEAB04PE2LlNZ5LiNzne0/ZtMks1CsYp6aj4NjIPipZIgyFKPXOjLazNekvPfueGxwN1OvCU9xCr89gRn8QnKGaQNtj7BsgGoOXJ3vsos79XrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837965; c=relaxed/simple;
	bh=bYQ6wgfogiTvlk1hDMEvcfMoNQYaVQKijPrQost/HsQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LM6hAksFdm8EAtdXUjL8JAlg2E9kWpazdfOgTO1uMF1t2ffyzhHGC7wLRtGlody/04S3Ey7hUgwp6YLAQdPkC9chPFwDuWGeWKcrd1QWysygFGptly3sUTIMfHAlQwULXgeSPpBkog3/HrO3hX3VMWIlkYEzZznabeMycmePnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv1yJImk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a36c2d3104so2340201f8f.1;
        Wed, 21 May 2025 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747837961; x=1748442761; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q3iEyb+roNUsk+D5mJFXrZuo8v+SD+UnUIu1KPYIkKQ=;
        b=Nv1yJImk/J3joLo1q97m6z8+i7+/lt3QlQpdLiCNgoR+RE4p0ZCVxdME0QI757xmzx
         DOPyQzX6Xt0Ds1p52sam1nq7z6ZHZnkCOo8MuB+afMOBEmNKEXqj6KjY2Y3YB1jx+xqB
         2Afmm8WBHa1mD8lChmdE/orznh7RPhcYrH8c2TzUNVn7jVIaGmynOO5fqXVYMQe4G1/N
         A0P/9h7EqiwuJhMqcAruOWTtcXDUdW/AV2Y/FVdavnXrFlbCdqGwD5/FCD9YLBeAHazD
         uDBLT5S4gd03/J9hYDH8xromxXVWEAkluRSlWKsg8U/y+jzsUYP4Pp/lR64vhBw1aH1V
         Np9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747837961; x=1748442761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3iEyb+roNUsk+D5mJFXrZuo8v+SD+UnUIu1KPYIkKQ=;
        b=mT1GCS8OQpcRs5Bfm1jpZi0cPElsY8kwxavZFq5WkTRm4D1RVKyyfjODx7Bf3/cDVl
         nh63hJNxtVhsD5v/EH6/xdPQzLLc/0evwSN5APlGJ4NDOiOiFAa0Smamm97/b1GSi3iy
         v0Xma+wEBploXwmXMhehdaoA1B2bVIWc7giOG2rRyhTfnwLBY6j9FFpNlq5vNcFgBY2l
         GQEfPBmlGbAVaUNaqDA/AbQl+2wbERj3jhR+DQVeaj+7LreTAvJoDhKWdXFCKF6rZSrF
         XjXE0y1ceuqKOlY5NepFEYlT3Gt2NiyfJYRDA8ikGX9SQJbjuQN7CuPJRnWzKI4n2Sgz
         mBxw==
X-Forwarded-Encrypted: i=1; AJvYcCV6XUz63xlqbxwK1Pm3Ddq3vOWd5jhYwQD+2kMji2jfEYwlKcz2Ylstuy3/9HvyPMQU1BQy7sXjdYmN@vger.kernel.org, AJvYcCWDrd2ZuOQm1nahaUXjRwTal8CymPikxogd29KY9Hkak0aBIvAsCY9Oc0zuAD0+COwsPLg88aeqZBOc@vger.kernel.org, AJvYcCXicO3BGm0weuEYrg3CD5EO/0kOMw+y1On9fd1fwLinWfxQ1llX+Blh9NBhobauUPcAzlBUaHikgBV8zA5Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XP7C2Hqsy7CGlMLeZxjnxEGHgoi7D5LfYlkdUxzaejLRtMat
	506EBg6x6glnu6F3Kl0Ww4sH6WvgbpzJ3gVkZvruwgYx5AZGXvL8Og+W
X-Gm-Gg: ASbGnctosxuCIHDo2YNlfrpGs2SiEfgMZUQxwf9Z8AQMbENar7RiMVwkOMjKaf8KHxj
	FAE+bJ2Javi8Z3yeuHVx0ihoRKE2sbU5dcyDcO8otM567W+34g8UcXLobPMh2a7FOq4KxWn0aOt
	J6DOJjZTUkTXyDlju4YUoCrQnktrAGJOfK++7hu9DJQwx9EhUmqSilGlO/IJFK6e6BHLP1K0AwO
	BTPocVPFtVDFSjIs5y+ernCSqaLYT0g1T5AUCc/qNhA2oPhe4iVPB5NKWNOOR196mKWmQkCCmbE
	lGRk99y3kUumretYg1skR3XPb5jZgyQO71V/fFVZ2JZs9vEFpzU=
X-Google-Smtp-Source: AGHT+IFNn/yxXRHv/Ffj+NoGNybG54LX2oOn1f4vDZpCU54+NLCd+AUavmKxXFMS6w6ErjqKXvWUOw==
X-Received: by 2002:a5d:5f4a:0:b0:3a3:6c61:9d52 with SMTP id ffacd0b85a97d-3a36c619e19mr11661427f8f.18.1747837960656;
        Wed, 21 May 2025 07:32:40 -0700 (PDT)
Received: from [10.5.0.2] ([185.174.156.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88990sm20384108f8f.68.2025.05.21.07.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:32:40 -0700 (PDT)
Message-ID: <fc5139294469450ead4baf595f041561319013ee.camel@gmail.com>
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 21 May 2025 15:32:42 +0100
In-Reply-To: <14a80484-5cfa-49bb-9608-12f25a113b23@baylibre.com>
References: 
	<20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
	 <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>
	 <zdltaexty6pzbqesoluuyluygyt6w7nq7r2wccmtfktppwuw3e@qb36fsu3jq4k>
	 <0dd1a97e-ff7c-4d09-b18e-5df9944488c6@baylibre.com>
	 <p3ejuwktdxcjwv43nnap5tin33ziimgxfan2xoghtaaubsxgy7@tjmwjpwy6yy5>
	 <14a80484-5cfa-49bb-9608-12f25a113b23@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-21 at 09:12 -0500, David Lechner wrote:
> On 5/21/25 8:54 AM, Uwe Kleine-K=C3=B6nig wrote:
> > Hello David,
> >=20
> > On Wed, May 21, 2025 at 08:19:51AM -0500, David Lechner wrote:
> > > On 5/21/25 4:22 AM, Uwe Kleine-K=C3=B6nig wrote:
> > > > Can you achieve the same effect with the (IMHO slightly nicer but
> > > > hand-crafted) following patch:
> > > >=20
> > > > =C2=A0	ddata =3D pwmchip_get_drvdata(chip);
> > > > =C2=A0	ddata->regmap =3D regmap;
> > > > =C2=A0
> > > > -	clk =3D devm_clk_get_enabled(dev, NULL);
> > > > -	if (IS_ERR(clk))
> > > > -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get
> > > > clock\n");
> > > > +	axi_clk =3D devm_clk_get_enabled(dev, "axi");
> > > > +	if (IS_ERR(axi_clk))
> > > > +		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to
> > > > get axi clock\n");
> > > >=20
> > > > +	clk =3D devm_clk_get_enabled_optional(dev, "ext");
> > > > +	if (IS_ERR(clk))
> > > > +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get
> > > > ext clock\n");
> > > > +	}
> > >=20
> > > The trouble with this is that it would not work with existing .dtbs
> > > that don't have clock-names set. I think it would need to be more lik=
e
> > > this:
> > >=20
> > >=20
> > > 	axi_clk =3D devm_clk_get_enabled(dev, NULL);
> > > 	if (IS_ERR(axi_clk))
> > > 		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to
> > > get axi clock\n");
> > >=20
> > > 	clk =3D devm_clk_get_enabled_optional(dev, "ext");
> > > 	if (IS_ERR(clk))
> > > 		return dev_err_probe(dev, PTR_ERR(clk), "failed to get
> > > ext clock\n");
> > >=20
> > > 	if (!clk)
> > > 		clk =3D axi_clk
> > >=20
> >=20
> > If there are no clock-names, the parameter is ignored. (I didn't test,
> > only quickly checked the code.) So passing "axi" instead of NULL should
> > work and yield a more robust solution.
> >=20
> > Best regards
> > Uwe
>=20
>=20
> I didn't know that. So with your suggestion, I guess we would get/enable
> the same clock twice. I guess that doesn't hurt anything. I will try it.

So, in the axi-dac we ended up doing this if you recall:

https://elixir.bootlin.com/linux/v6.15-rc7/source/drivers/iio/dac/adi-axi-d=
ac.c#L837

But I do not think you need that here. I that what you suggested (with the =
first
call having id as NULL) should work fine.

I'm starting to think that always having clock-names just makes things easi=
er
and more extendable (though the recommendation is to not have it in case th=
ere's
only one clock). Not the first time I see this (or go through this kind of
stuff). I had a similar situation in the axi-clkgen IP and IIRC, me and Con=
or
just agreed in making clock-names required and to handle backward compatibi=
lity
in the driver:
https://elixir.bootlin.com/linux/v6.14.7/source/drivers/clk/clk-axi-clkgen.=
c#L534

I'm actually now re-testing because I think I actually have a bug in there =
:)

- Nuno S=C3=A1


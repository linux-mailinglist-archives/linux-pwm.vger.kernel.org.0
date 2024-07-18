Return-Path: <linux-pwm+bounces-2849-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468AC934CC8
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jul 2024 13:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC394B228A7
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jul 2024 11:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9892E13A405;
	Thu, 18 Jul 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zevrOBOT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578FC1369BB
	for <linux-pwm@vger.kernel.org>; Thu, 18 Jul 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303463; cv=none; b=M34qbr4n3E4pD4bYxyHnAhDRHC6WM7GeepPX5NI4CqP+tUPVidyPX73tNDZrqR5MUBiYaa2IiggzufTj5NULTxR8gjB8fztoyBUipvnA0T5OcUbJHfvo74iXwmRrPX2DFnRxMNMLbDIc0scmQOT4eMwmRVb6B9WBMWc3vZtCpG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303463; c=relaxed/simple;
	bh=vD3tfVsWGs13fLKirLM+QMolfsmQJwO7QPEf2sxf1ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3OMFr6t1A2K0MPJ0wJblClv5GF+f3mLZcbhrfJUkv6IrG1PGg8+80RQMsAr/yudfYmh8nrxqRfWTPe5GowMNR9/Ey/ddt/bmUE/oORLA5KPjm4h1Yos5EAzWyR9pCHOPO7XYspYQUP4AeRric9blwo4Ntu9rYGYKVwWLkYxyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zevrOBOT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77abe5c709so73185866b.2
        for <linux-pwm@vger.kernel.org>; Thu, 18 Jul 2024 04:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721303460; x=1721908260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vD3tfVsWGs13fLKirLM+QMolfsmQJwO7QPEf2sxf1ks=;
        b=zevrOBOTfQssDP8/bbpgUa7VXzjUA4xtdvNvDjTAgv/DXuA1vgzp5ttbWK1A8W0Bk+
         Vc1zI+OlqZ5lDw5A0ruRlYDnb/xSyY5ae1o1+h/WlULR+RdbJdMrY346jCljROlRt/Bu
         jevaQnKIIUkDqeUx9xwQ1etZFJvCx8+a1K/Y8WMidGDggRB12KTkOOwe738THxJKb/sd
         py2mjEe8r+/3p5EuM2sK3ZpCOoj7kmDsWxc+40uH9pnsuVnmt4WQQZP6K55UhasZlWcY
         OlZTF+D3RBez9TIg18vPZjlApp9YVhrygrly2Xvo4mrxrAQTlxIAZEmtkZVaqgy5C6W/
         66cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303460; x=1721908260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD3tfVsWGs13fLKirLM+QMolfsmQJwO7QPEf2sxf1ks=;
        b=eAu+70qH9PIPcJwz7KFw14e8zLHRIcX8x7Dqi9d26V9jFFI2vh3Icq61+Mm9DeQ8Ev
         lSWBxn2QvPuA1NqTXr4QQskdXUaPEMXgDMvSEYMQmHk/9CmI5yU1SmOmKSZIGBO15uTJ
         8ZsdEaa0TYttp9VBczihOPp0bbw/Z5z903P/QSyZ0n866aBNlc/wlTjWC403VhjMsa9f
         Czbh+usL8rbyl9TNES+S58HiJkLFF8PaXHEaJkM8HITVNnZuIboNWFhJLfrXNyHsjnQQ
         57mMladX0wy53U12ROP2qdyiO4gszOOfOl+XQBpbW8sRs//cQmfBtIeJOHSvvfkEkC9f
         i3fg==
X-Forwarded-Encrypted: i=1; AJvYcCV26fY45djlv+F/NUCVBAcX5kMt1yUp/AnMgMyC9BhlZLGP60C+skkKDXnXyW4Wlwz7kwHuroDI0Whj8Y8O6deP92w7KP09vlzC
X-Gm-Message-State: AOJu0Yx0BnXvzFYhe5huygNIhaq8nldoCP3PlydMG1FOVoM51IBLjN6y
	j23S0Gej4HfLg89Z+/Q1WODxee4h8uCZIAFP61LuqpT3nS/40MAuD2hSwKNS9Qc=
X-Google-Smtp-Source: AGHT+IFwXIStMSuamLLszfwue44fiFsyS5r1vkhJKc/V6fjTvStINXv3htkE7bc+brSBhJS1PmJGBQ==
X-Received: by 2002:a17:906:e0d5:b0:a77:c26c:a56f with SMTP id a640c23a62f3a-a7a01130925mr304316966b.3.1721303459640;
        Thu, 18 Jul 2024 04:50:59 -0700 (PDT)
Received: from localhost ([193.197.128.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820d2fsm546971466b.200.2024.07.18.04.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:50:59 -0700 (PDT)
Date: Thu, 18 Jul 2024 13:50:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Farouk Bouabid <farouk.bouabid@cherry.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/6] pwm: add mule pwm-over-i2c driver
Message-ID: <fgpb3aswlk25kkziiwe62cjk5ajwx6xy6xvyfzlx35uc7quzwh@cov5otcowkgv>
References: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
 <20240529-buzzer_support-v1-2-fd3eb0a24442@cherry.de>
 <5hd7fndgivgusx76wq6mbvgefngd3tllqsfsk6pppbphchczte@ujagkep4miet>
 <25d71c19-6e94-477d-8d04-758015ca4b2c@cherry.de>
 <e7b3bfpvtrvt5g637yy7qxsbvfiylyzrjvwsro4hzp5t6cmeux@eqafx3k7oaks>
 <33d93798-459b-4d33-ac59-623a68ea48cf@cherry.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ddsoalw7wih372qx"
Content-Disposition: inline
In-Reply-To: <33d93798-459b-4d33-ac59-623a68ea48cf@cherry.de>


--ddsoalw7wih372qx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Quentin,

On Wed, Jul 17, 2024 at 10:48:52AM +0200, Quentin Schulz wrote:
> On 7/15/24 5:09 PM, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jul 15, 2024 at 02:16:15PM +0200, Quentin Schulz wrote:
> > > To give a bit more info on this, there are two possible flavors of th=
e MCU,
> > > ATtiny 816 (datasheet: https://ww1.microchip.com/downloads/en/DeviceD=
oc/ATtiny416-816-DataSheet-DS40001913B.pdf)
> > > and STM32F072CB (datasheet: https://www.st.com/content/ccc/resource/t=
echnical/document/reference_manual/c2/f8/8a/f2/18/e6/43/96/DM00031936.pdf/f=
iles/DM00031936.pdf/jcr:content/translations/en.DM00031936.pdf).
> > >=20
> > > FYI, on ATtiny, we use TCA in single-slope PWM generation mode and PE=
RBUF
> > > and CMP2BUF as period and duty-cycle registers. On STM32, we use TIM1=
5 in
> > > PWM mode and ARR and CCR1 as period and duty-cycle registers.
> >=20
> > Wouldn't it be more natural with these to have duty in a base-2 register
> > for duty, in the assumption that your MCUs habe this, too?
>=20
> Not sure to understand what you meant by base-2 register here? I am guess=
ing
> you rather wanted to suggest a different unit/representation of the duty
> cycle in the register in the FW API?

For humans 100 as maximal value for a register is natural, but hardware
usually uses binary representation ("base-2") for values and usually a
register (or bit field) is used completely. That is, valid values range
beween 0 and 2^n (or 2^n - 1) for some n.

Note this discussion isn't really relevant to the driver. Just me
wondering about the hardware design. So if you don't want to follow up,
that's fine for me.

Best regards
Uwe

--ddsoalw7wih372qx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaZAYsACgkQj4D7WH0S
/k4txQgAm2WzqXl0JXzy98Aebusbt2VhAwr2jKTv4YxBaue6sXmXUxAWnguTQCxy
nLoe42a8AStJHRpj8fo1gZe2/2cBr+/0gr6+/VnMvSl4mcMeU6Djur4GTUrMLq52
q73wDi1ujB/D3EqSiBv9lDQazE3HE27hiEIl3DtftfHURQcXW6Lcv34Px2opdkK5
6hwJdNw9orw6h15+QblnBv4SCDNgzf8F3qPR9YNZneGIBkkLPInBSEeRYuGZpOX6
FdAcYHdocdWg7b80RVgEWiDsupOOhEM/UWvxypLeA3/5GnZokkuEli0w8DaYBvl4
E59r+LLHZgfIgeWdZhBw31y8J0G83w==
=3jTY
-----END PGP SIGNATURE-----

--ddsoalw7wih372qx--


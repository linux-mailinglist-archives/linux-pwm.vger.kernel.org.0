Return-Path: <linux-pwm+bounces-3104-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73F296DE85
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 17:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D5B282BBF
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC1119D8AF;
	Thu,  5 Sep 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="21bH+4M7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10067D529
	for <linux-pwm@vger.kernel.org>; Thu,  5 Sep 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550799; cv=none; b=ItCglqNfEhe3fNqSDV1/Do1HtqWSYfkgSOSWrEJaJQ4wSQ2Q0Swz6RwCbS3iePytoD9sLWm00rV4N45lI20195NPp1UNiKDe+TO1wmtUTl6krEcDwK12hg8kgUNZQ7yArKlNEWClAUpRZ2bIgYcfZfKxLXUJrRuCBjmyB47+i4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550799; c=relaxed/simple;
	bh=mShTR0wpUdAvfg0TksQhUCmqef7LUJGPiigyw0CK2LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mp54RZR03qd+IZ1D35utPRLZV2RttL0qUlNsTIC/Hr9S9FfeGlL/n7Ff06SZrR7nAOYEmzOxo5kpnO47zwR2DEa5ssv62qjF4VQ3u+Pr7Cd4DFnZdQfhxgOlPHIk5jowkndpjDjn73tWBoOsjWwdashm/+R02UC9krVhUPxAsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=21bH+4M7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c25554ec1eso1069825a12.1
        for <linux-pwm@vger.kernel.org>; Thu, 05 Sep 2024 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725550795; x=1726155595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCkjd5aRXE77wTFecBrQlqKGiGvnECId8mwviesTQiQ=;
        b=21bH+4M79YVD1AvLSjsNszbykZ6lwQw9vLhVehqdbJyTmaM3qMK4vf2jIzm5jb0VYz
         GhJDPYadEt+hZq2ILm4bxHQu0xL01TqfYm+3CeosrrMCehhLN3nYP/mG5iFrzNA7DB7y
         UYOoHBj7apFejjFbsEdoTzsvueVILzdaxdqKIx/raCez1yRiCxpEIosoc9JpWseWF4jA
         h9fIM820t781vWXhS6EJnn2Nym1BPFgEa4SCHlqw2MWO7gzspmPThBxk5O7NgmdSYXU7
         vXe0njjhiOvWhMap8/XBcF3JvzCn6RjkqX5/CdwVrpM9KFaXwcL6VVaFwQ09oEMD4z9n
         fF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725550795; x=1726155595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCkjd5aRXE77wTFecBrQlqKGiGvnECId8mwviesTQiQ=;
        b=Mn4ly7IUfEQ0YUN3i21OA150NgL4mQAxT09gQ214p+FyEXdiJm/sp2qW2zIN3UgxiP
         ULAM3nNTCHaf7KEzOUrTzBfSqtqZF1O86aasFTg2CzkKYS2FRoxgoUQ0bO2laO3KilCh
         gcoEBlXgumhMN8cCzxI7IRg1ouZZU9EmunHwJwS67e3T5CQ0ML9T4BDrLSURuJbBPDdR
         tt6y7rlAYQU2E2gVPZTv4YCuTa7Rx7bQE1D7v0Gmb6qOrqKFoyukHyFqYM8i0lg4Gj1/
         8ddPuiEdUYAyi5pyxQa8tk/VD6ji2k8mBy99SIToo9GpKyDV2fCM5QQhNBIDZMjZJfDC
         arEw==
X-Forwarded-Encrypted: i=1; AJvYcCUVN2P3Vj9NLOcL6jGuhorCZAIXbbGoArDkWMfO9xH8NfJ08zX8w4ZpUFUD0BwvLoj3FooaWnTrSdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/Jj9VGVEMOQQGRh7mi4I07/nD0WbvL0MrRVfzQmllDULaXhC
	bhsrnI2Q1dlXc8lrkmM8uQlY+I6rCr6YRE2+uWWGvccvFbeCDERu3KriirSIWXg=
X-Google-Smtp-Source: AGHT+IFRAW1z6DKEHOmqApoikHOpDiIceOIq97SzaMQ4yjqsbOsT+Hzh1euIiYVWcaR+nXNdRuDAkA==
X-Received: by 2002:a05:6402:2750:b0:5c2:4cbe:abfc with SMTP id 4fb4d7f45d1cf-5c24cbeb2f2mr11708577a12.2.1725550795189;
        Thu, 05 Sep 2024 08:39:55 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc544a33sm1349974a12.24.2024.09.05.08.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:39:54 -0700 (PDT)
Date: Thu, 5 Sep 2024 17:39:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 5/5] pwm: airoha: Add support for EN7581 SoC
Message-ID: <64zfjgmc2dutmsukg2bxhb44k3wu2y7tt3h26hej7d4fx5nc7z@5zvo3hsucipc>
References: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
 <20240831-en7581-pinctrl-v3-5-98eebfb4da66@kernel.org>
 <yfqmlca6cnhrghpo5s6tml36tngmekcfbyjakxs7or7wtap3ka@7qlrxjowo4ou>
 <d9298199-fe10-4b28-8e28-dc252bd6832c@genexis.eu>
 <t2f5kockuvfi66qqumda6jxf5a4c4zf35ld5ainsnksavkchyj@kdueaqlhjoar>
 <b7e44fb2-6cf6-4530-a271-9e1730d4f431@genexis.eu>
 <xmlta4za6malgthd6cmt5fcipxgyzwmqwxqdg5e4qahcuqzcrt@eidsf6mexrkz>
 <a0a14b57-cc4e-43ef-984f-fb405949b41d@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ikk7wbgmsrnb7sr"
Content-Disposition: inline
In-Reply-To: <a0a14b57-cc4e-43ef-984f-fb405949b41d@genexis.eu>


--4ikk7wbgmsrnb7sr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Benjamin,

On Thu, Sep 05, 2024 at 02:18:41PM +0200, Benjamin Larsson wrote:
> On 2024-09-05 11:30, Uwe Kleine-K=F6nig wrote:
> > 1 second long pulses with a period size of 1 second, so a constant high
> > signal?
>=20
> Hi, I think I was unclear. The SoC documentation is not that detailed. Bu=
t I
> think I understand how it works now.
>=20
> One register contains the minimum duration (d_min). And then there is one=
 8
> bit register for the signal low period (lp) and then another 8bit register
> for the high period (hp). Per my understanding a change of polarity is th=
en
> just a swap of lp and hp.

that doesn't sound right.

A "normal" waveform with period =3D 10 ns and duty_cycle =3D 2 ns looks as
follows:

   _         _         _
  / \_______/ \_______/ \_______/=20
  ^         ^         ^         ^

assuming a monospace font that's 1 char per ns, the ^ marking the period
start.

Ignoring scaling, your hardware needs to have hp =3D 2 and lp =3D 8. If you
switch that (assuming you mean switching in the same way as I do) to hp
=3D 8 and lp =3D 2, you get:

   _______   _______   _______
  /       \_/       \_/       \_/
  ^         ^         ^         ^

which is still a "normal" polarity output as a period starts with the
active part.

I admit that's a bit artificial, because the waveform for

	period =3D 10 ns
	duty_cycle =3D 2 ns
	polarity =3D inversed

looks as follows:

     _______   _______   _______
  \_/       \_/       \_/       \_/
  ^         ^         ^         ^

which isn't any different from the 2nd waveform above if you ignore the
period start markers (which are not observable apart from the moments
where you reconfigure the output).

However it matters if you have a chip with >1 output that are not
independent.

> The period is d_min * (lp + hp) and duty_cycle (on time) is then d_min*hp
> (per my understanding of the linux api). This means that there can be
> different settings that result in the same pwm signal (if you double d_min
> and halving lp and hp the signal should be the same).

Sounds correct.

> This means that when requesting a period and duty cycle you need to search
> through the configuration space to find the optimal value.

Or restrict yourself consistently to something simpler than a exhaustive
search through the complete configuration space.

> MvH

(BTW, I had to research the meaning of MvH. In case someone else doesn't
know it: It's the usual abbreviation for "Med v=E4nliga h=E4lsningar" in
Sweden or "Med vennlig hilsen" in Norway; both meaning "With friendly
greetings".)

Best regards
Uwe

--4ikk7wbgmsrnb7sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbZ0L0ACgkQj4D7WH0S
/k5w+ggAhG/7cx2AC8jLk85B+JBlhL2wJdDDlAagB0gHc/M5PrmMLmMzMI0RoXJA
k3N0WNIK7uipsz8wWQLP8TKSzHS5Q94UE+6J7l1rTZX9iev8fuLDuRPV2pB3TtXo
o0b4P3QQDlB/Fo+WHBGijmr9EtYDbFwxYDDkZ+bg5P4+XmAIRRHEBy4QyP133+i1
1KBlJbVlqYNgh9UKqVo7+CZkmADApYkFskMjJeFS/rEtYfWbqRRijU31stgEaR1A
RhsNH6wnCOsTidBctYbl1QZ1iTnPhHElZKIqYOU2j6Ysrq4mBunVZSv9WZ2PDR55
IW/+aoHhp58nBftvSM+AO2NIWPC82Q==
=rwIW
-----END PGP SIGNATURE-----

--4ikk7wbgmsrnb7sr--


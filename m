Return-Path: <linux-pwm+bounces-2495-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D9590B337
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jun 2024 17:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DDC1C22DFA
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jun 2024 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0166613C8E2;
	Mon, 17 Jun 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bBk91bAt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9DD13C830
	for <linux-pwm@vger.kernel.org>; Mon, 17 Jun 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633520; cv=none; b=DTpYF2j1NBg1Z41EwMw5LBK5PjGoWHUbDeYo12vmVxxHRUFJSsGKtMvZyuohgCGqBHK2feuBxuXjZrIgIEeUKDPLlmnOUyGqcTj2nm30wSbUkDs07gEWTL374ZYit34ajAcrjrlYsTEKJyiHe8lYnBNlx9Z5M6d9VVhZj7BNQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633520; c=relaxed/simple;
	bh=C2SAVHOyNTSMDiQfOQc+olVCdTZJppGRHLEkFWkECgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EL9oNewomaNfZqDIhdPYS4t+HRceqS5S5TFCKcfX0rZhYxSQ/3yzSxsJuNNYFRCbKKXS/7Di48R9CAUlRXRSkJKoE4bFrgtTrEie1U+1P5pFqpw5c7PnnvmZen9F8KQjQ80y7aA3j3qNih7szvDh9C+40D6fMhahe3L9lwAKS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bBk91bAt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f04afcce1so562774666b.2
        for <linux-pwm@vger.kernel.org>; Mon, 17 Jun 2024 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718633517; x=1719238317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2SAVHOyNTSMDiQfOQc+olVCdTZJppGRHLEkFWkECgM=;
        b=bBk91bAt/erP5mL3knKkxVdMhFwJru9aAsPt/Z0dcLFBdXbBvSGnVV8Fvc4sValzdw
         iuMtSCdZZamxlBD4QbQpKg9U///sgFPgGwVA0tZa4aTqjqcayAiy+JKxZGNJpz5SVn/c
         wtLkRPoJc7U/gBOfleKB8FCtGpRdSlvE/m3edIbYZhsP92j+5y1odQ00TRHse8hq+hsZ
         Un7S2/+R2S5ceBAyXMbkcxX8mqe1ukgvNxmrB40omSG7g6EWk2T7gyNglH0CAQD5rzkN
         IweGMOgkrfXp7rdzC9s42LAydeMZ+DGj0MSeD0ZrYKb2IKFuGd1tmJ6D6HopW/tCsz17
         cj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633517; x=1719238317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2SAVHOyNTSMDiQfOQc+olVCdTZJppGRHLEkFWkECgM=;
        b=GA7W2kcyoEAw0wUWp+h1DVv2ZLqMfMPcbhZK9hXN0rbRoQ42RURpkS4UeZp+1/Dx0Y
         Tyj6PSRU2GYx1a+Om++AWXTzGbLGMCgA0CMrA8G3YxG0qy1hbcERsECCAvdX0Or0/bZj
         TiRFi/pvVAltSPr0h/juPF7f5Adxu6FgxjkU0EvpoonBav4ekgWGCcS5VGkaLeVAh6Dy
         WjhaWeKSwX8UqRl2ndASg9iy1RwVHofSnKngZFjW+wQ8mPIlde7Z8wnOrK3CEFi0VMXG
         ieqXMQj6G6iBcJd8dD0XUPkTm9oq0EcsR+VVLkWlTaAoTGhDpOHLSYYtGwFwrv/sjk04
         cBBw==
X-Forwarded-Encrypted: i=1; AJvYcCVwAI8q9l6n4td/uBDZj8iFWHRQbiRa4DHlyanzJL2qxDZV3lNXIlxj6Eu+mczoDUJmVbeNayYgTTaDARv2O8grnELzLdE8XxiQ
X-Gm-Message-State: AOJu0YxVVmViYVMaH4yMh/zeapvFo/OJEHoeyXUG6WP7z2g//SN9bh5m
	1j3frfyix8OQD4gnQnJ+hRGI7pMwbohVNktbKNbWqFd8sOVWhJok4H57KybMURM=
X-Google-Smtp-Source: AGHT+IFlbSH1GvxfJkQSwG+UrC4v6gx0fdCPmYTDKY3WzRbLOQNkpCirO5vKZ2nfSibqMaANo06JTQ==
X-Received: by 2002:a17:907:c283:b0:a6f:6661:dbbf with SMTP id a640c23a62f3a-a6f6661de22mr770138066b.71.1718633517028;
        Mon, 17 Jun 2024 07:11:57 -0700 (PDT)
Received: from localhost (p200300f65f283b00ca876ee5dd3d1e3b.dip0.t-ipconnect.de. [2003:f6:5f28:3b00:ca87:6ee5:dd3d:1e3b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56dd2dcesm518217066b.93.2024.06.17.07.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:11:56 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:11:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
	Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, kelvin.zhang@amlogic.com, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 1/2] pwm: meson: Add support for Amlogic S4 PWM
Message-ID: <6bzysc3jwugo3epcxsef7uupk536prsc3phlf3m64n3jjwpxus@2uigg44uotuh>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
 <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
 <1jfrtgj0so.fsf@starbuckisacylon.baylibre.com>
 <tnwdnwiruoty5yd42bmkupgg6hjxib5lblhqcyouoyx5y3zvnq@2d7cnrei24m4>
 <1jbk44htqr.fsf@starbuckisacylon.baylibre.com>
 <948ba34a-1e05-45c4-8ba7-66c72bdb6fa5@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vjzyofe7xtcvocgd"
Content-Disposition: inline
In-Reply-To: <948ba34a-1e05-45c4-8ba7-66c72bdb6fa5@amlogic.com>


--vjzyofe7xtcvocgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 17, 2024 at 04:44:13PM +0800, Junyi Zhao wrote:
> > > So yes, please use dev_err_probe() also to handle
> > > devm_add_action_or_reset().
> >=20
> > My point here is also that devm_add_action_or_reset() can only fail on
> > memory allocation, like (devm_)kzalloc. Looking around the kernel, we
> > tend to not add messages for that and just return the error code,
> > presumably because those same 'out of memory' messages would proliferate
> > everywhere.
>
> Hi Uwe, I didnt get the clear point.
> So, if we need "return ret" directly? or keep "dev_err_probe()" to print?

Please keep the dev_err_probe(). There is a problem with that approach
(as Jerome pointed out), but that is about to be addressed in driver
core code.

Best regards
Uwe

--vjzyofe7xtcvocgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZwRCcACgkQj4D7WH0S
/k5C6ggAusUDCe62w1qb8jlNP1dXoK6OQvw09sDK1x3v6607Hh9+PZte3/EYmwn1
AIT2qpIcaBkVb3oB8plPowm3oU62dqZ5Z5ab1QN97qlths09uZiOxkA/MSLTTUx6
T6GbIn+8OmUDBSa2jyqbFBV5IapU3TgN/PGDUVu3/fp5psvI6tCfyLUpxR1pTXWZ
M3XM5N2LvVkzyu1O77yBaKOsB+4TVcgRLGwi1MzbqbvbLQoyRscvB18qB4x8Ytsa
kLCtuCLJfdujJfR6fTWC/1xeXGoK+YnnoELLOj7LaBVpnUzN8StlNOTM2q7Pm354
ndgwDT55Ok9oedoR5qNzhmx6RPB9qw==
=M9gi
-----END PGP SIGNATURE-----

--vjzyofe7xtcvocgd--


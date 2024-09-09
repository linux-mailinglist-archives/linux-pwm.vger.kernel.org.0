Return-Path: <linux-pwm+bounces-3169-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 793C497186E
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 13:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8EF1C22078
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1690D1B654A;
	Mon,  9 Sep 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Sh032Y0+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDF1B5EAA
	for <linux-pwm@vger.kernel.org>; Mon,  9 Sep 2024 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882066; cv=none; b=AJ1850cw3F3p8nSCiuK++20DsvZNcLPfyttoOThYVJJ7GCguduXROLJwV5seESQVFQQPLkiXZA440gqtks5CU11Ttr8BUDsdeS11vdD87Wtmn21VurL02FUFlovp5Il0FzXZ4sQTbwtgwbHiFKp6LjMoRg27DaOMCRwxc5BbQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882066; c=relaxed/simple;
	bh=6F0xeNH5VrkWZo2t/B669odKzMRhLNXAo/4rVQyNtpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfwcWXOKyeZb9qx/ZVda1SfGGuVGgvwaWr+ROg9oYjIAoIYl6wp7jtQa3ukmCBTQIhyK3uaK+nlG56/UQcTauvcurLLxIfWmhlz5OJ7PlwBmKCThc/P+d9ERKqgbnwgX1/9JZBnJuytGKOS+ZwkxhefUCljo1kS2MKGH+z8dZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Sh032Y0+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so4261199a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 09 Sep 2024 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725882062; x=1726486862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qScQKuhLe0u0kU29RiovzYcJQ7U4pPcU2U2IC4qnjo=;
        b=Sh032Y0+BixEvtq28Jl/LMEWUOQeA5QV3jCZwPMACSNVLeyFDxfH2gO82vMcw+GfI4
         4qlEQcRNe/YBZ92iI2txH99pmpkCoRmBeHq1egYI7QEkb9GSPxA3KNHUjFApJFdzYxYb
         8c11ZEK9FOrk/KI7IfbPXD5IdIlt0MhS74dOdo1UDYtB8dxKTIHWM0l9HkHb9ODiAH+p
         1xNacd+GD6gGEYrnOVqG/GGf9+G8wuAAZckzyiL8iJweWFWGpUAOA//vSWNH4PUgpzuk
         MWc3XOoQ6Xa9lCquz0jFTZfPNWU5ENt46/FTZVIg4n3P/E4VZInJE+6ugKxIKFdmc2fi
         qLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725882062; x=1726486862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qScQKuhLe0u0kU29RiovzYcJQ7U4pPcU2U2IC4qnjo=;
        b=c300qzAgV8cKpmpq9l+IUeRthoXAyw20uy39fO3OkiXqzUCh+RUJLbDKEfhDFQi3iN
         sqxo4fqnQYi3HIGXFgA8ODsAFCBkTBnCAkDv0KNWu4n4fbCFzQ21oLsOuBcwhrEGXkJ0
         lJTNlgzEqKXwKgdg1mrd/9Ghoxy2gxaC0w+61JO6QEonAvFhe9kYYP7NvviDMoPpcVaS
         p4Tm3Yyi7Mx+i1xS5rXTUz7SngUfVagTj581IIoAUeS9bSmYVWO2G7qjiuxfQBiGcL+p
         cvIRAd2S3/8gqQads9ZjpQzDUeLBLAOmDzatZ2ANb1J9ZdJtVfB4b3tmXcu4qHIjc5cY
         02JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBKjsxQPEk64BtMAlelEH94NjnCHnusFM8iCXGDROiyH0DYNEXS3Tjrd2oGr2Qo9ehOgziQU9ZWec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7UBDBe+G6+l3A2WXbWbTB+32FqIWS2tMKhKqwAUyK+YALiUwm
	uZ2vNBAH1BD8JiLkpmTFaSnXhXS3kg0oiynC6zPm33g9LQ4SvETKUJZepQpeKEw=
X-Google-Smtp-Source: AGHT+IHDgayYrVFlLUnr75TE2iUhDWIUp+Y/asUCMIvzpkpyyov+MgrEOlYDX/4jK9mNclswQahpTA==
X-Received: by 2002:a05:6402:5203:b0:5c2:6311:8478 with SMTP id 4fb4d7f45d1cf-5c3dc7bb4e1mr7244140a12.25.1725882062302;
        Mon, 09 Sep 2024 04:41:02 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:d821:d81a:d0ad:70b8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd51f37sm2936361a12.42.2024.09.09.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:41:01 -0700 (PDT)
Date: Mon, 9 Sep 2024 13:40:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>, linux-pwm@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 12/38] dt-bindings: pwm: Add Cirrus EP93xx
Message-ID: <mh4ivr3ktmf2rlra6jp54ajzukkgsrx6acs2rendlo6xzap3zz@qz25cxc2xnvl>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <20240909-ep93xx-v12-12-e86ab2423d4b@maquefel.me>
 <172587509814.3289077.10746482650513855019.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vamiatiuza7wnvj3"
Content-Disposition: inline
In-Reply-To: <172587509814.3289077.10746482650513855019.robh@kernel.org>


--vamiatiuza7wnvj3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 04:45:07AM -0500, Rob Herring (Arm) wrote:
>=20
> On Mon, 09 Sep 2024 11:10:37 +0300, Nikita Shubin wrote:
> > Add YAML bindings for ep93xx SoC PWM.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml | 53 ++++++++++++++=
++++++++
> >  1 file changed, 53 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.example.dts:18:18=
: fatal error: dt-bindings/clock/cirrus,ep9301-syscon.h: No such file or di=
rectory
>    18 |         #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.lib:442: Documentation/devicetree/bindings=
/pwm/cirrus,ep9301-pwm.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1432: dt_bin=
ding_check] Error 2
> make: *** [Makefile:224: __sub-make] Error 2

The file that was claimed to be missing is added in patch #6 of this
series. So I don't think this error is valid.

Best regards
Uwe

--vamiatiuza7wnvj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbe3r8ACgkQj4D7WH0S
/k6QuAgAu468E6mVUa3ruHWB+a3zmGjSu8jKppOWHCqPBWLFMvrYHqTwUFtsy88M
DHaRYv0ixvAXlIJAZRZKu1sy8xPxAUTX2WbsflljIRbyUJKPQ2DoSFszhwpJhJze
uZYXhbAUwZUt19u9+Fg+V7LHjlGTxeMFAI/aZa2HmK/+U+tGcNzNL7iiTodMOERj
aMUOAdQxtuWhUmwvjxHR9i29Tn4I+o/UkWCwFIi9dowsoABWXhHJHVn1aY0G3fKF
XnE4emL1o7NHGkcQLRvFxnSBqPkEFVTYr4QI8dwO5YAeR16CgfPT/Lc4oMqJugWj
ZfMi4QYaG9mpLXlvqWTOGu7a4x7mSQ==
=dI6N
-----END PGP SIGNATURE-----

--vamiatiuza7wnvj3--


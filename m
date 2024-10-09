Return-Path: <linux-pwm+bounces-3548-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 682EF99611C
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 09:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998381C2157A
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 07:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D114A17279E;
	Wed,  9 Oct 2024 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lUN8gD02"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2717BB06
	for <linux-pwm@vger.kernel.org>; Wed,  9 Oct 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459674; cv=none; b=knBtENp6bYGpYS+IipaKYYUsqthdx6QD7WJqiuesYDf3I4dC+yjGMnKnKuKRXndyFJt8ETJHpJARZGa8yax93V/2DQxYuskFV1ccR+FM9bdrgv8OpdQzcir9x+QPPcBFAt6enDdSrPt4yzcdMkvcmPf1RcgvHyjXsoRP1P3S2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459674; c=relaxed/simple;
	bh=8Om95y4F6es/Wxnlpk2uQdvoXMVAL2YO3FbbfSfgtM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCSJWll9mliOvUF8ek9k9NH2ftIbyU7IOM2HJMjsXj00MBnCepS5meowoUAFezJAhMnUpc1YkB1YebostRfiGN/lN1vNSJHtgJpp5I10dQG09cusl79TC9d4ePV6PCeK7+/soHP5WAAIE/cJueXcLTcLDhdrmCkvnBIg/TGzhOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lUN8gD02; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so303704f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 09 Oct 2024 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728459671; x=1729064471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2viIowtWPbXMalgfD8+O9ZrcVwo57XCKNmEpCFwYjQ=;
        b=lUN8gD02yxE0qRJ8Feslg8hK0KALM8ZjRnAs9aYwMBdFKtrlNDc0b2U5M7u3x5KP7d
         uQgCI5vbIj/4AYO6IVSzUJKNSRZuFzndNmIaEfJClGynP7Nlc07/v1LOvH8/HY+8qbrz
         mARjtAHkX4tpjvd1ewOAPZWIh0gN1vPYGYaMwl6Aply2tTCA24gn85GQwtLDhVehLcJx
         06g+TQrgPfUHzJG6sIDEpZLIIEMKPvMopJrzlF+JG/MHEmjPogf44fn8MRdGtpiC5wF0
         cEII5VQ+5za6iJYE6emU2WzL+usYTkSP7H4Ek1kL9ZotQBMb0jTcSaZ+9+rKsOds2tFn
         4K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728459671; x=1729064471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2viIowtWPbXMalgfD8+O9ZrcVwo57XCKNmEpCFwYjQ=;
        b=t3ZQtwrJP2vm8GYFQMCIRe6KXoU5dVURHxvYJLAc15E0s2tsQOTpVsk38lm8afGgrB
         qGhwkqzR8Xax07leJb2Az08f/EKOxUXvbJiUazoXQ+r/aIb/w6GyhoyiX1+lLkr1fFkq
         tT3CL1BNuzoCMM7q+oLa37fBuEBmErMByPbXHtKG5jsmYeilwlfU7pMpna6fAv7eXRFd
         JzCz+g7mi/msDRToGec+4UFMbuad6Xd/lVzbnnJjtZUV+UFn5c0Iuqp2kzJx5C0XjXOc
         OriWHHs5uTdPtF81Fx0XZM68Kzk57gLucZR2In57+5SDyDoHP1gVAqgGqV5ZYrMBMDeH
         tAow==
X-Forwarded-Encrypted: i=1; AJvYcCVEdh/N3bz9jRJjuDIBCx3BoYTwcULW5Bmvfcn9VEaUMfH7zQxTKibBUTwgw9Vl0eF42mn4vjI46Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0418ytL5F+zsRhrDuaDP2S3DjZYeKJw7T+VtnoCcigW6+O2Ng
	BV2r0NU91TJSlO8xP+kBLWRn3X9kncicUB1X3IUI/338fI26tvL9mY0+8uW8Nfo=
X-Google-Smtp-Source: AGHT+IEyd05ui1VmLA1rJ5jgdYGapO6L5DJBjVw/NMVD99NroiPJMW7cLe8u+UN9UqCyNM8dGfTC/g==
X-Received: by 2002:a05:6000:23c6:b0:37d:321e:ef0c with SMTP id ffacd0b85a97d-37d321ef108mr2946699f8f.11.1728459670763;
        Wed, 09 Oct 2024 00:41:10 -0700 (PDT)
Received: from localhost (p509151f9.dip0.t-ipconnect.de. [80.145.81.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d2e65d618sm3025569f8f.23.2024.10.09.00.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:41:10 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:41:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: kelvin.zhang@amlogic.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/2] Add support for Amlogic C3 PWM
Message-ID: <nrrw2vvhyw2gsbqpne5pgw43yyp4uzkjq2ioskvjjwgfk4ahuo@rryumcqojbhm>
References: <20240914-c3-pwm-v2-0-ac1f34c68ac2@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3g32dk24m6nlnxrf"
Content-Disposition: inline
In-Reply-To: <20240914-c3-pwm-v2-0-ac1f34c68ac2@amlogic.com>


--3g32dk24m6nlnxrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 01:48:57PM +0800, Kelvin Zhang via B4 Relay wrote:
> Add support for Amlogic C3 PWM, including the DT binding document and DTS.
>=20
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
> Changes in v2:
> - Rebase this patchset due to recent upstream changes.
> - Link to v1: https://lore.kernel.org/r/20240906-c3-pwm-v1-0-acaf17fad247=
@amlogic.com
>=20
> ---
> Kelvin Zhang (2):
>       dt-bindings: pwm: amlogic: Document C3 PWM
>       arm64: dts: amlogic: Add Amlogic C3 PWM
>=20
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml       |   1 +
>  arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 364 +++++++++++++++=
++++++
>  2 files changed, 365 insertions(+)
> ---
> base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
> change-id: 20240906-c3-pwm-d17072517826

Applied patch #1 to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E I guess patch #2 will go in via arm-soc?

Thanks
Uwe

--3g32dk24m6nlnxrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcGM5EACgkQj4D7WH0S
/k422Af/WeAeMG12qlVL9TxVyfgCoOaW67cCbyllbKGrSYC7OkgI+ujL4WpeqBw7
S0buIREm1V5mtmzXBboD2scB1+QGKalmVSObFXMtgSfJnGszpUViETfwBI9c8az9
oXC9IJSfmF7aqlfugMWcAhrlIZFXEn5I6RMQi8e4fM+F/i83G9aoXVJ6qqQKscr8
uvcpfGZ+hXCdcjPLX2nryNaqNqmlHBk7RYncDYYLPsAnM1gVITTHf0rc/cjKotVj
jcFV+dSSWr8bz6bR8ANt/Tv4reR+NVl3fzmEeQhkWT9gOZEy1YFsnjA+v7L+ect3
+CVMHadCSQx0G3uAK1jTKvVf8PyFRw==
=Njq5
-----END PGP SIGNATURE-----

--3g32dk24m6nlnxrf--


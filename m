Return-Path: <linux-pwm+bounces-3967-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C409B5C1D
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 07:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFE21F227F0
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 06:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85091DC184;
	Wed, 30 Oct 2024 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bewQAceO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4E1CFEA0
	for <linux-pwm@vger.kernel.org>; Wed, 30 Oct 2024 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271566; cv=none; b=OvpEaQmeXgvj9ZkMfqlLrCl5/A9xHL2+kB8gA1huxCSqBT/YxZpom/lY1JIyIRdgMGlALY+aqBFcEHZpF31CU1epMNczZuea3NWUPHjtIDPSvjVdaVDw87Sw4nb0ANZjr9SdGeo8QUAqYQx5JISaIbLqYqN6MtIaU2I9Lpnazk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271566; c=relaxed/simple;
	bh=i16pYFlL+2GPz4u0u591aWQv0tNB7ELcsGAfV5zdSA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRszyeUVNNF0ZNwFw2HAT/CtqjW1KzxATH/+VxO5GGq7Tz/qrQibW4ToXwQ6kR7FFRuaPd92486vz5Nkbjood9rLrBFYAgKJ37Lp0JdMXSteOUtsbMlgBn5a++tU59s/hLEzrnnd5WA7TeuBE9VTitnIpOzlxjjf9UmTjx1UR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bewQAceO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so3994729f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 23:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730271562; x=1730876362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i16pYFlL+2GPz4u0u591aWQv0tNB7ELcsGAfV5zdSA0=;
        b=bewQAceOUlkCq4sGvFwKgJAvRCBs+2FMXbT/xf/xKK2+bG9J6UNQCE9Ob6wEX7Hr7d
         6m3iZ9P+KrWnZ6dxEdOYQiYXeiPGM8PHmhqF5jcT6wk8fapUjJ2pPI4xjEPUEX+l8STD
         3cuCw32RsLK467pJ4nu7b6uVo+Zlg57pAeqMoOVwnpw3GVNVeViDeAGVJyBNJCsmpzvb
         Exsqt4SLG+/rOoy2kOTYS20YsdEX7UlDopAJRk4leXtxDWYb46z7HfA0zmZCe0V9ILA0
         uQ9gWfULPHIbjNtAblCsCzEUA/1yo/E06ZDL3BM60maIHdbi0Ze7dBs8QShIT46X6zgD
         4VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730271562; x=1730876362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i16pYFlL+2GPz4u0u591aWQv0tNB7ELcsGAfV5zdSA0=;
        b=L90KMnes85BqTmF49EvOidl5X9eSSw7T8Gq84p+UMm+CmA1uKyPpj6cSClNXNElnPW
         oLwhOpuXdbrlRRQTsajEpGvk9oNh9HHLO80ibPljdHU1geLWAYZJizVew/KQkSaDP/H1
         BHLOw9F/9ERHH4parMah77Drey/nFw6eGSufHa2x7XyNoLh7iBoUXhLEeu8HGv1ky2rz
         pogFbYlSWePcy+W69gZlkdjzf3wnRsSPIsj5L7VnFxRlAqX21sjN6mysHTH6WMlYodb8
         UyA2fWh1Ud0GJiFYHsyQ3KutnJuQ2J8Oss4971xFVh/4sBqdNrLUad8Bn+CeSVTYKULa
         S/6g==
X-Forwarded-Encrypted: i=1; AJvYcCXjnsqglBU3UMWTERE4a1dHWkzd+ay+BjcklRoh4V0XKSuWAOjDqXB/FghicPdCXciGSRtXS0dma84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIr6X5MoC5VUMO5u7SZ34vtN90na+q8UFhnLXGMVVJt5wjZBD
	ID0mzZx9gnd4Hq9vmeisHPtWgfJnnUft/IFD6InQyYwQI4f9n3XTAxVMzHnabh4=
X-Google-Smtp-Source: AGHT+IFyqfOrZ4MI+sXiINodrY0EVZIGOc3drYiZoKJHu/kEVijxTqjjc6wOezZxjLb6iMiKoIcUbQ==
X-Received: by 2002:a5d:638b:0:b0:37d:387b:f080 with SMTP id ffacd0b85a97d-381b7075edfmr1643140f8f.15.1730271562350;
        Tue, 29 Oct 2024 23:59:22 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70f25sm14695531f8f.67.2024.10.29.23.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 23:59:21 -0700 (PDT)
Date: Wed, 30 Oct 2024 07:59:19 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v9 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
Message-ID: <jzihr7yp5ftyl6ojhtnv2r4duos6or6hozip7yxxodycokwjms@nfa5clftyocy>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <20241023-en7581-pinctrl-v9-3-afb0cbcab0ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xv6ynghrtwc3g4ok"
Content-Disposition: inline
In-Reply-To: <20241023-en7581-pinctrl-v9-3-afb0cbcab0ec@kernel.org>


--xv6ynghrtwc3g4ok
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
MIME-Version: 1.0

Hello,

On Wed, Oct 23, 2024 at 01:20:03AM +0200, Lorenzo Bianconi wrote:
> Introduce device-tree binding documentation for Airoha EN7581 pwm
> controller.
>=20
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

LGTM

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Thanks
Uwe

--xv6ynghrtwc3g4ok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmch2UMACgkQj4D7WH0S
/k4AsAf/WTL0HrSsNuwSLR9YrYS9gYAReyTQAnpm7wbARGWjQE5VLwUF+noWxWP/
AWmOyJdCsgTFs3fXzuToK5SrEPTcsLv3lMAZl48Q7n6NNxMfHFFQSnLp7h+ZRKxu
OQcfRE0N2VD/4NNDTlKZ9/LoTUTCFhJzjlGnhI6YlEe9Rj97KA1GlBrpneUUfXJ/
ukXdcpGeN4W8DzvrzZSLjZYKT5EfDoFA0UFX6cDS1dZbe9LeCH/v13KFM5f7p1HU
+rs9IqNp62uk4YBbsaRjExCK9pcQsQMK/zxcTUn+jMbqR5wweK0wtulbSUdgChQE
Q1oE4Hk6LfFUUnRHCMrbhDER34YMOA==
=rEHm
-----END PGP SIGNATURE-----

--xv6ynghrtwc3g4ok--


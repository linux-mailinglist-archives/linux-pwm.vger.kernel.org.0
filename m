Return-Path: <linux-pwm+bounces-3969-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C959B5D00
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 08:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC83D283EA2
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A58A1DF74B;
	Wed, 30 Oct 2024 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SvQNd1IA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6121C4608
	for <linux-pwm@vger.kernel.org>; Wed, 30 Oct 2024 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273646; cv=none; b=LDheA/jwY0PWqjwoi89X0ErrOo8dluWCRGS8RkiUax83cAfODrwG1vLb2rx7kF513bw3LOcqXOnJUneO9lzrrWd/KRQ4LddLFqcgadrm6RKzb/sKThNk8WkbiZUOeG7W2KA3ncuOdJ4RUfePYZwt7jiUh5s8p/4xIOt4SgD9cM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273646; c=relaxed/simple;
	bh=WwEZskytNCIxQggG34Kcvzn/h7WxM+KE0ZJz42WQe0A=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7gwVTcTk7zDYo/PSmEviAlWCcuie8zICIMSprl0oimiyxD1ZY7+xMSFM+1VxIJ+YUg9PfNYQORF8SMFc2mKh+xNYI7F+Z9df6ZhIornmVJpXBhoD+abVQK7rXvYW/On71zi/0pzxRoDnayZ1kj4tfCwLuDjI5qY7d7tCQ5/nxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SvQNd1IA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4319399a411so48332325e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 30 Oct 2024 00:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730273643; x=1730878443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwEZskytNCIxQggG34Kcvzn/h7WxM+KE0ZJz42WQe0A=;
        b=SvQNd1IAhpZRQ0eI+A8IY6DDXqfVGXyu0aZT2U3UVYaxK92slfexuQQyeohMS/Qouo
         /8YN5uGFAePlLSEQVLGoQhsrTkiusqQbBI2WJSSTUF82H5V7GFoIexv8AU2MpNC4KjZm
         zLnWd6w/pzRDnzeaUbtOENpyQ3rFo1721gz5cFsVsYGj0ITAejf5cj8vMVXwEsQVO9LY
         HGKZ89fL3GMRhn79NQ6YoYFYAhFL9TLL0/TWrNijjFunfkl1VU2CSpzIDCqZ/j7BT2v3
         cAKvRlYlJbXHWnoSKTVzjm94Q+jFhU2Kp4kXAeu+GkzM9jed9hSgaoup+4/gRpBUsYpT
         iEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730273643; x=1730878443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwEZskytNCIxQggG34Kcvzn/h7WxM+KE0ZJz42WQe0A=;
        b=CLDAvuA1+pgdAtU5WdMc6S/lwWLn7nj+7YEfMOWjxmH47yLBqAWNFES2TDQ3N5R2Dg
         21oD/R4dA2+MIbEtAjWp4aaMFe+Wg2HRGsLF4lujcNCiEX+IGHCuA64FR8tNXPK1LHlE
         kM3qsa2By7/DZJxcYTv7hQJYELgUDoyWGVQY3rw3zU3vOuNlKV1MvOkonhBkMSLWUqdp
         9G9mG+DlBIjVy73JSBU3XXfcswYUmYve3CNNpAoZzoh+hgVLQDWExwJyeEJoRNMufKk9
         x7ochTPvl9UhKDQ77wWtuOt4f0zDWjoEnMYhDtqPhOssLa8O/8i7AejoBmhTva8Puoyc
         W9fg==
X-Forwarded-Encrypted: i=1; AJvYcCV2NsA8sab0Sf8UXitGmmC5042/4JzJjmqMe/fdMMx4HAdLDT1mqNNbosugltXGF53L3dzF/ujue2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQ9oIMhNYM36dsKs0G487B12tFMg4p9NKP7QO3QQozOkjDGm1
	bI5KEEavOvUo8rdrSte2hECl+q/DzxdFTdj7QESoAJxKodtxS83LU/7JsB/9l4Q=
X-Google-Smtp-Source: AGHT+IFvSeQlKDXZ2TaznWZQry6qmvVUbv1vCSFsNuf03fMgrDansChUa9SPu6uyHlj1+Orbp7RrSg==
X-Received: by 2002:a05:600c:4ecb:b0:42e:75a6:bb60 with SMTP id 5b1f17b1804b1-4319acb8fcbmr123819465e9.19.1730273642534;
        Wed, 30 Oct 2024 00:34:02 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd99eab4sm12468095e9.44.2024.10.30.00.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:34:02 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:34:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v9 0/6] Add mfd, pinctrl and pwm support to EN7581 SoC
Message-ID: <t7i6lkx5oedjma6uauiygnvbgzixnsqmolmkse3j2qiy5znf7t@kfozote6mm2k>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <CACRpkdaEQYBim8TuDCCw15QDUWhHC-VqhGq1Le7eOd76k56zwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="56rk2czsrrb44okr"
Content-Disposition: inline
In-Reply-To: <CACRpkdaEQYBim8TuDCCw15QDUWhHC-VqhGq1Le7eOd76k56zwQ@mail.gmail.com>


--56rk2czsrrb44okr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 0/6] Add mfd, pinctrl and pwm support to EN7581 SoC
MIME-Version: 1.0

Hello Linus,

On Tue, Oct 29, 2024 at 11:03:14PM +0100, Linus Walleij wrote:
> On Wed, Oct 23, 2024 at 1:21=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
>=20
> > Introduce airoha-mfd driver in order to load pinctrl and pwm drivers for
> > EN7581 SoC. airoha-mfd is needed since both pinctrl and pwm drivers
> > needs to access the same memory block (gpio memory region) to configure
> > {gio,irq}_chip and pwm functionalities respectively, so model them as
> > childs of a parent mfd driver.
>=20
> OK someone has to merge this and I suggest that I merge patches 1-5
> (all bindings and the pinctrl driver) since the different bindings have
> dependencies between them.

Fine for me.

> Then Uwe can merge patch 6/6 (the pwm driver).

The pwm patch needs some more love, we can handle that separately then.

Best regards and thanks,
Uwe

--56rk2czsrrb44okr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmch4WYACgkQj4D7WH0S
/k5D1QgAjbBhIuEEliXD8FforKpez8jJ1PxkBpkZubAbNImwSpOpOGraTpIwdy94
+Mp7owHDJULSYRibBSz9vASz1ULu+LElGQSTtfO/FMdo4fxZhS8mNWJmso3GgbfB
6sf83Ou6IPy0V9RZS06z92en0jFa296T66+U+eQRcMvgZRZnL0R7Aqhm9acidZFS
kTzQw7fKIpqi5t07aAeQxKZWZ8Ag8hPwQdEECSpzJedn8c9yRaop1swgJ5X46Gs4
NZMYuepIpatIVEfog8i/NzV/AQpy99nlQfLpt7nbPQk+o0gINALiBGe7bGzZMDNj
27futyysj3wJ/nuiDdGOnZtazOm71Q==
=pz6h
-----END PGP SIGNATURE-----

--56rk2czsrrb44okr--


Return-Path: <linux-pwm+bounces-7444-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B1BD0319
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Oct 2025 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C10C3A850C
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Oct 2025 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61357277C8D;
	Sun, 12 Oct 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3PZwKLi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33629277814;
	Sun, 12 Oct 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760277955; cv=none; b=m254hUabTAaWPxk5JpnXgoylzu38tRvGoQFr3wB5xHqOWgwO1Pt0crIKqf/PdZ7CSibBXMiptXnkMzpEby1qMSocZLmN7sVXa728N+mP7ClflWl42vAys27fD33aRAwj0GhSpVFV1uEIFNvc0NqWeD7tQ9J+LMruQk4LJOjmBYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760277955; c=relaxed/simple;
	bh=+UJhMGZLyCB4kTOPEaLd2P01YsA/qWwFEyrlQUBQcx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYsxxHNmp4V4jYaZOwC+9wfUOkrVMVcG+cP22JFxCpTIL6lArq/ZUGdC+9Fukh9WhRT9Fl3cK5uU4WTSGRsV1H2H4iPrIoRpv6LefH1umBYgi3t5hwVvTSl2VBVU4mxIaVwNg+FWIJUYkY4Pu6e87JMx75oYE91C5MfLWr+bYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3PZwKLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED52C4CEFE;
	Sun, 12 Oct 2025 14:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760277954;
	bh=+UJhMGZLyCB4kTOPEaLd2P01YsA/qWwFEyrlQUBQcx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3PZwKLiwlWm2I2cNuHVGFdOaowBIIrTvOUxGlF8LH8q6n3x+TqguvNqYioYxRAoI
	 05Hvv8wgfL39oQEZIvYP5Dn+DubgzdvS5zIBqxY54kAYQO7DvA9KQEGwzbBeJduHTL
	 BKopD+6JZboWhlSxYI7Ej+5CRsbZ3tprz1ZFoGxyGoQLWyLgo5StZk+t0/ZJxJj2HN
	 Lf3GMTLshGK/v5276uYpsZZH0/T7L4t31OmoiQOdvzbLzQXEtac6aJlIylrAJ7Tq6/
	 GD6VGvq40yJcUxk/uBjYyg8jXbIs1wM7XUXcZ664/x9sGncUghLAy+wYOjDDoU0ID7
	 39nbFx0Od3O7g==
Date: Sun, 12 Oct 2025 16:05:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
	Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: pwm: samsung: add exynos8890 compatible
Message-ID: <hapruczvl5fknoxpuciwqe2fhhmnv6ybtvsr74fn2l2vl7r5t2@o6p3la4pskhw>
References: <20250914132033.2622886-1-ivo.ivanov.ivanov1@gmail.com>
 <f5b4ed0f-85a8-4476-898e-0a13dcdc2c6e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z6wswybev2kbjalj"
Content-Disposition: inline
In-Reply-To: <f5b4ed0f-85a8-4476-898e-0a13dcdc2c6e@kernel.org>


--z6wswybev2kbjalj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] dt-bindings: pwm: samsung: add exynos8890 compatible
MIME-Version: 1.0

Hello Krzysztof,

On Fri, Oct 10, 2025 at 02:32:53PM +0200, Krzysztof Kozlowski wrote:
> On 14/09/2025 15:20, Ivaylo Ivanov wrote:
> > Add samsung,exynos8890-pwm compatible string to binding document.
> >=20
> > Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

While I'm usually slow picking up patches, that one already went into
Linus' tree with my PR for 6.18-rc1.

Best regards
Uwe

--z6wswybev2kbjalj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjrtb0ACgkQj4D7WH0S
/k6f8wf/VVy0eDHP5BQPfEP1qBLBXktw0c4YpVZ4E3p6s3El7je2gETUIqi2HqLF
+4qOx/oB0jOyKvXVhnDiU3+dh0QT5Ow0VKc2TUJoLf0o12E89OehJQtVJUKXjmTh
GRqlKo09MbvTG7/zC2lGLgJUDsoc0eCvbnbwUxb4CikGR5Vu4E1VVPj8JljPxkVJ
9D9kcuwh1zZjKi3NVQsR6UjDqsIpq+p7li9znwFJ7SAwqbVWtHyxGr94r+inFa0A
/PcWDjSe6pKKuxytENlPVZnO6X0pdhvE2ul5/bsfdQ9ic+l/HhSgcrkG72QU4lW+
AtZu0tD7AG53YJd8KA9baajd1KXGcw==
=s9Xt
-----END PGP SIGNATURE-----

--z6wswybev2kbjalj--


Return-Path: <linux-pwm+bounces-4748-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B09A1DB9E
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 18:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3730018899DF
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 17:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529EA18A6A1;
	Mon, 27 Jan 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhDelnfB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9C1632EF;
	Mon, 27 Jan 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000427; cv=none; b=Tj+L3WniDc0KhU6u6DPlykX87a+hbW3nYk0FVrrvHbUOc8AQf2nB/vzGUoFDZ/+8o2lI407HcjvyBQ/sbvMALJsCE5xwnK8XGekGPkbOLT1vvchEcETkSb8Fw0eCXPQRMqgLexvPOpJmVzRjrlw8FdtDOcVsodb+nrAopR1M1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000427; c=relaxed/simple;
	bh=D6rTYlJ7adtRt6OVqK+mDWFMjreMOILxT7XBoOHfLEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPAxkOsS1NfrjGCeefZxa+5ppMKwOVbW1P83zC14E4uwftYYFC/EgavFqn4qtrXW+PcLx6ob2BukN+zCO4wQ6v2WvGk9afAFEAgTKNxSjurXVi8ma/b0EB/MbRh7Nhe3QG7MAYuckH6tEg3N2WfEwm1ADaL4i1TGV718Zc/Onxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhDelnfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EA2C4CED2;
	Mon, 27 Jan 2025 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738000427;
	bh=D6rTYlJ7adtRt6OVqK+mDWFMjreMOILxT7XBoOHfLEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhDelnfBbP0zvX54YLY/nI+7R+AJivkYOcPZkheUdzxsHuDfHgyIegUuTy1HSIWDA
	 52zw5M5wAC3RRlhyLeTLvLH0jjcP1Yi+H2wnT8sOgfWoPaIHWcB3pk+b8oXFpa4xfR
	 zCLtv00exLWY1VmK8mFBUS8hJnHS7fv46EnCxd6l0qfYn5rj4DVUs6oEiur8Aqel7o
	 HOgL+VbLJ9ONh6tKBn9QqjDVNBFMys64pkevk2zDb8MMEepZfrN1NafmDhvwBlTdec
	 urTqH83+I3/fUne2Qf2NLA9Ywr3qbi9pbkUKZLmAQNZt7B82XxzXg+ZKqXB4lqIB9M
	 n9BURY8VbUUlQ==
Date: Mon, 27 Jan 2025 17:53:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: iio: adf4371: add refin mode
Message-ID: <20250127-makeshift-legroom-bb02764c6ed6@spud>
References: <20250127101026.5320-1-antoniu.miclaus@analog.com>
 <20250127101026.5320-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m24T8jOaz/caQgXq"
Content-Disposition: inline
In-Reply-To: <20250127101026.5320-2-antoniu.miclaus@analog.com>


--m24T8jOaz/caQgXq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 12:10:21PM +0200, Antoniu Miclaus wrote:
> Add support for selecting between single-ended and differential
> reference input.
>=20
> Input frequency boundaries are change based on the mode selected
> (single-ended/differential).
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v6.

Why'd you not pick up my ack?
https://lore.kernel.org/all/20250121-crumb-dispense-b455b591481a@spud/
:
>  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml=
 b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 1cb2adaf66f9..53d607441612 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -30,8 +30,9 @@ properties:
> =20
>    clock-names:
>      description:
> -      Must be "clkin"
> -    maxItems: 1
> +      Must be "clkin" if the input reference is single ended or "clkin-d=
iff"
> +      if the input reference is differential.
> +    enum: [clkin, clkin-diff]
> =20
>    adi,mute-till-lock-en:
>      type: boolean
> --=20
> 2.48.1
>=20

--m24T8jOaz/caQgXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5fIJgAKCRB4tDGHoIJi
0tyqAQCHsWuqf153qokbl2mu+I+QiG6wFR7hqRawftbxoFYReQEA+L8PDfzvr45y
bw3yBThZH3lGHxySkaBrEm0sD4JpVAk=
=HrzY
-----END PGP SIGNATURE-----

--m24T8jOaz/caQgXq--


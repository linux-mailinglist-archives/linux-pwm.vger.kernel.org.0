Return-Path: <linux-pwm+bounces-7590-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC73C30B65
	for <lists+linux-pwm@lfdr.de>; Tue, 04 Nov 2025 12:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B49424E633D
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Nov 2025 11:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92A2E6CAE;
	Tue,  4 Nov 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgYpEGXy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69AF2C0F7E;
	Tue,  4 Nov 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255436; cv=none; b=hqISX/MCO+5oig97EFenJIzOnM+cl4T+50yQwy18cn4IewTJR72HQmzpLf4XQmptZcm+SYKzUIxjH7tDfNGWyK9PtidUG975luXBsuLt0KXTCi7ohxUYn/6jPeCoVnLR61EYh2u/5OAOoE2clDMtrBioFu+BkD2Gcko1nm8DhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255436; c=relaxed/simple;
	bh=HhTVtV4rEohbmJ8Omo+NT88w6Is5yQozSY2c2wbVNKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQNSDkN6SCGkpmBEwpbMx3/nLvLVllgXs1u272t+4PjALDK/3f4KRJnyNfvcQv9OegQs0/XDLgeYrFcBKUI95Jp3XZ0sEHBVtl1ZOuF0gOEW7mtUtJT3pWPIpO+BmimxMOg3LYirJrxhg7stn0qLL4f/O/SPQ8In30Zf14Bg+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgYpEGXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A87AC116B1;
	Tue,  4 Nov 2025 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762255435;
	bh=HhTVtV4rEohbmJ8Omo+NT88w6Is5yQozSY2c2wbVNKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgYpEGXy/xHY4SfNKGNUN/yedaOO2FcuYbdiyefrF+gdJsKs9bne+OU33pf4BHRoe
	 +jG28RiH52Wt9vASp2n4hzFiMstmxLRByY8Oy+SAubgdEZelFeXtAyr4i4xztucwO3
	 VrJ5V0Prd62IlY0RKv5T3viDxGenzK9o7nn9/v3cR6mbbvX72vM97BWSPGKvUtH8M4
	 NZxwu+1SNscjf4XvnhtrIoWYZzGXc3LqhpIiUEOqAJUtoS3TJfi2f0VKDmuT3oTjuZ
	 7YwQHAKxa+iX4uUoTC1DsdKIDqxI7UyHtwWZVbKXOGYS+Cqqg3guozcRjF04j2dtR2
	 nlnmIfWtpubew==
Date: Tue, 4 Nov 2025 12:23:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Martyn Welch <martyn.welch@collabora.com>, kernel@collabora.com, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH] pwm: rz-mtu3: Share parent device node to MTU3 PWM
Message-ID: <sauwnl3nyyzgyop2qskjrczjgoog4jnjkkhwjf4ofwrthatvzk@2a5rb3vsf75z>
References: <20251009162445.701589-1-martyn.welch@collabora.com>
 <7uuuqhmkmmucmeeo5fybzld62rybyq6fjxwqqnxqr6eufis2ze@xfc2owdzfcs5>
 <b041fde6-afea-4233-b00b-4e8cbb294c4a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qlmq2cdaierwkwwb"
Content-Disposition: inline
In-Reply-To: <b041fde6-afea-4233-b00b-4e8cbb294c4a@kernel.org>


--qlmq2cdaierwkwwb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: rz-mtu3: Share parent device node to MTU3 PWM
MIME-Version: 1.0

Hello,

On Tue, Oct 21, 2025 at 12:47:52PM +0200, Krzysztof Kozlowski wrote:
> On 21/10/2025 12:19, Uwe Kleine-K=F6nig wrote:
> >> diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
> >> index ab39bd37edafc..5825875fa0128 100644
> >> --- a/drivers/pwm/pwm-rz-mtu3.c
> >> +++ b/drivers/pwm/pwm-rz-mtu3.c
> >> @@ -523,6 +523,12 @@ static int rz_mtu3_pwm_probe(struct platform_devi=
ce *pdev)
> >>  	if (ret < 0)
> >>  		return ret;
> >> =20
> >> +	/*
> >> +	 * There is only one DT node, get it from the parent MFD device, so
> >> +	 * that the PWM channels can be referenced via phandles
> >> +	 */
> >> +	dev->of_node =3D dev->parent->of_node;
> >> +
> >=20
> > I (very quickly) talked to Krzysztof about this. He said that
> > of_node_get() should probably be used here. I wonder if
> > device_add_of_node() is the right function to use (which uses
> > of_node_get(), also handles fwnode and implements some safeguards).
>=20
>=20
> I am not so sure about device_add_of_node(). You do not need to
> get_device(), because reference is already hold. Although setting
> dev->fwnode might make sense... But, not that important I think, works
> with me.

Note that device_add_of_node() only holds the get_device() reference
temporarily as it calls put_device() before returning. So that's only to
assert that the device doesn't disappear in-flight. That "locking" might
not be needed here, but it also doesn't do any harm (apart from a minor
runtime overhead).

Best regards
Uwe

--qlmq2cdaierwkwwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkJ4kUACgkQj4D7WH0S
/k6VVAgAhshI0+vwCsZuCJkq7CmD+INgvTz5OUo9fDsQeK4PqZpbbOh6Evv7K2u+
L4ZOQ95qNb7AMkm9ePyHD170SyrogcXF1/sZYk/dK0Exs3sjuCpzTdBbKdEeRXQk
tSJTIxV5vPwxoMzKgVLqVqK78rKfdRPvd440AqJsqz5dZ9adhcVZYU3k2lRKK58g
bab779DEBXvwkD1F2KolI1aVHvNW4fto/SeFGsLS6NhO44knmTMp4IRS6vpK55Q3
vMwkZi9DjEUy0TZo+Zfuj0Woeif1WpqQnw15nl7cpXcFHzVs3aq2jWYrtf3YgP0F
/TKqoDZosIff4g9Q4on28r3C83Clxw==
=7UKB
-----END PGP SIGNATURE-----

--qlmq2cdaierwkwwb--


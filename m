Return-Path: <linux-pwm+bounces-4695-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EF6A182FD
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 18:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F793160311
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3B1F540A;
	Tue, 21 Jan 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgtfnnZR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0741509BF;
	Tue, 21 Jan 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480911; cv=none; b=jBbBYDp+XyrPNg0JPbKDFUlYhG8zTyQkgRPAdJBX9Z/tvB8Pi2a7uoDPo78p17E5YIFKIXga7Tgk56mbbAMbHZnMRJyxI26vqCKfyA8R2wzcZURoVK0ewgiD/eNcCODv3oNBwf+jmRPQ+opao76M0S5maaUQHYFa8FHKSytIDfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480911; c=relaxed/simple;
	bh=0O73OE+w4Xbznwo5wLX2Ao+rZtbtIsgrmJGdYX8/1uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbjOGQusD5EzwWsLRjKc5HttXUAh5i5LoyLJYlXPAXsRTxnWuiPEj42srFpMcCmqQg6U7y3DUSfJZK+hdbLK6RwndkOCOU7T1GMO2yUhsgMQJDKC7y6kMh4+9mUI3CFvFvqjp4KAxA12O0hqIjcTpi416rv7W8yaYQ5fTi3hWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgtfnnZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7126DC4CEDF;
	Tue, 21 Jan 2025 17:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737480911;
	bh=0O73OE+w4Xbznwo5wLX2Ao+rZtbtIsgrmJGdYX8/1uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgtfnnZR7XEN2Ki/+LK1za5x+icZYLPytphulTVncxI5po/BrCor67f3UUI7cVJhq
	 IhvCQdAuCEVogvEWnC+2ivraLNR6tuMJWZXU8/YjINtchsXtRJDgxQ+JB3ps/D+X3r
	 +0ExDB4LxrsbhzEp1m/GCU/hRkG2X7pynHyQuK7DNLauMkIFw4tkM2pJaFlKM/R5sA
	 TQL1pGysG0wFldQVGFJ5gocKkq4HzSrAm2JK0VxC8ziNgzhCfqsgqA8D5jS5+HheHt
	 eKcLg88aAV2eWWKVgY26zzTarzeDczjWnzV+9jTYgxon5/VFbBPAAUbDBnqCCNXJ1M
	 db6tu1nUFBDDQ==
Date: Tue, 21 Jan 2025 17:35:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: iio: adf4371: add refin mode
Message-ID: <20250121-crumb-dispense-b455b591481a@spud>
References: <20250120113408.24395-1-antoniu.miclaus@analog.com>
 <20250120113408.24395-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ACBy6CDaGsrlwYH6"
Content-Disposition: inline
In-Reply-To: <20250120113408.24395-2-antoniu.miclaus@analog.com>


--ACBy6CDaGsrlwYH6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 01:34:02PM +0200, Antoniu Miclaus wrote:
> Add support for selecting between single-ended and differential
> reference input.
>=20
> Input frequency boundaries are change based on the mode selected
> (single-ended/differential).
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ACBy6CDaGsrlwYH6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ4/aywAKCRB4tDGHoIJi
0i45AP98E4w9Lx20+jojJoUS/vrMwvCLu8pfWIqpfZEi0npcCAD7BHvuIIR30lKl
eylmT9CA8ioT63/Qa4i+RuJKZN6ZHgs=
=LsVt
-----END PGP SIGNATURE-----

--ACBy6CDaGsrlwYH6--


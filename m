Return-Path: <linux-pwm+bounces-6328-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B6AAD7838
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 18:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7EB1883CC7
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B429A30A;
	Thu, 12 Jun 2025 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojAf1B2Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A86298CB2;
	Thu, 12 Jun 2025 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745779; cv=none; b=GwNYmx9GSX/C2BiowHn/zIj9sJFwIh1IsbJ3k6bHoc9gZ+HPWKJrU8e4V6nnnY2VHSzl/ZpqnFfr5ysQVtaxokclodI3CREeMsKL7VqaYeMtO89Np8QjpH4YQgl4Q0dnjE2V1RBa55rin6/gMDH7Ui/gIh3/kb1/VhT0JKgFIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745779; c=relaxed/simple;
	bh=+foV1HFQtXe/BJp6C8D+T9nvZYYAoq8z11OiZjLqrZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sizaS25J5M0cSc0FtUjMA5VSDC1VNBVLB2Muhxdu7pRC7PwvlDlzW2VlCGhElexC99lZVTG5uZ0zXDqx5JDNeT9KvqOmmqfoc+SCnHE4G65HOv6DvHmaXGiSOwQehhBo4yX0c9xK/m1i2F3gCB/OlP1DeJGKIOn7JHccbda2i8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojAf1B2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C9DC4CEEA;
	Thu, 12 Jun 2025 16:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749745777;
	bh=+foV1HFQtXe/BJp6C8D+T9nvZYYAoq8z11OiZjLqrZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojAf1B2Y8L8Z8GnLSZ63qs9P7oQzoJJQtlSmIPccOGL/fQ33shMI6q9cwnjssw36Z
	 0EVTFIGpU27nKUiYKSlbT2qLMWbG1h/HK2JaUbHyvCjX5CHXIfc7xFY7iK51TB0l7L
	 XWar8ohG56W1no3L8KffNJaOXwcmNd2sRbp/Yx9unVfe6fKY3Qs1r4ggR2iSo0Y0XV
	 mm5AD4v1uAs5NrCjL++TQrma/O2XUbC2WzBO1mGgkpHaGfNJ7suRZxKGm9z8sGPn5u
	 Ew+zBCqFgInncnj8sVLgO1DJCqePuLN+fq1Ch8wAKNTGzJ1Wb2I0OBVHvtnwjVJyq2
	 CxBBUXdFKKSyg==
Date: Thu, 12 Jun 2025 17:29:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Document Argon40
Message-ID: <20250612-untidy-quilt-4b8528fd2c27@spud>
References: <20250610220814.167318-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qGKAJAv92TKfrpN9"
Content-Disposition: inline
In-Reply-To: <20250610220814.167318-1-marek.vasut+renesas@mailbox.org>


--qGKAJAv92TKfrpN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 12:07:25AM +0200, Marek Vasut wrote:
> Argon 40 Technologies Limited is a SBC expansion board vendor.
> Document the prefix. For details see https://argon40.com .
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--qGKAJAv92TKfrpN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEsAbgAKCRB4tDGHoIJi
0gZlAP9BHvAO6J8HCOF9ukala1/ekkmylQwjTKy1RsAkCkd6DAEA/pZid+NmoxYJ
Fl9eqc7GlFBYF5Xsb4fVwjBQ+Yx2dwM=
=QvxH
-----END PGP SIGNATURE-----

--qGKAJAv92TKfrpN9--


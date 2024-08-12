Return-Path: <linux-pwm+bounces-3010-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877F094EA5D
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2024 11:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24243B211CE
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2024 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB55216E86B;
	Mon, 12 Aug 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyqpaRTr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196616DECC;
	Mon, 12 Aug 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456688; cv=none; b=RPEN94bKqSTYpmEeJGWDBCvfc155CKw3wc0aNO7qKS0owi1OtbEcZNEH+EpACK4DzZwGDTbnS65PwKXopBsKEPBhC5RIBsi/AcIBdXSlKbzoEx9c8GBv7QfK0482pKky29RI2Ra88Hqv8MDxWraJLoJW2p6PhzLznbI0345ULAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456688; c=relaxed/simple;
	bh=7TglcbWM9PAvGdHd/deayAho5Z1VUuXjptlNnaZZMVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng2eioZMgs2jvOw3EDfOuKQHStWco2PWoCg9JJXhSCZq+HLRYhWI0zXnJHrnANvAW0p5prZU/Cpv1C7tE4uc0Z6xEVviLnQqvPMnYn/2eESCNCSdCbN6axGg2Oy9a8atYRamvoYuNmUxtHy9aQgWmU7Z+pCQYGz1ccn8+mXOnwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyqpaRTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913BCC32782;
	Mon, 12 Aug 2024 09:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723456688;
	bh=7TglcbWM9PAvGdHd/deayAho5Z1VUuXjptlNnaZZMVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZyqpaRTrnilEeQHNewSRPLKuLOH97XTGoIHGn3Kv5jS+xNKjuGxJWddbrVmlVQKfG
	 i+KsDnDa0EAHptf20yBEnZuzc+7lRrt3md0ZSLaUnB6EBqoASnp0PjRJN9l5IYInpg
	 RTqXhzXwfIBhWUPV8sJq4ASWojQhLiMTtmVpD1ODvtMLMewzsictBzlfwCFJbVItpH
	 GVOD8Z5pe/XxE7VvhffiOZzw+cl9E3Mv9sJjcbTPnTim9Mh2ogkEdU/iZh6MaaOhCU
	 5hcMcywIimy+MVuKG4jwII15zy44MRH1H45IIrvT61E2VZpVG2yPqbKCrXSsCU1brL
	 LmMugT6sAJJFw==
Date: Mon, 12 Aug 2024 11:58:03 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pwm@vger.kernel.org, ukleinek@kernel.org,
	lorenzo.bianconi83@gmail.com, krzk+dt@kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, conor+dt@kernel.org,
	ansuelsmth@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Document Airoha EN7581 PWM
Message-ID: <Zrncq1a_TuZLXLZ9@lore-rh-laptop.homenet.telecomitalia.it>
References: <cover.1723393857.git.lorenzo@kernel.org>
 <bd0528c45c2e2efb799b59ce503ab8fed196df07.1723393857.git.lorenzo@kernel.org>
 <9dd754e9-2f46-4083-b30d-cfe1ac204d8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VhIFX8+0OqRshGeC"
Content-Disposition: inline
In-Reply-To: <9dd754e9-2f46-4083-b30d-cfe1ac204d8b@kernel.org>


--VhIFX8+0OqRshGeC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 11/08/2024 18:34, Lorenzo Bianconi wrote:
> > From: Christian Marangi <ansuelsmth@gmail.com>
> >=20
> > Document required property for the Airoha EN7581 PWM. The device
> > requires 3 different address for the sgpio, flash and cycle config.
> >=20
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> That's odd placement. Which tool placed it that way?

I placed it manually. Do you prefer to put the Reviewed-by tag at the end if
the patch is unchanged?

Regards,
Lorenzo

>=20
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Best regards,
> Krzysztof
>=20

--VhIFX8+0OqRshGeC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZrncqAAKCRA6cBh0uS2t
rHLmAP9l7fUIRDH2veivOf520FYlae/A1NWbpxI28gh0hMijuQD9EQX/QnLY1IbJ
Lulb2qFeaD0IAPsoVmPgd6L+MxsFLAU=
=ErQ/
-----END PGP SIGNATURE-----

--VhIFX8+0OqRshGeC--


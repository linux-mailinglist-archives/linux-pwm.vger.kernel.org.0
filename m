Return-Path: <linux-pwm+bounces-4550-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54734A0452C
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 16:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAA018879A6
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905A51EB9FA;
	Tue,  7 Jan 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psnZ0Fcx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED522594AB;
	Tue,  7 Jan 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265150; cv=none; b=RPN8n+cW1J+420QjjRztLaKO+2PZJ1DWalVP3zYZIchYSqDDswYBbyqQDpYrm3NESxaAU6uCHDK0vpzW2Zqz/ZeioMIkmZ+9DlFWpv7CUTYJZSGJcBmUG+P03lnYGaq2c7R6I7JNhlmtEomrBHU0/IomeWFijj9FYALj1U83JHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265150; c=relaxed/simple;
	bh=Q7QnbL6bI1ZqkhdszxN9JIdQgeAvDUdc9ZXusfOULEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqY2mtfhKm0ZzxNH08VFzkuZld3tzovBGCCtqFhasqzW/Z7kVevV2wvK9dUsi9GGmLOeSqn1V0ZpQHyKBcNTKlxrZ3wiGAILfmX2YlHmQycy3DtxUpDOcMqBW1GLpBAoxscD6RE5an3i/Tl2wyhTFK8QvPUrmyLm5k3vMH/Nbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psnZ0Fcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF24C4CED6;
	Tue,  7 Jan 2025 15:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736265149;
	bh=Q7QnbL6bI1ZqkhdszxN9JIdQgeAvDUdc9ZXusfOULEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psnZ0Fcx1yS/A0wNUWIgnOiXW75qdUSv/an4by6qE954b3QnhiMrspRJiNPidpL9O
	 FpTN+Y6y9zlLzzYVJ4gqaMARzDxll5zE9At4PlZlM6Tvdit8QrTqEt81mHQU7OGOHL
	 gfK5IsaeBJIc8+SfzR+J6zYaBXLsv7ksiA2bQHL3Jf09fd1Ehf6MpDz5TZY1w13UbK
	 QoZ4+HCUAyQ2k7D1KMEUac10BpPNmPTWinA84xFMgNJdP8DihEUEC8tmDqyjuyeJBT
	 QXb+x4fjXGUlnVGafD334WdvxYxPNwxYk3GYe0okX9OieJsLfOSINDPXdx7Kzd6kud
	 /guT7BFRR3P2g==
Date: Tue, 7 Jan 2025 16:52:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pwm: Correct indentation and style in DTS
 example
Message-ID: <sc5bau2ynnba5fuzbe423vl6on4kxttb7lyem7yrjzwszzo2gq@e4fhvoxjgdfr>
References: <20250107125831.225068-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f2guj3orivcw775p"
Content-Disposition: inline
In-Reply-To: <20250107125831.225068-1-krzysztof.kozlowski@linaro.org>


--f2guj3orivcw775p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: Correct indentation and style in DTS
 example
MIME-Version: 1.0

Hello,

On Tue, Jan 07, 2025 at 01:58:30PM +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
>=20
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml | 8 ++++----
>  .../devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml         | 8 ++++----
>  Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml  | 8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Thanks
Uwe

--f2guj3orivcw775p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmd9TbgACgkQj4D7WH0S
/k6GiAgAlE1jYz2DlRyJVPcl9nmKyK6RVrxqthTnHQH0jiPrmfTH2AYVa5l1xQSA
c+hMlpk9VUlMDxBuAxU4Bue6ZOV8+umPBED3BvO8ZBsY1OeMMPLgkha4aO2bgSyP
ncbo3Gdt6J3OM1Lgu6i5kL0eBz1SpPo1D/+hkVb1hIvyGVBAPR72wGwgI3d7A86v
CbpqkpD7wfAbX3f0Aq5X/Cj8O6QCSB5K8APyUeg2FU/Ydd7ww1rU1abQZwtRlRTg
Jr3rn8QsZpiWyqMZWYiP8kjnGS91EO7FL6YQjuMz8vg2MUdxxWP5hR/+HR/6Rq+o
sPL6XXtr/CAdCoed8Ng6Hsr/CKpRcw==
=Ui0j
-----END PGP SIGNATURE-----

--f2guj3orivcw775p--


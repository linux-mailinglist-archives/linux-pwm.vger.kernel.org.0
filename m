Return-Path: <linux-pwm+bounces-7748-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF864C980DA
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 16:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731AA3A3580
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F59232D0CC;
	Mon,  1 Dec 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyniix/X"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C332C326;
	Mon,  1 Dec 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602941; cv=none; b=cTe75j0sgx7fPI7lvmHSlIsnigV+ISD0xOIQIw+nCdZlcU76z07EkLcIWI3iklif2EP+fN1wIMnT0PPdY0oq44KdV40XPao6IptfdOIC4v/i2kD8W391RLyIsvHKDy+3EQfIU5C6GSf/YvhmMbQqz4VmfmTMMXLzNUf0Lo92+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602941; c=relaxed/simple;
	bh=dthHaPZq0iIUFz9B7qI5qF+rXA+tieje7A3EBFh1RXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGrfwlLtcIMCmBcD73XADm4eTp4tkAcYz6kd+upSa9UH/CAlS8A+wYHEjGsr11jDZj0J+qGWRTx7o5hRoKN/fGPNWf4v+tXQCl3YcYbGwdCrpooTcI9xT6PY6MtoNASrixQeQD3vx7LEnAAR8Lk+B2j63MNj5cYYCjDeGeYgFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyniix/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D146C4CEF1;
	Mon,  1 Dec 2025 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764602940;
	bh=dthHaPZq0iIUFz9B7qI5qF+rXA+tieje7A3EBFh1RXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyniix/X7vu80IvA23tpFgKyACHvyU7rAySiFNrhgEjOQt1JhKsJWALmrvYFQBQcG
	 gQpUGnQu1Q9pdVMDqVUwB4tJLiX48+45wdIsqekdUJmXMnsu5KyPt+BHi7e3KG+Hnm
	 zIc2HMmT5PMkUxaEQl4zVKwNI62tDdrN6Lx2FaEfhTbk8TNQcSQZSwzYhu4YUSpxHS
	 4i1xDR9mHq95ykUgN2cuOoafPtSPhJOyP+TGTomYb8jol6txGL/lwwLhWwHJ2R5l+m
	 +0dmfnbiLzCaQSaMFoStJGqL7FVZ3tgCJAeRqLMhmmX9cWyDbfPnEq0olYKUZFQJx0
	 w5phXdHw8AhFA==
Date: Mon, 1 Dec 2025 16:28:58 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Message-ID: <ydqyvme43ul6ui7bl37kv3kuhn7js7tvkje2u4a3vasiw4kgdv@w2govkhaa3xz>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-7-biju.das.jz@bp.renesas.com>
 <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
 <TY3PR01MB1134692D7D9F5B67116D2BC7786DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <pilx2etxezmr6rhbwculwjqcxotzkxus5bqdpjrt5na5c7fqhj@mdfm2yh2aptp>
 <TY3PR01MB11346DE28875EFD9B9D86DE5186DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113464F283A3ED4A8AAC813D886DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vhnkbpeucn2g26vw"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113464F283A3ED4A8AAC813D886DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--vhnkbpeucn2g26vw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
MIME-Version: 1.0

Hello Biju,

On Mon, Dec 01, 2025 at 03:04:08PM +0000, Biju Das wrote:
> You mean to avoid unbalance between suspend()/resume(), we should not
> do error handling in resume()??

Consider the following resume function:

	static int myresume(...)
	{
		ret = enable_some_resource(...);
		if (ret)
			return ret;

		ret = enable_some_other_resource(...)
		if (ret) {
			disable_some_resource();
			return ret;

		}

		return 0;
	}

If disable_some_resource() can fail it might happen that the first call
to myresume() is left with some_resource enabled and some_other_resource
disabled (i.e. if both enable_some_other_resource() and
disable_some_resource() fail). Now if the resume is retried
some_resource is enabled a second time without being tracked and a later
suspend (or remove) won't bring the enable count to 0 and thus leak a
resource.

Best regards
Uwe

--vhnkbpeucn2g26vw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkttDUACgkQj4D7WH0S
/k7wiggAow5m2NLPYZqwNeypwJ5l/czsQUJEwYgh9B1KSx1X79ajLzn6SAO/Efen
uB1p/91mmafesP7Cj8ovlNDFq2q8ZBNlKClN5lreGodopGcBiMDuOviTmDf7rHvl
SQGyMM/s6ysMhDOfcI1Xpdb1BPiTFyvWmWdi88Rct9VTXR9qTYS4SOwpQFmKOyyx
F7y1WmMv53C7RBO5jXfaeA2WhmCU6KGG32CVet4zRziDCQT2ZklmCC6pulbb2zdc
JZRk5AaIWdlx0yKOpqb3Y/bGwwWUPBNTkwP6lgcIabKzRovWF0+n1zrLDBxc/sN6
OVRqefhu+qOiPu49ypP/YoEdS4NFjg==
=WPcL
-----END PGP SIGNATURE-----

--vhnkbpeucn2g26vw--


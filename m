Return-Path: <linux-pwm+bounces-7262-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A4B4A57A
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 10:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B007A165CD8
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 08:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3E42512F1;
	Tue,  9 Sep 2025 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQimaebM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00E24A047;
	Tue,  9 Sep 2025 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406990; cv=none; b=rQw/cDMnRbgFKPSXX1Uwpyxhb57QLaKPk2fJGlUWudD2h8i9D6l3mkSs4XedLfFEPc5JeA5y5MWxC8rLq4WXmbNMcC51ahgncPDG0vI8qctKWM8inPMnZZEeeXX6sIzou2YsxqZdXTuHn2Ys49u/euWKqhq6ixsKLCAPEQWHUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406990; c=relaxed/simple;
	bh=ggVURUfp1YoriDykwYtbM1jFe9i/1p9HTTWhCQeLOpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o45z7sTVsb9tJzTcOYlcB5ah2PC19UK/XEzL/1Mnyns9C4fNLxrnc5WP/klRydbfZ+Pa8f2ElwNAOn533PdnsyLzdylJkqx74zPC4EYsVB4nbKl5yNPBZcIlFnwAf8h3tPL21ZUPsUxYxjKOSQ5Kk6D3AN5n8NX25l5vie2nH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQimaebM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0556EC4CEF4;
	Tue,  9 Sep 2025 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757406988;
	bh=ggVURUfp1YoriDykwYtbM1jFe9i/1p9HTTWhCQeLOpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQimaebMsXuc56rqD30mXBr4L+2Sx/Egij/Pwshh/S9DDvVfQmPLcipzuWQRYQZGZ
	 b+ttpcWEu08xvZppqEGaTPiTsfdjEzYD/6dKPdfqDttbTXq7SXH8jkrn973CGkLXWC
	 t9s5Mgzt5Z/5pDbi8AEFwG4LmhWnsBIUzMJM1cx7uWTCyFS92tnGTwnAncY71Jq9Ni
	 FzpRDp1TR6l9qEF0w4Z3D8G6Ub/L+Jqn8T0eiJXYMO2H9UdlzaFsIu8Bj1oWzfw92i
	 Nma/PBrG7Cf/WnoKFzYspHb0IvA1mLHD00pw2OxnzHYlH1xLvyiU37ne9LT+XpA0jP
	 p17kbJbZQk6jw==
Date: Tue, 9 Sep 2025 10:36:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: robh@kernel.org, andreas@kemnade.info, lee@kernel.org, 
	krzk+dt@kernel.org, tony@atomide.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <f6sppn34p4f5rxwtp7hygukh2bqxzb7uxy3xurznfbmop55w6p@mturvxxitkfz>
References: <20250906145905.93845-1-jihed.chaibi.dev@gmail.com>
 <20250906145905.93845-2-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="levdglp5q4pwvgch"
Content-Disposition: inline
In-Reply-To: <20250906145905.93845-2-jihed.chaibi.dev@gmail.com>


--levdglp5q4pwvgch
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/3] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
MIME-Version: 1.0

Hello,

On Sat, Sep 06, 2025 at 04:59:03PM +0200, Jihed Chaibi wrote:
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 221 +++++++++++++++++-
>  .../devicetree/bindings/mfd/twl4030-power.txt |  48 ----
>  .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
>  .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
>  4 files changed, 210 insertions(+), 93 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.t=
xt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.t=
xt

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

for folding Documentation/devicetree/bindings/pwm/ti,twl-pwm*.txt into
ti,twl.yaml.

I assume this will eventually go via Lee's mfd tree, I don't expect any
conflicts and from my side there is no need for a branch to merge this
back into my PWM tree.

Best regards
Uwe

--levdglp5q4pwvgch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmi/5wYACgkQj4D7WH0S
/k4Niwf/Y5CFIBUM+NX02ofsrtkvqQtLCdbAh3EANYXaWRzJKQ+grDHLtczabsxT
442FIO4WZ9rPoiZhAJvWEeVXCqSeSwJiVng5FohvZVZS607pQNIX8yWCy3m+d20l
ZIJjqeJSQ3bCjbav2au83N4+x1Z6y9OvAWGTvwO0hK6pKTTUsWHQd9LDahL+QBzg
fJEJz0nhh9UJNXM7HmaLhY+mjaJgrxOl35D4Y3h7skZ9BMHKcszNbce8EC5vSLbC
AMrw2K83+UsUdbXDHkHxl0yhr6uI+319xCpnK5Q9wGIS568v+V1ejCq+qKXdeTzU
jS9Ihkk6wG/oz9eKQHwYmJgUt95Nqw==
=zs2J
-----END PGP SIGNATURE-----

--levdglp5q4pwvgch--


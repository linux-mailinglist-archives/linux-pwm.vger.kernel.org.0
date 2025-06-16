Return-Path: <linux-pwm+bounces-6379-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59982ADB255
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 15:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB99188303D
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5747E2877E3;
	Mon, 16 Jun 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IplYXVmP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521D2BF01A;
	Mon, 16 Jun 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081254; cv=none; b=P2YG912tQqPjRFNfbSf7eoH8UZpeqSaYHke/r+fT7wqUUQv3Njxi8afzZM0twciLDpnleuwmxJqnpk5sqPX2+achEj18582OMD6Oda1NoF0FVTIEvo8/8S52qQMBUHInGt0YRdLQ4Rz9Pa5gKqLOIRKdlJwI0V4IWTJ0aAqznvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081254; c=relaxed/simple;
	bh=rdv9kLnOvyNV5TOzVtFB/uj865WbpER5B4I4p9ckmR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHwJ5yfrAF+lp+EqCcFxvfcJrz5tsz/gEfVOKFqFFSlZycYXTCcnmwRXv2s2SFnt+vjYx+Y5iRjIxqgg05oUsaDPcz1CGkI+tg3DDbVmE5NU+eFYF4BQJtGnCxP5Bp7AFIlfE8wONznogHyGIdezoaUPALBX3leWginIYOtQ8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IplYXVmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25630C4CEED;
	Mon, 16 Jun 2025 13:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750081253;
	bh=rdv9kLnOvyNV5TOzVtFB/uj865WbpER5B4I4p9ckmR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IplYXVmP7vw4qSpQym/7rxQLwKuwNI2e8pBTRu/r17RN5mvo97RENr4I4q50uDB9z
	 t3IXRMwwFu4tpBq8wDxHCNQm7EZ8D6+rfHfsnlpRzc3J6ADCRb00Jaff2WjFtcKnov
	 Ocd658g+eaqFfCzrHNDXIpYgGX8gnfr6atwHt7Lp1hBUnuGUF2wMz+0oiU9Q5sqpfP
	 +0rOAC7mhbC1gemvOOXRfCcnGmH3ybxlgV5UBHOSVjEVmeUEY7KNwEb4apo63ukbHQ
	 Was0gsB6EAsSNE4ZrvIhqwcNjf9GVHDesnO3JMC9xwp36co9VscAofw7gb60Sc2QvV
	 6lpTJgl42aimw==
Date: Mon, 16 Jun 2025 15:40:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: pwm: convert lpc1850-sct-pwm.txt to
 yaml format
Message-ID: <hzcpjqvc7jygzt2xj25y7467b55gjv5w6bhgqq7plvzsom44wr@hzfzf6gth2we>
References: <20250602140722.941002-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ren6ciqm735ki2cb"
Content-Disposition: inline
In-Reply-To: <20250602140722.941002-1-Frank.Li@nxp.com>


--ren6ciqm735ki2cb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/1] dt-bindings: pwm: convert lpc1850-sct-pwm.txt to
 yaml format
MIME-Version: 1.0

Hello Frank,

On Mon, Jun 02, 2025 at 10:07:21AM -0400, Frank Li wrote:
> +properties:
> +  compatible:
> +    const: nxp,lpc1850-sct-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: pwm
> +
> +  resets:
> +    maxItems: 1

Please add:

  '#pwm-cells':
    const: 3

Otherwise looks fine.

Best regards
Uwe

--ren6ciqm735ki2cb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhQHt4ACgkQj4D7WH0S
/k6RoAf/U5Cx+rqRYS2ZdCPFHIdMoeLmobyj02rswAVnjmxl0ABjsH4OfMakH6tj
76A4BaXMJG0cV8rtj546BuslYkMXGo9ekZ8XwGBSx4mv2i7/12jhXJLqYraJNZ5D
Z1Kq7/KfOi4VN9A5iYOQwbIbYTnbX8DqvaoYg3jODYKRjSBrvox+JJ9+WHGhSmpm
rXTp1Q3O7dCP9JVxFS5BBfSKDmkuUH/P7mX7abfnw2E93W7foFlKOJtBvrhxWPN3
LPqrY6tkXKtjJ9QC9J28WFM7+f5HvEDA/V3QZm99fRQbkw2T6A863sgbTG4iA/qU
V/V5ST9owWyF5szHnkzCikG7CROvhQ==
=tzl7
-----END PGP SIGNATURE-----

--ren6ciqm735ki2cb--


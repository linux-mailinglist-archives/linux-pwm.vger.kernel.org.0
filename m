Return-Path: <linux-pwm+bounces-7034-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD8B2514C
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 19:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B010D4E44D1
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7CE298CA5;
	Wed, 13 Aug 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6sC3POs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39C296BCE;
	Wed, 13 Aug 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104682; cv=none; b=ZP0GDJck/5JM4c35f2qJyqFlzPw474JtAMEhpV64oM+N415pLlwuhx9Sj+uBugcTeHsK7c8V+JtZ5+wGrWOxvuJBIwtzfd2OZyfHy/gRwpeHdWBsJR35xMjp3c3vgmKmykWYio6tguY76l083Wk8ZoAQocUxA33IFFqklh7MOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104682; c=relaxed/simple;
	bh=FSbJnX/tdDDfJEsqxBkGdS+Mt93VVJRBi5BDnS63LrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM7+ieYbOBlHkveakVUYyLwhtFVOrU6NwjH6yG/4yjDml4z8xSSvf6S0ISHgp3Vf3VuVyBrnH4tLn5tTGkPzrwHSOxaCCq7+gfQH3XL64mv0L9Xmf7dYlPPbQ8G5R3GjG+pfmA9VAh9MjnQ7NM7Wz7Vpq3z0uX98RpEs/h3qDH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6sC3POs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DD1C4CEEB;
	Wed, 13 Aug 2025 17:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755104682;
	bh=FSbJnX/tdDDfJEsqxBkGdS+Mt93VVJRBi5BDnS63LrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6sC3POsHNbSLFaFHvuXxYNI7iydZ3zybQL2zc/OwIJwvDljQnciryylLyaFbRWfu
	 42+IpLwFBz15+c4o06uoCluukWrjr7MkUdr0pVDUGSgGjNYfiT4+eNr9aKAZTusHXM
	 bcxloXVLpr9X7GuGqBSW6JyLuOusm/9WzJ+zLHQS2NApmpcV+qkRX2WLos3eXYgQAY
	 OtAvsIhp/B09sOqSh/ZQhAUNnHys6Lc/TxM2VpYqoYR6H5SeGL1UurtDpSF/GAjxFV
	 9ALci36BTn+ay3FLgViJaPR4C2HULP3E29kndISE8R/XYSaj/jlax5SGQjzgwzKGt9
	 QjYFwUOfgAdTg==
Date: Wed, 13 Aug 2025 18:04:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Frank.Li@nxp.com, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ghennadi.Procopciuc@nxp.com, s32@nxp.com
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: fsl,vf610-ftm-pwm: Add
 compatible for s32g2 and s32g3
Message-ID: <20250813-degraded-suds-7f3835afe532@spud>
References: <20250812200036.3432917-1-daniel.lezcano@linaro.org>
 <20250812200036.3432917-2-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RQHkjRFD+cMAASiM"
Content-Disposition: inline
In-Reply-To: <20250812200036.3432917-2-daniel.lezcano@linaro.org>


--RQHkjRFD+cMAASiM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:00:35PM +0200, Daniel Lezcano wrote:
> The S32G2 and S32G3 have a FlexTimer (FTM) available which is the same
> as the one found on the Vybrid Family and the i.MX8.
>=20
> Add the compatibles in the bindings
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--RQHkjRFD+cMAASiM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJzFpQAKCRB4tDGHoIJi
0iaCAP930uL+/MNTShH+iLr3K0k/Z0OGgyJPz6agtNojZKb2MwD/SnRmhmfhNl9u
zK+a3mIzBhHScsYN3AnQN9c4fzDUbw4=
=lIG0
-----END PGP SIGNATURE-----

--RQHkjRFD+cMAASiM--


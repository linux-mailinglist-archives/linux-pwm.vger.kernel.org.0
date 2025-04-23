Return-Path: <linux-pwm+bounces-5670-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32546A985A7
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2FD7A551C
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9767B21FF51;
	Wed, 23 Apr 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuOO2u3C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716A2701A9;
	Wed, 23 Apr 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400912; cv=none; b=Xi7gXOPj3qdBWfwacrRysnUOJeUPQ0u2EPi5oZ+BnJPI8PVg2H6OLYs4CReohY10QoFfgOQzXg40pcsjKk3hDb04So43DKJSK6MBuMCch2Bing/C7SC4yMp7hXUs5HGztHs9xtcQ0T0WNO3LYXD+N1eRk058VRUvMiUQwEIonC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400912; c=relaxed/simple;
	bh=8P8sDzkahWhhCT64GZn0Nrgekze9oIVFg2YRSKyBcuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+tzJeVEL3FrZXAsnOBIIxuNtr08fdH1tXX4G3HWs4CVYQiOqm5QO0ZoVywut8Ok2fu8EWr4sjCb5bI3JvXXNnUN9lKbkMqWUnQl/rU5WL5ImsXIGGxvXV8QZfl/mia+0PtZhf4Ckm0OPxVwePcScnNvduNcoPaE10KkDU1+uiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuOO2u3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A295C4CEE2;
	Wed, 23 Apr 2025 09:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745400911;
	bh=8P8sDzkahWhhCT64GZn0Nrgekze9oIVFg2YRSKyBcuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GuOO2u3Cx4wJMRt8kBTyR7w4O1A5fCUCktQ4067IV9XrWECd0zsGQfyY2KXwxAAjL
	 bcohNDuApp3O+XrdnY7uN+usEaYxwX1yS5bW6BeAimRk9Xgno0J5GiT9MVR2mnXPBN
	 0E3zZDYnKAb2am/Q7VVMX5WUzUcH7Nnoy+QO+ZeydZSfVQeTcfyMkkPw16JDXiVjcq
	 hIYhw9l+oTK8KdKsyCpi9E6fcRrdCdIMfsZloOkdGe8FRrlhSFYm01VHm+aXb0sL7B
	 mu8yCzZuBzSAtS9DhgxEgrg4iO7jUPCZEjqSpOtE7BI19pxeClVa8CuSD6GBu20Pe9
	 rEfdqPBtuTPGg==
Date: Wed, 23 Apr 2025 11:35:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, jitao.shi@mediatek.com, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] dt-bindings: pwm: mediatek,pwm-disp: Add compatible for
 MT6893
Message-ID: <5j5sp6jkayy3xojrnuiwlfm4gwd65dcoevef24l2wjnw7vm7qr@lh3ztubq4cxz>
References: <20250416120253.147977-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4q2qghcrkefhmt2"
Content-Disposition: inline
In-Reply-To: <20250416120253.147977-1-angelogioacchino.delregno@collabora.com>


--p4q2qghcrkefhmt2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: mediatek,pwm-disp: Add compatible for
 MT6893
MIME-Version: 1.0

Hello AngeloGioacchino,

On Wed, Apr 16, 2025 at 02:02:53PM +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for the Display Controller PWM IP found in
> the MediaTek Dimensity 1200 (MT6893) SoC, which is compatible with
> the one found in MT8183.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
with Rob's Ack.

Best regards
Uwe

--p4q2qghcrkefhmt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgItEkACgkQj4D7WH0S
/k55tQgAlq1/IAh3RsXMDwoqCzmUuiKr7II2d4Wm5ALC76/irLZDfA5QQVU51/ai
+TfOCRLuh9K5Hqki3o7pEkYBS9naCujh5JYMyG9rVmFawRsO/eV1IJ0PS493ZF+7
0ELBMhPpmGol96JgkYpKeDBWlLTH8jLDK4pnH2FmE1tvN/OU8mSPvD6LuIJmhBdI
p5G4SIQNeTy9ydeJuoWnxO/NSiOBEyqfJxKE8xEFvWhEC4fpjXPzkYYqvQ+2MJbp
qQiHymfCWi5Zz2YUnnsm9c0I1GgoJTPl2Ad0FxPg5eGxpCj95WyyZJxM2VAG6SjA
xKukBj6MTSvGXAYh0VvNwBQ4LkaDfA==
=vDOt
-----END PGP SIGNATURE-----

--p4q2qghcrkefhmt2--


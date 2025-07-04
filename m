Return-Path: <linux-pwm+bounces-6716-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7FCAF883C
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 08:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CAE6E2C7B
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 06:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4DE2620D6;
	Fri,  4 Jul 2025 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZmZrbgb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A812620CB;
	Fri,  4 Jul 2025 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751611434; cv=none; b=VGw/tuoFye4zAhUho5so+h7kGdW+EpuSA3tFioctwcIsGwwo5Fv041tNgmH8kKa5MnptTSkUtqpxe2pXXqV622WvbkSz7pWpOfQwh/7y2OkMVtZuKt5z60idH8EAqPkEppD03XtkR/1BZQaFDo6BogB2dVjoKJvBJskOBoZGEys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751611434; c=relaxed/simple;
	bh=3XkFupaNsnBemY+aTFZSZov+OdyjJe27TTa4OcSEYY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfqKkSEnD81T/pyh+JhkxPmQuPtwVbQ0fjhqDY+W6KadJBGZZJ8cB3Lx/v3xPzlOJC8ztwXeNWPlKFtlCFQtLOhluC0EFhewzHI8Y6QwcrPiWVeqFqNm/o02Rz1DWRvl6cO7vwl+AhW/saUAowqNyvfEC+Aq+h+2s/WLW4kkPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZmZrbgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C1AC4CEE3;
	Fri,  4 Jul 2025 06:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751611434;
	bh=3XkFupaNsnBemY+aTFZSZov+OdyjJe27TTa4OcSEYY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZmZrbgbZiTcGiO8fA/OwuBdyZVo8GegDfk3uRIVQHoUb4L6HhCihaHf4oEL6qjur
	 6KCi6XyoJy0ARByCS9rzIwovauPzAYuD116JhXcFoDYyWTy+QiK3s0JHBpC6Ah2be6
	 f+pgj7W+AbAj442ziPanwVT+mXKp1pl5cn7wt6eixElULShYrfxX+AEIOryAi49P0B
	 fxpLkD2vSG/+DkdSxvcQ3V1DYWzGEEj5khXR1HpKaixSxuq7VYfxDEXbJ2rR1HPNyD
	 h3/Db6jG5GtA+rVu4bKY6gXeibLxMA7zNiTXmkSi8srzgrxzQp8EzYd5MKsU1Hz0Ci
	 kSyBgpg8FE4Jg==
Date: Fri, 4 Jul 2025 08:43:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v19] pwm: airoha: Add support for EN7581 SoC
Message-ID: <4mkqtablb4anqul5khhuhbrkm4hxfpamualogc246vjgagjpyf@h6rc6cpbmumi>
References: <20250630114504.8308-1-ansuelsmth@gmail.com>
 <bwtk2nac2eo2jgf2lousguw7o34tzhz7mesdo3jfaf4gc3pri6@tff3h4f4274u>
 <686434fb.050a0220.efc3e.909b@mx.google.com>
 <wntjec4p7nepuauucwqwgwcresphjikln7cqchep3vjocpuo6u@6hjpkwcbvx7d>
 <6866c701.5d0a0220.2823e.2772@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="46owwjx5ecsjzrqw"
Content-Disposition: inline
In-Reply-To: <6866c701.5d0a0220.2823e.2772@mx.google.com>


--46owwjx5ecsjzrqw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v19] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello,

On Thu, Jul 03, 2025 at 08:07:58PM +0200, Christian Marangi wrote:
> But the thing is that since duty tick depends on period and now the
> bucket base everything on the tick, I really feel normalizing duty is
> not needed at all.

that sounds right. The normalizing is done by just having an integer
result for the involved divisions. (Actually I understood that when I
requested to consider ticks instead of ns for the bucket configuration,
but wasn't aware any more later in this thread.)

Best regards
Uwe

--46owwjx5ecsjzrqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhneCQACgkQj4D7WH0S
/k61HAf5ASP+tCKduX4Xwy49/V/WPeyqQIGNdzdpewGPFQd/f2AZJ792HOLlF23D
00OQXStudpFQMBVwqdc4cEfTLoiO4nFzXyUbkrtGPTIGEEUehhPdDJJQQeXer6oc
R7jdMHqpmWWrkJn0IJM4fj//aQd7JRThX1fAiFx6rvwfTdbGhl0l6QjhcTQCpp0t
SLyVUpAQCsRDhiSLtQLDEJMzMntZZaVcoU8ZjG6KXQcmPu3urHk6asal5QUCtPqk
FcmYwgI4UrVUeSNKC8BYBeo85C+2DjZ+7ga4/cC9LY2tAA33Ft4lAejWhUoGfB7j
H8GDaiHXXJgyZzFMUlyWkGQ5CWXISg==
=uAZe
-----END PGP SIGNATURE-----

--46owwjx5ecsjzrqw--


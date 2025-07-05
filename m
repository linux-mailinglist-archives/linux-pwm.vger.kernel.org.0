Return-Path: <linux-pwm+bounces-6738-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD76AFA09F
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 17:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D064017ED04
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B2917A2F8;
	Sat,  5 Jul 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRJeW48i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EA2CA9;
	Sat,  5 Jul 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751727868; cv=none; b=rSUgMlQ2gDBF/ikdVlQBiIiE7pkjBXvdlnbdG8jo3k3SZKKnGCJy8crpOb+pTkRZSFGqas1pgLGqkxmwqMlrUVY1qIpbQbHvZkQNSN5FaGRWzM0UMNebcMFKDkAAAtLWyqZ1nX/4n+PnGKgw0BuToe7E8vMrzEAMc4icxyQNNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751727868; c=relaxed/simple;
	bh=/tEGc5fW6hHUijJeSsWN8K4a9GkWPWhooqc7Gsks4/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3z6i58/poi/E4YxvTKCiDh/9y+JLaC5YOFxcyLujx00Y34STA0AhSkrhls6h6ge3nOnn2T5xTY24wZ0dl07irM9XVqR0Vb0Af2XfFIEmJGLez5mOUqNN8fubQ7w+Vy7U8ZJP05ELVrE9OE4Ru7iLT9JUklexd/3Wp7oxYfm7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRJeW48i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BEDC4CEE7;
	Sat,  5 Jul 2025 15:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751727867;
	bh=/tEGc5fW6hHUijJeSsWN8K4a9GkWPWhooqc7Gsks4/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRJeW48i1RIJKuvkX/Hy10kbhpiry1RaHWPDBCU4JUnt92+a1l9u6TXtv3H2PuJjv
	 JXidW903yZJO1RKH+WBgHNkXCnYWrCVRnWpQ9z7UZw96XyDWioKIRmdYxRmal+pOq3
	 KHjUcC4tcoPE74Xmfv3CJqK/ayJzo72l/qtc076dtuegcZ1nNYUxvhcbE+7UFY4yZX
	 o+SUjfRpWq0jDIymlgHc8kvUngF6IRu+MVcUXz9WcCVLEiHOHm2QCvKrFHpsezyapD
	 ZGbhjhQp3s1WPa5oDNFrCJg4VS7r6wBfMXc0PO3MN/R8/KGwfYxbn6WaXrzZLRgIqC
	 +1zTkKpUaivWA==
Date: Sat, 5 Jul 2025 17:04:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v21] pwm: airoha: Add support for EN7581 SoC
Message-ID: <wzneefjojgfpgrp3w6llst3kazrczmyrmudubqijnupvijwwxb@22744d27arra>
References: <20250705072825.26497-1-ansuelsmth@gmail.com>
 <k3s7wp52oljegusctucabvo2wcmx7defklk7fdtqh32a2vvcux@7tuafqra4nrw>
 <6868e83a.050a0220.2d26f8.0920@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cq2jf3rldtccbvkk"
Content-Disposition: inline
In-Reply-To: <6868e83a.050a0220.2d26f8.0920@mx.google.com>


--cq2jf3rldtccbvkk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v21] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

On Sat, Jul 05, 2025 at 10:54:14AM +0200, Christian Marangi wrote:
> I used do_div since it can calculate both division and remainder in one
> go.

On 32bit archs do_div is definitively more expensive than a 32bit / + a
32bit %. So the latter is the way to go. And given that these operations
are native on all archs, there is no do_div32. And I'd expect that the
compiler can use the synergies (if any on a given arch) when a division
and a modulo operation with the same parameters is done.

Best regards
Uwe

--cq2jf3rldtccbvkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhpPu8ACgkQj4D7WH0S
/k72/wf/QFxXGrRc1VkBUQYwW/Wch27GYhYRla7LKNBUL9mQc+WhkLODHDz3mC/r
WQz5S4UqMfOxCzwRaMJ8gIgIRsmFLKLmruIKOFu2Xox+UbI91/vDdGVo+wl6NuRs
9OR3kriNdxe0OXtSlyrmRfet3Jgnuq2FX+Km+Pxge1Z+oM9n4wTLKBK00i7//Pu3
dpPhKdbwKxjVO20Iz3eYADwIs9ABD3qdP5/xbAL+FxXMbrdbA+faS2LsF00a1Z33
SlKAYTBEvA/K4QgOrde3Oah1vV5dRqJHMSvdLKOZAcbd3iRc4HFX8Mbg6XSo38DY
U540bsh7PN+awhLnPAUzn70CwoRe1Q==
=rRvC
-----END PGP SIGNATURE-----

--cq2jf3rldtccbvkk--


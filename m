Return-Path: <linux-pwm+bounces-7119-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A1BB2DA81
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 13:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A52418967A2
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 11:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF78F2E339E;
	Wed, 20 Aug 2025 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBFjFvYM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1152E2F15;
	Wed, 20 Aug 2025 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687925; cv=none; b=r6c9CZwOcQFNIrAvB1Vyy9gXsZOKg3Xp5UHKHbqO2l6AYu1bk0MDRXyc46gMPV0U3vjuuRH7hF6gI6rGH5qnl2F9CmMv5QsMfYk7X9k183IXA9I9r35BBLHE5DE9PEWYzuIyzzBcc8Tffd8HfLLYGiSjEeiDPINhDLyHWbH41s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687925; c=relaxed/simple;
	bh=Uw9R2rLFig43U1J7ZsuMVZ3XhevrTzhz/X5SX3+ZS4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7COpa8wJbnzCtHsxYdWqIpU8YlksTnVVmAReZDiS/iPIoF8mCRxEiu47er3naPS4qacgdG4/B+vE6V4Jp2AzljHUhzqQfYAJaToaIXQq+9AfaokmqIY7GMXskVyTWc7+AvOohMq9+1MUqCwfVjsqTiLsF6iJPJsiM2nWVA8YRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBFjFvYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D526AC4CEED;
	Wed, 20 Aug 2025 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755687925;
	bh=Uw9R2rLFig43U1J7ZsuMVZ3XhevrTzhz/X5SX3+ZS4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBFjFvYMhK0tyT5Y4Xt0R+1BB206fVhyWiSDUVz2/ftMSELf/IvMvFi6GDocI8Ade
	 x4oca6+3fVyskXo4D1ESOPFvccDCLAdM6qjg9TzXE/2AX/zhOrrJpsCXqeYwsu0hr3
	 3IitLauZJUldjiMx4/saWk76DWp+aJrxEvet9MicE75JSugrhbYobdULHAJ1mD989e
	 wgOKWHGmLwdS5EmmJEkl+poaNCXVbYXY+ZKVOA+m8W2WQOvLPb7a+JpcdMlTBrNtrh
	 LgT5jTVxdQu8mb1tDqAcS437nOlAug8a2B5FNmm8nSoneCCqpvvYyMZv2pEKUMV8pe
	 LikPa6enQ5caQ==
Date: Wed, 20 Aug 2025 13:05:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: berlin: Fix wrong register in suspend/resume
Message-ID: <dpo6rhrcn6eapfupv72cl3i3eeaqexla5embodk5ook4hew5tr@biyqxthux4kj>
References: <20250819114224.31825-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7dqenncwd4fmgmyv"
Content-Disposition: inline
In-Reply-To: <20250819114224.31825-1-jszhang@kernel.org>


--7dqenncwd4fmgmyv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: berlin: Fix wrong register in suspend/resume
MIME-Version: 1.0

Hello,

On Tue, Aug 19, 2025 at 07:42:24PM +0800, Jisheng Zhang wrote:
> The 'enable' register should be BERLIN_PWM_EN rather than
> BERLIN_PWM_ENABLE, otherwise, the driver accesses wrong address, there
> will be cpu exception then kernel panic during suspend/resume.
>=20
> Fixes: bbf0722c1c66 ("pwm: berlin: Add suspend/resume support")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> since v1:
>  - update commit log to mention cpu exception then kernel panic w/o
>    the patch

Applied this patch to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fixes

with a Cc: stable now. Given this issue is nearly 9 years old I'm not
sure yet this fix is urgent enough to justify a fixes PR to Linus.

However there are two such patches now, so maybe I will prepare another
pull request before 6.17. But for now I will give it a few days in next
first.

Best regards
Uwe

--7dqenncwd4fmgmyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmilq+8ACgkQj4D7WH0S
/k4lSgf8DL1V9Xa1N+GPtYmVSSRC5tYFT97I5OTY9AXpKL+iPP1VMCxExqNlNVQQ
pvisA2MYGtmPSMoNcGv9LYknzCo9/NFdDUuHWYPiq+cum+7sGfiM3/FeVTQhmPo/
TN8p1XPP/+jIIc1o2L2kxRh3DFh/IfI0MQI3Fc6iZMu3HjCZL4mbkes9X2wrdEeF
Zwoyfe1F650wYpejc8+k2aw3gThD7qB1JZesDu1eiJMtIdanJD0g0wSPKSpKsZYP
iNo7SDXkKKZMPGC7sfzm223rmMP/GxfFdy5L9qs09UEpbRZtkrMt5BtmyObBquKL
6LxGEJBQoRZ5CCBHXLLGcUkBa8GD7A==
=czFl
-----END PGP SIGNATURE-----

--7dqenncwd4fmgmyv--


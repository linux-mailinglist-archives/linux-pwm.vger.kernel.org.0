Return-Path: <linux-pwm+bounces-6803-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A44DAFE34B
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 10:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DB4188E3C3
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 08:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EB3280305;
	Wed,  9 Jul 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwCqxZIs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0A27F182;
	Wed,  9 Jul 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051335; cv=none; b=ZDBTYmDiGKRkh1uje5564s11R1QKRwHDbCrOWkDRpkfDZeajfaT1Wk35Ye64nz8Wk0xkm2Psd6Ua/9re8eD3+O/l6Ynlch2/MJmc3zYiIapOq+WnVx+lzob7NOfFGJ3dNdFg++D2Kn28mRWSbR/5SBzKtZg+oA3u1qA8De+mdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051335; c=relaxed/simple;
	bh=LR7i+GKgvXxym6Q25pJmSWIiHAofsdGbz3qu46EZaEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFkeCVXfHAqRUs1f7tuM4rvnT/tAzceBUUrS51asSRzEmlBmCI2AnJWmP+Pkisw7PhfbSVA4ogSCLW4ahXul2tPGOigUVP3kAE9d/n1GdxcFeAVgZLAJHZga0CGB+4aSbw0GBHZ2BcMuTemueVjdjLTs+z0rXrE3PrvvLLp0+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwCqxZIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C79C4CEEF;
	Wed,  9 Jul 2025 08:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752051334;
	bh=LR7i+GKgvXxym6Q25pJmSWIiHAofsdGbz3qu46EZaEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwCqxZIsb9EEDdmnKMTlhNWfMBq1AJMA5MYDkUfs0SVo8iGSc+kSwo0kF8ZLN9/oc
	 LH4xu/aB0CNIm1/zBGG8NQX06BGbKYWS3Yc8TReej0qnOmq9zm7tJ1ulnvv26xuoDR
	 OBKkPxnd0Qz0gkpAJnqqxtNawck6wX95yeyl4YzpuMiA85nyzhPYJQ1XvuoGSt5Y0w
	 NksGALJdlGRgtxqYzIiZgo0m3/UpIPCYle4xfeZlSrXDh+CO8lVXHReLhdhGQsYvGV
	 tt8dGBDv3AXTfFFNU7Ht7gV/EnmtgJK7T3Fr9Ww898d5DUUlkxL/Y2kFc8cBKCKSqF
	 92+EDedpLKz3g==
Date: Wed, 9 Jul 2025 10:55:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 56/80] pwm: img: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <rd4bbz6jjohmeymqpbzaehgzqx2cooaelcryhbpaeyxkazwzjx@l4akvqxyv65t>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
 <20250704075443.3221370-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qqxxxv5qnoubvhre"
Content-Disposition: inline
In-Reply-To: <20250704075443.3221370-1-sakari.ailus@linux.intel.com>


--qqxxxv5qnoubvhre
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 56/80] pwm: img: Remove redundant
 pm_runtime_mark_last_busy() calls
MIME-Version: 1.0

On Fri, Jul 04, 2025 at 10:54:43AM +0300, Sakari Ailus wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> The cover letter of the set can be found here
> <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ail=
us@linux.intel.com>.
>=20
> In brief, this patch depends on PM runtime patches adding marking the last
> busy timestamp in autosuspend related functions. The patches are here, on
> rc2:
>=20
>         git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 \
>                 pm-runtime-6.17-rc1

My tree is based on v6.16-rc1 and this tag on -rc2. I merged it anyhow
and applied the pwm patch. We will see how much trouble this creates, I
hope very little.

Find the result on
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--qqxxxv5qnoubvhre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhuLoEACgkQj4D7WH0S
/k6zFwgAh5MMNbbZVoddGb8QPgjeP+TrphQ8L3EAbDG03LbLShKUELndwV8mnEhi
PG5/8GLjemDIZA3r3EDprZZAOVttZD53Wznv4JgpG5qkkiyqjAi0KUy0iE5KsLPv
uZTSiTR408Gmch7mNpgo5KAEAVGqWnCVXSeSJ8bHIHBjiRwu9n9l8zl3b72srud4
BX7/pYoWsMkIQEMS6O1+6+3Q8zEQp+b05cQ4P+wvTuS0SgtqXVog3OGSjYmFUsRu
ETEJ7fs6qmN2hOVVdFrLHC0g01BPEptS/63YqlN0YHX2O8CW2WW6Z5w92KqAsP8E
GLdYvycW+izTqCUg0lxbF1nrFXMiDQ==
=J1OW
-----END PGP SIGNATURE-----

--qqxxxv5qnoubvhre--


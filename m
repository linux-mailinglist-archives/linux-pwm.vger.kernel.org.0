Return-Path: <linux-pwm+bounces-6013-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393DAABBFAF
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBFA4A33F3
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF5027F19F;
	Mon, 19 May 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uf3qLYod"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C327C875;
	Mon, 19 May 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662449; cv=none; b=atQQsFXlpk+JHNxoIbLus0DOj3XZ1tKsOJD+NApEg9zqaQhvTqqdEqbpSkG3d39zogEmxb8b+tBwukb9cgAJ2KypHtu8YLPReoIsEsfeIKGA6CrQT2WI+f8+7R+5sBQ+cUF1t5BHY/JIuad+iIvyGpESeuzaUWVOpjvGjYRKBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662449; c=relaxed/simple;
	bh=ZiIztDnqsy7lttlHbcN9H2p9Y766zX7cnay4gMCyOBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PweemoNgiav5thxCIwHWzNU+B9DhChNM9H+9/pmX49j5nw/xOloHac/EGDukcELLupuOLko1dOQBiXPRwk5G84h++uwtGxWPdPPLvhA6xHjIkC09qiTtGOBn6FhIJjjdnyGUx3ThAKL7Q9criUJLK5y7xzDQufTssFVUT09uhQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uf3qLYod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC852C4CEE4;
	Mon, 19 May 2025 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747662449;
	bh=ZiIztDnqsy7lttlHbcN9H2p9Y766zX7cnay4gMCyOBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uf3qLYoddfguPY5juRMEYzps76k5iwNa4hcT/OnINzFIuhS6A+70NtOgsyK4PTLaG
	 9y/xKTKi/e9ZpII4i6+3+1suYiSRzQyA5saxyqVNUNQDsOUe9Nj5uKFKQNH1npmqkL
	 Dn35rC9i+9AhrBrqvpvq9si1XFoZx4z9xqvr7sjpvTW1XXuvJa7onpzAGk6z6lOAap
	 YkEaf3ywPoYYBwhcZVIPcACxDvCoucI4UbOJAK3SiMydRVu+8zNfUQtKWdk6RJy8V9
	 FNWg+Wrb6VnkCa551cNf48e7z9vg92jcYjDNbozrgLx/zAmgGBLDkm5fzOqQlDCpud
	 gtYHiu77ZdZeQ==
Date: Mon, 19 May 2025 15:47:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: dimitri.fedrau@liebherr.com, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <kvckrtgbdxlzezxzn5xe6owmbaxa5rygknsv3hne32awfc7y5s@k2akbs6u7tkr>
References: <20250515-mc33xs2410-hwmon-v2-1-8d2e78f7e30d@liebherr.com>
 <mjmrgvw7dg6wlipvku4yzaazbxomsfpr42hdvh37c3r5zybjyh@4olym5bwde45>
 <20250519124028.GA423953@legfed1>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rrl3j5uikcwdofo3"
Content-Disposition: inline
In-Reply-To: <20250519124028.GA423953@legfed1>


--rrl3j5uikcwdofo3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2] pwm: mc33xs2410: add support for temperature sensors
MIME-Version: 1.0

Hello Dimitri,

On Mon, May 19, 2025 at 02:40:28PM +0200, Dimitri Fedrau wrote:
> Perfering IS_REACHABLE over IS_ENABLED is fine for me. Is there a reason
> why you just didn't replace IS_ENABLED with IS_REACHABLE ?

Because if (IS_REACHABLE(...)) is nicer than #if IS_REACHABLE(...). It
has better compile coverage and is easier to parse for a human.

Best regards
Uwe

--rrl3j5uikcwdofo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgrNmsACgkQj4D7WH0S
/k6+Hgf+Mhu+Ky4NV790iyqYQmN2UyFjZjLEVMjwih3w7K4MtQlDzniuUyYBr3Cj
b8/owEO1PUzmx9pRFvq36M21EAyhJi0U8bR6LsbBLZ2jUfBK3PFT62ht1gGoNt+q
2la/3Uj44+3I1azq9FY52SkikXlhiTsaMuls+xiGjhvKn8Sr7BZNUjYQSQXFPmSM
jy4UTfN0LSLcJjivsAzr8570Hmm5XLxs7LW2e0QJx2NIjFrDh1sCH2BOcUxUeTWh
BqjxeIbTtZ/9EfVrHfDPZjdonJbm8dTBg7Ot8kg69xYnfgJAIIYHnNVogHaY8Och
QGKd/h6r+mVYw8Xi5ghiJE1Q4W7jKg==
=XnUH
-----END PGP SIGNATURE-----

--rrl3j5uikcwdofo3--


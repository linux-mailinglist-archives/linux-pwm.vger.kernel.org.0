Return-Path: <linux-pwm+bounces-5816-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1D9AA77AA
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 18:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6FB16AAE9
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC85190472;
	Fri,  2 May 2025 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP+Y9lSp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F41418AFC;
	Fri,  2 May 2025 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204472; cv=none; b=LcuV4zL+0W/Hm7DPXR29tzJ3zgEs+JWvkgOecjKGzPhb5mA2r4P5g44qq+XpOmNvnNxLA0sVx/Q37tYgZOg0dHwIZJ/HZe01RCMpYb+Mnji3hyMKKCSUSpR8EMBve1lEAYz4mJIoinRvdiSmeuA3Gph/ZRXKUMq++Qao5kRCcWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204472; c=relaxed/simple;
	bh=tUQ4h7QZxsvJ5HB6FNwGgOGWyw/11iybNMFrdWHguKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOgdLyifohsYbv5UgUeGLqCu7GRct3XfN281ua6mwBwXm+zjdjP9VgeDyZMNfumVizYuwcRP5a8z01jxVP/+0un88IenMxHo2U/RjQQ72b/4G+fXvknkk4z6gAbVQeg30dcUa2fT+3tsUf2JY7db12I2b6qKKi5hj3cixRx89Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP+Y9lSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81660C4CEE4;
	Fri,  2 May 2025 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746204472;
	bh=tUQ4h7QZxsvJ5HB6FNwGgOGWyw/11iybNMFrdWHguKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FP+Y9lSpgzpsoNdZNxNsvBRLEAnzB1mIfyi3ZQDvqSzkQTkUzQZJe1SIC2+GCE+PK
	 rL6LpH+t6e6BE4onYn78VtpMbDwZuAFSb3aN3u5H8QcQdtxVC59hH3YoqEwNOnZCoq
	 PeoTCK2BaKIBqZkKaN0WNjJBw225Fokr5IuPuqDBmkCYCsrBofJ8dll7Tfi6h6GX2S
	 ZEalc+83CcJEAG5reAqm7FVEfa06sEM+HRVfoGGW8HMFJXGyuCq/RmRdmn7vunxK8Q
	 BrqVGMVK0XTgeFgLsGHdU6AGEsX3SrMktPHE+ddOsjfsfeq+4fY53eG0D4ZBuLc8Lt
	 XkwiZKya7hytA==
Date: Fri, 2 May 2025 18:47:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: dimitri.fedrau@liebherr.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 0/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <cz5tzcmkpkoi7f6g64opcoq5mclahyom4aqafpjxmhisjidize@uw4uq3pmxou4>
References: <20250407-mc33xs2410-v9-0-57adcb56a6e4@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fb4lyrpuybx6it7v"
Content-Disposition: inline
In-Reply-To: <20250407-mc33xs2410-v9-0-57adcb56a6e4@liebherr.com>


--fb4lyrpuybx6it7v
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v9 0/2] pwm: add support for NXPs high-side switch
 MC33XS2410
MIME-Version: 1.0

Hallo Dimitri,

On Mon, Apr 07, 2025 at 01:21:50PM +0200, Dimitri Fedrau via B4 Relay wrote:
> The MC33XS2410 is a four channel high-side switch. Featuring advanced
> monitoring and control function, the device is operational from 3.0 V to
> 60 V. The device is controlled by SPI port for configuration.

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next

as v6.16-rc1 material. Thanks for your contribution!

Best regards
Uwe

--fb4lyrpuybx6it7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgU9zEACgkQj4D7WH0S
/k7Hnwf/dTP1MMQv9/ToNPc2H4nO5NJTsH2IUJtUlyKlbVaPrTmAilrWZJ6VquA9
b2UJJ/udGeBwyaDC6pJQmZgw/gTBEbzCM19KdoI2U67j5XjNEApMfth0E4JcTNUI
qgwQHWKlIsf/r+N8BioHl+7bBOY3oxJ8f8n78ZTI0mnfTHUc5H/TGbXY4/n+sn/l
cJF/sR1OIlQ8m9orvJA8+XozHaev7jqsCTDnyJXHK5wZXRsyDVO1GXOYzm1GTd/g
xDpgkXNrm7SLmP/9SIo8McnjFmb1CAcH66LxnQZUBDz1ly1qdeuPSFteK3TYjW5G
oquesExyfQhOHS7OJ89DAp9yggNJqQ==
=YH15
-----END PGP SIGNATURE-----

--fb4lyrpuybx6it7v--


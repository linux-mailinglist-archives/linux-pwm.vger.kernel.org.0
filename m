Return-Path: <linux-pwm+bounces-2146-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1498B7E05
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 19:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A656288A1C
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF8417F39E;
	Tue, 30 Apr 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvY1BHyS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA917F39C;
	Tue, 30 Apr 2024 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496290; cv=none; b=dNtxgGhMSipdLUgZ9Oqp5R24vLKFU1YicqxW+JCEO5+YplNqgzb3S1AKvYuNdrekvMjQb2CHFtFK4pjoB09ClLWmX8BL1iJnvxG0SlNt+RPzSqTijVO1uAlpqWSUNn1BzeKw9OwmeHjaSHLYJ0+x/6DvIboe1eXn3o0cnQp9xGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496290; c=relaxed/simple;
	bh=lDUPsHNJRm2vFC6dQs76wSFZgmxfxSwIZr0Km7C9CAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2mQqINtTDRtpznPjziBohrv7JLxiXKirB2qH/5SoGxWwRJXCUGIjH8DQKoWoLsq8askcn6bWhJUSmuM8QQd7K9sDlEjoVaRnxQR22udQ/kCOYUoqJfiDFJtztuPxqpXbxiD/mTnaXE2UKj7Ce86DsRTgNp3rUnGy8Poogw9pNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvY1BHyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10177C2BBFC;
	Tue, 30 Apr 2024 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714496289;
	bh=lDUPsHNJRm2vFC6dQs76wSFZgmxfxSwIZr0Km7C9CAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FvY1BHySc4Ng8aJTlT3vQN64yhzv0e54BaUVsSzzc0eJqnuQBQQnoOldKPp+T1O8y
	 UX2LPHtsctootgqAJ5+0YpYjPsvozSuLS3/xYBhahzvyncWy/EFHVSjQJv/JwqiXhe
	 b3c4EzhjVDpgPWIImU6lK2MnWQUxZsePcmfSZA2R9lh00NsY36G7ma6uvmNjzNEeTr
	 uzK0KSHRKpSQ7Z1z5GBUEvyY+ZCLA/gA5jJJqsXVOT1wVhto5xN7yxp2Ej4lb/d8Hn
	 KbHGgglmetLwEaBiGoLibycITHHeNs8qOw0jPc5OJWrLu75zMs8BYXvM70bjkSSgq9
	 jf7VFweOZ5jRw==
Date: Tue, 30 Apr 2024 17:58:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/6] dt-bindings: pwm: Cleanup pwm-cells required twice
Message-ID: <20240430-handstand-stowing-f8977b2f640a@spud>
References: <cover.1714450308.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GyLqxIzh+7R6rwUQ"
Content-Disposition: inline
In-Reply-To: <cover.1714450308.git.zhoubinbin@loongson.cn>


--GyLqxIzh+7R6rwUQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 03:32:01PM +0800, Binbin Zhou wrote:
> Hi all:
>=20
> When I was submitting the Loongson PWM dt-binding, Rob reminded me that
> the pwm-cells property was already required in pwm.yaml and did not need
> to be repeated.
>=20
> This patchset attempts to clean up the required pwm-cells attribute twice.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--GyLqxIzh+7R6rwUQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjEjHAAKCRB4tDGHoIJi
0tbuAPio57Z5KY9x+8ZJkH0hHYUbb8tAXGr/WNyLtHjY/xhRAP96CgbhSBImN2aM
Y0cRxwsgf+7w7fYmFHEW5sI06ZqfCA==
=UnDz
-----END PGP SIGNATURE-----

--GyLqxIzh+7R6rwUQ--


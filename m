Return-Path: <linux-pwm+bounces-7555-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0FEC21F81
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 20:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4D644ED136
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC92D839A;
	Thu, 30 Oct 2025 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP5D3fX1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D341A8F84;
	Thu, 30 Oct 2025 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852681; cv=none; b=ILwSaph/sW3Wq5KYPz7/006Khhb/Z3fBWQKHrLNc/fU/fRsK58jmzYuvaiap8RsABgtWWeevhsVQbv08zEwHfXtWfB+WJyCYAEu2nxwAuT2o4BnjhI2X0RmD1VyHGaLUCRQaf5AlzWy4sz6MngvL5js3G2YpM+QfhJVpMlGWTkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852681; c=relaxed/simple;
	bh=ABr3gcTdy1AEFkY5sdZ4MfJ8Bnsm1SQbnHUT6ph5efY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M55EB4OIOrtC42qnfS2iaWIxz6eVVvarbrTzuWmjSfgWc98jJV5t3/9yxg5mmd0h3gRPiW/WCoMsh30Dlu2Rbca5A7BzNqx13aQukL9gskEJH5Y/hAuxd3aLIDe+tE3Zoa0GLYPwRN22PWZ0iDX6eId3/6E32bXe3KgygTrDuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP5D3fX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A2CC4CEF1;
	Thu, 30 Oct 2025 19:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761852681;
	bh=ABr3gcTdy1AEFkY5sdZ4MfJ8Bnsm1SQbnHUT6ph5efY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oP5D3fX1EMGh9c10kCDwfDmiGMpOZtXMyPQL9SFXPSo5AL0ohcKb3mOMIL4H/HOW3
	 z7JxGhq0EQFRfw1LQ+JpAl5zajomatIEYiljoPZykixCR87GyxuiqHBvwQUfMCdOQF
	 riMzaPCGXlYqCLnxAx57I1eUr7mp/9dRC9so2ILWNJaonPz9Zwg7w1H/MX52BRewMD
	 KLprEy3IxXML/IW0QCKyYzo+6wxecMknLFy1ZEL2SqaR5p/FcWk+RQS4A3li1AcVV1
	 mb9F5bZWgLLFlyLiw7YbRKr+qK/T8ttGm9yysmo+eZaUFLtlX9+12TUlfc1I5pZwpE
	 5pS3zIJ+Ihn1Q==
Date: Thu, 30 Oct 2025 19:31:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Jack Hsu <jh.hsu@mediatek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, srini@kernel.org,
	ukleinek@kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
	chunfeng.yun@mediatek.com, wim@linux-watchdog.org,
	linux@roeck-us.net, sean.wang@mediatek.com,
	zhiyong.tao@mediatek.com, andrew-ct.chen@mediatek.com,
	lala.lin@mediatek.com, jitao.shi@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 03/11] dt-bindings: nvmem: Support MediaTek MT8189 evb
 board efuse
Message-ID: <20251030-mutable-stash-8638eed370e4@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-4-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c7Po6BzRobpZEEj2"
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-4-jh.hsu@mediatek.com>


--c7Po6BzRobpZEEj2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--c7Po6BzRobpZEEj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQO9AQAKCRB4tDGHoIJi
0rdAAQDtfOt9xXOJY3LJZ28eWWlhiiz47oR/2Mc9KTEE2+w0WgD/faqEEQD5epc9
1K7ESHczUP4YKxIVb83Twfdsvc4n3AI=
=lU7u
-----END PGP SIGNATURE-----

--c7Po6BzRobpZEEj2--


Return-Path: <linux-pwm+bounces-7554-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EDEC21F36
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 20:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611CD4042C0
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B84293C42;
	Thu, 30 Oct 2025 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebvt9yUu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090381A8F84;
	Thu, 30 Oct 2025 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852650; cv=none; b=OX2ib4uiUhOWiYcDQfghQCg/YphcpBP1KvlcDdfYaRJng5hnrGeB9UH164+30T/d+YD8ZczbKlq3JJcusXuuZosjMmqkMOERG9kBdEi4PJDPuBbhjCueRdCsZWmsEj2zwDjtZfnvRKyyzMR3PJ6fT0wP+UJSmqdxFHNK5TlakdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852650; c=relaxed/simple;
	bh=NRAsw0Jvy30LSQZn/ZsjAXFfZkS7Dgm4QYXlwV0+OL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USgFQ2aTV6CGKYadMV5QWdy6xGQZ66cYMsTuqYQ7HDTjyS/Yo7w5tUQhqQZFczOnGIFyLapCGZ9AyuCrfZ3GJ9GLqoCu7KbZc+GkPZavKtVw+uVVYcLpnhZefUoVM/34dlXQ/wrBBBJ+yWo5nSsQi2vXQ5aC4wyCOHTeo9lCqs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebvt9yUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED54C4CEF1;
	Thu, 30 Oct 2025 19:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761852647;
	bh=NRAsw0Jvy30LSQZn/ZsjAXFfZkS7Dgm4QYXlwV0+OL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ebvt9yUu8m6PsKLurYOqqCnVWud9FvHyc/A3AN2f/4EJ3cps8JYgmLc0XkPB3Olyt
	 9n8mjSePLWgCaUG0kU/2WZi/zd5V9HyVWeCxPIAnp9xrCyoEEm1fHg1jgxljTZMHN/
	 ehiuaTBlLV2H4+lcYXaMNGuC3LTwZXiI07JsRGy6cZYsxSglExgabAR3SYCHwXEJUb
	 U1VP9To7+sN4eaN1F/isowHDHxri82nEUUt/EROBckHTw7A18nl+95bBPiW+MfINj4
	 j/LtizuQdJHgYv8D7/2DvhPbj6hv5q+9xvAMNL3/g4B/2SX3Mc6pzXpv+9TlYJZGoC
	 OL2quRY9rUaLw==
Date: Thu, 30 Oct 2025 19:30:39 +0000
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
Subject: Re: [PATCH v6 02/11] dt-bindings: iio: adc: Support MediaTek MT8189
 evb board auxadc
Message-ID: <20251030-deftly-lent-0588c4e910b1@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-3-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZN1lBKxxaIlgYPSc"
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-3-jh.hsu@mediatek.com>


--ZN1lBKxxaIlgYPSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ZN1lBKxxaIlgYPSc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQO83wAKCRB4tDGHoIJi
0kDdAQCPf+4uCaqPObbOK6bxqVafljn62RS/VLsXnr57gJhBUgEAlKxfisQruqi1
UdsEXXfBl/WLLQq9XvKlMn++N69iBws=
=Rorn
-----END PGP SIGNATURE-----

--ZN1lBKxxaIlgYPSc--


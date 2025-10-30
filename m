Return-Path: <linux-pwm+bounces-7551-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2700C2178F
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 18:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E6A40752C
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D06368388;
	Thu, 30 Oct 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkjBz/+e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B622F60A3;
	Thu, 30 Oct 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844844; cv=none; b=opN3ZQ69G9iQjN4yB0fPVpQ4jv3tlAzEQu2klowQ8RUsQG+taql9/ks8sMFuUMcl9EYywarZiIgng3AgaeKW9mrxxsHW5LoXAWcO6Atfrn2tDE4PGQJ50jjRomS3DUFGhp8KbUwINuT7aPKqkj5Bw4aNP4ZubJCvT5F44sko2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844844; c=relaxed/simple;
	bh=u1y3B+8RUYFHKy7C4XHtKEXlhSgIPJIedO3quTvmsnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRFw5puCpyCA0Bi7KTXHVSgcuyrfOKFCONLCblz/B3j+mgWxDzXXmyn0WJ+aobHrNtW7Vk1UaD09WFZVhs1ur9WCz0RFTMLTPyvuqXklKV8GowlmK/CvLOE4qyzqiOfMyTm2C7XRPl2JmwEuYExV/J9jjGigIVBORqv6febHFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkjBz/+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15760C4CEF8;
	Thu, 30 Oct 2025 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761844843;
	bh=u1y3B+8RUYFHKy7C4XHtKEXlhSgIPJIedO3quTvmsnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkjBz/+eMf9gwnuS/btR8gNRi5Y9H5T1/MvDgOETJ01Dlf7POOO8RpU31DJXRWkz0
	 2sg5vdBqJj8Ph6kWnzFnjJqOVHS0p9qIdVvuTwEQdEkbWnKfitwI60rwv1R0RaXOIM
	 SllKsLbXxhoU+lYjc5zZSCwVSFAaxUBYQb1pw/L2dvWot+q9EEwCz01cn454THCbNq
	 eW15Oz+PjCT/eyWSex7gJkIKAg9STU6JMZ93zoBM4JW6g3PVmElPdab0CgaA3lJY0S
	 V180/yFR9pgQdRK2zMgvjebt/1nWBiFL0eYyUUTKzuqEz6PjDvxKLTfQ4gaxsmO29o
	 dKSoOx1QelBig==
Date: Thu, 30 Oct 2025 18:20:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jack Hsu <jh.hsu@mediatek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, srini@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, daniel.lezcano@linaro.org, 
	tglx@linutronix.de, chunfeng.yun@mediatek.com, wim@linux-watchdog.org, 
	linux@roeck-us.net, sean.wang@mediatek.com, zhiyong.tao@mediatek.com, 
	andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, jitao.shi@mediatek.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 04/11] dt-bindings: pwm: Support MediaTek MT8189 evb
 board disp-pwm
Message-ID: <fqceagmqxbix4bnpacimf2lwpnwrw3gpwzknh3a7pt7sfmccm2@4jnh4ynkwwcg>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-5-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tnp73246a7ax7u7v"
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-5-jh.hsu@mediatek.com>


--tnp73246a7ax7u7v
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 04/11] dt-bindings: pwm: Support MediaTek MT8189 evb
 board disp-pwm
MIME-Version: 1.0

On Thu, Oct 30, 2025 at 09:44:36PM +0800, Jack Hsu wrote:
> add compatible string for mt8189 evb board dts node of disp-pwm
>=20
> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>

LGTM. Assuming this patch will go in together with the other patches
=66rom this series via arm-soc:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--tnp73246a7ax7u7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkDnmYACgkQj4D7WH0S
/k6ntAgAmefAEgqrCjLWiUHmGcabEITjr9SAE4YojmK2oq78HLZC4n0T3P19U5zm
VFVFw+gARsZVw2CQ2ANeQiQBXWVDyT8BQ9Vh0PZZvVvE7fqMZM3FfIQ9bU2OgdWE
vmSpfUBeyu1Fm95OZrMi475gX0v9ej4Tj6uLesaLywvcW0l8JZRPpRHDwpARP7rL
fXgtxa69IAvwq1YGDcJfHXe3M+Z4t7OIJpE8qbAVkTpAqH438a26TzlQEgxHsXzi
4C26RMlvhfSb/Ajn1ZU+y1SYyskpUOyGNUKMVYYoRUQEN9D/o3Mrx1T8BAhzpu5A
XXCuNcZ2Tx5Mz3amOjApNarZkQVZhw==
=Yaxj
-----END PGP SIGNATURE-----

--tnp73246a7ax7u7v--


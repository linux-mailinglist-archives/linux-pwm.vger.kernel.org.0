Return-Path: <linux-pwm+bounces-7561-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4CFC2210D
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 20:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D2874E0805
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3F131328E;
	Thu, 30 Oct 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu/eBFP5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5ED283FD9;
	Thu, 30 Oct 2025 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853757; cv=none; b=hMq4fBIUOENJIOEtFceTUwXsLSB3lQs114mv140jqJ2ymXV/ZN8jNoo8prezPz4xXrsHyqLxeVz0n0g7qpi7ays6VkITJ0LAjwl94EAC+ShQDjrOKsg2h5TIcGhdx1MlU0MqHQSCjx54g4i/IKr6iuv2JMP04Opt5vNcs3FKF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853757; c=relaxed/simple;
	bh=lgyDLafQE8DiQDUiJtyJ9+bt7JmcvlRaYp0Kn6urakc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdwTESd6chY1SR85q5DDsB9Matu5aDUFh885jMMyn9HlnfF/NicyndfJ8a9QE05jjuP2E0AOJVOQw6aMACfTl0BO+iH1UJahWptylKjyKzeqE+XLhXm2x7rltNtWcGtVJAvto7I1Xlgq/j0xPvJYntVUS35E7RcVlM9HL8dz5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu/eBFP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084B2C4CEF8;
	Thu, 30 Oct 2025 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761853754;
	bh=lgyDLafQE8DiQDUiJtyJ9+bt7JmcvlRaYp0Kn6urakc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lu/eBFP5oLDumMFhEBp06aze9McYEFE1zeHtLyHf/sA/wPzcnlWHWr09lV/qIkPX+
	 qxMfJ+aT4WdooF22hWKVeSJDTJV6i6+YSHaGVbFY5JHMOo6NHj+iHKqq5W/iibB16l
	 mEoKxOuSC5iS1FlIvtkIDOHLWKl7agqhk3pGa6rzO9pHeNO7cSfhkZvtjJVd1Dr4il
	 LPLVA/244xMmWW93aRCOtXxClp2npsrzYGq1QhADfpsS1Zy60rOiWYHkHWFHOyvZZ7
	 dHpqz/YoHkoaGWp4aMuK6O2/ahC2M4Jtd8mifw4McZg4uUv2C44rNMKg729jbC7gNq
	 aFKX3OVv10sew==
Date: Thu, 30 Oct 2025 19:49:07 +0000
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
Subject: Re: [PATCH v6 00/11] Add mt8189 dts evaluation board and Makefile
Message-ID: <20251030-deodorant-unglazed-190cbfb4a69b@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yaNJtXhYGM5K609h"
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-1-jh.hsu@mediatek.com>


--yaNJtXhYGM5K609h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 09:44:32PM +0800, Jack Hsu wrote:
> In this patch series,=20
> we add Mediatek MT8189 evaluation board dts, dtsi and Makefile,
> and also related dt-binding documents.
> Jack Hsu (11):
>   dt-bindings: arm: Add compatible for MediaTek MT8189
>   dt-bindings: iio: adc: Support MediaTek MT8189 evb board auxadc
>   dt-bindings: nvmem: Support MediaTek MT8189 evb board efuse
>   dt-bindings: pwm: Support MediaTek MT8189 evb board disp-pwm
>   dt-bindings: serial: Support MediaTek MT8189 evb board uart
>   dt-bindings: timer: Support MediaTek MT8189 evb board timer
>   dt-bindings: usb: Support MediaTek MT8189 evb board xhci
>   dt-bindings: watchdog: Support MediaTek MT8189 evb board wdt

Please drop mention of the evb from all of these commit messages. The
compatible has nothing to do with the evb board, it's going to be common
across all boards using an mt8189.

>   arm64: dts: mediatek: Add MT6319 PMIC Support
>   arm64: dts: mediatek: add properties for MT6359

Wait a minute, what are these two patches even doing in this series in
the first place, when it is otherwise about the mt8189?

>   arm64: dts: mediatek: Add mt8189 evaluation board dts


--yaNJtXhYGM5K609h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQPBMgAKCRB4tDGHoIJi
0lPkAQCRU09Z6yjkHdytWu2mAy2u6tRSvE2qwbIcuk80eZ/k7wD/UgxmnNEGR8HM
8eS3jGJAmBHKHjZ6iiVHXynJ+4bEdwg=
=YIMa
-----END PGP SIGNATURE-----

--yaNJtXhYGM5K609h--


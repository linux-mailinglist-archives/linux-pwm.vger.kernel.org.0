Return-Path: <linux-pwm+bounces-4116-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F09D43C0
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Nov 2024 23:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA02E1F22032
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Nov 2024 22:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0EA158868;
	Wed, 20 Nov 2024 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA62W2hk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC1133998;
	Wed, 20 Nov 2024 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732140233; cv=none; b=Lk5FfV6Hfr4YJhJoNfVm99KQ5KUxDDxThBg15GkeZZ4uQMokCCNMdZfRHJPYG2ruL0JomfkALVU/sZL8d+Wcg8bH6iYZJt9tiX8fB8i3CO227aSCDRwDYVoTGt8V5MHBKmFVrbCRtEu80o9NSLQBTSVLtoaZzvK6uv1YIkAxCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732140233; c=relaxed/simple;
	bh=DSdUX9EORg9aeW0O99F832Xf3e4PIsf8UeoN8YOJeXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRDc27qV9ohSn6cQM3bHLj2cEWqUTy47GBGzPy3WJRAM8+6jQNYlwOVUj8F9HcgzCZ778H293QgRpLetKbH2bb2neZwNdsW9bvBXmmXtGEL8j4c1OuEUB8vlVYgoar4M6kWPc8BGim4s1qh+jyZft8IR/JpTjfstBl7k+dy6Tjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA62W2hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77844C4CECD;
	Wed, 20 Nov 2024 22:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732140233;
	bh=DSdUX9EORg9aeW0O99F832Xf3e4PIsf8UeoN8YOJeXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nA62W2hkW3OBbLCKQH8pXTrIPp7xLX0CZJY5vDAvPhBwLpPzvPlJ2kUxWmYu39VKG
	 bXL21YHJVqk0RB+TCbzBL9ogC5LI92fovZHVte+cTIKd/oBvpgU2i64QHfsSeDjAMr
	 2SuTi+FYhbGpfATj49YdPNiTTGcnfSOgcKPDy4l7aMzLPiKQ1ELNIichpoyci4zlMj
	 oBUzauu7o/MgmrsT1PZWLvRHvBiT9V8jc+AMoiotLrWMaQaubg/rO0mQPZJbdOcgm3
	 0v9sfw2G2gSusv5SntcAUCSEkaZ0uk8n4+R9fokeX+iyInNmOog+msO8TLRa48heSw
	 xCdPQXLQkZHYg==
Date: Wed, 20 Nov 2024 23:03:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>, 
	Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	ychuang3@nuvoton.com, schung@nuvoton.com, cwweng@nuvoton.com
Subject: Re: [PATCH RESEND v2 2/2] pwm: Add Nuvoton MA35D1 PWM controller
 support
Message-ID: <fllw3dv6juj2vepsnrb4lajh2j7b42jl6rzncmvt57gfaalgiv@sypw55h54oag>
References: <20241024104309.169510-1-cwweng.linux@gmail.com>
 <20241024104309.169510-3-cwweng.linux@gmail.com>
 <5a6ad0dc-f777-4129-962f-e10a0f7d6ee1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4knel4pwzvp7g3m"
Content-Disposition: inline
In-Reply-To: <5a6ad0dc-f777-4129-962f-e10a0f7d6ee1@baylibre.com>


--p4knel4pwzvp7g3m
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v2 2/2] pwm: Add Nuvoton MA35D1 PWM controller
 support
MIME-Version: 1.0

hello,

On Wed, Nov 20, 2024 at 11:49:48AM -0500, Trevor Gamblin wrote:
> On 2024-10-24 06:43, Chi-Wen Weng wrote:
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/io.h>
> > +#include <linux/clk.h>
> > +#include <linux/math64.h>
> These should be organized alphabetically.
> > +
> > +/* The following are registers for PWM controller */
> > +#define REG_PWM_CTL0            (0x00)
> > +#define REG_PWM_CNTEN           (0x20)
> > +#define REG_PWM_PERIOD0         (0x30)
> > +#define REG_PWM_CMPDAT0         (0x50)
> > +#define REG_PWM_WGCTL0          (0xB0)
> > +#define REG_PWM_POLCTL          (0xD4)
> > +#define REG_PWM_POEN            (0xD8)
>=20
> These too, I think - it will make it more readable for others.

Keeping the registers in address order is the usual thing to do, so
please keep the order of these.

Otherwise I agree to Trevor's comments. Thanks for taking the time to
look at this patch.

Best regards
Uwe

--p4knel4pwzvp7g3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc+XMMACgkQj4D7WH0S
/k7IhAf/bg94AU7SgCoY0jUgTHhpOnTtuYX7RFUtU5+7GSv/aIpG50Lf93bcVjGC
CnmWIYI35Yl3Uqdr2zlpaxPsTJ8JrOtBpxpbhITrdYJKtJ2fWn08X6DIdcXnAwFw
qnJER3Ys5dNus+jacOcQqmAM91o+Xa8Gu+BQ37OAe5o7iPr5eBPFcVcIR/0bMmbO
S5e7pZ9FDagQXUX4JQ2IcWPDUW3/p0PNHhUC30V3AdkKv4OJrZd661iLTKe+ianl
fayeMW1fwIzQQ2Ikxi7R/INg6naPnc4vfU3X3t2YLgYhsHKHe4Jg3X5Knp251b0F
D7FcFyuB6hyhr4LDeYKtt3L0h2n0/A==
=FNhz
-----END PGP SIGNATURE-----

--p4knel4pwzvp7g3m--


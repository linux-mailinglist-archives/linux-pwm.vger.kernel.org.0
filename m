Return-Path: <linux-pwm+bounces-4773-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FDDA28790
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03717A581F
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80122DF8A;
	Wed,  5 Feb 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Irtg16Tb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABFB22B5A1;
	Wed,  5 Feb 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749977; cv=none; b=Lp3fH3v007p01gmhzu+Xf1x10mbxSpIE37Ild665Kz83u6EtvS9U7pxJQRgwqQxx8YZcRdWkAZcH05SNjsXIa9Z77U3/VMlEPl6BtFd+V7rVxwhYdLDB70xXtvfv50pTJ7pJQRVwouGl5OogtkaxRUrROdHqA/4T60cr+QpV3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749977; c=relaxed/simple;
	bh=9blT37ja1It8cIhR7kixRLVaycXv9QA1EF5U7E97CRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho6AUJVfSrFQD9klBC/N6IjVB26A3U+O9hMpVTSpCdcoAJQw4XZq6CSqF7vglov8BgN0VOGFnbmL9ADFcpapXH7rKlVPjtriyjII+LJALoZvhvbQ/Gez/ddt/nkkVBJ1MHxoJrS0zfjGhwc2EEI1cqcJUQrh6nC9iDdivbpiGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Irtg16Tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FB5C4CEE6;
	Wed,  5 Feb 2025 10:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738749977;
	bh=9blT37ja1It8cIhR7kixRLVaycXv9QA1EF5U7E97CRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Irtg16TbS6QQCIbILy3pcNRCMUzDzpvr3vV+8DhTru2TPzZf/se2KD0QWwzUuSwks
	 vUnsJATiQuhIMSPXM67wQqGJ8vzvvFZcnOs9J+jRUXlrTpUhMPBlleXmZhVghGMJZ7
	 +6+/KchLtz+CAiMaZlbWj8WAHFF3/u3Kl2cPbamT++o/A0gSsq3a2fJ5D+uuoOIidd
	 GstmXsz7816VPsbghfD3jkuKgnyF428dhiEOzheitLJtMV/KKvl0biAhMgWyRvKahh
	 645jzng7TUffgormBNR0owQGm6uJY15dqHcvmUL6XtIesGA224LxFZrUr+iPtZYj2U
	 eeZzw8J5aAHOA==
Date: Wed, 5 Feb 2025 11:06:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	unicorn_wang@outlook.com, inochiama@outlook.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	chunzhi.lin@sophgo.com, Sean Young <sean@mess.org>
Subject: Re: [PATCH v7 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
Message-ID: <ivgsidvdx2ypntnlopww6fiwyuzj2sadt3znyofr54dsz3c5d4@3mr25vhwlwy3>
References: <cover.1738737617.git.unicorn_wang@outlook.com>
 <ae8ea1bf0bb0a09336cd8b7f627a994630524bba.1738737617.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="arbxzkuj76u4tbwm"
Content-Disposition: inline
In-Reply-To: <ae8ea1bf0bb0a09336cd8b7f627a994630524bba.1738737617.git.unicorn_wang@outlook.com>


--arbxzkuj76u4tbwm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
MIME-Version: 1.0

Hello Chen,

I was tempted to apply this patch while reading throug it until nearly
the end ...

On Wed, Feb 05, 2025 at 03:01:13PM +0800, Chen Wang wrote:
> [...]
> +static int pwm_sg2042_probe(struct platform_device *pdev)
> +{
> [...]
> +	rst =3D devm_reset_control_get_optional_shared_deasserted(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
> +
> +	chip->ops =3D &pwm_sg2042_ops;
> +	chip->atomic =3D true;
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret < 0) {
> +		reset_control_assert(rst);

This is wrong (well, or unneeded). With
devm_reset_control_get_optional_shared_deasserted() the devm cleanup
cares for reasserting the reset.

> +		return dev_err_probe(dev, ret, "Failed to register PWM chip\n");
> +	}
> +
> +	return 0;
> +}

If you want I can apply and squash the following in:

diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg204=
2.c
index ce8cf8af3402..ff4639d849ce 100644
--- a/drivers/pwm/pwm-sophgo-sg2042.c
+++ b/drivers/pwm/pwm-sophgo-sg2042.c
@@ -174,10 +174,8 @@ static int pwm_sg2042_probe(struct platform_device *pd=
ev)
 	chip->atomic =3D true;
=20
 	ret =3D devm_pwmchip_add(dev, chip);
-	if (ret < 0) {
-		reset_control_assert(rst);
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to register PWM chip\n");
-	}
=20
 	return 0;
 }

ack?

Best regards
Uwe

--arbxzkuj76u4tbwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmejOBQACgkQj4D7WH0S
/k7xhAf+NrI5L589ZuQPvEDwS8Qwb4XlzoNnmEFCbOWCj0645JBLD/7WjiTYpfMg
Kgq30Y3aooAF7lznjQC3Dhgr8AmTEVevm2Cq+zvW0kVXG0AfzN8EZTd72OYJz6xB
Zibrt+MCzUt45EOrPwYjdndRLjo/M7N35/M24oWLhXKr7bw8DPqGFQwR0Baz/SoX
jVW41leLuAm8skH4my6WfNcsjCkhF25vo0LQDkUBqJ8jLCxdQ0QmnfzIaDu9nMUe
GUStrmWJIDzQDCtn6RNIQNPEYv72rjF2BtOVTRxCfD3VBKiOk9TwWA1wLtTVN6Ig
hFHjxG2+crhEqJZBaoVZd6malV3W4A==
=0gIf
-----END PGP SIGNATURE-----

--arbxzkuj76u4tbwm--


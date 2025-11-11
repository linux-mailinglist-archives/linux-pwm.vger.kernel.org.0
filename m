Return-Path: <linux-pwm+bounces-7618-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 736DEC4F5BD
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Nov 2025 19:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BB718C2F24
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Nov 2025 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210692798F8;
	Tue, 11 Nov 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMnkboKg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1671FC0ED;
	Tue, 11 Nov 2025 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884077; cv=none; b=h10T/uKQ32KYVczMsJgY43NmaNFSvcJDJQ/EoPy7dLCOI1rWNVRzAMIiogDJk+5i/9tHLH5/MhiDgjK2f7qeVAIVJ+Msq52AOqC2TRRFXsNv+cXeXcWtTujkPo+8Nd70//1JLFFbMl2/d6/9YHKz+dz5XlLQUzKoCdtPByJrV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884077; c=relaxed/simple;
	bh=f1tQc9fKxPXjOAXomvZMDR+OXXQMQ2u54M9yxOwFvaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN/s1b8iPFlRq0QyrGNC5ripWPJeAQZVfFg4HUJi+5eeHVlyaQcgBeu5k8EFA9JCy2z4fie9jfAmiuiiZb0ceXOhuOdBUZFYEyOwnY0mrSmX0IPfuzyAyrCB0+5e+ph1er6LsQflf7OgeOjnH4MiNJXUwdolC12pXQ062an45N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMnkboKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609F8C113D0;
	Tue, 11 Nov 2025 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762884076;
	bh=f1tQc9fKxPXjOAXomvZMDR+OXXQMQ2u54M9yxOwFvaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMnkboKgujlmFzn+1F12YPG0LrNsL91vnvn/TUaHmyNFFWL5O9ua8Vt0+9og4W4SD
	 BBCkFndVJY/FAdIdXHQXE6w8eGcsHc2LUrZ4bFj3ascztlgJN7KftPO0B3TxD/R0mJ
	 IYimW6mPvZwjTg+oxfVYA9OERnqCnrI6nVwyu8IibLiP6fX9/el1eW4d6S5qXDwDzK
	 b7vto81dT3Fu1sK1LpH9Rdpxm91E2mhmKIbXEwmrhIgLPSmwkM2pxG9JMtrEql9Q11
	 IdfxuLPKBWCFZiovJcrbeDfko2anZvHPKTe9vsZFm1ZF/YCTBHL+CZmEL55qjbdTei
	 FY+9eoDAR1lZQ==
Date: Tue, 11 Nov 2025 18:01:08 +0000
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
Subject: Re: [PATCH v7 5/9] dt-bindings: usb: Support MediaTek MT8189 xhci
Message-ID: <20251111-ocelot-ipod-4d5f902b640b@spud>
References: <20251111070031.305281-1-jh.hsu@mediatek.com>
 <20251111070031.305281-6-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mkp7Vm+0xTxl2wgI"
Content-Disposition: inline
In-Reply-To: <20251111070031.305281-6-jh.hsu@mediatek.com>


--mkp7Vm+0xTxl2wgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 02:59:19PM +0800, Jack Hsu wrote:
> modify dt-binding for support mt8189 dts node of xhci
>=20
> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--mkp7Vm+0xTxl2wgI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRN55AAKCRB4tDGHoIJi
0nZ6AP46To/9lZ7sJV4I2ivoFKzECzpBwHjBzWlqIKPxNe0XpwEAoe7F6s2tr9ca
hGvlAGOJEUCvxWDv5C09Q2U7m+8MuwI=
=k5Lj
-----END PGP SIGNATURE-----

--mkp7Vm+0xTxl2wgI--


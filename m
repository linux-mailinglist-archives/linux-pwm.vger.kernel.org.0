Return-Path: <linux-pwm+bounces-7556-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC0C21F57
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 20:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AB63A6AF3
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 19:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5480A2E8E04;
	Thu, 30 Oct 2025 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u41ac5T0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201672236E1;
	Thu, 30 Oct 2025 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852755; cv=none; b=qF2KUOwXaj9ou5mIew0J6zGDZhlUEofMUXvwTX2skXIGnQSHFHZC1AsVhPdnlz0K9/Z1ozZrfUBhlLMsyhDrMbApdSxHEYDuwbURZX/npCzTJ1oUfylGnOH/5/1XIZARIh9MoTD6rRvONKcfCD/1eZd0fBkd5N+D7+QUObp8WTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852755; c=relaxed/simple;
	bh=iGCxq+nOC/gm/4t2m2k1i6Pdm4+kZ75nPWFm76rh8DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+VPLpYGdDXNNgxe0OeWY57PORdMFDAzGtkAflWx4VUBYJJhowitluR1yQT7ds6Sakum9UR/VOPixIadsaXbu8OJOtE3AcJMUEGmszhVAhNG/XhbbS6jx9kXraGNxtgDXE1/RYfmtrwAPMTTJHXUiF1NS5XCPM/CTdtubPG5CPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u41ac5T0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E56C4CEF8;
	Thu, 30 Oct 2025 19:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761852754;
	bh=iGCxq+nOC/gm/4t2m2k1i6Pdm4+kZ75nPWFm76rh8DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u41ac5T0O6qtGzbuC88TnasgBH+1jd1AwJpS+B5g1fCypV2oXXyaCH77gKLTelu+N
	 5x8vhVUniIxZxImSHqVhB8OyY/YQDOM/xJ94vnyeTtYWWoJLgIDAzdWWA0Mzpl+IQa
	 yVS983TUUu50CWfnaxMN256DfoGKh41xUAar2B9Yapd7nuhBr85+o9BdDATMn/1MzK
	 p9WbRE4NOvfa/f6A42jg0P4xXsD3dqPBU3WYbUJxNgfoOpWVut4JjF8HbDcSCHus7w
	 HKSKKsihWTxyoHYnBTHrThyZb+xLjMSVQwt/hYDjPKtTkCbhhdBE1viFO5TnLIXkRF
	 9CfVbXv5eqYxQ==
Date: Thu, 30 Oct 2025 19:32:26 +0000
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
Subject: Re: [PATCH v6 07/11] dt-bindings: usb: Support MediaTek MT8189 evb
 board xhci
Message-ID: <20251030-underwent-courier-1f4322e1cb34@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-8-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W0QGy4D+uQ2gIdd5"
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-8-jh.hsu@mediatek.com>


--W0QGy4D+uQ2gIdd5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 09:44:39PM +0800, Jack Hsu wrote:
> modify dt-binding for support mt8189 evb board dts node of xhci
>=20
> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml         | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml=
 b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index 004d3ebec091..05cb6a219e5c 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -34,6 +34,7 @@ properties:
>            - mediatek,mt8183-xhci
>            - mediatek,mt8186-xhci
>            - mediatek,mt8188-xhci
> +          - mediatek,mt8189-xhci
>            - mediatek,mt8192-xhci
>            - mediatek,mt8195-xhci
>            - mediatek,mt8365-xhci
> @@ -119,6 +120,9 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  reset-names:
> +    maxItems: 1

Is this reset required on mt8189? Does it appear on other mediatek xhci
controllers?

> +
>    usb3-lpm-capable: true
> =20
>    usb2-lpm-disable: true
> @@ -168,7 +172,8 @@ properties:
>              104 - used by mt8195, IP1, specific 1.04;
>              105 - used by mt8195, IP2, specific 1.05;
>              106 - used by mt8195, IP3, specific 1.06;
> -          enum: [1, 2, 101, 102, 103, 104, 105, 106]
> +            110 - used by mt8189, IP4, specific 1.10;
> +          enum: [1, 2, 101, 102, 103, 104, 105, 106, 110]
> =20
>    mediatek,u3p-dis-msk:
>      $ref: /schemas/types.yaml#/definitions/uint32
> --=20
> 2.45.2
>=20

--W0QGy4D+uQ2gIdd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQO9SgAKCRB4tDGHoIJi
0soAAQDNsik8zgyDq1CJEDvhDCDIrIOJlea5QC3W8+UKQZXN9wEAy7Gh90cGt4nY
42Kle5H3RlFGQAZQQgg/cPi5ol120wM=
=FAxM
-----END PGP SIGNATURE-----

--W0QGy4D+uQ2gIdd5--


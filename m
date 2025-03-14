Return-Path: <linux-pwm+bounces-5183-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54025A60C3D
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 09:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7EC3B6E01
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915F71DDA32;
	Fri, 14 Mar 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dewKEqMV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814F1DACA1;
	Fri, 14 Mar 2025 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942370; cv=none; b=kPzEKje5iwMD03+Ocms5rEsZXCga2lCO+YTl8Kf9Wcp89oPF9IjqtAX3+k5A7QMXipcMSk6XxVgPVWXSwCTqN5wQLl7//ddBiOyyUfm0b3H/eUQ/3MFiqRfaQ2btC5xgr8ws0DcOa/Ieo6NgQisb/XpGDCT9T5kX2dzcN673pzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942370; c=relaxed/simple;
	bh=BIGHYMmVBNxp9HXVH5icjLkC9e/+DcrpgOyld1oHSBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLC+IcuLzvUAmjA4PI3Kym0YCxJ7eVfYyyhPfH2kOcU4Qc6Q0Ho1nS53CVrx4Gif8R6XvTYa0WwdP7M1si2L5YdAzhmXUbXl2/5i0YeRchkzqdONDSSJinDDJTr3Pi/OfixFP+4pBcL16b2qP6qD7HX5KG7Rz45un67G9VdyG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dewKEqMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79C5C4CEE3;
	Fri, 14 Mar 2025 08:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741942369;
	bh=BIGHYMmVBNxp9HXVH5icjLkC9e/+DcrpgOyld1oHSBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dewKEqMV+ziBim3Bx8K1JL3NcBdBSEyTcSx1NsdEUbBXwcnOcVIG7oBtRYuGWQqDn
	 vMSrB++mScJquaKXpJzbgxK8Bc5Q+0p98Hn69tahpkYynkQJYbbDRxisWqUYeHEgJO
	 iKnQCN2gYz0k2C/OmNaPRXm3kz+MKd99mcClz8tyywB2k7LjDRmUs3albLZ5fa6Ijp
	 8K3VFgA9IUqHSkVXbycE0SVa3sn+SLH4ZSnUd9hHpePNnkrmFIjdrmFdr9MkN2Pchl
	 YVGXmkk7Xr2xBXOZ03wOyy+Z4VWwr1mcAbxKeFQjV2oHRpvIFgGlPB1YZOGc2aqBk+
	 Tg5u8Za7In8qQ==
Date: Fri, 14 Mar 2025 09:52:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 15/18] dt-bindings: mfd: adp5585: document reset gpio
Message-ID: <20250314-blond-shellfish-of-blizzard-f7ddc6@krzk-bin>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
 <20250313-dev-adp5589-fw-v1-15-20e80d4bd4ea@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250313-dev-adp5589-fw-v1-15-20e80d4bd4ea@analog.com>

On Thu, Mar 13, 2025 at 02:19:32PM +0000, Nuno S=C3=A1 wrote:
> Add a reset gpio property. Note that for the adp5585-01 models, the
> reset pin is used as the additional ROW5 which means there's no reset.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Doc=
umentation/devicetree/bindings/mfd/adi,adp5585.yaml
> index e976c9240df79afae1d0949e6ac91d477bfaceef..20488af1563369b0ef60e8b55=
ad660a35623039c 100644
> --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> @@ -39,6 +39,9 @@ properties:
> =20
>    vdd-supply: true
> =20
> +  reset-gpios:
> +    maxItems: 1
> +
>    gpio-controller: true
> =20
>    '#gpio-cells':
> @@ -167,6 +170,7 @@ allOf:
>          adi,unlock-keys: false
>          adi,unlock-trigger-sec: false
>          gpio-reserved-ranges: false
> +        reset-gpios: false

I am not so sure there is benefit in keeping these devices together in
one schema.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



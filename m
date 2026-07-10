Return-Path: <linux-pwm+bounces-9685-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ttuZAHvKUGqs5AIAu9opvQ
	(envelope-from <linux-pwm+bounces-9685-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 12:33:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D1E739BEF
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 12:33:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XrlteZyI;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9685-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9685-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C81A2305D21E
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 10:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50689407CFB;
	Fri, 10 Jul 2026 10:31:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176863F6C4D;
	Fri, 10 Jul 2026 10:31:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679500; cv=none; b=Iq7/kHKb9kRqfwZ60xxGY7nDzDEQMkuaDEoWrCyVPOk1ujc3792Rxf6kXpMTb+9Y4byLGz9icWK+s1P/+nBWH+BainE8E9reXu4WZcFyV7mVajenVDvmoYDTQhui0A24a7koGQJpBb2b8cZ1oYXV4DjBlfOsA3qu29h3lZ+dNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679500; c=relaxed/simple;
	bh=LqoiRnStXFd6VuaQ2xJ0qTmfqtOIEJ06j648rHWrXyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxgyf5rM2UHECwwGR4bfTq0Bq9/1Zy6xHE3jEZYRLRK3b/Xt/IWf3ysEIpt1+LOzRGcfjNVk5Lm1Gk7kEeKDbMSkrrZdD40TPJfqI9r7fd2rqVGSwzfZTD8BD358uth48wC/ZGAdTnLmFZD6AXSmvGMI3yyYAG15L2CVQg9jTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrlteZyI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 305191F000E9;
	Fri, 10 Jul 2026 10:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783679498;
	bh=B/0P6CjkFCqMXZpshxscC8fggHEtFDHkHgmueIFeARI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XrlteZyITiTdyCYT+QTMlv7oyxY4ow9O28q/YRWuSlvBnyi7poznDF/ThmSDZxxPB
	 w7veUv+18dltW9ecVdH1DQr9bE11YUPBPax5UthbczOYmgPmKccMut/QTjUQW7QTDK
	 oR0vbTQ3gtR2Sy4a/foGnQ+nHBkLHBYF5y6vF1wylkAEvRTd8ylBdhYjqRJf5clxM6
	 /ONYaZLt60BANJFnZ3KojsppG1VDEgJZm52ITUsC0PLcRxtB/T5/8KvzUgcd5HsQWS
	 Xd7MiWxZcvUluTvvQX5tKQTf72vMRMDUywzXzF38BUVRZ4LH2OH68tpVk6MNiznIIT
	 BHkOg3CcE8Hvg==
Date: Fri, 10 Jul 2026 12:31:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, Damon Ding <damon.ding@rock-chips.com>, kernel@collabora.com, 
	Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>, 
	linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: pwm: Add a new binding for
 rockchip,rk3576-pwm
Message-ID: <alCvmLX1ke0qjh99@monoceros>
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-1-ae7cfbbe5427@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mnh6xjyjg3d65ymy"
Content-Disposition: inline
In-Reply-To: <20260420-rk3576-pwm-v5-1-ae7cfbbe5427@collabora.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:nicolas.frattaroli@collabora.com,m:heiko@sntech.de,m:lee@kernel.org,m:wbg@kernel.org,m:damon.ding@rock-chips.com,m:kernel@collabora.com,m:jonas@kwiboo.se,m:alchark@gmail.com,m:linux-rockchip@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-iio@vger.kernel.org,m:conor.dooley@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9685-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[collabora.com,sntech.de,kernel.org,rock-chips.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org,microchip.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email,monoceros:mid,sashiko.dev:url,devicetree.org:url,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60D1E739BEF


--mnh6xjyjg3d65ymy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/6] dt-bindings: pwm: Add a new binding for
 rockchip,rk3576-pwm
MIME-Version: 1.0

Hello,

On Mon, Apr 20, 2026 at 03:52:38PM +0200, Nicolas Frattaroli wrote:
> The Rockchip RK3576 SoC has a newer PWM controller IP revision than
> previous Rockchip SoCs. This IP, called "PWMv4" by Rockchip, introduces
> several new features, and consequently differs in its bindings.
>=20
> Instead of expanding the ever-growing rockchip-pwm binding that already
> has an if-condition, add an entirely new binding to handle this.
>=20
> There are two additional clocks, "osc" and "rc". These are available for
> every PWM instance, and the PWM hardware can switch between the "pwm",
> "osc" and "rc" clock at runtime.
>=20
> The PWM controller also comes with an interrupt now. This interrupt is
> used to signal various conditions.
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/pwm/rockchip,rk3576-pwm.yaml          | 77 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 84 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.ya=
ml b/Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
> new file mode 100644
> index 000000000000..48d5055c8b06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/rockchip,rk3576-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip PWMv4 controller
> +
> +maintainers:
> +  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> +
> +description: |
> +  The Rockchip PWMv4 controller is a PWM controller found on several Roc=
kchip
> +  SoCs, such as the RK3576.
> +
> +  It supports both generating and capturing PWM signals.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: rockchip,rk3576-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Used to derive the PWM signal.
> +      - description: Used as the APB bus clock.
> +      - description: Used as an alternative to derive the PWM signal.
> +      - description: Used as another alternative to derive the PWM signa=
l.
> +
> +  clock-names:
> +    items:
> +      - const: pwm
> +      - const: pclk
> +      - const: osc
> +      - const: rc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts

pwm.yaml has:

	required:
	  - "#pwm-cells"

Still Sashiko[1] claims:

	The binding defines #pwm-cells under properties, but omitting it from the
	required list allows device tree nodes missing the property to pass schema
	validation.

I played a bit around with dt-validate and I think Sashiko is wrong here
and pwm.yaml's requirement isn't overridden by the local required list.

So this patch should be fine.

Best regards
Uwe

[1] https://sashiko.dev/#/patchset/20260420-rk3576-pwm-v5-0-ae7cfbbe5427%40=
collabora.com

--mnh6xjyjg3d65ymy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpQygUACgkQj4D7WH0S
/k530Qf/Yrgd15Oua0wX8H9DeijzIE3bpRLuqNvVEsc2me0Ww9zPov4iHylUuu1a
RubtMDQyyXRuiGSqbcmeNV8lWGFbd/moOm1pw/KXnkvtIuBd2S3tIlTC2qCKRwpF
MVE2yBKSN1h4IAZ88/ei1M2RCCTX6WQ13Tp3cvt1MEx9+y06qLmjgkrBixr/mPMq
JZYYzZh//1spbCmc6clKnfshjrRB1iDOQiS1VeTZgCv/bcNgYxIRDov/BJZzLnRZ
GYYcl6tFqfbJ8UA7sn7s9I6q6/1ZlHwjK7e7/DWPeyPgD7ncpJHr7a91ajTCtZmC
lnC4jZZBJcY1/1UCHZTUCTXDhQRwhQ==
=FvaV
-----END PGP SIGNATURE-----

--mnh6xjyjg3d65ymy--


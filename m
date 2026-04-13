Return-Path: <linux-pwm+bounces-8563-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOYcKoGr3GlfVAkAu9opvQ
	(envelope-from <linux-pwm+bounces-8563-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 10:38:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA573E935F
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 10:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B0DB3001F80
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508093AB274;
	Mon, 13 Apr 2026 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYmPI9j4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D82264A9;
	Mon, 13 Apr 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069500; cv=none; b=LxpLOrbjCPb5rIBvpUrMBLSmhh46VXywHvQwMZQb+X+Sp2+D4mfLiyeBHPRuaIMB9Kn+SUnhx7dKaHxqBH1EqBMARYitBAiMi5vB9ulf5wDJiJDGV90brrpRjlJ3fudAShWyViv0jqWqz70UrSRIFAFw/nDJr2me4qEA/ZRzaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069500; c=relaxed/simple;
	bh=hQC+dWReMp0AEvFExU9znjcR15PjYZSh4RYLGIYnIT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDBtHQZzgnlgMSD1NoojDb7nHL4Jv54S8tQOK/SoGC1yspAmIrGc78Q7BK/mDsGkDfGCeTr5251VSsanWGIU+VDCQSNtMZS7RaVZEkRKNCZXV7RNeAtwIw2JqtaWD/D1CRZd2m2Tk0744LzRjdx9qWWpMQ3f9292RZ4liRo1UwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYmPI9j4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D0EC116C6;
	Mon, 13 Apr 2026 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776069499;
	bh=hQC+dWReMp0AEvFExU9znjcR15PjYZSh4RYLGIYnIT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYmPI9j44m063hu9ojAHSM/uXN31tgSlskZ69wTFDkbrEwjYWOArAXuc6DVj1A2GI
	 eSp5DXm8GGpsNEFvYi6G6m0/kstL271ISUk3owDGB7ZQAAp9lQGzhN/e4qhpkqDant
	 6thMApG5MHf/MsrUG9tp7UisfLUl7QCj0KV+R6cb7bZhAP2Z+zUG/2yNQDtwXtLN/3
	 o5bheZjmDL55JXtbCX17VkUx12GojOI5UigX6Dgi5OkaV5efLNpaabs2SMmpPumJEK
	 ZUYvlpG48AppzoBtRj7S2SnbjUj7emwCwLykrKEF4lOfDKwIN5ORV9x0ZpTh04QX1v
	 vTTjv+vu63PzA==
Date: Mon, 13 Apr 2026 10:38:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 2/2] pwm: pxa: Add optional bus clock
Message-ID: <adyq-Uckwwe9uACA@monoceros>
References: <20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org>
 <20260409-03-k3-pwm-drv-v1-2-1307a06fba38@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="763z7lvugsdeouil"
Content-Disposition: inline
In-Reply-To: <20260409-03-k3-pwm-drv-v1-2-1307a06fba38@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8563-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BA573E935F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--763z7lvugsdeouil
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] pwm: pxa: Add optional bus clock
MIME-Version: 1.0

Hello,

On Thu, Apr 09, 2026 at 12:45:12AM +0000, Yixun Lan wrote:
> Add one secondary optional bus clock for the PWM PXA driver, also keep it
> compatible with old single clock.
>=20
> The SpacemiT K3 SoC require one bus clock for PWM controller, acquire

s/one/a/ ?

> and enable it during probe phase.
>=20
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  drivers/pwm/pwm-pxa.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index 0f5bdb0e395e..2ace31405c2d 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -53,6 +53,7 @@ struct pxa_pwm_chip {
>  	struct device	*dev;
> =20
>  	struct clk	*clk;
> +	struct clk	*bus_clk;
>  	void __iomem	*mmio_base;
>  };
> =20
> @@ -177,7 +178,12 @@ static int pwm_probe(struct platform_device *pdev)
>  		return PTR_ERR(chip);
>  	pc =3D to_pxa_pwm_chip(chip);
> =20
> -	pc->clk =3D devm_clk_get(dev, NULL);
> +	pc->bus_clk =3D devm_clk_get_optional_enabled(dev, "bus");
> +	if (IS_ERR(pc->bus_clk))
> +		return dev_err_probe(dev, PTR_ERR(pc->bus_clk), "Failed to get bus clo=
ck\n");
> +
> +	/* Get named func clk if bus clock is valid */
> +	pc->clk =3D devm_clk_get(dev, pc->bus_clk ? "func" : NULL);

A local variable for bus_clk would be sufficient.

I'm not sure, but I think passing "func" unconditionally to
devm_clk_get() would also work fine.

Best regards
Uwe

--763z7lvugsdeouil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmncq3UACgkQj4D7WH0S
/k7W3QgAoubMFAiRzq6hszjmm/xb9Gcgmkb//pXKEp2aWMTJOS8NxIwApQLcWVSK
TER943wXO4h2gddLqDhxGqoClG/XTO5sQoTDI1E1iEgtqEhH+ubHu+wcTXTH7/VJ
ukekULO5bPkCh5Ncgr6yIsL/YwSyBtAYm4PkxW5n+rKR7YHtmCX1T43b8GG4bkux
u64sL5qYxGV98Mes56lCOu9v7k9fDKuGCrzIr9AL0zU20AVmF2kxVu/vmCJcl2Rt
Yk7B8O0pYbZmRuGjn1YyulXnvBwo0GTWC6SHzoDC6fZVOMSBuQJJGz4CdpQGkXeE
huqDvYA/yh/qxaNx8deyGc8oe1RB9Q==
=xEV+
-----END PGP SIGNATURE-----

--763z7lvugsdeouil--


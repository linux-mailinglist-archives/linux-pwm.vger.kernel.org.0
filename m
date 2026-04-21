Return-Path: <linux-pwm+bounces-8664-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCMUBlBi52nF7QEAu9opvQ
	(envelope-from <linux-pwm+bounces-8664-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 13:41:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 123AE43A2CC
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 13:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0310F300862B
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 11:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A89276049;
	Tue, 21 Apr 2026 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnHmsRiS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA413C9C4;
	Tue, 21 Apr 2026 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771658; cv=none; b=PgVI93iK5eOZ6/2dnLjsW2RRbm4Usz0Py83OATLK/kcrH0dvNxyFuW1Wy9snOfHVEVbWhHy2GdB5VX4Yvq09O3RYU3x+gNU52hlGuDKHexsl9fR+pJ1aaVDeVttkYYNimg1AkJS1InP8xrnYDvOGLuZIPsc6Wx/+IbM3qD1z4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771658; c=relaxed/simple;
	bh=AMrZo1hx0IaVR554MMJRzqOTHAysXa89TiJakACup3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyuGACzLiEZqIiwHiAd8PTpfOqr1sSo9kE2VHDrWjWQvkYz6vPejNNdQVvX/C2uDQS7p0ERNy1jrI8tEoGHTyaS/usU1KTFO9xXGgXIvwZvMHYK8rnvW+oQu6vS6gIqz950JzGf3KIrwpXIv4RNmRNkg2d70wMN+Fct/owCOLfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnHmsRiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C072FC2BCB0;
	Tue, 21 Apr 2026 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776771658;
	bh=AMrZo1hx0IaVR554MMJRzqOTHAysXa89TiJakACup3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnHmsRiScc5GjzXlfh0NjHFnm9wOfj8svUl52iPpZKhGdUtgk8jl8OO/AN7wHh2dA
	 9ybsedV1naVRheAdzo6wj0TDYbYK/w2rVR4qsBs3Q/8BSmsJzdEGdK6AJJtcsKGpo/
	 wNHDUVfBPjIDParXLo2fKN4S/HwKhMM6VofQTbx/KhpQ8jgrdiqRfZBeuTk9jOrBoR
	 te9BAsxHW+mqsvhiCWw+WXq+2HC8WOrEBjfa4dZs8w6FLzeZefcuqPPAPbXltEBTzz
	 5ftIjazSXQ/D2AuTaen1lHLuQXFE8Par1wSCHYHOIC3UFG4cLcmmki6Mne1kQJz1UZ
	 3lyiUgPQ3YASA==
Date: Tue, 21 Apr 2026 13:40:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Sangyun Kim <sangyun.kim@snu.ac.kr>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: atmel-tcb: Cache clock rates and mark chip as
 atomic
Message-ID: <aedfEzeRH5tH0-Fb@monoceros>
References: <20260415093433.2359955-1-sangyun.kim@snu.ac.kr>
 <20260419080838.3192357-1-sangyun.kim@snu.ac.kr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zmlydvd5ruato4sk"
Content-Disposition: inline
In-Reply-To: <20260419080838.3192357-1-sangyun.kim@snu.ac.kr>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8664-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 123AE43A2CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--zmlydvd5ruato4sk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: atmel-tcb: Cache clock rates and mark chip as
 atomic
MIME-Version: 1.0

Hello Sangyun,

On Sun, Apr 19, 2026 at 05:08:38PM +0900, Sangyun Kim wrote:
> @@ -438,16 +441,33 @@ static int atmel_tcb_pwm_probe(struct platform_devi=
ce *pdev)
>  	if (err)
>  		goto err_gclk;
> =20
> +	err =3D clk_rate_exclusive_get(tcbpwmc->clk);
> +	if (err)
> +		goto err_disable_clk;
> +
> +	err =3D clk_rate_exclusive_get(tcbpwmc->slow_clk);
> +	if (err)
> +		goto err_clk_unlock;
> +
> +	tcbpwmc->rate =3D clk_get_rate(tcbpwmc->clk);
> +	tcbpwmc->slow_rate =3D clk_get_rate(tcbpwmc->slow_clk);
> +

Only one concern left: clk_get_rate() should only be called on enabled
clocks. I don't know the architecture details and how expensive it is to
have .clk enabled (or if it's enabled anyhow).

If you're ok, I'd squash the following diff into your patch:

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 1a2832f1ace2..3d30aeab507e 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -437,13 +437,17 @@ static int atmel_tcb_pwm_probe(struct platform_device=
 *pdev)
 	tcbpwmc->channel =3D channel;
 	tcbpwmc->width =3D config->counter_width;
=20
-	err =3D clk_prepare_enable(tcbpwmc->slow_clk);
+	err =3D clk_prepare_enable(tcbpwmc->clk);
 	if (err)
 		goto err_gclk;
=20
+	err =3D clk_prepare_enable(tcbpwmc->slow_clk);
+	if (err)
+		goto err_disable_clk;;
+
 	err =3D clk_rate_exclusive_get(tcbpwmc->clk);
 	if (err)
-		goto err_disable_clk;
+		goto err_disable_slow_clk;
=20
 	err =3D clk_rate_exclusive_get(tcbpwmc->slow_clk);
 	if (err)
@@ -469,6 +473,9 @@ static int atmel_tcb_pwm_probe(struct platform_device *=
pdev)
 	clk_rate_exclusive_put(tcbpwmc->clk);
=20
 err_disable_clk:
+	clk_disable_unprepare(tcbpwmc->clk);
+
+err_disable_slow_clk:
 	clk_disable_unprepare(tcbpwmc->slow_clk);
=20
 err_gclk:
@@ -492,6 +499,7 @@ static void atmel_tcb_pwm_remove(struct platform_device=
 *pdev)
=20
 	clk_rate_exclusive_put(tcbpwmc->slow_clk);
 	clk_rate_exclusive_put(tcbpwmc->clk);
+	clk_disable_unprepare(tcbpwmc->clk);
 	clk_disable_unprepare(tcbpwmc->slow_clk);
 	clk_put(tcbpwmc->gclk);
 	clk_put(tcbpwmc->clk);


This has the downside that clk is kept enabled the whole driver
lifetime, but that's the easiest way to make your fix honor the clk API
constraints. This allows to fast-track the patch fixing the sleeping
function called from invalid context issue and the optimisation can then
be addressed with more time during the next development cycles.

Best regards
Uwe

--zmlydvd5ruato4sk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnnYkUACgkQj4D7WH0S
/k6oIQgAmju9sVnu1SosgbRPtkoA4RXoRnn776xuGDw/YiiUdWY0a74HZ3q1TGln
EsiW5MDYMdWQVF0FRBK8Sx1RnVGzAvBqnupEQdLODs5G48tnLFXBEUmuMV6iU4JB
ackooROEjHtZj7AgAlmDGUUtz0MPR4LPNWxs1RCjE+iUtamtAaEQxbQ0pJKI/QlB
d1UZ2XStLLvVBBhoJhhwmUoEwtCnPRm2O8TZFIxt+1Yb9kUcVc+eH2AGyMVGpGYu
CSFdjbjjWnLwakKgJSZbb4BeXD0a6UY/cYb+AKiaon0Uzqd/QU3YwgJJFkh9W10d
Aj88FgPkNhpZP4oIIFS9qUx/fV6sRg==
=9oZB
-----END PGP SIGNATURE-----

--zmlydvd5ruato4sk--


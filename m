Return-Path: <linux-pwm+bounces-9679-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n7aGGsjgT2qCpgIAu9opvQ
	(envelope-from <linux-pwm+bounces-9679-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 19:56:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1027340C5
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 19:56:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ch+fGB01;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9679-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9679-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90FD13019B3B
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 17:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1684DA55A;
	Thu,  9 Jul 2026 17:54:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192FC4DA541;
	Thu,  9 Jul 2026 17:53:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619640; cv=none; b=aunO2JXdvA6ewWZ5L7AyF5kZcYMhzUb7CgLu2zdbGcqqhavrFDHPRbkhN6B1hp7XFnOSyVxPabF8iI7p8sc9KnrAfpkknLMlEBFcDXrB4Uw63AUt032nXvfwOIVxxEKpFadyMRhA/8ZK3E1zz1OQ8tEQ1pBXPqj4iSYCSpy5DfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619640; c=relaxed/simple;
	bh=IgaaPsemsC+IDKQ3E1/0ZPZ3hwV9iGW6IP86+iaMa+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fawOZkrAjikWNxra4q8kFeVBXt9n9aImbW5iriL5NAiA/GGlGuAOhpHtxVdDv4ZOq+R+EcOrKxaJu47vmVgwuKMBI/Im81dg5sCj5Gs+RCAf7qYOZ0Sp3Jrk3EeQpVHLO0GnVGimVc6Jow0yGlWcHJ+953POSi6mG1TM6ETQPB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch+fGB01; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBE01F000E9;
	Thu,  9 Jul 2026 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619638;
	bh=NPTWf8IkpUM/GoXdCReFMm8GO5zNKUCMfneM2J+wRcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ch+fGB01B+Y2wHsXyL6Mwf+jlXLmYKTogI8bhG9oidFgOrCvd0H5Z8TqY43bORl7j
	 fdavMNONM29oyC7GhEP4Z1gQHawvMvAWFJB0xXxiY5zoUMo02V7TBS+foOjQrrwWcG
	 v6wDETv+iwHZbBH8fEW5KrLbIu0DImHPM0S8h7y7hUHBrot3QzdCgL07XLxQgBIVBC
	 ndXOFrqcueWmVNhKapLvsZFmXwhFJp7+U0PGOmYLSwsXDJGL2CbrDVvKsANVZJ2q3Y
	 QyVJATx0BZrtorCd7w0Y/b/kwDs9e9/IDo8PpvHoO7SFiksewAcwAjxizSqrw1VKP4
	 sZI6G/agO9pow==
Date: Thu, 9 Jul 2026 18:53:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 09/11] dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and
 t6031 compatibles
Message-ID: <20260709-decimal-footnote-efb045601806@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-9-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J240Diajxrqh0f/T"
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-9-55b305833123@jannau.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:j@jannau.net,m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9679-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,jannau.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:email,spud:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E1027340C5

--J240Diajxrqh0f/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 09:30:55AM +0200, Janne Grunau wrote:
> The PWM controller on Apple silicon M3 Pro, Max and Ultra SoCs is
> compatible with the t8103 (M1) one. Add "apple,t6030-pinctrl" for M3 Pro

Is this copy-paste getting you? The fallback here is a phone I think, so
the text should probably say s5l - even if being compatible with the s5l
means that it's comaptible with the t8103 too.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

> and "apple,t6031-pinctrl" for M3 Max and Ultra as per-SoC compatibles.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/=
Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> index 25ef04b60ca1..dd95037ea5ee 100644
> --- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> @@ -21,6 +21,8 @@ properties:
>            - apple,t8122-fpwm
>            - apple,t6000-fpwm
>            - apple,t6020-fpwm
> +          - apple,t6030-fpwm
> +          - apple,t6031-fpwm
>        - const: apple,s5l-fpwm
> =20
>    reg:
>=20
> --=20
> 2.54.0
>=20

--J240Diajxrqh0f/T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/gMAAKCRB4tDGHoIJi
0iA1AP9f2X3yVc+9kze/1BFv51MWAwJzEJUK3YiBi76IVaJTMAD/TKKQIBLqKKKe
2nVj0Lym2F8dg6XkZnloYvGSi8A45gk=
=kEtM
-----END PGP SIGNATURE-----

--J240Diajxrqh0f/T--


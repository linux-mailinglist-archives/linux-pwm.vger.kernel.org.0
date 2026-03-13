Return-Path: <linux-pwm+bounces-8253-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCd6NfTts2m4dQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8253-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:59:00 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 089EC281D6D
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 163303053A6C
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF438A2A4;
	Fri, 13 Mar 2026 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTPVHhfw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02034DCE3
	for <linux-pwm@vger.kernel.org>; Fri, 13 Mar 2026 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399507; cv=none; b=i1kxy2zsZWQaMmWMBPugcbMyM043sCC1/GNbyd3GlYorvGPkDUrjIUV5QrLxZKLU8fpKUOFoqIHU5l8P3obw5DsZb/46tq/Y4ZZ4cykQl9sZnNUrFsmg5LOE9JMw642vqevSBXOdjukP4TOALWp59wK6FJMIZQ60pFouNv+8Zzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399507; c=relaxed/simple;
	bh=34Lj9aEuWwASIusAF/p6A+RWo95PpijWJDVHObS9CJw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX14n5Nv1g0Prp0WydPahQikXy07yH40wdCL7KvPov+lfoM7+Yuh4mIEmDyNz8gfl7SdlVIgsAWlSlKr7SPtiS70xuHIo8k8FGB+p4B6a6ksCw3jUIP9I6msdErX9KeCdPJUqFFxM9FmR/15sBJOnFWPf+PTEc0DAY7LylSJovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTPVHhfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0298C19421
	for <linux-pwm@vger.kernel.org>; Fri, 13 Mar 2026 10:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773399507;
	bh=34Lj9aEuWwASIusAF/p6A+RWo95PpijWJDVHObS9CJw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=uTPVHhfwQN+WK6pQS83Luawb4NSKGKsCH3taJTufn1vuz4vzDRNAtIr1CoVIgIok2
	 cJs6WnViXxXLefqBi1PAusq6ouGRqz1OEO7njaFnrnZsJ4uxwnccqJwHLP1SbTvxdi
	 iVxb3MGqvSEuyZdKEuQg0RukWlMJ8niW51CihwngVHhhe9WLS7HxT8QUpgSC419Rw/
	 LxEYfOFE0DRYr0Vr6swzfxrz6f92HSpfxbIaE/ItSXF7SatZD7lKp8XtaOUSpteKmf
	 T5vXU/6VDMLeSLl8jZb/OysJKsdeB2VqlU3xDYGUxtLQivGGrX+C0yujsct0CME8D1
	 7nD2BVIl82Xwg==
Date: Fri, 13 Mar 2026 11:58:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add #linux-pwm irc channel to pwm entry
Message-ID: <abPtr7Xcof9x145d@monoceros>
References: <20260309201954.1938136-2-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3pmfpcjyoxudp7c3"
Content-Disposition: inline
In-Reply-To: <20260309201954.1938136-2-ukleinek@kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8253-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ozlabs.org:url]
X-Rspamd-Queue-Id: 089EC281D6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--3pmfpcjyoxudp7c3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: Add #linux-pwm irc channel to pwm entry
MIME-Version: 1.0

Hello,

On Mon, Mar 09, 2026 at 09:19:55PM +0100, Uwe Kleine-K=F6nig wrote:
> The channel exists since quite a while, it's very low volume, so chances
> are good that I see you starting a conversation.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55af015174a5..708c050ac397 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21337,6 +21337,7 @@ M:	Uwe Kleine-K=F6nig <ukleinek@kernel.org>
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
> +C:	irc://irc.libera.chat/linux-pwm
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git
>  F:	Documentation/devicetree/bindings/pwm/
>  F:	Documentation/driver-api/pwm.rst

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--3pmfpcjyoxudp7c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmz7c4ACgkQj4D7WH0S
/k7E4Af+NQQJYTzA4JP0Il8TqLUsfvgD8Jpmw6/HLZTaSUlac6Gxh+EFIC1h//1b
B2zNb98egWtBZY3ZLkUQiNjQYKKTqxxSf0nqE2qiwWUwB6HnQufFHFHlOkhQWBLu
vjjWsod8PV7akOQjriS8EoZBQ3D0264Bzl4/40D/hcscb/nxyVJ1Zo5fvW7mJgCj
zqezFMHhUME3LuQIb0waurbAqSlthAB1UdXKiLYTnHS5GOxfHnYe7l9B7e1YJ/Fy
xQx+1WfF8+FcERxneqbb2kUGZ4LO/Bu31O/zdjaYUi6B4ocNry9FO7XB1FdD3X6P
5x0nu80fMT6HdH+3U5Iyk2NJp0vkqg==
=dXsS
-----END PGP SIGNATURE-----

--3pmfpcjyoxudp7c3--


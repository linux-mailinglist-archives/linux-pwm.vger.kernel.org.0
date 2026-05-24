Return-Path: <linux-pwm+bounces-9094-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM3UOkPfEmrL4wYAu9opvQ
	(envelope-from <linux-pwm+bounces-9094-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 24 May 2026 13:21:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0CC5C22F2
	for <lists+linux-pwm@lfdr.de>; Sun, 24 May 2026 13:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3F84300348E
	for <lists+linux-pwm@lfdr.de>; Sun, 24 May 2026 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D523939B5;
	Sun, 24 May 2026 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivt+XsYs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99853932F6;
	Sun, 24 May 2026 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779621694; cv=none; b=a/bd+h8mFgkNaznHWyuPmW7shHtyRiABrYDP7N8vkoWMTl3x3PqWZmbsKCnmj+9654ZcNPE1aaJdpwk1mojrTBAQdvG1C7u+hyDE+Re6brZ+vunODskGlMWiicfFTB9As/3lMwEg/T8P1nPugHvOQ6f+N5alFDvasuSivO8MQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779621694; c=relaxed/simple;
	bh=oLiSri69Now47RImuq7She4lhkBga74FFWNykITHvrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDpvPa1mZpaJ3nGhUPU320ZCUakdXP0M2h9DsgBMRAMvTn/sqd6fiSvzBKTplm4LKHJ4NvEGGCXmUV1HQlqBSqdYrvzqDr9FP6J1SF9q3Jq6c7j5tBdXZCx9+WsrhXkaCTNJDJ8o1g9bTjlhAwq698JX4ofcDwUn6LeHs6sUGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivt+XsYs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 874481F000E9;
	Sun, 24 May 2026 11:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779621692;
	bh=oLiSri69Now47RImuq7She4lhkBga74FFWNykITHvrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ivt+XsYsfCEwwRlyrk81FgW8qmN3XGVrUO4QIE49s7hLG85UWNqNJFaSnj2oNI2Ba
	 i1HR34jswIcsOXNFB3K/MjAqwzGQ79pneyvAfKAIvQfzwvTX6+dMpKQirtRaCRntgj
	 X8gg/k38ukFxyZBKSukaVZ8pP4IHopZFKAMnlQWlkvZYGl3gzaIJ9/kpC+abZ54y64
	 wAnUhPcRqaCOF6Gt5OxzSvpXai5cXSrsDJnmFwWSg4NHRMjofNGihVHDuwCwXk7txi
	 MJ+YuW8qYiRyo/oGNqnAziNoro3Kf1WmvoCaolWRJK3C0GpMPMuEOJYge820VPRPJz
	 ej0Ch+HZiwFGQ==
Date: Sun, 24 May 2026 13:21:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Manish Baing <manishbaing2789@gmail.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linusw@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: pwm: stmpe: drop legacy binding
Message-ID: <ahLemdy7Ie9n-Ltx@monoceros>
References: <20260523173251.72540-1-manishbaing2789@gmail.com>
 <20260523173251.72540-3-manishbaing2789@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="apdghv2sfx72heyb"
Content-Disposition: inline
In-Reply-To: <20260523173251.72540-3-manishbaing2789@gmail.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9094-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,microchip.com];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DA0CC5C22F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--apdghv2sfx72heyb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] dt-bindings: pwm: stmpe: drop legacy binding
MIME-Version: 1.0

On Sat, May 23, 2026 at 05:32:51PM +0000, Manish Baing wrote:
> The st,stmpe-pwm binding is already covered by the MFD schema
> Documentation/devicetree/bindings/mfd/st,stmpe.yaml. Remove the
> obsolete and redundant text binding file.
>=20
> Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
with Rob's ack from v2.

Best regards
Uwe

--apdghv2sfx72heyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoS3zYACgkQj4D7WH0S
/k7CnQf+LrJy/swVkHwrkqPTyAvOZxezQIxQ6APF6k7/l2fout14sLJ0g7dQtpaW
nUc8cmeCXmoQkDQ/uhzxhfQBxEGXIX+p92kbur2eXOUWsErUzdPFqEQ1bxZhGb5p
clieA/lMQE/uZBoFhSlF73S9yBKoQks6s5rqTsEq6vyArWYXm74eHvrcsW+UNL17
Qsr7my0ZvgUpvRVE6F++d2SpNdtgrrjUAhq3dMqn/HnlQFoNoOxPAh7FKyg5MTyF
IduJDMP/25MrUL1hRm7XDoiP8xkbHfoHpZif0h0z1xrm8URPA4N5BvTO0hlPmgCd
pDpNs+9W5CK4XIhyssis+HaaiShrMQ==
=1Xa4
-----END PGP SIGNATURE-----

--apdghv2sfx72heyb--


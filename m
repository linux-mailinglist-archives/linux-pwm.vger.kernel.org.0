Return-Path: <linux-pwm+bounces-7970-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAPuMaXeb2n8RwAAu9opvQ
	(envelope-from <linux-pwm+bounces-7970-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:59:33 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9340D4AE98
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8FC258D3A8
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C154426699;
	Tue, 20 Jan 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh4bRul/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4931352923;
	Tue, 20 Jan 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930936; cv=none; b=BHcqKgD/fC44Uqt2Hi77kY1LFbLcx6wMtvZX9WksV7h3i/dVBPS5moVXmCMKeWU7EyDRshz3BMxSyaBoP719gU6FTaWraAldeJnNHz5eHW84lEnS/Wol8T31RqqEV+6Zo628Ldo3zRRvvec375jW3ihc7PStUj8nGrDRHra49lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930936; c=relaxed/simple;
	bh=meAvemZovZcmYZ+yrNIom6AqspQE+OsGeNd99DojcpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkCDj7cZmzk//G4I59+kTJf6WSKvBYibTfNZAYBMlxpG8C7cmq1atzxCjb2iwehqrEnHjiz6K2JxTMEq8sNY4NLx5hCKczPRecwOBtAUI9TJjFSORABhpHtZK2lMKUX8aTV1+vnSW4bccg9YC/abjND1baQ+pRWiqPQKqBVq+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh4bRul/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B337C16AAE;
	Tue, 20 Jan 2026 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768930936;
	bh=meAvemZovZcmYZ+yrNIom6AqspQE+OsGeNd99DojcpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zh4bRul/KSBbvP6YPRQhiEGizzgIQH633prYhXN+vnF40G/S5IeovLHI4wDA40H09
	 Np+/OsVu57tOnLK6Ul24Uf/EzWuwUa6KxcYlnwplpQ9ujZru6w5pRR/Kmjvspv65do
	 B3EVm83mbcptf0KmNyZZOWnM+Hg8u5HIoV57ziBVUvBhe3maVdvSVk7JmUeCBUGHoz
	 urbXYB5/QxBYCoq7RJNX4D1nNHwv9A827koBZ0pbksEzRidOOKN/1sWdYXtxQCjGN8
	 3Ne0FZ3z7B75SLCTxiDykkxPLTXiSYG6ZRNNPuLHacwUS0zkeTZQg4fmJhZGpv8T5N
	 Mz7CYKtOndmsA==
Date: Tue, 20 Jan 2026 18:42:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: nxp,lpc32xx-pwm: Specify clocks
 property as mandatory
Message-ID: <hshg5k7t3sry3wzf6alfok5wodzrkjcec5z63pmlephs3yshdq@jshxaxn5po2b>
References: <20251228224907.1729627-1-vz@mleia.com>
 <20251228224907.1729627-2-vz@mleia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mduptxgnz2zv7264"
Content-Disposition: inline
In-Reply-To: <20251228224907.1729627-2-vz@mleia.com>
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7970-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mleia.com:email]
X-Rspamd-Queue-Id: 9340D4AE98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--mduptxgnz2zv7264
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: pwm: nxp,lpc32xx-pwm: Specify clocks
 property as mandatory
MIME-Version: 1.0

Hello,

On Mon, Dec 29, 2025 at 12:49:06AM +0200, Vladimir Zapolskiy wrote:
> Both described in the binding PWM controllers depend on supply clocks,
> thus it's necessary to specify 'clocks' property in the correspondent
> device tree nodes.
>=20
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

LGTM, I applied it with Rob's Ack to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

as 6.20-rc1 material.

Best regards
Uwe

--mduptxgnz2zv7264
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvvnIACgkQj4D7WH0S
/k6oGQf/fLm9JvhCbgJIjQHpd/eY7kv8bDtODdscfIX9ICJh+dNX8S4QnKxW5CDQ
VRZu5h4ylnMEiIURtpWr3DdZcOmMPe2ItCwyvJep0pRc5IF0YL5szUguq/AT1uOm
txCLphKHOh1OATvDuVCjgJHBtCaOltPjJ/sCpZo1dvkMMti8ilKbTUaksq8ig/aa
mxOyOX56Q45kdVDXgMBeWPTi4fIBcmQAa/OPKOK+2IPkICNRtIc/gP3aYSPpjCLT
STHf6lzmOPn6zOXu8JrbeC53wef1qqP9Wr1d0T4cvYMdZ+LC0Y4dG3AW3Kc3Zv0r
7Yi9JDY9UtIZ1mkC4bpgtlIfGrJvzw==
=zDFJ
-----END PGP SIGNATURE-----

--mduptxgnz2zv7264--


Return-Path: <linux-pwm+bounces-9164-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EUBtGm+jFmoOoAcAu9opvQ
	(envelope-from <linux-pwm+bounces-9164-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 09:55:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DF35E0B0E
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 09:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B958530087D7
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 07:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A733CDBA9;
	Wed, 27 May 2026 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNUWQFCm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06CB3CD8AA;
	Wed, 27 May 2026 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868524; cv=none; b=kaUdklQewsi3B5mu4q65FxGUwGZ7h8DCUvUxe8OQEe2RPXVEtCob7FyLeD4Ywhs4UXGuvpIYNVpwbhrUUfOSbotfwHQGR9IjfOABHu+r02aDRpPn6OA3262rtXur+06wNzIp2eOQy9+3Mzji3mWbeBgYz1hiQzdQgYjqPwb6D1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868524; c=relaxed/simple;
	bh=zDN3dQE0pZCHm/EWjUiAZII+WWQDvvks2kEWRXa7SX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgtRW1MRj0m8ut0k42WuvN7vhMsUOGc1hLZT/gB8hYZywvv/vIUorNRW7WxGD6uMML8Fd6DfLKd6K8M6luUBtwkO4xmII1nAbegxTV+JxgX7Q/XLliSW/7xmlrWnnXNJ/pz6LXbj9cbJgOXCyWpAoZUaxXOBD830k9S2cFccr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNUWQFCm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BF5EA1F000E9;
	Wed, 27 May 2026 07:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779868523;
	bh=zDN3dQE0pZCHm/EWjUiAZII+WWQDvvks2kEWRXa7SX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UNUWQFCmi5dD4PUWIDlyhsoLTrAw7u+EKnCD83Dl+FeOFH21yTR9qoQlpzrn0/Asg
	 6wl8Q6DA44YlPXZSP+ETUeUeheClz+nXVCCl7KjTpq56EwcM7loZnLuI38m2pxQXMj
	 YrRey8SH8BzJndKiuWTn4biBT6Pjl76uuNSDFZ96ohRRa1CeYvbe7I8r2wqcpKVhmu
	 JvffroaCsnKqINBkmXgbdooRNXVnDveZE0T/b7W4RaWPZSgfG0NVd2Zq92xgKHkywN
	 8sUmQ3MDSorxiyemIS30cwyTZNsG1umaNJ77bc+GBttpjmZntE0XacWoYYx1ebJ9iu
	 FJWRKHV/WOIxA==
Date: Wed, 27 May 2026 09:55:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, linux-pwm@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v3 0/3] Add RP1 PWM controller support
Message-ID: <ahajNRmYNa5SNQnS@monoceros>
References: <cover.1776932336.git.andrea.porta@suse.com>
 <af2bsEdAhYY9c4rb@apocalypse>
 <394b5e02-1aa6-4efe-a5f7-4468d1f82172@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="euzjwg2lalycyeq4"
Content-Disposition: inline
In-Reply-To: <394b5e02-1aa6-4efe-a5f7-4468d1f82172@broadcom.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9164-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F0DF35E0B0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--euzjwg2lalycyeq4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 0/3] Add RP1 PWM controller support
MIME-Version: 1.0

Hello,

On Wed, May 20, 2026 at 04:31:42PM -0700, Florian Fainelli wrote:
> I would prefer to take the DTS changes through the Broadcom ARM SoC tree to
> minimize conflicts on my end, are you going to take the PWM patches for 7.2?

I didn't find the time yet to look in detail, but skimming
https://sashiko.dev/#/patchset/cover.1776932336.git.andrea.porta%40suse.com
suggests that there is still something to do for Andrea.

Best regards
Uwe

--euzjwg2lalycyeq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoWo2QACgkQj4D7WH0S
/k72hwf/eJOLdTqx9awA8YMjMpmRLgfAPn2nkdaDbwV6esNNZT0ofvsM+CvjBPXh
pJjAAuufZwcSsQjEEd6kB41yTDhIBsR8ZLves3J7ocg1SwKGdmVucyKw9mnCR2ce
AWsrfAD0AZLrdlxEG1L5N0d95SUPLlFMSJcr9kyol3NsL4i3oerEsMhJC1mkhq8Y
NZRB86OK1cnc70jWKEUjGvfuHP+G9rn0gOuax2znEwcVxq4Hytm/HCsHoheP119q
Cq9GRHBRvmt5fl4BsgFxTcpTSOce1quz54tJh2ln0cGEorxO02RfVXipYGXel5xv
WMPklMj+QVkPq6qK3uqLvmcVkRkZAQ==
=4Fzh
-----END PGP SIGNATURE-----

--euzjwg2lalycyeq4--


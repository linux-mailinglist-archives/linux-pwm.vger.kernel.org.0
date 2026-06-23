Return-Path: <linux-pwm+bounces-9358-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2H4eByHDOmqVGAgAu9opvQ
	(envelope-from <linux-pwm+bounces-9358-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 19:32:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D46B9123
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 19:32:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lIBGXa6V;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9358-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9358-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77F973019113
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 17:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD8138B13C;
	Tue, 23 Jun 2026 17:32:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DFE31E848;
	Tue, 23 Jun 2026 17:32:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235934; cv=none; b=W+AbgKaq/PDyicL8uFJQBArXFQUvZwNs88lwFdyz+5kDk3LSre4u9vgkP6uEJ52YleAH3YsfGf2Dz4o70UN52Ds4WQMXZzjz2C0Fvi/kdVHNPRToVWMX0m6SNb4q6qBVk0jOl9TGj/QzH/UqvpHSkUOkgBeonQwjXc3IiMWwpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235934; c=relaxed/simple;
	bh=mEHtEJfSVvPRo0FiAoWZg0wyxCt307pleMeuVDIuBVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJK1KzFf1dl4SDAZWh+ceBYjvm9Xbv4gvoH9Qc5wUJqX3MK7BskDvvQstl8GMlTXtZMdNElMTeC1Yhx81sZS/y3Vfc6S8xfj7OpuQECsu0A+OUC0yaYszuGr2DYEa+NABcQmNO3s7OT8dHpQhkCIfXEHHH5akHDclqAEl5EbL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIBGXa6V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468D21F000E9;
	Tue, 23 Jun 2026 17:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782235933;
	bh=mEHtEJfSVvPRo0FiAoWZg0wyxCt307pleMeuVDIuBVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lIBGXa6VqKMV/lKmzJkqQbiD3ezaGzFeDWtt3TBm1AL5R/o5P2b1TRb9SFtA1qpjn
	 nzd47yHxR62EAj8AhwFFTi1VJr6Pnbdrziub+aUcr6MwUbuFc88DHcZn25IJjut7FP
	 WO06Q1HNvp8+Ck3ggWClR74Zh3rStQFW5fa+RbCUY8xad6B530WQFF4A3in4T9YdBP
	 ZRxGw/ZNsv6ID1xsQAzGkUtwKx2ZKHVBqXjbf6JVgz1d/0l2Bd9p3YRp26NL2BL2ht
	 BeVHHlAroGA5WYao+UURpc/jZLZTbeQQLIDL1u7UkdizIhPn2Pfpme21EV8Ia7DCvH
	 iH7d0P3YocYPw==
Date: Tue, 23 Jun 2026 18:32:08 +0100
From: Conor Dooley <conor@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v8 2/3] dt-bindings: pwm: dwc: Add eswin compatible
Message-ID: <20260623-etching-boozy-8775b1f1554f@spud>
References: <20260623071329.2034-1-dongxuyang@eswincomputing.com>
 <20260623071438.2147-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pc5d/wXxWbfsACVj"
Content-Disposition: inline
In-Reply-To: <20260623071438.2147-1-dongxuyang@eswincomputing.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9358-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dongxuyang@eswincomputing.com,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ben-linux@fluff.org,m:ben.dooks@codethink.co.uk,m:p.zabel@pengutronix.de,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:xuxiang@eswincomputing.com,m:wangguosheng@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C1D46B9123


--Pc5d/wXxWbfsACVj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Pc5d/wXxWbfsACVj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajrDGAAKCRB4tDGHoIJi
0tpQAQDyYKTzDauf8ZG938t4/xbFS79vxmq28F116fHcXh7UygEAwUboEJCIzgvw
O1LLfrxCZxcCMtcZtniXyzTnHNrM/gE=
=ecFI
-----END PGP SIGNATURE-----

--Pc5d/wXxWbfsACVj--


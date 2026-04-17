Return-Path: <linux-pwm+bounces-8630-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N1EOxtV4mlg5AAAu9opvQ
	(envelope-from <linux-pwm+bounces-8630-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 17:43:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CBA41CC17
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 17:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 499FF30C6951
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98626056C;
	Fri, 17 Apr 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEAkiEiv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3A22AE65;
	Fri, 17 Apr 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440156; cv=none; b=gZDcSvi1xdbtLFbBt2KHaGXIKQY6dxYAQHGbvoWBFmXyX04/Hd5DKDW/Pr4W/v+L+bAWXBaGbeQ/uxnSuYbT1xGLv5oISTLtvCr5FMEnt/4cNDoFOUhEqyMkoheZNrjRrcKUPhG8aDDPAzv1kNd6qK+yf6qGDKPQbNTkziXPoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440156; c=relaxed/simple;
	bh=a1Crdh/+nqNrrHioW0baNEGiaZ4uh+mfrgP6IF19+tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODbhH+SbXeR8f5YYEzCYbC7QqibRVs9pDpNUtz0vYQ89APjjahspqWZXrEqgXX73Bw8EAKUvkkalyAmYWzsxiA83pWf/meDqJk+vU65QJcvklwSf/1JjaJkfwUPRH9Gpf6NZm6sGgQRFPa3F8Z2OJ90Vj+d0S1ITClTX77gCA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEAkiEiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A92C19425;
	Fri, 17 Apr 2026 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776440156;
	bh=a1Crdh/+nqNrrHioW0baNEGiaZ4uh+mfrgP6IF19+tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEAkiEiveDU2XN4YsjaCdYF3CZKAeXqvnw9HY/ydDUEdFzs8zQA5u9I9xY1lXKCxc
	 KOyxzAHY39FEgWK3l704UX5/unPWW+PP3mwOjBydsSZjvwkp0Qk2eJjXcOkYsGeOVu
	 1lghdd17Tshzgn6M+ToKXGyjrH4Stu76Xy1VsDiTWehVm5to6Tf74KG7PzdoKJlZbJ
	 FGko1zjgN5W97R48m5LpGMQx4Slpv8j2UGp7+JixjEb/X3Sg0apzwj5ts7bGK4FkG4
	 bKv01X9oExglAUw2+meutKasdTCNRmrawensex3f0LgF7OQbm723j3m5vph0bTi8jI
	 ShUaYTPcBKfew==
Date: Fri, 17 Apr 2026 17:35:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Linus Walleij <linus.walleij@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v8 00/15] Add RZ/G2L POEG support
Message-ID: <aeJS4gjplQ8KNIhb@monoceros>
References: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kq3ou6pgicvep6dc"
Content-Disposition: inline
In-Reply-To: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8630-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[glider.be,linaro.org,pengutronix.de,gmail.com,bp.renesas.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78CBA41CC17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--kq3ou6pgicvep6dc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v8 00/15] Add RZ/G2L POEG support
MIME-Version: 1.0

Hello Biju,

there are currently two series by you open touching the same driver
(this series and "[PATCH v4 0/9] Add RZ/G3E GPT support"). Would you
please make it easier for me and create a single series containing
everything that you still want to get in? (Or if one of the series
became irrelevant, that would also be actable for me.)

Best regards
Uwe

--kq3ou6pgicvep6dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmniU1YACgkQj4D7WH0S
/k5e7QgAkXOey3hWrL6Rlf5L69jWSxaJB8PIilCjqU3LSJ0SzzxivP5Sl/W0ikCQ
pNG0q1oEly89lXlw+q1qX4+3o/9FiphdBzCq28bdtdZAhcudnjnm8lzXdr63yBon
BfvNUKbY1t33KEOhNWKsdfsDL6TB7b5QV7GrSuUygo3cDE9qF6YAX9UI+q58w12L
hKlfP9skX61J7Kec0pnMIiGPtgeKnIyUbci0khbNik4CoC/VBENXMo21ncxizqFu
t0YZ1g+VAuHN+SWLLa2KZoNZ2NIRUMXWj7EG3YzsbLxH6y0e9baQKG8KYbSDjXfP
7m03FgpSnymzaXHkR+yWNbO9ekldcA==
=nVPA
-----END PGP SIGNATURE-----

--kq3ou6pgicvep6dc--


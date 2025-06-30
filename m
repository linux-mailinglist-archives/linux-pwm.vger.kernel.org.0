Return-Path: <linux-pwm+bounces-6576-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D84DAED6C3
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 10:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C20218930A2
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C2421CFF6;
	Mon, 30 Jun 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFNfTpwK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE942A80;
	Mon, 30 Jun 2025 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751271148; cv=none; b=k+BDAYXurutYo0J1i4jch1qwCD8g0Vcrvj9J0nFDBqx3dovoZRapLd0e82qCRoR0JJqdGbKMOy+rsVSYAnD/+CGNuHsvGFONtdr9+Rl27C0VW5msBlcfEHzsNAR/o1rbNJnCZb3ieRaPPrheCGsjqtZmgnL6Ke7jRkCLTnKpLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751271148; c=relaxed/simple;
	bh=wQPXfgfZqxpVElgIFx359NMt3iAlCztlIijWS0d+KBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY1jB5cK3rlZRb7DdlTJi8lm7tG5Qhs0bWuJkxjnL8eQH5FCqYmp5vToYc+4CCChpGYBG5O7Gzu1jFg94I4S5zuoX4hNNKhbo7uXcCepABVrv5N8UDoBtUpBefvLTfOisL/zYJDdiZ0ReDJeDa3OMrx6DeKgnJqHIN3oR8e5QR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFNfTpwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D60C4CEE3;
	Mon, 30 Jun 2025 08:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751271147;
	bh=wQPXfgfZqxpVElgIFx359NMt3iAlCztlIijWS0d+KBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFNfTpwK8swC1POSXIPUIoEMJ28k7wrGD3PdM0EkGZkB2rOOjW5SloeD4+UPH8WJ6
	 UtCD0g1IH1UwMGjIgl4wYI+HO24LPvhnIBGCfCfFH7mMfo1H9VSvu2BFD3aGuf/4se
	 LdgWLd0A6K/fqZAthk4+MsTLt6u4RAPTR9DdoAEZ1rGsH7BMzaz1IRosP/X1hqCwHr
	 LG44wu2OFIFu5spl0oUsvBIuryY8OQVYOmzoh6MZNrlqhwWt81oqq4tm8h4Jd6ewXi
	 UJgVFvhN0ZccVgzhWNK0U/X35uxM4Zw1n1m+CYKg3BnjvnB2q1x9C30sC7l3mLjMpY
	 bw89uUZy0RY9g==
Date: Mon, 30 Jun 2025 10:12:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: vendor-prefixes: Document Argon40
Message-ID: <75z77kduzyfn6b5r4iw6pflnwh3g6d5t2ciozk5jwvgbnq27cj@4sgrx3adhpnk>
References: <20250629220757.936212-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ian3v7df3oyd4ig"
Content-Disposition: inline
In-Reply-To: <20250629220757.936212-1-marek.vasut+renesas@mailbox.org>


--2ian3v7df3oyd4ig
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 1/3] dt-bindings: vendor-prefixes: Document Argon40
MIME-Version: 1.0

Hello Marek,

On Mon, Jun 30, 2025 at 12:07:18AM +0200, Marek Vasut wrote:
> Argon 40 Technologies Limited is a SBC expansion board vendor.
> Document the prefix. For details see https://argon40.com .

Applied all 3 patches to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next

Best regards
Uwe

--2ian3v7df3oyd4ig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhiRuUACgkQj4D7WH0S
/k5+0wf+NnlVfcXkRJbWJC5nd1t9wN1SZinRQTYsvCIHU42bWvdcotacqReFuOgc
tufi7oRUpnYnqQhA5SprNe1bFCnGzFT28bceHfGUI6KoQXAAl/VOJjZ0D0qs2REr
jt++5Krt7gqeGxD1lmWhLVuYJzTlr4jM2IUyjeOogDqvXhEJ+WEY9jEv3vJQQWVF
bedfGK1ak2By+LY3fPiGhLCDC26R0yPsXt5FNRR5aTRmjgBbRaleRXhFP9oE2ikO
t2dnxYFIE75dTpjcIocDqc//AtpwAsRBqXkJA8CcB0D1xlOBzFyLqdQ+0CcbTnGy
IRDxM2UHFnxY5FwgEIc9fy6ewlRArA==
=Ou83
-----END PGP SIGNATURE-----

--2ian3v7df3oyd4ig--


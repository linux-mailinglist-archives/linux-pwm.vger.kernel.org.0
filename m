Return-Path: <linux-pwm+bounces-6252-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D4EACFF9D
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 11:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA70173C6F
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5D327F160;
	Fri,  6 Jun 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ildp5oto"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF3191F7E;
	Fri,  6 Jun 2025 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203248; cv=none; b=FKWgyxlFgNCTX/+BT11ptcpqbeP4+krp+rwm+DZIRNPlGRX3kdjMtbPtBKQw7sZYTPC2K62NEUKh0EUtJNMn7z3YYJOUKblYZMoGj4i7vjUjL1uXZ0IwMch2xxsFn84JZAEPVSZyuuxgue9jF/GYaR8QxE4JbWhB7PQHLkiU/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203248; c=relaxed/simple;
	bh=vvY+zy9RAHY5Xv9bdqTJBXFQVoDzhPJHF1eJQ9KYoDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tTv8/yxTKBLsMYGcyPWVh9M8g84/dVHCXOYEa3HPyIvolx9quQrQS3AHvSgfxbsz48W63EI5zOcFEjbLYgor1rwXhPEJ+dP1VQyAB/Cb+l9kupO+CgrV5Pug6IfaOhBoukldKGoSs3Kjv8QD9BJq4EEwXea8fcc0bx44m/azf6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ildp5oto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206BBC4CEEB;
	Fri,  6 Jun 2025 09:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749203247;
	bh=vvY+zy9RAHY5Xv9bdqTJBXFQVoDzhPJHF1eJQ9KYoDA=;
	h=Date:From:To:Cc:Subject:From;
	b=Ildp5otoztJksh2Bp1iOkOSirhm5+tezfn0hw/Rw+xybsiVkpMtUl54gFeybakK2A
	 8RZOGYWAhYSCikgMAbxy2p/8yRm1+AUtktxfoeTjI3vS4jUxcK4lfhX+07ujCkyAFA
	 nRkbbY6N6WbvUMItJV1PhxzLzLAqKbzMPyuJptfBYQXxJSU3TfMiKjhDurw+OakI3N
	 ychK01gtpN9frEV4+RqJFC2YNvU2DQmhSxPj5KHTBCbsokkcNALcy8bH1OHvGKgkXI
	 6mjlXu+mxSSospxpDKx2MeWOfPtTGTXGKcJ/4R6TdZHTO1heZkj5Ra3cJSO52BtlrJ
	 26JDjpOv836EA==
Date: Fri, 6 Jun 2025 11:47:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: axi-pwmgen: Fix handling of external clock
Message-ID: <jzbvo3ranrbpiaox6pzs73jmq5njkkmq7iqnme5z7krcugjdk2@6hy7myyjdji5>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ixgvzd3utbel5w3b"
Content-Disposition: inline


--ixgvzd3utbel5w3b
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] pwm: axi-pwmgen: Fix handling of external clock
MIME-Version: 1.0

Hello Linus,

the following changes since commit c0c980f237e822fd9cc6c0ab5b60ce8efe76464e:

  dt-bindings: timer: renesas,tpu: remove binding documentation (2025-05-19 18:46:45 +0200)

(which corresponds to my tag pwm/for-6.16-rc1 that you already pulled
last week) are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.16-rc1-fixes

for you to fetch changes up to a8841dc3dfbf127a19c3612204bd336ee559b9a1:

  pwm: axi-pwmgen: fix missing separate external clock (2025-06-02 18:23:33 +0200)

----------------------------------------------------------------
pwm: axi-pwmgen: Fix handling of external clock

The pwm-axi-pwmgen device is backed by an FPGA and can be synthesized in
different ways. Relevant here is that it can use one or two external
clock signals. The changes included here fix clock handling for the two
clocks case.

----------------------------------------------------------------

The two commits have been in next since last Tuesday without issues.
Please pull these two changes for 6.16-rc1.

Thanks
Uwe

David Lechner (2):
      dt-bindings: pwm: adi,axi-pwmgen: Fix clocks
      pwm: axi-pwmgen: fix missing separate external clock

 .../devicetree/bindings/pwm/adi,axi-pwmgen.yaml    | 13 ++++++++++--
 drivers/pwm/pwm-axi-pwmgen.c                       | 23 +++++++++++++++++++---
 2 files changed, 31 insertions(+), 5 deletions(-)

--ixgvzd3utbel5w3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhCuSkACgkQj4D7WH0S
/k6vOQf+NCDzm/4JC9KgW9GvFklJ811OhzwGYtDBvTPpOjwI8vU1/d0c+0gffUDx
BkbuEGS3fTZSURW2uXhP8OiazkVbBCZIJbJVScssNTbskQVDWNSgOojnqQz7uzjK
oCO8W2uUURBSCdafJ+mRpsRgN0I7YB4Pili0o5QWtjrZ+YU1VYfKZVGlTbl58Dci
z9QtzZX5uxBNq5FxtSpiPQIWKMGl5HiGaGo4JTI9wwb+tQiFdi843AkpTwhLiAgD
YjJ91a7wzMgWvOuEmP/8cGyIlJCbN99RLEu0lh2p6UbFxpPS6SWpRj5vJ4HQ69K1
9AS5znuYDWPT6wbvJ4VtF+Q/IhRkgw==
=TiO0
-----END PGP SIGNATURE-----

--ixgvzd3utbel5w3b--


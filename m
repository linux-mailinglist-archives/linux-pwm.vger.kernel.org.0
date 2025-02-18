Return-Path: <linux-pwm+bounces-4942-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94592A3A310
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Feb 2025 17:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD4D167A81
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Feb 2025 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E2026F443;
	Tue, 18 Feb 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECSIvAUw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416126E658
	for <linux-pwm@vger.kernel.org>; Tue, 18 Feb 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896944; cv=none; b=IKhx8TqPE6uJkF9F3EdChWVlkpVJHcMnUpC3rRsTfVYEDzdGSEfIzgdZtklLR+TETBLIbuj9qgVU9zx1qIicyKpBNyjqt2WoDWIUcsf2zO1piqele3ChUdStB8brZWHenPpiXVKgZAmxlFq1wNa72d5c6h6viNkrx9iNEka+zkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896944; c=relaxed/simple;
	bh=0UR7ZnzNvjz0SEvJtLSwadQ9oZvEotljrbUsdRRYjzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxvrxGU6hJaiuO4qDZDJ3/E4E2Gb1wYfrqqy7muh7rtB8mxjourtRw9/hah6v3NCIFw3RoRa+p2Sh9qgZsoRi1qucu6YGbq7yDU+b24Vw3Urb12k5TAWRmofSKR44sCYGUbkp2RYh6se3Z7MriHWNBv6x0RH2WeyLJfFkTM6v5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECSIvAUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C283C4CEE7;
	Tue, 18 Feb 2025 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739896942;
	bh=0UR7ZnzNvjz0SEvJtLSwadQ9oZvEotljrbUsdRRYjzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECSIvAUwLDlMHiFskaPKGIwKt/429M4ZYwyuDx2aiwDstX5IZjB4vpk3zjscOEv2v
	 zqQYU/atnf7Fd9N5SfudJl1bsrT5MQ9XM/iCEmBegFOpQUOOAL47ZFDU6smP/i+KGg
	 tlKvYJ91MpGDw6oFvaagm56nBqSzHwgVzrPdIeBCoCbmonyIEg+Xv8UsnXWt3rBcKi
	 xnfPYQo2jtltHS795hs0XBB/hbNrKg5Zf33dw/aA/U0wd+eHV95SRWIkih0zBBwAsG
	 QVQEBklMdE43+0gZoAKuDRRdkZhfwAXWFqDlVps7bWU80yhszD/nkFtqGQ/RruXOtb
	 YjXoRDBz8Nrfg==
Date: Tue, 18 Feb 2025 16:42:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] pwm: Strengthen dependency for PWM_SIFIVE
Message-ID: <20250218-only-banshee-035249898ef8@spud>
References: <20250127105001.587610-2-u.kleine-koenig@baylibre.com>
 <ts5ze4fosj2vg6pokjfqx3tjernjug646kihiqikxfrhk7tzbl@whgq4nuhni4r>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aHbrkrX7hwaxkCfs"
Content-Disposition: inline
In-Reply-To: <ts5ze4fosj2vg6pokjfqx3tjernjug646kihiqikxfrhk7tzbl@whgq4nuhni4r>


--aHbrkrX7hwaxkCfs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 03:48:43PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, Jan 27, 2025 at 11:50:01AM +0100, Uwe Kleine-K=F6nig wrote:
> > Back when the sifive pwm driver was added there was no symbol for sifive
> > SoCs yet. Today there is ARCH_SIFIVE however. Let PWM_SIFIVE depend on
> > that to ensure the driver is only build for platforms where there is a
> > chance that the hardware is available.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> > a quick grep suggests that the driver is only used on machines that inc=
lude
> > arch/riscv/boot/dts/sifive/fu540-c000.dtsi or
> > arch/riscv/boot/dts/sifive/fu740-c000.dtsi and for these ARCH_SIFIVE is
> > enabled. So I'd guess this patch is fine. Still an ack from someone who
> > knows this arch better would be very welcome.
>=20
> Applied now without further feedback to
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/f=
or-next

Bit late, but ye I think that's fair.

--aHbrkrX7hwaxkCfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7S4agAKCRB4tDGHoIJi
0qPYAP4madBzzucHdVUiWEvKgNT8uI7WckM0qzO7+ApHjfyW3gD/b55C8F0Ask/h
7xT/eb9iS5DtWcglDhOYNi1ldp5YPw4=
=jb5M
-----END PGP SIGNATURE-----

--aHbrkrX7hwaxkCfs--


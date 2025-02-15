Return-Path: <linux-pwm+bounces-4920-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F4DA36EDD
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Feb 2025 15:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CB13A81BF
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Feb 2025 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480F81D7E52;
	Sat, 15 Feb 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWtbniCq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F51A2643;
	Sat, 15 Feb 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739630539; cv=none; b=KFAm7gBf7WhRzEuQLAgzHwI67QW+9+FS/1mQj2ytmevTyCQZXJawvMdGz0Ppwbid7ggjqXJrjQWCUOBKMISmBgUP42AoyUXCTXpDdVGyuHrqxW8dO1emNghKVucPO1YnmqvqCHW2jgbb071yMiQMcbAKFskOYhn4GMelXThqHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739630539; c=relaxed/simple;
	bh=hTQm94dhp6obc+kQ+B9IiKPO7d+zW3z3W/Yf3QSb1AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJGBSfo5YPwBhYxYgNTzJBoXj6vU0Gxep72/PoVSZP/mhnESsSiVsNeA3NtVjT4EpwnsM2GbmtSYOgwc61okhohWea4pfchLrcyogG0ulybVkUYroSD49CVD/wji5iUpmKrkNf0tXgI268UTNJ5h74U2YDY+OTXnuI2KlP5f6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWtbniCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24514C4CEDF;
	Sat, 15 Feb 2025 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739630538;
	bh=hTQm94dhp6obc+kQ+B9IiKPO7d+zW3z3W/Yf3QSb1AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWtbniCqnMJOxKy6itdzLPIMHCx30/BEceRxewC23RZl0lkY117PHu42VZoBHcMGx
	 2niZS6b5NQt/YvhMS36G13iHaxZc/TrrMSE2tomRP2ePxJASJG5WRfmmIzcfAlWlsm
	 MQadSK6UMGMtCTmK7v+pXqr4z7YNZEWtDvujMnM8q5VOn5GFYTL5eNSO4WxVqp2dWT
	 zZfkuHvYJ5FVJcMoy7Tky026h7Sb+aeOJhKH56xkr2uRET21A1Vx0KOOZb7jpgiyRc
	 zp3X3SZtFgLyGioPRpGWGFhqFMiCyr3o6O+eb9VF3Q5LLUE+o2Wb6duP+6mvha7cop
	 fJlnHEZujePMQ==
Date: Sat, 15 Feb 2025 15:42:15 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pwm: pca9685: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <h5ra6lcg6hqbn6pwl35crqedjthpcsysh2e4l7h6m7ruos6cax@7qa6bab7n5jd>
References: <20250214154031.3395014-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="si7ku3zoap6x6lt3"
Content-Disposition: inline
In-Reply-To: <20250214154031.3395014-1-andriy.shevchenko@linux.intel.com>


--si7ku3zoap6x6lt3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] pwm: pca9685: Drop ACPI_PTR() and of_match_ptr()
MIME-Version: 1.0

Hello Andy,

On Fri, Feb 14, 2025 at 05:40:31PM +0200, Andy Shevchenko wrote:
> Drop rather useless use of ACPI_PTR() and of_match_ptr().
> It also removes the necessity to be dependent acpi.h inclusion.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Thanks
Uwe

--si7ku3zoap6x6lt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmewp8QACgkQj4D7WH0S
/k6okAf9HsJNibCf9xPMvCAeXGUigjK8aiD717J/cbjwd1BPR7iLNO0/6kiZ7dqO
A0dee6+/OVA/QIZavjyvF23G4YRSKmVJW5C0bg1CBp+7HNyspf8xySNSA7W4br7X
z9OQgMoMqpGR8VncXjbiNs9dWkpLQDqyxisY7CilAalDQLsrbUAlUe1wZkqvpaqj
BXmNPJSg1V748WPac7Qa7qfu6skQY0BKuHKbKlIXp7KIHbuttv9dDY/kqCrUXoPn
SqnTSrAZScrGISZvNlNhQ6bLVPLQ57RQGum52o2LBhHGDJ9T7iqz6BsFhtB4xnqd
eYBXeKikm2bPi5bjDDzXmZLCoy2PnQ==
=x2qj
-----END PGP SIGNATURE-----

--si7ku3zoap6x6lt3--


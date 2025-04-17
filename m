Return-Path: <linux-pwm+bounces-5554-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E81A91855
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 11:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B8E3ABFBB
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035E6226D02;
	Thu, 17 Apr 2025 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJNeDJ5a"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8588189B8C;
	Thu, 17 Apr 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883463; cv=none; b=Dhh4xch1MqYY3f9RYDwHAWUk/+kFbtkHOIveGCP32J2gvOL9IipwTSBL4fEKFbQITJbR/6e5c0fWRQjnyyhcDseLJTZ4ncjOfqzynjwNPHZw39GLTb4yaDzgKmc4qhZ+BTryKZy0/STE9w7QH3xkZl1gCC+bAJQL7TQok/YAtgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883463; c=relaxed/simple;
	bh=L8o2PSkGeZxi2mBoFN19BApuLbghB6wGeSWpWaGCaTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NztdZFaTxbgYqv2wEry9SX23Bybauq4dzeHUUGaGRlrww6M3eOxSX7p/psZagXUMdrsUFfTyiMnMjqLkDhlginn+Bn9j38IGOMZ/57PPsJGM8X4qvQWz7g5darCp5H/91MFCbXisbfAHUboXKiIc2JNjnx6QDI4BYHajjKYuFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJNeDJ5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A01C4CEE7;
	Thu, 17 Apr 2025 09:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744883463;
	bh=L8o2PSkGeZxi2mBoFN19BApuLbghB6wGeSWpWaGCaTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJNeDJ5a7rXZB3aV5DxX/MCGa77oE21mxbt+dYjy8W71i8SMQO9lI+JRJj1MuTNeK
	 PDtBEUTxmJ2BNwI3Fd7DLt8En85mkjUdTsW1S86vhnxYwRLFYQb3E3QwE5q93BSl6L
	 NbLhvoO+haS/iQAhYM2pjNLjdiOhjb4kvMDApTd/EAXCqOChB23jnwFoM0tF4Ubg5E
	 gfR8iVWMe3lQ0+NwEzvn9TttR8k586DAsrO5dff9ZU5JaRpMVosi2yM+0yKkAZdUma
	 2etP+icr4Mq/WjSeZ6JK96g0XYbgGXjrkrSTQmZLk7TB8FMKmdk+avpl4VxsuzShhr
	 2VEUUKsMosSrw==
Date: Thu, 17 Apr 2025 11:51:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v24 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <wapp2p55vrdpgwy7dpnrbxallcdu4yvk6a3nqimbyb565crqg2@7ljkanddwmjz>
References: <20250226144531.176819-1-biju.das.jz@bp.renesas.com>
 <20250226144531.176819-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oo3vkt6iyksbvgcq"
Content-Disposition: inline
In-Reply-To: <20250226144531.176819-4-biju.das.jz@bp.renesas.com>


--oo3vkt6iyksbvgcq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v24 3/4] pwm: Add support for RZ/G2L GPT
MIME-Version: 1.0

Hello Biju,

On Wed, Feb 26, 2025 at 02:45:22PM +0000, Biju Das wrote:
> RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
> (GPT32E). It supports the following functions
>  * 32 bits x 8 channels
>  * Up-counting or down-counting (saw waves) or up/down-counting
>    (triangle waves) for each counter.
>  * Clock sources independently selectable for each channel
>  * Two I/O pins per channel
>  * Two output compare/input capture registers per channel
>  * For the two output compare/input capture registers of each channel,
>    four registers are provided as buffer registers and are capable of
>    operating as comparison registers when buffering is not in use.
>  * In output compare operation, buffer switching can be at crests or
>    troughs, enabling the generation of laterally asymmetric PWM waveforms.
>  * Registers for setting up frame cycles in each channel (with capability
>    for generating interrupts at overflow or underflow)
>  * Generation of dead times in PWM operation
>  * Synchronous starting, stopping and clearing counters for arbitrary
>    channels
>  * Starting, stopping, clearing and up/down counters in response to input
>    level comparison
>  * Starting, clearing, stopping and up/down counters in response to a
>    maximum of four external triggers
>  * Output pin disable function by dead time error and detected
>    short-circuits between output pins
>  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
>  * Enables the noise filter for input capture and external trigger
>    operation

I now finally looked over this patch and I'm ok with it. So I will apply
patches 1 and 3 to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next

for now. Note this doesn't mean 2 and 4 are bad, just I
didn't find the time yet to look into these.

I will send a patch on top of this for a low-hanging improvement.

Best regards
Uwe

--oo3vkt6iyksbvgcq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgAzwIACgkQj4D7WH0S
/k6F3wf+Noa4373MKa5MYVacKyVz7WLzOdwsr3d/DMwV1+M3hE4L2euGaaZS85+U
k3G4c/LqIoOFFQUFF/qYiIQADWKNoRY269Rj0c3jFKwzs0ZoW6GKROlSv7FOLvJN
5BIqudas5hvjTmuOmFivMyRfc3s/nMoABNgkpZvZ7PEa7FKkQyF+KMdpE8VCgaZQ
6g1y9IC7sgzYUmIZL3HBbEgJ2zefddY0h2WFxqvZ5F9MNXnXxhxg5sEr2Sf3RFkS
BgkebDoyXdo3l14GhfVunSdggvHYpWaKfX4ad3Zkox+vyp76SEhRIr9fRh0yXfZL
3S8/sMk9wxwxvQg6raINc5lHW6XZdA==
=z9MA
-----END PGP SIGNATURE-----

--oo3vkt6iyksbvgcq--


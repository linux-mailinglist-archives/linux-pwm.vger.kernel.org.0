Return-Path: <linux-pwm+bounces-5334-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE4BA7C03A
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 17:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD7E1899DD3
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 15:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CC81F3D58;
	Fri,  4 Apr 2025 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIVwUz30"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFFC1A3172;
	Fri,  4 Apr 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779231; cv=none; b=GSlGkutS9gKK21rtwRu8gOEa4hAdaMfk7SKLck3M5q+d+PySDwh1I6U1LLy3rfmkGcWj/fK3JQYojvfTyThucfqvJRssOd2olIatrfUUNCL9lfzB2uIw8eNJ+/U4GpbLO7WdiZfMB4qVsoXYwcdeNyIdkMtc0yBkiFZ2tDEtp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779231; c=relaxed/simple;
	bh=PApck01QYV/Gm3ye6uMvwA27Rqmi2H7xw7efZ8WzdfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtnegNKTcbQEPMIJlVwQ8J/Tw4Vf56E9IQTbtw1GSmcBczn1EUXTNvjTr/lF/5ezMeaIdC+isQekZdGPp+a0f7tmMLB2imz0RE/9QRqGHKZeb4mTiiaKtg5+BxNqHTOuunkAe5/mdlw7IhjWqRO+XySO8Pf51pOM1cARoX2KUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIVwUz30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ED5C4CEDD;
	Fri,  4 Apr 2025 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743779229;
	bh=PApck01QYV/Gm3ye6uMvwA27Rqmi2H7xw7efZ8WzdfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIVwUz30QNkraC8Xbe2q5/YV+CRnzJXgiz5dfbAw/VNjgtceqvuhvaQfe/3Tu4/7W
	 7NX6rriinaFRtTk+uq5VcbmM8sd1ZYAHSt1dceBtZZxK+II7I1aeSAfrJvHW4Rapff
	 l13UNnkHR4aV+DryGxG2GXlzocwwzL/FSakfnwayYbDyhbOWqHk+PEos94TiVntBLj
	 fZPblxb4W1XZFj4wYrCL6eth6KPYjbhde+GGVPqNxZ+Zkj2D8TVOfrfxJduZZFd6Da
	 imfLRsiyftRIRtblv2qnh00VdRN/gg+jo1j/TngHM2gNDqKOVA3gl8ZyheRm7AybpZ
	 7e93sDPzqX4EA==
Date: Fri, 4 Apr 2025 17:07:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jic23@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, 
	robh@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	devicetree@vger.kernel.org, wbg@kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, olivier.moysan@foss.st.com
Subject: Re: [PATCH v4 5/8] pwm: stm32-lp: add support for stm32mp25
Message-ID: <biwwcmsjatsmjdsgeiz27rfukeidkz64nfxdtdajpfp7ace4j7@5d5b5mvfoy43>
References: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
 <20250314171451.3497789-6-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5sewg2xfq5x3bxnf"
Content-Disposition: inline
In-Reply-To: <20250314171451.3497789-6-fabrice.gasnier@foss.st.com>


--5sewg2xfq5x3bxnf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 5/8] pwm: stm32-lp: add support for stm32mp25
MIME-Version: 1.0

Hello,

On Fri, Mar 14, 2025 at 06:14:48PM +0100, Fabrice Gasnier wrote:
> Add support for STM32MP25 SoC. A new compatible has been added to the
> dt-bindings. It represents handle new features, registers and bits
> diversity.
> It isn't used currently in the driver, as matching is done by retrieving
> MFD parent data.
>=20
> New dedicated capture/compare channels has been added: e.g. a new compare
> register for channel 2. Some controls (polarity / cc channel enable) are
> handled in CCMR register on this new variant (instead of wavepol bit).
>=20
> So, Low-power timer can now have up to two PWM outputs. Use device data
> from the MFD parent to configure the number of PWM channels e.g. 'npwm'.
>=20
> Update current get_state() and apply() ops to support either:
> - one PWM channel (as on older revision, or LPTIM5 on STM32MP25)
> - two PWM channels (e.g. LPTIM1/2/3/4 on STM32MP25 that has the full
>   feature set)
> Introduce new routines to manage common prescaler, reload register and
> global enable bit.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

I didn't do an in-depth review, but the patch looks fine to me.
It's ok for me if Lee picks this up for v6.16-rc1, so:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--5sewg2xfq5x3bxnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfv9ZcACgkQj4D7WH0S
/k53Pwf/Zw3MFYpS7c/OdBkw9qirsB7YS6C3Y3MBc/vAYhYrhcxBpVevHbyFLsyW
yLhfba05+l6U2GOdtWltJUqVwzdVX8kt7J61y1jtQnRDTAExxJDwjTH+rfKSv7wO
3ZtQ9/BEO41/8sLLrZ8/eBxhG2SYgK4xBi46yR/b0Hx0/hGGPW82036L/xjxR3Cp
N5+q3kjLaDYxUIBGy/dJ5N500yM1fizFEK+ejjfR18yhcYR3bWXLoMGHsXSChnZw
3GnD89vE8w1ciehkBpbUWvjBXlFj0Qs+AUQmLAOBENriiX1OoH6+LI+qW9kqlef8
58L7lQyOAj2g1DyQ0B20iXRaCCxtCg==
=lIiW
-----END PGP SIGNATURE-----

--5sewg2xfq5x3bxnf--


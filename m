Return-Path: <linux-pwm+bounces-4396-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD27E9F6BDC
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 18:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2912816FD66
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73501F5426;
	Wed, 18 Dec 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwaxwWxb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B61148850;
	Wed, 18 Dec 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541534; cv=none; b=jSV6Ns0l1JrG+dNAsLBgJEjBWoWVhjkLCxRu5Odwa5gY20tCHv0EO7NNSf6ujLUY6C6yn7nw4g6bTzT2MaSJ3jGcwnyq4rlvxZKrUtkD3m9qMIbhqWPVdcg/mTu89yXPb153Cxk6UkRP4GsM8D0hU3JwiQrC0/eKo028fo0Gm2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541534; c=relaxed/simple;
	bh=vdCGcaMayzhDEz8c0LDs81VDSkOesnvIbxDPEyYGWXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU4No2CIsEWxG+3K1VQYOEguCUMyzG+GAfzd2x+BDY7MupwRcSf6Uz5MGDlkIVN5I6dJo2Suoo9DI0/RmnspuHOkOl9VrM4om4MLnkrG1pA7NlEFJj/ATdS4V0DEk2H67A5UbdtZvhpCvT768/LACWCaWCZ0X1TA4KYqZbS5Hio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwaxwWxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B563C4CECD;
	Wed, 18 Dec 2024 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541534;
	bh=vdCGcaMayzhDEz8c0LDs81VDSkOesnvIbxDPEyYGWXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwaxwWxbAZQkrVs7P4XNx3LVJhXjA7NCYHNRzFdn+0OamVDIUQNm3wptViBHeVAp9
	 vqeNlVy8ms4bU1UFGbYnqB3umTWeEOtqA/X3N8+EMyn24tylg087xQwKSrZ3JfwpHa
	 DOkF+gtazUmJLJir111SbohFjqlA1k6nfO6Urqwa33LiZgemwdhuc8uigS8nLxWY2I
	 DLeIKIsbERhGaqjHlMmDoFKcJnALw2YxuiCZgPk7liH+5wVB6Z6Cit3k1aAuHpO6Fw
	 fDQZ73alDWiSiUQB/qX+wd8kfPUodNrTk8mVp4qq3O9B7feZGpoSL9JhGoZDMMIzHD
	 5nA4/D3BgnX4A==
Date: Wed, 18 Dec 2024 17:05:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, alexandre.torgue@foss.st.com, wbg@kernel.org,
	jic23@kernel.org, ukleinek@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com
Subject: Re: [PATCH 1/9] dt-bindings: mfd: stm32-timers: add support for
 stm32mp25
Message-ID: <20241218-debating-campus-1d92c4fb5730@spud>
References: <20241218090153.742869-1-fabrice.gasnier@foss.st.com>
 <20241218090153.742869-2-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EoOWfOi1n9QKUU+q"
Content-Disposition: inline
In-Reply-To: <20241218090153.742869-2-fabrice.gasnier@foss.st.com>


--EoOWfOi1n9QKUU+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 10:01:45AM +0100, Fabrice Gasnier wrote:
> Add a new stm32mp25 compatible to stm32-timer dt-bindings in order to
> support the STM32MP25 SoC. Some features has been added or updated in
> the stm32-timer timer such as:
> - hardware configuration and identification registers to read the timer
>   version and capabilities (counter width, number of channels...)
> - dithering mode (can be used to extend PWM resolution)
> - input triggers list
> - new counter modes
> - various bit-field updates
> - power-domains property
> Timer trigger identifier can be up to 19 (from timer 20)
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--EoOWfOi1n9QKUU+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2MA2AAKCRB4tDGHoIJi
0vUcAQDHt1a291qOikCk+YbFAxxytC/jHrnDcNjqTbJpnfpkxwEA/WPnp/cnmyv9
ApGtO9lFz3BQAdvpCZ2662o9jnd3OAw=
=h9U4
-----END PGP SIGNATURE-----

--EoOWfOi1n9QKUU+q--


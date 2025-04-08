Return-Path: <linux-pwm+bounces-5372-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30AFA7F63B
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 09:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354B83ABF20
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 07:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C932620C4;
	Tue,  8 Apr 2025 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYMqVzz7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160310E0;
	Tue,  8 Apr 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097358; cv=none; b=pmthMnFJF4azMjzW5/192DE4GWBG3kh7na9JfoZTXAXRPDWMmSTrAY6Zzy7X0bql444oyVXHFS0LTVg3AOv1vGEA4bEf8FWhdD0m9hc2KXQZhCeLjcxOx0UqpBlPGLskgKLPAoPc4L5dmlS0jhM71bxXdTybGKufI4eJUU158sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097358; c=relaxed/simple;
	bh=5KWxthNPPcDTO+MOo+gfSsFp9HUzpKoAl7or2dZMyhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpNpXotqoqM0mLdmUgqhT0Ea4UVC7wApnVnkEH4NuNtpGsOTvBbMPPugbV9h7N889tk+aicJwJDqJKraIC3wRLVlOZanoOLYqAUhwltdO7DaWm2ZgGh9yAuyqZDysN7u2wFP75Gw8aAOIi1o998TIAr0KROedg1VeJ2ivK7C9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYMqVzz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BD1C4CEE9;
	Tue,  8 Apr 2025 07:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744097355;
	bh=5KWxthNPPcDTO+MOo+gfSsFp9HUzpKoAl7or2dZMyhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYMqVzz7xyhpqKDxDzAU99VUUh8JRVqi05tFNXeewA7pHGyOQmSl7pjydY6VJcfOJ
	 FfdHQvrCW4hD7CjL4IoqeFUu2ITH8xiANd4mGByWbYjJRcbwTAGQkKwIC9LE4WQbyu
	 IXnVuHsNQ/tZrWwc9Pad0tBxcGJ4S2NU6QKAbQI4xOD+cQR6i+lM2+MtuMvx+ViI1H
	 zIswq6+KCo6bAGEOVt0p9EpUNA1A+enSt+Mko1Z5NjvElccg5iT5S3LzpDnK5J7deB
	 daBbmvkaC+QwM9Y5Lrk7Y5+LIw/9lPEDObh7BSj9w3iYTLilnVNjRp9IdZqwCvv43K
	 l3q3jcY+yxjdQ==
Date: Tue, 8 Apr 2025 09:29:12 +0200
From: =?utf-8?Q?=22Uwe_Kleine-K=C3=B6nig=22?= <ukleinek@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: renesas,tpu: remove DoC
Message-ID: <72v3ymskrew3kvi2uzjoq2gewp7wnade75tjl4bfp7sw35h2ne@rfc5mygrgb2y>
References: <877c3vnq0k.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vfexy5i6yj7er6zv"
Content-Disposition: inline
In-Reply-To: <877c3vnq0k.wl-kuninori.morimoto.gx@renesas.com>


--vfexy5i6yj7er6zv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] dt-bindings: timer: renesas,tpu: remove DoC
MIME-Version: 1.0

Hello,

what is "DoC" in the Subject?

On Tue, Apr 08, 2025 at 06:09:15AM +0000, Kuninori Morimoto wrote:
> commit 1c4b5ecb7ea1 ("remove the h8300 architecture") removes Renesas TPU
> timer driver. Let's remove its Doc.

s/Doc/binding documentation/ ?

Best regards
Uwe

--vfexy5i6yj7er6zv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmf00EYACgkQj4D7WH0S
/k7cLwf/fXisWT5vgttCLvvHZpLyax2898y2iXRY0F9310TLJmUbbOsQj2GdRiV+
XWUqXZnbySRoFy9UFQVqRm9rxUT5cjuQMmd2Vt8Y1bJklwRknLbtw649eFStq1zI
qq9CWymTez95H2G8GvfOzhJoqvNbO2X7070CivGjx1F/VVRPsJOHG4rQVP6LMk52
PaUb+LI2BKHJelXDkcPrz9ZccMdgi8Kj25lfc5FMjQIScYG9MfFmDN6MWNsvmpI6
wyv39GFIrtN1dHPWl8Tp0VwZ5N/C0uItw13RCDcDOPs1eYvYmDvTUtGhsO+xh8nv
fd0tfzgFRSZmjzY8HnNGiCOkuEsfmg==
=cnQY
-----END PGP SIGNATURE-----

--vfexy5i6yj7er6zv--


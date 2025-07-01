Return-Path: <linux-pwm+bounces-6621-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183ACAEF14E
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 10:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FF5176773
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A127266B41;
	Tue,  1 Jul 2025 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0N1EdDj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476E1FDD;
	Tue,  1 Jul 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359067; cv=none; b=aaWU1rpviqDQQ3iROgpxL03d0lrFWpXJuZ/+Jc+h5uaS6JP+VKbIA8XPm3Fcjl/+9Jwdi3lXHnIJQ77F5VL7A5B2+8CvkdEVWxQkr4MdNovrdd+9jEwBNZoo6X4+RtW1DC0i3eETUQNtFwFkpLZKhyuuoze2a/Yo67MmZ2XPUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359067; c=relaxed/simple;
	bh=Fol+Onr6AX+6q8X/RzSabA3gh8+jqlmEX4hzJihL3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeohPDJol5fj2YZDZ/eC16HnHxUfxjGV9QmZAUfZQRL4j9MVq870s8VO5cZOPtHNUTdzwhq8OAubPImOdcuqhEfUYA747rAiFAUpLxcoHo4wYXDkoonf/zhX2fGKyB555P8gllqVXxAd0gEEjPEb9RwGfozUmbfV9ODfSZR2oTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0N1EdDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A007C4CEEB;
	Tue,  1 Jul 2025 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751359066;
	bh=Fol+Onr6AX+6q8X/RzSabA3gh8+jqlmEX4hzJihL3W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0N1EdDjz3lDGF5Gs+i05Q7cHJGLbYBse1LJAKuoPY68lYjUhRkFMKeIokrrRaqbW
	 YpZHyz4CJ8uKzjm+2eOJWZV4GjZrHER/KyGmZ1ddDOEPthNiVkSTDDWePD+kvfF3zZ
	 dcAz5StHgYQV3mxUKya2f52hEQG4LEwyY7Iv7yfdy5MCJ86Qfxk4aREE+tVoI9KylW
	 8YjunFF3aMDlaecPF5WPe3SZdANK5see5NUxsTrzYdxp85NecrWgBiJXg/QI98HF2Y
	 hVMQMJafOR5Rha547v7p5FeqHgKRIpad22dfjALzxtIIULQYnDk6rZMVW5hkeYKfty
	 Kr1odQXmh76Zw==
Date: Tue, 1 Jul 2025 10:37:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v6 03/20] mfd: adp5585: Enable oscilator during probe
Message-ID: <7lgjenjwbkf55ycxogibxvckcmqseq7auoaurvb7sih4nplyuw@xgh3v4qgwghe>
References: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
 <20250630-dev-adp5589-fw-v6-3-a0f392a0ba91@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ibhfvmpogrcuyehc"
Content-Disposition: inline
In-Reply-To: <20250630-dev-adp5589-fw-v6-3-a0f392a0ba91@analog.com>


--ibhfvmpogrcuyehc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 03/20] mfd: adp5585: Enable oscilator during probe
MIME-Version: 1.0

Hello,

just one comment that I saw while skimming over this series in my
mailbox:

$Subject ~= s/oscilator/oscillator/

Best regards
Uwe

--ibhfvmpogrcuyehc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhjnlUACgkQj4D7WH0S
/k6rugf/fAQpHtJXXJ+9liGajvF59VUtUco5aeDGq/SlLPu2XqMsQeYnNn62EsnQ
KEaVvnxpasvpOuLby1Ormf8dD+OkMb8FAF0syjtLeXGFm+YPdgMmnh8GPOr1x39Q
+gLCxVKqo/BfU9jYY+XfPyUYcHlh1US/A/2QCupYEARsVFRzFABXpguWL0+52LOi
5jSlu9pQA7k/4mjdTptImYEn3ZDaRtNjD7MgeL0Q+i7w1YonX1Os0e0OcjlwDVOF
vcdwlLr9LFnHxeZuXA8xOzS0GYYPQ7yxPWlqpcmSCcOk41CJHYQVMRr5rRPx4nbF
k5dBc4bjHjD43eUfoofFmrzPwP0llQ==
=2BbF
-----END PGP SIGNATURE-----

--ibhfvmpogrcuyehc--


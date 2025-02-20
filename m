Return-Path: <linux-pwm+bounces-4960-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AB3A3D5FB
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 11:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A7C3AE541
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9271EE7D3;
	Thu, 20 Feb 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aojsDVdI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605FA1E5B6F;
	Thu, 20 Feb 2025 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046087; cv=none; b=uVIeYgarnZKTpGte3ICgois7740zrC4OKS6HNddYZ1uB84wh9rTH2vEweYXqyP45ySyukohp3WCQTM07xXxwBaR8NscHe+Jx7f2Xs0yhwfEhpXHZF2uGaWDrPDTpziFPwNR1zD6I9LxApPgSQ8PpGttjZ3UlmCwuknal0uA7fFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046087; c=relaxed/simple;
	bh=7aYxpeFx/zXSVlZs4Nwq5L05WYs1pKMPdutN6w1FjNo=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=bGX+EdgW0zLF/OyfNKkWTzgDNE0ZKlw6SjPT0ntvTFgNErw9q3ynJ74uyh30aeJsE7YFUHwC6e/gs2vd+EFvb3hXvgBmuuXhAtTrXCklvZx82aH5xfzV/i3sZx4W3djyNHM9BComLFwPM50H/kFeVVPHNza5V8ow8B6NonGQ3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aojsDVdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4F8C4CED1;
	Thu, 20 Feb 2025 10:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740046085;
	bh=7aYxpeFx/zXSVlZs4Nwq5L05WYs1pKMPdutN6w1FjNo=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=aojsDVdILOygS2utXv123V9c8O9v4S1CvbTVJx8UiuNQs3d+fgyiy8plnewjGBMRZ
	 4xjEnmqs7ZiMfShxTUE2fdJsKqxiNkOFSsS00WFfDEOqd/O6j6Q7+qEMfMzyVd1Fil
	 SkuK0c0x2NrGbP7hzV4wcYL/mERo2j6sIy2BHsaofmFB4CaE13ooLox0Ow9coqsq+F
	 Eeqj663nSg4jeSZKjcDCzmV+BBl7KYfuIVvqXceuZSkN8G/6O7lj9Z9JBoyI6XSVjK
	 RmsvGJWvqMJGojCzWQMnfyvqrQlbuCagPCq2xXf3BUIDMou/1aq67evJbXd39lzsbC
	 fThwKYsZj8Olw==
Content-Type: multipart/signed;
 boundary=58feea78e480b05d4ea244c42e5a507b481f8c5676e1bb90d305279d625a;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 20 Feb 2025 11:08:01 +0100
Message-Id: <D7X6UUIR6FBY.2CAEK4V6YOHEM@kernel.org>
Subject: Re: [PATCH v2 07/15] gpio: regmap: use value returning setters
Cc: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, "Bartosz Golaszewski"
 <bartosz.golaszewski@linaro.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Bamvor Jian Zhang" <bamv2005@gmail.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, "Keerthy"
 <j-keerthy@ti.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
X-Mailer: aerc 0.16.0
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
 <20250220-gpio-set-retval-v2-7-bc4cfd38dae3@linaro.org>
In-Reply-To: <20250220-gpio-set-retval-v2-7-bc4cfd38dae3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

--58feea78e480b05d4ea244c42e5a507b481f8c5676e1bb90d305279d625a
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Feb 20, 2025 at 10:57 AM CET, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has additional variants of the set(_multiple)
> driver callbacks that return an integer to indicate success or failure.
> Convert the driver to using them.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

--58feea78e480b05d4ea244c42e5a507b481f8c5676e1bb90d305279d625a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ7b/AhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jUtgGAvgzFeiyP4H+lQUSX84x8HebLiOxDtgdR
dIeEV/y68ek6vWJfv/6HrG6KgmBiW/FnAYDXKNY3A/excX0C+g4yyyrhAbGjMGAl
2IGEAbcBVMciMJL3KUMCmvWuHiveGRVjYsU=
=Qql6
-----END PGP SIGNATURE-----

--58feea78e480b05d4ea244c42e5a507b481f8c5676e1bb90d305279d625a--


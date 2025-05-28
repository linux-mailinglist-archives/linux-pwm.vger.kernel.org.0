Return-Path: <linux-pwm+bounces-6164-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D89EAC66DF
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 12:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572164A1A60
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B986324467C;
	Wed, 28 May 2025 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4QFFQUI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B3214A9E;
	Wed, 28 May 2025 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748427708; cv=none; b=V3fznS8Ps7OlB6t73dsWXHuFfJkrKhjL/RKck4bV1zCYAMyJownL4ruxLfGFGYpKwKYd8HFsPWZg+nWzv0KuozVmxLvvA3S/1fe/CqMRz4mPPAoFMZyxPWa3gQpx0TnWVPNewCNMqf65GiH8IwO7DKe2CRjybqiIWc4XCUhRvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748427708; c=relaxed/simple;
	bh=MarkZ8utDfJEEqG+ZwLpK8d+OC45TaBkZgBFc7qet+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwYkyneQnV4KzQW1mIqD4RSWAsbX2IHZpbYNz0W+FxSGIYRiX8p92RvjyOrP9h+bBrV9RnrP8aUDvGxBkgt4LRLtPcVXU2fCn0bIGlsgY6VDMRLe2Ko+Mf/0/CsrOXlm/AF4IOuDT7pfPVCOWjKUuWiJzCAo8LjU6O4D/UFzqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4QFFQUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626A6C4CEEB;
	Wed, 28 May 2025 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748427708;
	bh=MarkZ8utDfJEEqG+ZwLpK8d+OC45TaBkZgBFc7qet+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4QFFQUIcZimiPD3SX9jXdRRX77wR2TsQWYRGBAm7B+x66WD6mXbTPY8CFWaatNzT
	 BHpRSl9D0m0FV3dyChup6xal++HQlK+ocxtllMOk59zPyM1hOM43W45usPV/a1cF15
	 hqroARrL1RjBAtB8rh/GjU3BNsCaSW7Ozrpg3opRCsOtJEpuffjm413yrnP5/HeANG
	 Wpw0cqfAbUqjZ10TiqhukNRnJPqjA387wshfZqS4ipF3XJOSA9LSYIKkWHLOL4wgqI
	 CP7gtUj2HsLSfbQ92/w4Ckam3mMIwyeNIY1f6UzHUl6nk1Sdj130C9sV/AusB0V8Tp
	 ZucM4V6myOcTg==
Date: Wed, 28 May 2025 12:21:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nylon Chen <nylon.chen@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, paul.walmsley@sifive.com, samuel.holland@sifive.com
Subject: Re: [PATCH v14 0/5] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <crcfskukqifse6gqrydx2iezargv5frv6dguj3iqdkfm7xxbqh@4v2dvo4zcmbz>
References: <20250509095234.643890-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q3beuwyz772xtchz"
Content-Disposition: inline
In-Reply-To: <20250509095234.643890-1-nylon.chen@sifive.com>


--q3beuwyz772xtchz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 0/5] Change PWM-controlled LED pin active mode and
 algorithm
MIME-Version: 1.0

Hello,

patches 1 and 2 ideally go in together, right? @Conor, does your Ack
mean that you're OK with me taking the dts change via my pwm tree?

On Fri, May 09, 2025 at 05:52:29PM +0800, Nylon Chen wrote:
> Nylon Chen (5):
>   riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's
>     active-low properties
>   pwm: sifive: change the PWM algorithm
>   pwm: sifive: Fix the error in the idempotent test within the
>     pwm_apply_state_debug function
>   pwm: sifive: Fix rounding issues in apply and get_state functions
>   pwm: sifive: clarify inverted compare logic in comments

The objective of patches #3 and #4 is the same, right? Both prevent that
=2Eapply =E2=88=98 .get_state is idempotent, right?

And I'd also squash patches #2 and #5 to have the comments updated
together with the respective code changes.

I think the algorithm implemented in this driver is more complicated
than it should be, but this is not this series's fault, so I tend to
apply it with the above mentioned squashes.

Best regards
Uwe

--q3beuwyz772xtchz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg247UACgkQj4D7WH0S
/k6YPwf8CPS53gGarqxZhus1KnVvEiNi//eZnxRpZNoAwKCuMXf3nZ87lDGFDOpr
ZafvQskHAPQK6E5WffbH33HJyr+8sFLhHWPFLWBmpHbi4pNdUDYfYWPhgwcU0roH
j3J0ihE2ysD3hq8AnYFjM/O5wqZDkXQQ+Qgk1XUuLp3SywIQDYmsVt5+Gqy7LXRd
BcYv7fWURROIeLL4XnKEZghjYDJUXIk50ue3UYqeYDv6jhWdoJOn6Acc7KdUXDYQ
hO99harJgO772boFRxa7+c9edXfNpCHzeVMFJbqoqvWu8msq7SpvZqJKz1aUQOMN
EPaRoaY8tdFY4qPbwrka8VfubM395A==
=dm+D
-----END PGP SIGNATURE-----

--q3beuwyz772xtchz--


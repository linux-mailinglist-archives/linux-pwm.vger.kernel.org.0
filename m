Return-Path: <linux-pwm+bounces-6195-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F7AC91DB
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFFE3AF863
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAD4230D1E;
	Fri, 30 May 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUv9Ilhm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5D186284;
	Fri, 30 May 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616702; cv=none; b=mvYpJnQEtO4lSE/dnND0kwB2o+NOx/eZj5vohzrTBgWG4566rsDAjVkua5KtqisZN3i+BbTQXNnQuq2Pqbl4UHkVpYXDp9/VbjGU+7ZnTmoVdl9urUDCLEyif+IBXsish3TbAf107UYUBCILkoQ02TYen4urkL6y//dORvrgT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616702; c=relaxed/simple;
	bh=YUVxmlvmDsTTQBrqHZZvodbvDIfS5ELujSc15JpoURQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl658szTVA5iug4KANQXYaOmmaiegdt9Idbqkxzgb+Yloe36AvQxPka4SAUp+kK03DFwEjALA5kTEXcpGyqWyl9Ks/D6GtvGsMB8lwd44oxp3Zsh7ZAvLz6YYPBrZBpMn3WGqZ9+OSK8mHkmKZwZqIro2I3aF+MCUz4oTMdJHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUv9Ilhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD99C4CEE9;
	Fri, 30 May 2025 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748616702;
	bh=YUVxmlvmDsTTQBrqHZZvodbvDIfS5ELujSc15JpoURQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUv9IlhmyLZafr0OwzIxVzfFT2RlP8qNYB6ZemazQaN9wWQV3WOXA4tj9Yh6brOxr
	 28z68kK1Yhn7vq5oCAICTC+ZUw1prw2tmW9u/JceQIRWALuFpm3hFg2JlJWedHDEzf
	 TxeLUhagPvDSnVeVrQkYTx2eulerMhMmEhl6sCR+3CnQDtIYYlyx4hdMNGI16gRb2E
	 yP/5XCO9NABPGQZPnC9++ZTuJNj0uA+3n/iUYpLhPqKLhBogdDGPqWIxxczhq183Fx
	 FZcQU2/QRzUgea3gfRiHJ3YSwYjqyJlzB+p9swn2PGlOUIY32908jsC4pOXBJWEVar
	 se4n6DdOc8OIw==
Date: Fri, 30 May 2025 16:51:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 3/3] pwm: sophgo: add driver for SG2044
Message-ID: <el33us4hbjl2e3o4zsnbtfhjlry6bujgrdq6jdj3zq6b6yn3ao@lxmcia3ysttf>
References: <20250528101139.28702-1-looong.bin@gmail.com>
 <20250528101139.28702-4-looong.bin@gmail.com>
 <azf5lzfkegr6wt3mratxra2mlfah45dc3comtkjbrbdzf4x5xc@tlzxp7oqtcfl>
 <oo3pevzuyhrsf7t2ja7mxytaxhnthfar73iwvqxgawr5gjiudf@hbevzjog7akj>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j7ixwxshhas4xuxd"
Content-Disposition: inline
In-Reply-To: <oo3pevzuyhrsf7t2ja7mxytaxhnthfar73iwvqxgawr5gjiudf@hbevzjog7akj>


--j7ixwxshhas4xuxd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 3/3] pwm: sophgo: add driver for SG2044
MIME-Version: 1.0

Hello,

On Fri, May 30, 2025 at 05:48:27PM +0800, Longbin Li wrote:
> Thanks, it's ok to go.

Great, pushed out to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-nexxt

as 6.17-rc1 material with the changes mentioned earlier. If you don't
agree to a change I did there, please tell me.

Best regards
Uwe

--j7ixwxshhas4xuxd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg5xfgACgkQj4D7WH0S
/k5srAgAhbX8qLIToQ+QZkTJMqqqQcE5IHOSXM+GQUnkylpXSDwcg/fC2hEHl1+p
cXvGBd/nGPc1+Eewe2HjxG+ghQ408jregwS3QiqGqSaau7FhUU4AN1XC6GFR7QEr
WHQ+7zJ5KdT2xGAtFRjlGAPCWkhOKQPV02nn7M0GQaUI89IDgHpb9XkP9glH1qJd
KBBjD8lqI2pPBptRtCkModmgynQDQhNE/GpNegQZAkO3m0vN/NL9pTSFfs9cMHBU
Cz3OeGLF2kxooemevn8hJx8TIm669P+cmcESVBJtmUxb4h341HOdHkp/YIhG7sGF
tWqcQ3178t688NepvCjh0zlDgymu0Q==
=5Epk
-----END PGP SIGNATURE-----

--j7ixwxshhas4xuxd--


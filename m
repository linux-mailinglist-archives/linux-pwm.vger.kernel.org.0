Return-Path: <linux-pwm+bounces-7747-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B0C9805C
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 16:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24103A4970
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EA032AAA9;
	Mon,  1 Dec 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZEK9ZWK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8E329E6E;
	Mon,  1 Dec 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602462; cv=none; b=MoXB30aGz0EItjp2uMvdhCH03BA8FATVCTCpWNlguYzhOHJEK/AlabGt5Cs80hf9M9lmBk36ucB0c2r8BFb/Hp0sfmAejR+okgw2aYttFxupMEK5XgL2jmYeKqgP5Lt/nvldIaVWsioPrEHpH/M0D/WsOgOmLrvDRndtrWYAXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602462; c=relaxed/simple;
	bh=GtGmDX/AhMSuhiKJVzfPEcFDYyXwcQo7/YcDqwnHlzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMMpeU1CgxeR70dYlaAZ1Bw+SmEsEuQ0jh5HMaPcPvkXhmlvxvvNPABeyl01P21gTcWuStFbFljNbG5ywns0UiMDCvoQx4fhtW/6YQx44p3V56gJknNpPpI3f68ICjbIElci8UvIE15uf747eHQuXga8rsYJboUX70qu/K3FJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZEK9ZWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B962DC4CEF1;
	Mon,  1 Dec 2025 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764602461;
	bh=GtGmDX/AhMSuhiKJVzfPEcFDYyXwcQo7/YcDqwnHlzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZEK9ZWKk/GAS8Coktmt1tPWsi0PLBEftcXDUJJ9SqfIV8XXJYlB5LpL9peuH1QVY
	 d7BGdSBieGVdP45eEvWS/BujkT4t6+e4KOs669pTArdJCYo2qcQKZ9GzBk4cDUFw1Q
	 6C6u333t+1cxDBRZAaETq47U0HLHKIj2hTEg5qEONt4KVxdV95VUL0ctK31XiF53ij
	 0+0cCsg5c2TPlO7MhEDWvLDjBtL5YWyPYWg8HZx5EzkzlSWmoMEgTJqTtvdii1QJQR
	 wzYO0v7TR6P0bvcC2K/BOYMf3x9SGsE0neCQKNHByxn5NM3hOJyqUbuDRF3xhw4M9y
	 7OsNsCpVHhb0g==
Date: Mon, 1 Dec 2025 16:20:58 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 0/8] Add RZ/G3E GPT support
Message-ID: <vbqsrlqyzd2hhg3qhbpuw4h3tfigpf5vv5yfqoxyad7b5657sy@4opkalytc3kv>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pviclmaqrxg2pdad"
Content-Disposition: inline
In-Reply-To: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>


--pviclmaqrxg2pdad
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/8] Add RZ/G3E GPT support
MIME-Version: 1.0

Hello Biju,

On Tue, Sep 23, 2025 at 03:45:04PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add RZ/G3E GPT support. It has multiple clocks and resets compared to
> RZ/G2L. Also prescale field width and factor for calculating prescale
> are different.
>=20
> This patch series depend upon[1]
>=20
> [1]
> https://lore.kernel.org/all/20250915163637.3572-1-biju.das.jz@bp.renesas.=
com/
>=20
> v2->v3:
>  * Added Rb tag from Rob for bindings patch
>  * Dropped wave form callback conversion from this patch series as
>    it is covered in another series[1]
>  * Added suspend/resume support.
> v1->v2:
>  * Created separate document for RZ/G3E GPT.
>  * Updated commit header and description for binding patch.
>  * Added waveform callback conversion to this series.
>  * Collected tag.
>  * Added link to hardware manual
>  * Updated limitation section in driver patch.
>=20
> Biju Das (8):
>   dt-bindings: pwm: Document RZ/G3E GPT support
>   pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
>   pwm: rzg2l-gpt: Add prescale_pow_of_two_mult_factor variable to struct
>     rzg2l_gpt_info
>   pwm: rzg2l-gpt: Add calculate_prescale() callback to struct
>     rzg2l_gpt_info
>   pwm: rzg2l-gpt: Add RZ/G3E support
>   pwm: rzg2l-gpt: Add suspend/resume support
>   arm64: dts: renesas: r9a09g047: Add GPT nodes
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable GPT on carrier board
>=20
>  .../bindings/pwm/renesas,rzg3e-gpt.yaml       | 323 ++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 184 ++++++++++
>  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  13 +
>  drivers/pwm/pwm-rzg2l-gpt.c                   | 209 ++++++++++--
>  4 files changed, 704 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg3e-g=
pt.yaml
>=20
>=20
> base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1

I don't know what you did here, but applying your series doesn't work:

	uwe@monoceros:~/gsrc/linux$ b4 am -3 20250923144524.191892-1-biju.das.jz@b=
p.renesas.com
	Analyzing 19 messages in the thread
	Analyzing 27 code-review messages
	Checking attestation on all messages, may take a moment...
	---
	  =E2=9C=97 [PATCH v3 1/8] dt-bindings: pwm: Document RZ/G3E GPT support
	  =E2=9C=97 [PATCH v3 2/8] pwm: rzg2l-gpt: Add info variable to struct rzg=
2l_gpt_chip
	  =E2=9C=97 [PATCH v3 3/8] pwm: rzg2l-gpt: Add prescale_pow_of_two_mult_fa=
ctor variable to struct rzg2l_gpt_info
	  =E2=9C=97 [PATCH v3 4/8] pwm: rzg2l-gpt: Add calculate_prescale() callba=
ck to struct rzg2l_gpt_info
	  =E2=9C=97 [PATCH v3 5/8] pwm: rzg2l-gpt: Add RZ/G3E support
	  =E2=9C=97 [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
	  =E2=9C=97 [PATCH v3 7/8] arm64: dts: renesas: r9a09g047: Add GPT nodes
	    + Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
	  =E2=9C=97 [PATCH v3 8/8] arm64: dts: renesas: r9a09g047e57-smarc: Enable=
 GPT on carrier board
	  ---
	  =E2=9C=97 BADSIG: DKIM/gmail.com
	---
	Total patches: 8
	Preparing fake-am for v3: Add RZ/G3E GPT support
	ERROR: Could not fake-am version v3
	---
	Cover: ./v3_20250923_biju_das_au_add_rz_g3e_gpt_support.cover
	 Link: https://patch.msgid.link/20250923144524.191892-1-biju.das.jz@bp.ren=
esas.com
	 Base: using specified base-commit bf2602a3cb2381fb1a04bf1c39a290518d2538d1
	       git checkout -b v3_20250923_biju_das_au_gmail_com bf2602a3cb2381fb1=
a04bf1c39a290518d2538d1
	       git am -3 ./v3_20250923_biju_das_au_add_rz_g3e_gpt_support.mbx

	uwe@monoceros:~/gsrc/linux$ git checkout bf2602a3cb2381fb1a04bf1c39a290518=
d2538d1
	Previous HEAD position was ...
	HEAD is now at bf2602a3cb23 Add linux-next specific files for 20250922

	uwe@monoceros:~/gsrc/linux$ git am -3 ./v3_20250923_biju_das_au_add_rz_g3e=
_gpt_support.mbx
	Applying: dt-bindings: pwm: Document RZ/G3E GPT support
	Applying: pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
	error: sha1 information is lacking or useless (drivers/pwm/pwm-rzg2l-gpt.c=
).
	error: could not build fake ancestor
	Patch failed at 0002 pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt=
_chip
	hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
	hint: When you have resolved this problem, run "git am --continue".
	hint: If you prefer to skip this patch, run "git am --skip" instead.
	hint: To restore the original branch and stop patching, run "git am --abor=
t".
	hint: Disable this message with "git config advice.mergeConflict false"

I don't feel like debugging that, which unfortunately means I cannot
provide you a diff on top of your tree to explain my doubts about the
resume callback. :-(

Best regards
Uwe

--pviclmaqrxg2pdad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmktslgACgkQj4D7WH0S
/k5uGAgAudLS8v065D9Xt+vJPjMyP4WKVupIE9LTMeT8/TaAMRra9UYtHljDzUft
3FdA03MGwGypwF9Dwb1u1V5onJJJa6gNFvcbgEvWRv+lelvSLHGyqPsvw/sNdiXP
EalhH1oU9KxlfjDbkejk2L4J8e1Mo+M0Virz5Fgd28NKvf7Bj5xwZZ+wd5ZHCSpD
n3SBC1dG84bRR1d2UDFSOZD1+fksXvyVguFD3eKY4e1cgbK4bgBuKuqP772cMzh3
AnTceJJ27GHQrY2FALfvxOfllb7Szfp+5t4ZE12Zq2w6htY7rm6PAVqdC+y2wIUP
jap8rn0uZ8xxx2fMZSbsXnYV8qG19w==
=sRyU
-----END PGP SIGNATURE-----

--pviclmaqrxg2pdad--


Return-Path: <linux-pwm+bounces-7607-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD1DC489D3
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 19:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E060E3A55D3
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281B32E62C4;
	Mon, 10 Nov 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHjgQXbi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A17242925;
	Mon, 10 Nov 2025 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799788; cv=none; b=VGyhPOKqXewDbljNCDIKAIuCuzfVYF+ZBMMqualfwykAH2798XVQT8oung++V2efaCtUQL9rLs6OYusOVtMKQ3EqN3tQYM5+WAZr+Pv82Jkrkkye0ZSy3GPRX94v0DF2yCCeMUqqb+EiKlgVTahOcgtRDWEB7LyhTwTXvbJMcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799788; c=relaxed/simple;
	bh=X2UMR+ek8t4dC9FVAihJ8te21o4CcIV3uaXVHjtVgcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aChs30n3E2AhK+AAntc/VWrGXRy2Bgs8f1eKOfqlHUH/hifohQ47C8Jp8rYE+7XPfFDNDyOY0lIjPAU9VSTfDwYSZnFD9Y0e3q1qYlAJsQKPfvyrMOaw9iS9SHOjlEdDc5yoqyQdZZUFNLqS0Me4vk6PSx2k/yk69RSEduBSI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHjgQXbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6263C116B1;
	Mon, 10 Nov 2025 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799787;
	bh=X2UMR+ek8t4dC9FVAihJ8te21o4CcIV3uaXVHjtVgcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHjgQXbiAMJaLpbNPCzTNjHjQvoLTAlkmWF++9regAa9FjAr6Zu6vqf7TY/j0EJTl
	 iGiOQpzp0AnQMKNXY6qj+2KPgHeiceemXV8Up9jDQe3GfrfYsaKWN7Og/6TUQKFFrR
	 C7JuU/vC5nfFRY7jnEH202SPLeFN0sbaCwwbC8F5O8VdLzL5g1lRhOsf3hu2IBsoNw
	 ZkQQKXckpe7gyO/9uUQlZm9s1pZ34252/byXsxLdczV5Ez1OCWBgCDiZQSROTnPTJy
	 fooEUE8E7vlmmo4H/j+LtSMMPVe6N0WoC4iyEN7g8v6OlCm26TbVtzCmU359R2ixV/
	 pwCqNZMVW0Akw==
Date: Mon, 10 Nov 2025 19:36:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Baruch Siach <baruch@tkos.co.il>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>, 
	Baruch Siach <baruch.siach@siklu.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v18 1/6] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <tqbdvt2yj2e7ycxiu7nlvwgeh4cf7em6n7gia7cd4f7lsqjdeg@ksyfpy63laop>
References: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
 <20251029-ipq-pwm-v18-1-edbef8efbb8e@outlook.com>
 <gkvbziqeae53bunqd556r4swaye4s4lcnwthryouynwfwqrnsi@6o4cjgxiwxco>
 <lkbwgakmqknqptsjrb7hvxv3bxi3fo62vml7tmf4avo7nr7cue@dwsovmchu2pp>
 <DS7PR19MB88832537DA9998530BAAC9C39DCEA@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s5dbfl4angh7vjuo"
Content-Disposition: inline
In-Reply-To: <DS7PR19MB88832537DA9998530BAAC9C39DCEA@DS7PR19MB8883.namprd19.prod.outlook.com>


--s5dbfl4angh7vjuo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v18 1/6] dt-bindings: pwm: add IPQ6018 binding
MIME-Version: 1.0

Hello George,

On Mon, Nov 10, 2025 at 03:41:49PM +0400, George Moussalem wrote:
> On 11/10/25 15:32, Uwe Kleine-K=F6nig wrote:
> >>> +  "#pwm-cells":
> >>> +    const: 2
> >=20
> > Please use 3 here.
>=20
> The driver doesn't support polarity and I don't know whether the HW even
> supports it. Hence, I kept it as 2 as originally submitted by qcom
> (Devi). I don't have access to the datasheets. Would you like me to
> resubmit a new version anyways or keep as is?

I want all new drivers use 3 pwm-cells for consistency even if the
hardware doesn't support the (currently) only flag. Additionally this
simplifies things like pwm nexus nodes (see
e71e46a6f19c46b38983bebde8bfac1c04968fdf).

So yes, please change to 3.

Best regards
Uwe

--s5dbfl4angh7vjuo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkSMKMACgkQj4D7WH0S
/k6MvwgAmAv345GS0OBmiRO1V+Um4ZZv+MMGog8wAp4dG4wNqRSfg+bJcDwN/11Z
4yRhFo26C4hVPPs5JYHOx178k2EwvOtphK1flrb9r91w+24ySpvPDHhOzbOlk91M
sVhXrVXHAUaVxZS+2lbyqXzWptistZhDfLGMso0s1M20vVYsmdMJkF7Z0N5OSzhW
qplkJltikAmqaqYr8SPAVbH/a0mtPKProR/WPrV64gf9PFo6LwIpD9julJiJLlMB
Ke//T2lvmH3YJwOov7UfszhXp7+TA8yKhwmxePPGcag7JIycFKsanR04XwvpB6JQ
ADIY4Fd/OKtJZVbiAUf27scd1cMV0g==
=XKuc
-----END PGP SIGNATURE-----

--s5dbfl4angh7vjuo--


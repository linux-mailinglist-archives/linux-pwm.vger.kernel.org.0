Return-Path: <linux-pwm+bounces-5690-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E99EA9ADDE
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 14:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0101B6323C
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3570223DEE;
	Thu, 24 Apr 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ub27Ape0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF482701AA;
	Thu, 24 Apr 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498900; cv=none; b=ir9MXaNo0TXMeBpzEWP7k9I2QnpEXeopQhAea+GSSaZGqbp1q6IWZV8vBnIoTvjcgOWqRpkbBpDK94XYOtbhNZdyjqtKgrxsJYjv0/iL0x73i89jDHGvYelYe8W587jq3Wd3tM5vmxaLYsY3dHWUXKGAdlp0Y0BHQ6Hw+mZytKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498900; c=relaxed/simple;
	bh=ZyGzDPVkf3UyTDfF9skRIcbVvkbOFEY5W64LlARR1qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI9JHVXXeMt4AsR5NpNUGliVgOHqIaSDNYNFSVIEIJQmgJgOGKAqjVGmx5Px1P/OMU7HBIXL9zDDIBHGM87gGK4pZAG/0oUZZc2pkYmWORArUAeVlfbwqAz1ElKPd2OSsbyn6VnOMMy6xe9oKZlSiKxVRrbNXRsMfcYOu545GDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ub27Ape0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F40C4CEE3;
	Thu, 24 Apr 2025 12:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745498899;
	bh=ZyGzDPVkf3UyTDfF9skRIcbVvkbOFEY5W64LlARR1qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ub27Ape0NQbpr7gqj98cAhVIIiVvy4ptD4xnBSv5Gls8QHA3t0TQfFW9I+1MB4QL+
	 c3NdQePo2dTPp7S9BjOte4spLp/8JkqBfKUKBjXd51OT9x2TZz00cx0R3uuqb5ryp5
	 e4z2+kSOpWC0Fr/CbL/S7KUXKZZ7YgrzitBplayrYcZcKmKVfsMU2DeVZo7bUAl4b0
	 nHunG+zTc1k4VDONEORWLx8hj6RdqKlDVD0PZZ1sbgc+qxM+aBDypbX79xBO50rh2I
	 imt3nXAOJcM7HiDXvstdgp9VCoT23QmltmebO4I03okRzK4i1Wz4ZZxMrOp0wDDx+v
	 B9WbhOLVrPqqg==
Date: Thu, 24 Apr 2025 14:48:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: vt8500-pwm: Convert to YAML
Message-ID: <aokv26x67eu3fhkcrtdo4suoz2lryb5x5u4m4xeycwlpgt4njs@7idth75voi4y>
References: <20250418-via_pwm_binding-v2-1-17545f4d719e@gmail.com>
 <yscledgclp2v4p7djwrszbc3dnqifkcofky7rugkcip7o2rmof@xljfd2kfyzzs>
 <CABjd4YxK+4kEeS_tKBi9zhj85y6U1Dgi3nJNuQ8hfkeoY+iK1w@mail.gmail.com>
 <eydewrcn4tviu6fbqmmvhoc2zao3uzrxwwlc55tuxuhfrexk5k@7xg5fdeu7wun>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eqirucv27yhzqwfa"
Content-Disposition: inline
In-Reply-To: <eydewrcn4tviu6fbqmmvhoc2zao3uzrxwwlc55tuxuhfrexk5k@7xg5fdeu7wun>


--eqirucv27yhzqwfa
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: pwm: vt8500-pwm: Convert to YAML
MIME-Version: 1.0

On Thu, Apr 24, 2025 at 02:32:33PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Nevertheless I'll play a bit with patatt and your key.

FTR, it wasn't complicated:

	$ keyringdir=3D~/.local/share/patatt/public
	$ mkdir "$keyringdir"
	$ git config --global set --append patatt.keyringsrc "$keyringsrc"
	$ mkdir -p "$keyringdir/ed25519/gmail.com/alchark
	$ echo "ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=3D" > "$keyringdir/ed2=
5519/gmail.com/alchark/20250416"

After that `b4 am` told me:

	=E2=9C=93 Signed: ed25519/alchark@gmail.com

for your patch \o/

Best regards
Uwe

--eqirucv27yhzqwfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgKMw4ACgkQj4D7WH0S
/k5qzQgAseTbJVJaProlfqJPevpOIh4z5WhUUKLHvnLH8q7VWBPtuUsN/r+EYbrf
4qLaUawPwuqqlgGGvN9GS7AzeYm0UBJK3aJsIHmjhGEwalDo+eHmW6bOjW3XmgKy
3fncC/xX8zYsX9jrv0jXmwWftkT4314XGLIccB+ZBogMidpCjxmNYsbfd3XXax4C
BqU6klCntKrHHYpPiQ9/qPEROEj12eceuSuu2dlyTkTkMAX2JZYpVYSJMINa5kGx
3kvLt0h3A0x8RqC8itS4rd3DW8/z5zpyaQpRWu4dfx/i1M5nVP2qLV+on4KgcDg9
faofmGB4Qiub7gjlRKoo0B1WvX0EHg==
=CnFZ
-----END PGP SIGNATURE-----

--eqirucv27yhzqwfa--


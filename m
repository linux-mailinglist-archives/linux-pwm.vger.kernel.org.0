Return-Path: <linux-pwm+bounces-5060-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 662DBA4D3E7
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 07:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A2D170548
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 06:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87F81F540F;
	Tue,  4 Mar 2025 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRqWU0f4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342DAD24;
	Tue,  4 Mar 2025 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069790; cv=none; b=lgEhT4nXQf9TfdfHRS2tuQ8v24+19A6LYI19Qnl6ey+nuTraakQQlHi4NhctfVu7ES+YcLd2OYFWBdSwokelT63gJNklhRGjKqpZHhiV7FBKclNq+EvvI2C6uvf7a6kYc2mpYysUYoVJn8ek/RBk4TRGWVl0OJqOaL05cPUUm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069790; c=relaxed/simple;
	bh=ggeUjaz+1iBUN10GhZtvDVxPTZOliFQ1v5Q5mAMLo/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIDLfxyntAQD1q7inpMhuw/kBUQvZVM8f/SwfJ53xT8wapO1kylBjfJIboYGOUS+r/R72L0AiA/Q6cnivo8+Q8rc8Io016xbn5W8HyEkUpm+VuD80bzbGwpU60yF8tIkrIcl+rke47wx05rSYTto6oy8Y0/73/hnSeCBL/0vZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRqWU0f4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F0CC4CEE5;
	Tue,  4 Mar 2025 06:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741069790;
	bh=ggeUjaz+1iBUN10GhZtvDVxPTZOliFQ1v5Q5mAMLo/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRqWU0f40+vX/3qLiRp+fX4HkYMIC3axTzw8LfE7ecIyHw7RNbuThDfL9MVIfqC5+
	 zDCLrv08jtMuRpeQr/IbcMuTIdPlLLyGZd8cxRe8ttYLXPNbIB3/iHSdnBlgokitrk
	 0hRI1Wq5hDJzvN2CrFEE38qRZSG0jQaQCosM2orxnRUvmwolzcuw8A6A2lNmSGRR6B
	 DWMrEjUuvHcMkRug/mdZTl2Ycez3mBW0CGo+Wg8TvtSlnjzOpkMGO+4b6ezuLJ3rMU
	 pokHCPC228ckbP9hZpgVWuxwNr02jE5NW77UOjmU31oHmof8iK1Xl178qZA8+eRx2X
	 +R+TRQPPThqpQ==
Date: Tue, 4 Mar 2025 07:29:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, Kamal Wadhwa <quic_kamalw@quicinc.com>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] leds: rgb: leds-qcom-lpg: PWM fixes
Message-ID: <lvi75asit3ati7wwnyae6rowycr3veodswu7blbnzbrq646fgi@iksn4qas3dwt>
References: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvccdsaewx7hrkb2"
Content-Disposition: inline
In-Reply-To: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>


--wvccdsaewx7hrkb2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/3] leds: rgb: leds-qcom-lpg: PWM fixes
MIME-Version: 1.0

Hello,

On Mon, Mar 03, 2025 at 01:52:49PM +0200, Abel Vesa wrote:
> The PWM allow configuring the PWM resolution from 8 bits PWM
> values up to 15 bits values, for the Hi-Res PWMs, and then either
> 6-bit or 9-bit for the normal PWMs. The current implementation loops
> through all possible resolutions (PWM sizes), for the PWM subtype, on top
> of the already existing process of determining the prediv, exponent and
> refclk.
>=20
> The first and second issues are related to capping the computed PWM
> value.

I just took a very quick look. I'd say squash the first and second patch
into a single one. Splitting a change that fixes the same issue in the
two branches of an if condition has no benefit.

Other than that this patch set would also benefit from what I wrote in
the review of the other patch you send: Please mention a request where
the result becomes wrong. This considerably simplifies understanding
your changes.

Thanks
Uwe

--wvccdsaewx7hrkb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfGndgACgkQj4D7WH0S
/k4E8Af0C/TTFiq7Pc0P9DdnyFVSFKtNouYJp/xbeFThs1fZ6N38gID8m7D8zOrq
WYCHqvZWKXsw+XtrOfdq1QopMatI85dcIj6XvX8m7xk8IWGuDWvCUNcPsPVu224V
dQd7N7KWFmoOTWoxHVMVq9TJlwF/C59vwUxZ+HFqk7mlkiBuXfhbFHftoYSlNMu5
OHDsabnXIeeUKZznXtWQULT8T3XSZgqaTLZf+WIbe+UiQQ7+qakesiX5YG4NE9Ty
FKf67YaOBHccLmnfNZYsRQ+SZx641sEI1HdAmxXWaTTs7hzohodTNa4qboRndbcM
UduqTj8i59OeCAInoCvyJ+ZG++r7
=vAjc
-----END PGP SIGNATURE-----

--wvccdsaewx7hrkb2--


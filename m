Return-Path: <linux-pwm+bounces-7982-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGvSDsyrcGkgZAAAu9opvQ
	(envelope-from <linux-pwm+bounces-7982-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 11:34:52 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA1955476
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 11:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72E3C62814B
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 10:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DCF481653;
	Wed, 21 Jan 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAmHqp8J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A3481648;
	Wed, 21 Jan 2026 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990705; cv=none; b=RL+3SU5X/7Qc5dZ6CcbSVfH0BunzEQ4QeypWwto8vpepD9EBpkSz522E+56kH90chbUx3yClXCRZjyLzICQ95gG27Rzgw04i53VjjGQ6z0GcaOmqukZMEqnvgnyXpjrMuPwZGNbRfr1VkPi56iGSCpclA91JqKU0MKDFYKtMrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990705; c=relaxed/simple;
	bh=kZ31Grkdld1h3pvoCPCPIXD/gxoG5DA7Zx/6jeAQsvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryTmLL7Bpoagr6aaN4yHveo+fGovUj6suqTqgt3ckxFhJvqQT97AjUyKMGeo8rv68+4jaTY8mrzynalS6W9k5T9zrzjqq4xV91ZxesLGbvix5+Kr/zH5U5V87l/4uVJQ2AoxpMKo8pDYTgSHaBOXs00NDdpAwteNezmNG3UCHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAmHqp8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40F4C116D0;
	Wed, 21 Jan 2026 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768990705;
	bh=kZ31Grkdld1h3pvoCPCPIXD/gxoG5DA7Zx/6jeAQsvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAmHqp8JfD/18hKEae7ABWh9JSJsrmcupNj+gHLGsM+keHE+G0+6bCSJIZQrOCFLs
	 EdlKjgVXBKbiYVt/IpMHovfMwgJsIARPTUWffa9okEI6kl5j8kNaG++fJ+Nv/rMDGe
	 fUS6aul+uThajtcZQXws7kFHpZEApKK2Cp5QG5ASFNuQNl+yi8RQUjS++eqLRvXHRC
	 VpZ0V1hVxwBCHq7M5hhg4ynkzdWByxwfxbweWGmoPQ7MqsC0qdX96LuiTTi5jNXyX1
	 haBQpCjf2gepBFhS3CYYUoHDnjU9Ly3RHS+WA88ELoSZTTuVqL+n4LCSeXTZTBAND3
	 hWf5nOzTn0kqQ==
Date: Wed, 21 Jan 2026 11:18:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Gokul Praveen <g-praveen@ti.com>
Cc: j-keerthy@ti.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, u-kumar1@ti.com, n-francis@ti.com
Subject: Re: [PATCH v4] pwm: tiehrpwm: Enable pwmchip's parent device before
 setting  configuration
Message-ID: <3ck3abtfdqzmatsvfqcbp7bxu7ydy7u37hfkke4xvpatpcg5uk@wfnya5hxrplo>
References: <20260121061134.15466-1-g-praveen@ti.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f3b4np2z5pl2kzbb"
Content-Disposition: inline
In-Reply-To: <20260121061134.15466-1-g-praveen@ti.com>
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7982-lists,linux-pwm=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ti.com:email]
X-Rspamd-Queue-Id: DAA1955476
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--f3b4np2z5pl2kzbb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] pwm: tiehrpwm: Enable pwmchip's parent device before
 setting  configuration
MIME-Version: 1.0

Hello Gokul,

On Wed, Jan 21, 2026 at 11:41:34AM +0530, Gokul Praveen wrote:
> The period and duty cycle configurations on J7200 and J784S4 SoCs
> does not get reflected after setting them using sysfs nodes.
> This is because at the end of ehrpwm_pwm_config function,
> the put_sync function is called which resets the hardware.
>=20
> Hold the PWM controller out of low-power mode during .apply() to
> make sure it accepts the writes to its registers.
>=20
> This renders the calls to pm_runtime_get_sync() and
> pm_runtime_put_sync() in ehrpwm_pwm_config() into no-ops, so
> these can be dropped.
>=20
> Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement .apply() callback")
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>

I applied this patch to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

and will send it during the next merge window. The problem is old
(v5.18-rc1~54^2~29 from 2021) and it's late in the development cycle, so
I won't bother Linus with it for 6.19.

Best regards
Uwe

--f3b4np2z5pl2kzbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlwp+wACgkQj4D7WH0S
/k5IiAf8DcOAPxtwVLaj9rJ2SeM3VRTKuG0LqoxitreRz6w4G6vvg8pb2gdskAX1
LlCPuGNrw7NqC+lv/Jvadrjm8BpeLBR0ISmYQ78a1xNjBmPJPT+2BXfP7W4z2uKb
UNkYfvAS6fP8TTjZaeZKESDW2LQFfHz4A2uePe+cisE4IGgqXF5c8FDlfPdzVdkw
FmpIlcUEv+0gfG/tl2wt7T2tcCtt8cLihuWVX12XYGJQu8IhXV2gjzO1B5N6g894
ZBwOaEvymFIEMeEXwMhwJNOl/ejBQhMs9UiSq+LDDQT/AdoHqi5ZJ9K54hzM8kwE
BzqgPHeDdCMqyuVvp7tMjX8UKK/G8Q==
=kdpK
-----END PGP SIGNATURE-----

--f3b4np2z5pl2kzbb--


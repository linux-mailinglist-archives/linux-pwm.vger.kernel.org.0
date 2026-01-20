Return-Path: <linux-pwm+bounces-7976-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mILuAN7Vb2mgMQAAu9opvQ
	(envelope-from <linux-pwm+bounces-7976-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:22:06 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCCF4A335
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DA068A3084
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E541345753;
	Tue, 20 Jan 2026 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpN8kU6G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AC31A072;
	Tue, 20 Jan 2026 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933023; cv=none; b=dB8neEkqrBbIzaV9lAeNrfaimrlCwm/h7uPVZnkoce1MUrDe/CWSfX4kRAnSejzE06vNlZLtL4fCNX+4IOn7hIyy5D5fRhhqOJRggvGl4iYwbw/zsNhgeO0pJISo9zmu3b7cJ5t8BZoULiTxKw3EFFeNAgvqK0BfYy9CcpytdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933023; c=relaxed/simple;
	bh=hSixSc/nGLi4+2kgvpet2/D3yoPhwni66/5BODlQHGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRetTRpDfwineJN+ateAfRDX5IXO32gfkT7WC3qjs0Y0fPYHHfcsd0gyJ5Aaxo/fRZiYvB7yPLpVU8YA/TJs9gD1Pbx7d8k0IMMYo2ObOkJif+aw+jJxpKm2DfxEKuY4CYB+CgEPeaFTRLgrgpYjVQvz4JqRx5cPas7RIN61rLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpN8kU6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37140C16AAE;
	Tue, 20 Jan 2026 18:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768933022;
	bh=hSixSc/nGLi4+2kgvpet2/D3yoPhwni66/5BODlQHGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpN8kU6GE1NQ0OgoT2CrICFe+ZxZwytkSGtOeDrU+NMsbpI5oC1WyoUafMTVUYqtd
	 AP+O12ogGnolQmFST/uWdOxeGN4mEmrjgs/S1Q1qdhHYioQHFXyeBvHEFVWd6T6cF3
	 ns3U3WBk+CR7gGbC5XUH1VSRXLr55irjquKySKYO3JDexMfED2ki6QOqsjJjTUvNnb
	 A+dYn0Ekv5L3bB5KIQG2gaozqWIAeFT58ruX/cUvNtf7dH8USKaKCn/8XfPGFPmEX8
	 B5G/lLMOjQVToxNoGxpt03BEp7gxK+mSAvciEEFdi3J1InwIPD70t//KH4EGHQl33K
	 QSLqi2FtCWzUg==
Date: Tue, 20 Jan 2026 19:17:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Gokul Praveen <g-praveen@ti.com>
Cc: j-keerthy@ti.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, u-kumar1@ti.com, n-francis@ti.com
Subject: Re: [PATCH v3] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
Message-ID: <uge7sfrlkyqr7wclrps3o6wyod7rmndewwtm5bspkjyw5tadvs@qgqyoi7xnnoh>
References: <20260120091922.71947-1-g-praveen@ti.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kbn4rop7dmb2ym3a"
Content-Disposition: inline
In-Reply-To: <20260120091922.71947-1-g-praveen@ti.com>
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
	TAGGED_FROM(0.00)[bounces-7976-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BFCCF4A335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--kbn4rop7dmb2ym3a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
MIME-Version: 1.0

Hello,

On Tue, Jan 20, 2026 at 02:49:22PM +0530, Gokul Praveen wrote:
> The period and duty cycle configurations does not get reflected
> after setting them using sysfs nodes. This is because at the
> end of ehrpwm_pwm_config function, the put_sync function is
> called which resets the hardware.

I'd like to have the text account for not all machines (SoCs?) suffering
=66rom that problem. Also the subject is wrong, as you enable the parent
of the PWM controller and not the controller itself?!
=20
> Fix it by preventing the pwm controller from going into
> low-power mode.

Please make this:

	Hold the PWM controller out of low-power mode during .apply() to
	make sure it accepts the writes to its registers.

	This renders the calls to pm_runtime_get_sync() and
	pm_runtime_put_sync() in ehrpwm_pwm_config() into no-ops, so
	these can be dropped.

as your sentence is wrong in general.

> Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement .apply() callback")
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> ---
> v3 <=3D=3D> v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Simplified the logic by adding guard function for runtime power=20
>   management.
>=20
> v2 <=3D=3D> v1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Removed space between Fixes and Signed-off tag
>=20
>  drivers/pwm/pwm-tiehrpwm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 7a86cb090f76..2533c95b0ba9 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -237,8 +237,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	if (period_cycles < 1)
>  		period_cycles =3D 1;
> =20
> -	pm_runtime_get_sync(pwmchip_parent(chip));
> -
>  	/* Update clock prescaler values */
>  	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
> =20
> @@ -290,8 +288,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	if (!(duty_cycles > period_cycles))
>  		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
> =20
> -	pm_runtime_put_sync(pwmchip_parent(chip));
> -
>  	return 0;
>  }
> =20
> @@ -378,6 +374,8 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	int err;
>  	bool enabled =3D pwm->state.enabled;
> =20
> +	guard(pm_runtime_active)(pwmchip_parent(chip));
> +
>  	if (state->polarity !=3D pwm->state.polarity) {
>  		if (enabled) {
>  			ehrpwm_pwm_disable(chip, pwm);

The patch is excellent :-D

Best regards
Uwe

--kbn4rop7dmb2ym3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvxpkACgkQj4D7WH0S
/k58ngf8D112LKCuTm2YcIR+u8hEeIPvtOoozsT9MOdt2LmJDEHwqmWgMpKxU4ja
/APxy00xRrxpgh2BBooULH12xOgPc4V0zUsjDeuAt5ARG35s8k87UE7Dh6WD7gfw
SgvsMBtqQ91CJCXeU7zm3ooAbZJ4cRPx3QJO/+OWPAibzUpQ/GR/eLTOsSEu7/XV
w6O5KqaW3ozMVGeYQP/l+902FliPpo3Z6sdwIFHMecod6rqkIQz5nHFcjshlcyEG
jTv0ZSuXJb0Jm+MlyZULdKTOYBDleuc6IXuSHJQnHtfVJq4LRr0gVGpDVdH34I4N
5qm+HEMszlPn6BGMlSfOvtIQxQrWhg==
=DjB6
-----END PGP SIGNATURE-----

--kbn4rop7dmb2ym3a--


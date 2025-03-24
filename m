Return-Path: <linux-pwm+bounces-5268-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59013A6D942
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Mar 2025 12:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C4D188F8D3
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Mar 2025 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41EC25DAE3;
	Mon, 24 Mar 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLlFYht6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF33197A68;
	Mon, 24 Mar 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816441; cv=none; b=IUYI+SnFw3u7uunalYpy9083ISl9Gx9Z3GpEn6buRP5Et2HWrwcf5L2BYlvTu/tjUmn4jCHpZ6+k/xvEIN6iN6GwWYRj7kpUGjZHCENP4H/n+3Aq9/aX2HRPngYBm7Hoen84piltFEYlsOvsXhibxbCf8xAaKBjDLVvJ7XqhF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816441; c=relaxed/simple;
	bh=1i0QDMqKfiVbHmoZ6j3RaZ9SuoswG1kMCF7gS9L1lRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw0NQh7nZnYPeZ3SC+7hnZMGAJFWCx7J1J5RoLVvuTfNHqaZP9yzQZym5Gojv7lr1ydGZxr6Jak/rVw3IVuPt58seZ9R5XFkr5nD2WfTHx2l4UME11r7laGXGme02FJd6hhPGd/awCip/TbKjWiieXLu5GWt/qEYPg09Xqb5dBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLlFYht6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DEFC4CEDD;
	Mon, 24 Mar 2025 11:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742816441;
	bh=1i0QDMqKfiVbHmoZ6j3RaZ9SuoswG1kMCF7gS9L1lRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLlFYht6WtT+po2JvGnc8GYr55OK4Ya2aBMFBkevmixYy6IhviZNZKThloY5FEQKR
	 K7/zHuAhedPMziMAPM7PjhGYWqXR6N2fMqz2Me76EOir1ofTmVoc7fDN4j9/l+eInd
	 kwW7JNOUQyxc6I3F47x4c/uiYnjrGCj4+tP1aVqh7p5RHERKCsB7tGFyHDbL2AAO2a
	 VYTNyDvhrY8D8dgWpO6TbXM19AL4LJweGqrp9usOXT4OUwCHJHFBSUdp/qXV31yAp8
	 E7eOt8P7ZhXxAvRJx/XXylCmBmFYDgV1EhMTOhfi4ixC280SNFXjkEVW55I7wjerA8
	 X/QHXGoLLsY+A==
Date: Mon, 24 Mar 2025 12:40:39 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mubin Sayyed <mubin.sayyed@amd.com>
Cc: krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org, 
	tglx@linutronix.de, michal.simek@amd.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v4 2/3] clocksource: timer-cadence-ttc: Support TTC
 device configured as PWM
Message-ID: <hwnhz4yr6vzz3oav4gq7qptejjy3rdwff7iveawaxexf3tbngr@pnrxi6jkpw3k>
References: <20250115113556.2832282-1-mubin.sayyed@amd.com>
 <20250115113556.2832282-3-mubin.sayyed@amd.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pzd7tzhb5lmj2cym"
Content-Disposition: inline
In-Reply-To: <20250115113556.2832282-3-mubin.sayyed@amd.com>


--pzd7tzhb5lmj2cym
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/3] clocksource: timer-cadence-ttc: Support TTC
 device configured as PWM
MIME-Version: 1.0

On Wed, Jan 15, 2025 at 05:05:55PM +0530, Mubin Sayyed wrote:
> TTC device can act either as clocksource/clockevent or PWM generator,
> it would be decided by pwm-cells property. If pwm-cells property is
> present in TTC node, it would be treated as PWM device, and clocksource
> driver just calls probe function for PWM functionality, so that TTC
> device would be registered with PWM framework.
>=20
> Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
> ---
> Changes for v4:
>     - In case of pwm-cells property call probe function for PWM
>       feature instead of returning error.
> Changes for v3:
>     - None
> Changes for v2:
>     - Added comment regarding pwm-cells property
> ---
>  drivers/clocksource/timer-cadence-ttc.c | 34 +++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksourc=
e/timer-cadence-ttc.c
> index 2f33d4c40153..c5ecad9332c9 100644
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -35,6 +35,10 @@
>   * obtained from device tree. The pre-scaler of 32 is used.
>   */
> =20
> +struct ttc_timer_config {
> +	bool is_pwm_mode;
> +};
> +
>  /**
>   * struct ttc_timer - This definition defines local timer structure
>   *
> @@ -453,6 +457,7 @@ static int __init ttc_setup_clockevent(struct clk *cl=
k,
> =20
>  static int __init ttc_timer_probe(struct platform_device *pdev)
>  {
> +	struct ttc_timer_config *ttc_config;
>  	unsigned int irq;
>  	void __iomem *timer_baseaddr;
>  	struct clk *clk_cs, *clk_ce;
> @@ -461,6 +466,24 @@ static int __init ttc_timer_probe(struct platform_de=
vice *pdev)
>  	u32 timer_width =3D 16;
>  	struct device_node *timer =3D pdev->dev.of_node;
> =20
> +	ttc_config =3D devm_kzalloc(&pdev->dev, sizeof(*ttc_config), GFP_KERNEL=
);
> +	if (!ttc_config)
> +		return -ENOMEM;
> +
> +	/*
> +	 * If pwm-cells property is present in TTC node,
> +	 * it would be treated as PWM device.
> +	 */
> +	if (of_property_read_bool(timer, "#pwm-cells")) {
> +		#if defined(CONFIG_PWM_CADENCE)
> +		ttc_config->is_pwm_mode =3D true;
> +			return ttc_pwm_probe(pdev);

strange indention. Maybe use

	if (IS_REACHABLE(CONFIG_PWM_CADENCE))

This is an unusal way to bind the PWM driver. I'd prefer creation of separa=
te
device in the PWM case. I wonder if it can happen that ttc_pwm_probe() is
called during boot before pwm_init() completed. Or use an auxbus device
to distinguish between timer and pwm?

> +		#else
> +			return -ENODEV;
> +		#endif
> +	}
> +	dev_set_drvdata(&pdev->dev, ttc_config);
> +
>  	if (initialized)
>  		return 0;
> =20

Best regards
Uwe

--pzd7tzhb5lmj2cym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfhRLQACgkQj4D7WH0S
/k4sqwf/cPZOgKEZ8UNhWo8+7B84fciGOJsR7JSGHrR8Ds3OzoSsSo2SL1hEBRJC
qRC7A/Ymvfm+VL+819XXNYXtCEtIe0Sdb5LZlUB4V+4muo4uhuOJtZCoj8Op0c8q
AlDpNDM3W0itt6BUe2gyTWwqwbUHXgdDHggexb+2Q3+h8qUoslfWQxxHC9xGTQvi
kqeLKzVhEQPY652y50JYDbS2QAi1bnI67inJFIHxUNCDg/ps/Br3w1xxO0/uKyE0
8xCRHh781T1g7F3gac9uXN5LZq1SX+X4vwQCO9S2UDIv1Oz4IrPrPRiFANASnXva
OzxvtMFDrG2IDLps1l2L0rn94pSeyA==
=Aeyv
-----END PGP SIGNATURE-----

--pzd7tzhb5lmj2cym--


Return-Path: <linux-pwm+bounces-8884-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDFyLwMlB2odsQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8884-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 15:52:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA81550CBF
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 15:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89C653062693
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 13:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111030BF6B;
	Fri, 15 May 2026 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uETHaK/6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B5302742;
	Fri, 15 May 2026 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850587; cv=none; b=uwRp3JIUHz2xGehBSu646aKKA/+xXZWA+UHFvDImB/bM03BtrS9Zx8QV1/glGplfFg48/cv+MddU0ADonRNqyUgbdVKhFX6b2NS6IyCq95a/fxXLu98ic7Qs5icrosYKrI0uIWaDAxrqM5VEK4ZGtk7O78WlZ55eGQbES8xtQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850587; c=relaxed/simple;
	bh=8HT7U6MbGUnPY3w7ftF7Pj8ZwTCOPc4Nj2sUdScJoM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFnvadxvaz5n3HLSr3ShJmpqhOY4zwjAlo18llpb3+ngi+m09e1OVNCnbOkPY4Ee4pZRjir/azjbzxTqxkKxGOzN8fL4zj/4L9ECDys4qRgZAdow7zRi5Uqu4SRz1hpGFpMmR8Wisy5KVIPRI6VwIysiYx+SIRlycjToESaww/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uETHaK/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C660CC2BCB8;
	Fri, 15 May 2026 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778850587;
	bh=8HT7U6MbGUnPY3w7ftF7Pj8ZwTCOPc4Nj2sUdScJoM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uETHaK/6JA4o/qdms2SZj2AD/cCQx5KtgTOIXmNolrOiywgskoZPcQsJ+SUDzsBjU
	 gawiHsCZRUZAFAZWcthszhJ/T6z5/9qpAx/oT5R3ptKpk/fW0k/XARmh4GsOxzjVxK
	 +fu7ZB1nSr9Ryrbvhyjw5jMUnsDFUynEWh8QqXMbqyHQNuwSaFsl2pcE/dfBoyPcHQ
	 xKf8Fmvthhj180RumlOUS43V496ujSK51NeZwOkKMSm5j5qt93epJWPCGFn95dx7iu
	 bYrfYDmjylyrYC3edupfu84JtDVYmIgg9hXozM+a4Mz5g22aJBFpK910YylCuG/Ezq
	 a5vkUB1Na3bdg==
Date: Fri, 15 May 2026 14:09:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v18 2/3] riscv: dts: starfive: Correct pwm nodes
Message-ID: <20260515-dandruff-outpour-7b3b6b5480db@spud>
References: <20260515054723.25024-1-hal.feng@starfivetech.com>
 <20260515054723.25024-3-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JriUJS52jcgo79we"
Content-Disposition: inline
In-Reply-To: <20260515054723.25024-3-hal.feng@starfivetech.com>
X-Rspamd-Queue-Id: BDA81550CBF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8884-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.190.149.16:email,0.190.110.0:email]
X-Rspamd-Action: no action


--JriUJS52jcgo79we
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 01:47:21PM +0800, Hal Feng wrote:
> Each of the StarFive JH7100/JH7110 SoCs has 8 OpenCores PTC IP
> cores. One OpenCores PTC IP core can output one PWM channel.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../boot/dts/starfive/jh7100-common.dtsi      | 28 ++++++--
>  arch/riscv/boot/dts/starfive/jh7100.dtsi      | 69 ++++++++++++++++++-
>  .../boot/dts/starfive/jh7110-common.dtsi      | 27 ++++++--
>  .../boot/dts/starfive/jh7110-milkv-mars.dts   |  6 +-
>  .../dts/starfive/jh7110-milkv-marscm.dtsi     |  6 +-
>  .../dts/starfive/jh7110-pine64-star64.dts     |  6 +-
>  .../jh7110-starfive-visionfive-2-lite.dtsi    |  6 +-
>  .../jh7110-starfive-visionfive-2.dtsi         |  6 +-
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 69 ++++++++++++++++++-
>  9 files changed, 200 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7100-common.dtsi
> index ae1a6aeb0aea..85106545090e 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> @@ -199,13 +199,23 @@ GPO_I2C2_PAD_SDA_OEN,
>  		};
>  	};
> =20
> -	pwm_pins: pwm-0 {
> -		pwm-pins {
> +	pwm0_pins: pwm0-0 {
> +		pwm0-pins {
>  			pinmux =3D <GPIOMUX(7,
>  				  GPO_PWM_PAD_OUT_BIT0,
>  				  GPO_PWM_PAD_OE_N_BIT0,
> -				  GPI_NONE)>,
> -				 <GPIOMUX(5,
> +				  GPI_NONE)>;
> +			bias-disable;
> +			drive-strength =3D <35>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate =3D <0>;
> +		};
> +	};
> +
> +	pwm1_pins: pwm1-0 {
> +		pwm1-pins {
> +			pinmux =3D  <GPIOMUX(5,
>  				  GPO_PWM_PAD_OUT_BIT1,
>  				  GPO_PWM_PAD_OE_N_BIT1,
>  				  GPI_NONE)>;
> @@ -359,9 +369,15 @@ &osc_aud {
>  	clock-frequency =3D <27000000>;
>  };
> =20
> -&pwm {
> +&pwm0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pwm0_pins>;
> +	status =3D "okay";
> +};
> +
> +&pwm1 {
>  	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&pwm_pins>;
> +	pinctrl-0 =3D <&pwm1_pins>;
>  	status =3D "okay";
>  };
> =20
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7100.dtsi
> index 7de0732b8eab..4629e9747307 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -360,9 +360,72 @@ watchdog@12480000 {
>  				 <&rstgen JH7100_RSTN_WDT>;
>  		};
> =20
> -		pwm: pwm@12490000 {
> -			compatible =3D "starfive,jh7100-pwm", "opencores,pwm-v1";
> -			reg =3D <0x0 0x12490000 0x0 0x10000>;
> +		pwm0: pwm@12490000 {
> +			compatible =3D "opencores,pwm-v1";
> +			reg =3D <0x0 0x12490000 0x0 0x10>;

NAK on the compatibles front, but this also looks very suspect, given
the size of the register regions, but I think it is actually correct.
You need to explain why it is correct in the commit message.

--JriUJS52jcgo79we
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagcbFgAKCRB4tDGHoIJi
0sOZAQCxnM7BwwH632XmI1nkReaAbjpkqxb7gbx/dTUK9rxb9gEA25ebV2QgpQw4
q+nS+323xE/qF1dkL8S3ShWf/tgduwA=
=u+CZ
-----END PGP SIGNATURE-----

--JriUJS52jcgo79we--


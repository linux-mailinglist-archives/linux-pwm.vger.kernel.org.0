Return-Path: <linux-pwm+bounces-7886-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC5FD0C7EE
	for <lists+linux-pwm@lfdr.de>; Fri, 09 Jan 2026 23:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8BA530081BC
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Jan 2026 22:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FDC2EC080;
	Fri,  9 Jan 2026 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/i/WRqr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4D86353;
	Fri,  9 Jan 2026 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767999208; cv=none; b=dG7fbSxJY7f1+cOBfze9r+98pmk3w+qr4ok7gjYGcFgpUzuxzop6eTbS1EQnYI2xIy2M90JXBZ3gHoY2CaxYbzpRX3Lqysy8lZoAwY77/bcp0CQe6RPHAOnkRX3ot2pDOiPrNdG8jloGphBnPZuApcMROCO4rVXMYVvONXgrt50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767999208; c=relaxed/simple;
	bh=Lh76pUDlrIZA7UcUIPT39vadtYQclkB+pECR5OifXvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfJfo+5kOHqa7/7TTqw1UAKPUZn3iFERATZXrgTA5I9fqSlp/CiBNr7uJHelrAuX7Ode9k0AaOEvoQbeLhr7Al6V1OhRN/vkvtiiveTYjFSX2HnZscNL7r6GWzJTmT1OqgfTUaQIfk3eTiRFOFRg1+Y5hT3zh9Y2XOgjNihn8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/i/WRqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D165C4CEF1;
	Fri,  9 Jan 2026 22:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767999208;
	bh=Lh76pUDlrIZA7UcUIPT39vadtYQclkB+pECR5OifXvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/i/WRqrNK0S7FViQ49z/hf3OqXp+ASrvjFhaqxUb+foy6HyTfKUtRzHM0Hf565sx
	 imsszVTB3LLnGrPOxinj/KZ7Eyexmp3LvORVGEaqQIf9QZSrpKF7RsZ2OrNQVY34b1
	 apcSc4MiM8wHo6xzwwMMLlP58sNV3bsQrwhmxdkYUw4K/RPZ9FX9+LguKoDLp/Lnur
	 fZkEgtV3n78Tp+MUwixkXe7N+/vzqQ58CzUY2kqcmbDM36wYhBPtUHAIqNu+ePgUVK
	 ihUUjRRC1V64wBVozLQRYrgp93Q1rvnzSqFuPpIUin2UmrUocTkxN9ghUF/TuOBFTP
	 LiqYvlgLIKdfg==
Date: Fri, 9 Jan 2026 23:53:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Gokul Praveen <g-praveen@ti.com>
Cc: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, j-keerthy@ti.com, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, n-francis@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
Message-ID: <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
 <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
 <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
 <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
 <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x7tthsuk3omquahv"
Content-Disposition: inline
In-Reply-To: <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>


--x7tthsuk3omquahv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
MIME-Version: 1.0

Hello Gokul,

On Fri, Jan 09, 2026 at 11:21:46AM +0530, Gokul Praveen wrote:
> On 08/01/26 23:40, Uwe Kleine-K=F6nig wrote:
> > On Thu, Jan 08, 2026 at 12:10:35PM +0530, Gokul Praveen wrote:
> > > On 08/01/26 01:17, Rafael V. Volkmer wrote:
> > > > Thanks for CC'ing me on this thread.
> > > >=20
> > > > On 07/01/26 15:21, Uwe Kleine-K=F6nig wrote:
> > > > > adding Rafael to Cc: who sent a patch series for this driver that=
 I
> > > > > didn't come around to review yet. Given that neither he nor me no=
ticed
> > > > > the problem addressed in this patch I wonder if it applies to all
> > > > > hardware variants.
> > > > >=20
> > > >=20
> > > > I also didn't observe the issue described here in my testing: duty =
cycle and
> > > > period changes always appeared to take effect as expected.
> > > >=20
> > > > My tests were done on an AM623 EVM.
> > > >=20
> > > > One possible explanation is that my test flow mostly exercised conf=
iguration
> > > > while the PWM was already enabled/active, which could mask the effe=
ct of a
> > > > put_sync/reset happening after configuration.
> > > >=20
> > >=20
> > > Yes, this is the reason why the configuration was taking effect for y=
ou ,
> > > Rafael, as the PWM was already enabled when setting the configuration=
 hence
> > > masking the effect of a put_sync/reset happening after configuration.
> >=20
> > Can you provide a list of commands that show the failure? That would
> > result in less guessing for me. My plan is to reproduce the failure
> > tomorrow to better understand it on my boneblack.
>=20
> Sure Uwe. These are the commands I have tried for PWM signal generation:
>=20
> cd /sys/class/pwm/pwmchip0
> /sys/class/pwm/pwmchip0# echo 0 > export
> /sys/class/pwm/pwmchip0# cd pwm0/
> /sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
> /sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
> /sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
>=20
> Once these commands were executed, I measured the PWM signal using logic
> analyzer and the duty cycle was 100% even though we had set 30% duty cycle
> through the sysfs nodes.

After that sequence I "see" a 30% relative duty cycle on my boneblack.
(With the follwing patch applied on top of pwm/for-next:

diff --git a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts b/arch/arm/boot=
/dts/ti/omap/am335x-boneblack.dts
index b4fdcf9c02b5..a3f4a4bb64e4 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
@@ -173,3 +173,25 @@ &gpio3 {
 &baseboard_eeprom {
 	vcc-supply =3D <&ldo4_reg>;
 };
+
+&am33xx_pinmux {
+	ehrpwm0_pins: ehrpwm0-pins {
+		pinctrl-single,pins =3D <
+			/* P9.21 UART2_TXD -> ehrpwm0B */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)
+			/* P9.22 UART2_RXD -> ehrpwm0A */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_OUTPUT_PULLDOWN, MUX_MODE3)
+		>;
+	};
+};
+
+&ehrpwm0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&ehrpwm0_pins>;
+
+	status =3D "okay";
+};
+
+&epwmss0 {
+	status =3D "okay";
+};

)

That makes me think the problem isn't understood well yet and needs more
research. @Rafael, does the problem reproduce for you with Gokul's
recipe? (Or did you try that already? I understood your reply as "I
didn't encounter the issue but also didn't test specifically for that.")

As I cannot reproduce the issue, can you please check if adding

	pm_runtime_get_sync(pwmchip_parent(chip));

to the probe function makes the problem disappear? Also please boot with

	trace_event=3Dpwm

on the command line and provide the content of
/sys/kernel/debug/tracing/trace after reproducing the problem.

Best regards
Uwe

--x7tthsuk3omquahv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlhht8ACgkQj4D7WH0S
/k6lxgf/QC/Ny5+xg9ESlY4lSJuZbP25L01Ak6yAMAuvO34gxnV6ixI+0C8MuYP4
M7f3dwL7rrz+yRnbDRyYoFSnbM6sHCpJ36CKMictJcqjXxNBRnuOD/1s+bZyQzRh
+Z3BeJvPqfM/vg8OJRLaVtfK1WF/oxZSHAdO4Z5e6CNHFrlFUn/NP9T0W44NWd4c
VUG920LK/JXjWmqg1pzheigEDxHUMGmjyJWwTUZ45NqMuqOVCMbriQ3eS9l0tb+v
t6G446poK/ie95s9iwarxJzqGOoeBAhXQNADyKgamRofymg2DfzHl4s47vAvi4Q9
gaz1vrbbYoYqTucGsmXIvCeGeFNolg==
=Rgz7
-----END PGP SIGNATURE-----

--x7tthsuk3omquahv--


Return-Path: <linux-pwm+bounces-7913-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83688D265EC
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 18:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D472F30F995C
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94592C027B;
	Thu, 15 Jan 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOUZSuhX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622586334;
	Thu, 15 Jan 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497466; cv=none; b=hOnKhS3MpFE43Jj3vC/G+nF4mdZ3Pgg09g4KPYhKUU9SbQasKTfEp+BWYz05i7Gzysqn7RS0K9fmIGJUiBvFLmD5eeFKTWN0jM/ZTQtb7g1qMkZxXRhKqp776ti1Mmoa8dibpDMZeBZ9FEhSLWt31gkh544k6Zhp2XR+lGJb0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497466; c=relaxed/simple;
	bh=yKAEz1dLsyneukqi9DbqG0IqMaBdlY+MQkgMDR6qlKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzSu4s6H8dqT9vKqURGyox8nNPzX63hoSiCFrf8wMrX1ns9BikIeSdVEA8d4iVhSRckZ4xscBGYrao7zccrf8CyVWCZ1oWs9o3eBIL4WanfUSD+zmGzkrXOfINxkuh6gBTPZKvcj/NqqI5XNLYCjfUaqMaiSVdtcMy3EGCHgJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOUZSuhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168E1C116D0;
	Thu, 15 Jan 2026 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768497466;
	bh=yKAEz1dLsyneukqi9DbqG0IqMaBdlY+MQkgMDR6qlKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOUZSuhXNPmyzQr9u30g5nnxI6MeST40WunIw6ouvRBhg+n0Kq0Nfp81TiiQ6lM+i
	 RPRTjCLvJNZ/dWbiCcj/aQPlCnDCngl/O2dDB458GqWCWWzbkZU8Eudqi6L4MoxuH3
	 HZE6Yqmo3GkdL6GbnyKt5dFhlkvP01k6G2taC//beWeSzeG5F5poh4O3e8nSVlfKeF
	 D+F9CUKe9Yb6teAlvaCTOxQzDcaU78CK6sxW8luQsNpnV6GKC4Tout9dfSFLNQ6Q3Z
	 A6Y+rBGqQ2jN5ng5qaxINdn596TAD3o56iMq3AsFtYoDmwYZVh34O4U+kD3evKuhwn
	 e71J7Z2whPX1Q==
Date: Thu, 15 Jan 2026 18:17:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Gokul Praveen <g-praveen@ti.com>
Cc: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, j-keerthy@ti.com, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, n-francis@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
Message-ID: <nj2xtbprctszessuedsxkdvpbjywcruwoo3ioyfrfdbt5lemg3@eri5iorsajo3>
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
 <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
 <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
 <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
 <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
 <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
 <63a0c480-c953-4717-9efe-766038d7fa8b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mlmirlic5aby5fvu"
Content-Disposition: inline
In-Reply-To: <63a0c480-c953-4717-9efe-766038d7fa8b@ti.com>


--mlmirlic5aby5fvu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
MIME-Version: 1.0

On Thu, Jan 15, 2026 at 04:02:16PM +0530, Gokul Praveen wrote:
> Hi Uwe,
>=20
> Apologies for the delay as it took some time for me to get the trace outp=
ut
> as well as to get the way I reproduced the issue.
>=20
>=20
> On 10/01/26 04:23, Uwe Kleine-K=F6nig wrote:
> > Hello Gokul,
> >=20
> > On Fri, Jan 09, 2026 at 11:21:46AM +0530, Gokul Praveen wrote:
> > > On 08/01/26 23:40, Uwe Kleine-K=F6nig wrote:
> > > > On Thu, Jan 08, 2026 at 12:10:35PM +0530, Gokul Praveen wrote:
> > > > > On 08/01/26 01:17, Rafael V. Volkmer wrote:
> > > > > > Thanks for CC'ing me on this thread.
> > > > > >=20
> > > > > > On 07/01/26 15:21, Uwe Kleine-K=F6nig wrote:
> > > > > > > adding Rafael to Cc: who sent a patch series for this driver =
that I
> > > > > > > didn't come around to review yet. Given that neither he nor m=
e noticed
> > > > > > > the problem addressed in this patch I wonder if it applies to=
 all
> > > > > > > hardware variants.
> > > > > > >=20
> > > > > >=20
> > > > > > I also didn't observe the issue described here in my testing: d=
uty cycle and
> > > > > > period changes always appeared to take effect as expected.
> > > > > >=20
> > > > > > My tests were done on an AM623 EVM.
> > > > > >=20
> > > > > > One possible explanation is that my test flow mostly exercised =
configuration
> > > > > > while the PWM was already enabled/active, which could mask the =
effect of a
> > > > > > put_sync/reset happening after configuration.
> > > > > >=20
> > > > >=20
> > > > > Yes, this is the reason why the configuration was taking effect f=
or you ,
> > > > > Rafael, as the PWM was already enabled when setting the configura=
tion hence
> > > > > masking the effect of a put_sync/reset happening after configurat=
ion.
> > > >=20
> > > > Can you provide a list of commands that show the failure? That would
> > > > result in less guessing for me. My plan is to reproduce the failure
> > > > tomorrow to better understand it on my boneblack.
> > >=20
> > > Sure Uwe. These are the commands I have tried for PWM signal generati=
on:
> > >=20
> > > cd /sys/class/pwm/pwmchip0
> > > /sys/class/pwm/pwmchip0# echo 0 > export
> > > /sys/class/pwm/pwmchip0# cd pwm0/
> > > /sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
> > > /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
> > > /sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
> > > /sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
> > >=20
> > > Once these commands were executed, I measured the PWM signal using lo=
gic
> > > analyzer and the duty cycle was 100% even though we had set 30% duty =
cycle
> > > through the sysfs nodes.
> >=20
> > After that sequence I "see" a 30% relative duty cycle on my boneblack.
> > (With the follwing patch applied on top of pwm/for-next:
> >=20
> > diff --git a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts b/arch/arm/=
boot/dts/ti/omap/am335x-boneblack.dts
> > index b4fdcf9c02b5..a3f4a4bb64e4 100644
> > --- a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
> > +++ b/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
> > @@ -173,3 +173,25 @@ &gpio3 {
> >   &baseboard_eeprom {
> >   	vcc-supply =3D <&ldo4_reg>;
> >   };
> > +
> > +&am33xx_pinmux {
> > +	ehrpwm0_pins: ehrpwm0-pins {
> > +		pinctrl-single,pins =3D <
> > +			/* P9.21 UART2_TXD -> ehrpwm0B */
> > +			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)
> > +			/* P9.22 UART2_RXD -> ehrpwm0A */
> > +			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_OUTPUT_PULLDOWN, MUX_MODE3)
> > +		>;
> > +	};
> > +};
> > +
> > +&ehrpwm0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&ehrpwm0_pins>;
> > +
> > +	status =3D "okay";
> > +};
> > +
> > +&epwmss0 {
> > +	status =3D "okay";
> > +};
> >=20
> > )
> >=20
> > That makes me think the problem isn't understood well yet and needs more
> > research. @Rafael, does the problem reproduce for you with Gokul's
> > recipe? (Or did you try that already? I understood your reply as "I
> > didn't encounter the issue but also didn't test specifically for that.")
> >=20
> > As I cannot reproduce the issue, can you please check if adding
> >=20
> > 	pm_runtime_get_sync(pwmchip_parent(chip));
> >=20
> > to the probe function makes the problem disappear? Also please boot with
> >=20
> > 	trace_event=3Dpwm
> >=20
> > on the command line and provide the content of
> > /sys/kernel/debug/tracing/trace after reproducing the problem.
> >=20
>=20
> PWM EVENT TRACING OUTPUT:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 3/3   #P:8
> #
> #                                _-----=3D> irqs-off/BH-disabled
> #                               / _----=3D> need-resched
> #                              | / _---=3D> hardirq/softirq
> #                              || / _--=3D> preempt-depth
> #                              ||| / _-=3D> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>       gen_pwm.sh-1039    [000] .....    88.564669: pwm_apply: pwmchip0.1:
> period=3D100000000 duty_cycle=3D0 polarity=3D0 enabled=3D0 err=3D0
>       gen_pwm.sh-1039    [000] .....    88.564728: pwm_apply: pwmchip0.1:
> period=3D100000000 duty_cycle=3D30000000 polarity=3D0 enabled=3D0 err=3D0
>       gen_pwm.sh-1039    [000] .....    88.565065: pwm_apply: pwmchip0.1:
> period=3D100000000 duty_cycle=3D30000000 polarity=3D0 enabled=3D1 err=3D0
>=20
> The trace output might mislead us thinking that the duty cycle is set
> properly as the event tracer reads the duty_cycle variable which gets set
> irrespective of whether the value gets reflected in the pwm registers or
> not.

Can you please also enable CONFIG_PWM_DEBUG? That should show the values
actually used as it enables a few calls to .get_state().

Best regards
Uwe

--mlmirlic5aby5fvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlpITUACgkQj4D7WH0S
/k6y3wgAl5FKxBM/IOKdcAZwodZ7MjO6uURXuMOzXv3JnVe6VMHqfKJwT1ENBeGy
QeZyhEMtKJKE0/3pUopBKP81zbFiWJldIcdnQE2CriQ/qfrMQsMjafPEtNLb2C40
ufeSrbYf4xEhAPKuPhW4I2gvPG3Cn79w5rlwwzbZZ7Mwj6VDE6vBWMrG5sc3f/bi
FI6oAPgE4bU3d9YFBgPQIO5adEhiy+y3bvL+tgupWnOpi3i9oT9gcn34IxYj+5O+
/J8yH1p9jM7s7aCsyXzo6uiVxsqtqeyGxujBbUClPj7v25hMzLK5gCq6Ipytgxrl
ijpXfg08IR2wBHBqKNGjOBtOEn8oGw==
=a7GO
-----END PGP SIGNATURE-----

--mlmirlic5aby5fvu--


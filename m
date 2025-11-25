Return-Path: <linux-pwm+bounces-7693-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B416C83F6F
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 09:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E17054E7C79
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EDE2D7813;
	Tue, 25 Nov 2025 08:24:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF42D8776
	for <linux-pwm@vger.kernel.org>; Tue, 25 Nov 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059081; cv=none; b=QbUWdtork995qmhGFwCgW4we3KV4FliETyg0ko3IBjs9sLfrYGxEwcBCf3JRGg3YOLywqc9zDNZoec+lHxRUySyZQ3//dB3Bg5WzCBsUeI1kY923KLQcLM82KLN3RWELK/ruyi96VzESvEHVo21Z+Qf54Uj/7+kMZoOXxVXTV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059081; c=relaxed/simple;
	bh=If+VgiQyyouldR/fQUtKqlbwUMOGSuP+lvB4VzI0074=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njcbbTPO7BiHV/QgQIz0jHEBsSzqZqxOkFxD6nUhQwVg7LSBE+hP+8UWlv+8LpOvdA3xIBLFFggvBMYnyIStD3IEd1SZEy8rU5eoqXOqEHTsxJNsPPv1Ktf47m441EpyfeL8BBFPuj0MnMR/U+hzDkFNqgUP4/JqPxg79SmjIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1vNoLb-0001ew-KH; Tue, 25 Nov 2025 09:24:27 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1vNoLb-002MCy-0J;
	Tue, 25 Nov 2025 09:24:27 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1vNoLa-005ooi-3B;
	Tue, 25 Nov 2025 09:24:26 +0100
Date: Tue, 25 Nov 2025 09:24:26 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Daniel Thompson <danielt@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org,
	linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Pengutronix <kernel@pengutronix.de>
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <aSVnulk0yfAd4UCx@pengutronix.de>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
 <f492d4d3-751c-40a3-bb93-0e1bb192cde7@sirena.org.uk>
 <aRxr_sR0ksklFsw-@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5lR1y+xZyNcXp5Ry"
Content-Disposition: inline
In-Reply-To: <aRxr_sR0ksklFsw-@aspen.lan>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--5lR1y+xZyNcXp5Ry
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 12:52:14PM +0000, Daniel Thompson wrote:
>On Fri, Nov 14, 2025 at 02:09:56PM +0000, Mark Brown wrote:
>> On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
>> > Currently when calling pwm_apply_might_sleep in the probe routine
>> > the pwm will be configured with an not fully defined state.
>> >
>> > The duty_cycle is not yet set in that moment. There is a final
>> > backlight_update_status call that will have a properly setup state.
>> > However this change in the backlight can create a short flicker if the
>> > backlight was already preinitialised.
>>
>> I'm seeing the libre.computer Renegade Elite producing warnings during
>> boot in -next which bisect to this patch.  The warnings are:
>>
>> [   24.175095] input: adc-keys as /devices/platform/adc-keys/input/input1
>> [   24.176612] ------------[ cut here ]------------
>> [   24.177048] WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:127 c=
t_kernel_exit.constprop.0+0x98/0xa0
>>
>> ...
>>
>> [   24.190106] Call trace:
>> [   24.190325]  ct_kernel_exit.constprop.0+0x98/0xa0 (P)
>> [   24.190775]  ct_idle_enter+0x10/0x20
>> [   24.191096]  cpuidle_enter_state+0x1fc/0x320
>> [   24.191476]  cpuidle_enter+0x38/0x50
>> [   24.191802]  do_idle+0x1e4/0x260
>> [   24.192094]  cpu_startup_entry+0x34/0x3c
>> [   24.192444]  rest_init+0xdc/0xe0
>> [   24.192734]  console_on_rootfs+0x0/0x6c
>> [   24.193082]  __primary_switched+0x88/0x90
>> [   24.193445] ---[ end trace 0000000000000000 ]---
>>
>> which seems a little surprising but there is some console stuff there
>> that looks relevant.
>>
>> Full log:
>>
>>     https://lava.sirena.org.uk/scheduler/job/2086528#L897
>
>Michael, reading these logs it looks to me like the underlying oops
>is this backtrace (which makes a lot more sense given the code you
>altered):
>
>[   24.133631] Call trace:
>[   24.133853]  pwm_backlight_probe+0x830/0x868 [pwm_bl] (P)
>[   24.134341]  platform_probe+0x5c/0xa4
>[   24.134679]  really_probe+0xbc/0x2c0
>[   24.135001]  __driver_probe_device+0x78/0x120
>[   24.135391]  driver_probe_device+0x3c/0x154
>[   24.135765]  __driver_attach+0x90/0x1a0
>[   24.136111]  bus_for_each_dev+0x7c/0xdc
>[   24.136462]  driver_attach+0x24/0x38
>[   24.136785]  bus_add_driver+0xe4/0x208
>[   24.137124]  driver_register+0x68/0x130
>[   24.137468]  __platform_driver_register+0x24/0x30
>[   24.137888]  pwm_backlight_driver_init+0x20/0x1000 [pwm_bl]
>[   24.138389]  do_one_initcall+0x60/0x1d4
>[   24.138735]  do_init_module+0x54/0x23c
>[   24.139073]  load_module+0x1760/0x1cf0
>[   24.139407]  init_module_from_file+0x88/0xcc
>[   24.139787]  __arm64_sys_finit_module+0x1bc/0x338
>[   24.140207]  invoke_syscall+0x48/0x104
>[   24.140549]  el0_svc_common.constprop.0+0x40/0xe0
>[   24.140970]  do_el0_svc+0x1c/0x28
>[   24.141268]  el0_svc+0x34/0xec
>[   24.141548]  el0t_64_sync_handler+0xa0/0xf0
>[   24.141920]  el0t_64_sync+0x198/0x19c
>
>Should we back out the patch for now?

I would be fine with that. But actually I would like to see the
proof that without the patch, this backtrace will not trigger.
Looking through the codepath, I could not directly find a case
where this should happen.

Mark, is there a way to rerun this without my patch?

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--5lR1y+xZyNcXp5Ry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmklZ7YACgkQC+njFXoe
LGS72w/6AoHVwozXjyve4l+1qlupkgIh4y0b5i8qAkJeX6oKbvwx7jqGUCUY1W3e
/L14o/GoYDwISuEsU4C8resSkGoLlp/QEotyIq+lbeBSAFl6O57NYg1EO+2pV9b6
vzvaWopThDGJY9ZSSvl/UecGpu4UcaRP8wMmal93yUIQ0AH6kiDS0JH2ZCXAFFvU
Al+Plxsne/zsm/3DhXFbCfHOMLITnaVedqwQd4gsOrc6u00JS2fEWQLVLHofGCLp
f9m1xxpEzb5naXDI/gQGlzKqmZ7ko0UDTSXukh13PMuHRR/nBzPKhuQb15+jR1I7
KBjkCVDV0NcV7oAFSvdUYLcVAVUNQLahsFXwCtxid3MUfluWcCmyM9fg1/Uzw8DH
W7NtR2nzlsLE4sNoHVLVHW60GYvO63IGmgiTBCgfFOt5WVuk2XopiBKRnMKc6UHw
yY+0xOH0GEChfTEnOnQbZlGG+xTRdthTpIWf5gQ5lF4wdcFiJF3zS9fq/GHaRrRq
qK3napeB52Lzw/BfZ9NPG1qLysv5QlT6WSJuGdl2/C7/lXRcIsi1xpNgzXZyPUNT
4VULTw9scsCtl9ZnD0+sijC3GYZjHKCgK7t/FZ7wBCL10g/wZPojLz9zh3v4VNeh
LleDOHxGk2ioCks2UMm0zJBJoTXKQREw13zHZ4W6B7Pm4uptXRc=
=R0Gw
-----END PGP SIGNATURE-----

--5lR1y+xZyNcXp5Ry--


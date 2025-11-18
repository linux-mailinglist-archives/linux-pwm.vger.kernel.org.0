Return-Path: <linux-pwm+bounces-7637-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E37C6977A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 13:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id F3FF72ABA2
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECCC239E7D;
	Tue, 18 Nov 2025 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd5MxB/F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ECBD531;
	Tue, 18 Nov 2025 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470155; cv=none; b=c3D/Nu5K7U/hMGnVeKOOZ9ASwmxlr6LXl4qBqjDc3GAyhKOvBQBMcaD02PJ/XHiFN6ma+Ma8AxYgT5yhmxZ1S6X1P5tOhoC8rhylE/87S+YaOvQ2OkiWAhEUWFDuLSx8gW+tp82aZF4yQRpP/EtszSiEyNqiDtgnL4dCLcOjSvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470155; c=relaxed/simple;
	bh=9YCkDMqLNwTXxB2/du8dT0VZecv+69TsOkjhuOSXYag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM8AMtClpZgpipAhjCaVXDv039XTsUTp/AdGEpvaSozTh/7K/cUBChHE/ef+oPFqPjxumrDCODVHBsvtJvX2F2A2ebLD8keNJ1N+O040X3ATHHKxhfO35Zwld3wsayes+smMowqzxuOUCgv07giTMeK8+Rrnfh/Vtp+UR9NoCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd5MxB/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BD7C2BC87;
	Tue, 18 Nov 2025 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763470155;
	bh=9YCkDMqLNwTXxB2/du8dT0VZecv+69TsOkjhuOSXYag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nd5MxB/FPve7LcUWbbiGm8gPcXqZN1mqVh9FKcATbSdx//TjVaQE6X1Dol1WhmsZz
	 D2Gfb3U5EkaNqRLs/DrqjCQodcFxZJbE1/lP2i65KMrdu2AHvSqEq9jQpqatQsSuUA
	 NO5g4AxZU7NIQT9TQpbNLtrgXPNPh1GHcbnBskPDVT4ZSCLmCC32T8LIwo3dBX9fcg
	 L6sn1PHReFqXq3nJBcu59wn9DkITLoZGvJF2RB+YvO+UcKYX7kDS0pTyErRi34RQj4
	 1Imf3DUTh2dSZtFUWsj/svftG22xaWYZElbB4tArLfebWsE5lKMT9IJWJMP6q19lGB
	 7f556L9I4XFdQ==
Date: Tue, 18 Nov 2025 12:52:14 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Pengutronix <kernel@pengutronix.de>,
	linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <aRxr_sR0ksklFsw-@aspen.lan>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
 <f492d4d3-751c-40a3-bb93-0e1bb192cde7@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f492d4d3-751c-40a3-bb93-0e1bb192cde7@sirena.org.uk>

On Fri, Nov 14, 2025 at 02:09:56PM +0000, Mark Brown wrote:
> On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
> > Currently when calling pwm_apply_might_sleep in the probe routine
> > the pwm will be configured with an not fully defined state.
> >
> > The duty_cycle is not yet set in that moment. There is a final
> > backlight_update_status call that will have a properly setup state.
> > However this change in the backlight can create a short flicker if the
> > backlight was already preinitialised.
>
> I'm seeing the libre.computer Renegade Elite producing warnings during
> boot in -next which bisect to this patch.  The warnings are:
>
> [   24.175095] input: adc-keys as /devices/platform/adc-keys/input/input1
> [   24.176612] ------------[ cut here ]------------
> [   24.177048] WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:127 ct_kernel_exit.constprop.0+0x98/0xa0
>
> ...
>
> [   24.190106] Call trace:
> [   24.190325]  ct_kernel_exit.constprop.0+0x98/0xa0 (P)
> [   24.190775]  ct_idle_enter+0x10/0x20
> [   24.191096]  cpuidle_enter_state+0x1fc/0x320
> [   24.191476]  cpuidle_enter+0x38/0x50
> [   24.191802]  do_idle+0x1e4/0x260
> [   24.192094]  cpu_startup_entry+0x34/0x3c
> [   24.192444]  rest_init+0xdc/0xe0
> [   24.192734]  console_on_rootfs+0x0/0x6c
> [   24.193082]  __primary_switched+0x88/0x90
> [   24.193445] ---[ end trace 0000000000000000 ]---
>
> which seems a little surprising but there is some console stuff there
> that looks relevant.
>
> Full log:
>
>     https://lava.sirena.org.uk/scheduler/job/2086528#L897

Michael, reading these logs it looks to me like the underlying oops
is this backtrace (which makes a lot more sense given the code you
altered):

[   24.133631] Call trace:
[   24.133853]  pwm_backlight_probe+0x830/0x868 [pwm_bl] (P)
[   24.134341]  platform_probe+0x5c/0xa4
[   24.134679]  really_probe+0xbc/0x2c0
[   24.135001]  __driver_probe_device+0x78/0x120
[   24.135391]  driver_probe_device+0x3c/0x154
[   24.135765]  __driver_attach+0x90/0x1a0
[   24.136111]  bus_for_each_dev+0x7c/0xdc
[   24.136462]  driver_attach+0x24/0x38
[   24.136785]  bus_add_driver+0xe4/0x208
[   24.137124]  driver_register+0x68/0x130
[   24.137468]  __platform_driver_register+0x24/0x30
[   24.137888]  pwm_backlight_driver_init+0x20/0x1000 [pwm_bl]
[   24.138389]  do_one_initcall+0x60/0x1d4
[   24.138735]  do_init_module+0x54/0x23c
[   24.139073]  load_module+0x1760/0x1cf0
[   24.139407]  init_module_from_file+0x88/0xcc
[   24.139787]  __arm64_sys_finit_module+0x1bc/0x338
[   24.140207]  invoke_syscall+0x48/0x104
[   24.140549]  el0_svc_common.constprop.0+0x40/0xe0
[   24.140970]  do_el0_svc+0x1c/0x28
[   24.141268]  el0_svc+0x34/0xec
[   24.141548]  el0t_64_sync_handler+0xa0/0xf0
[   24.141920]  el0t_64_sync+0x198/0x19c

Should we back out the patch for now?


Daniel.


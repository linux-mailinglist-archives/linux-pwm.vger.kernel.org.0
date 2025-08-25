Return-Path: <linux-pwm+bounces-7165-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 787A7B33A39
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Aug 2025 11:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A92178854
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Aug 2025 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93652C08D1;
	Mon, 25 Aug 2025 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="YflggP6f"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B85E29D283;
	Mon, 25 Aug 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113137; cv=pass; b=Ys22pExr0wTjhKtjViKFZtYMBVH7YVm2jwAr+Q0df2YH47+dO2ppW4pqBXqwjcGngApw+jcctJJvB4YREsSiJ2wCxK4E5Me41L4JLSTfyFdcXfyFG5dFezz/Wky4PWRlVEaN6S1RYs7ApZojtIQDnOSCdUA+omUZS/eT4lJLrpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113137; c=relaxed/simple;
	bh=UN7tZ7Mi8e7wrHnMuWaGhmTuxgnsZLQrHzqrSQdh1q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/n1eAwDWGv9V5E5MymhLceDk/YYwV3c0YJ27qdjJz34rCPHI4HibZB1OAdBmCco9RUHPjj1BNPB9yywxfUM4Zx0wOwQcPfK+ZPsoRXgb+vu0GULE4f3kVh7kUm6uFkDFIMePPmSo6GS34rCXts7ZckhihZivkI29ayu5IQUtMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=YflggP6f; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756113100; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ec8cyEUwiNI3LFhu8Bjr6TA4Ifd4X3t9gH9QHQqcOXK5FOOElNUvv5JYceocSXO76UZHo3rRHHjwd8h/U5yHjJBua+x0EpRi6KWh2jNzCa7gDYs0/H5b0mcM+Lb3wmWa2Cc8pkXK40RQOBqFpFx9Icyhna1Cyl/tPt8Ti/1Wv6E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756113100; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4zV5r8kLElpBRlahVoUG9dL32SfwaAS/peHVJEeTGgE=; 
	b=lOKX1ACuePfLg2c3+K7V6XewlAr9NPK6aQIa+PiyZGEZu+FbNLcKFi49vlmzKNn78T9vJzkaNQ6Nm61ps1chz7JbJgTAhN+iLpkv6iLkvQIOMHxC0fPWt+WhrOs7hWB9QSniAL/bpVkzE+g797gn47L0KLEsZ7dWLBMEzIk/Qc8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756113100;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=4zV5r8kLElpBRlahVoUG9dL32SfwaAS/peHVJEeTGgE=;
	b=YflggP6f4+3KqQMd0IzfGOdaBd89fbchQZvRAVp0mLKhEIKs53GprABEnKxJPcDh
	wiokus9kcYMAMiiIHJ+ek6m1oeuUL0XkEHZwa85lcOdVJxbNHO7Eq3Nodlmj2fHWWzH
	AZq4MRi5Ef45b3RLoZtGziyTi0o7e4d8t47xZDg0=
Received: by mx.zohomail.com with SMTPS id 1756113097823724.7840177435801;
	Mon, 25 Aug 2025 02:11:37 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: William Breathitt Gray <wbg@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v2 6/7] counter: Add rockchip-pwm-capture driver
Date: Mon, 25 Aug 2025 11:11:31 +0200
Message-ID: <3367507.aeNJFYEL58@workhorse>
In-Reply-To: <20250720002024.696040-1-wbg@kernel.org>
References: <20250720002024.696040-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday, 20 July 2025 02:20:15 Central European Summer Time William Breathitt Gray wrote:
> On Mon, Jun 02, 2025 at 06:19:17PM +0200, Nicolas Frattaroli wrote:
> > Among many other things, Rockchip's new PWMv4 IP in the RK3576 supports
> > PWM capture functionality.
> > 
> > Add a basic driver for this that works to capture period and duty cycle
> > values and return them as nanoseconds to the user. It's quite basic, but
> > works well enough to demonstrate the device function exclusion stuff
> > that mfpwm does, in order to eventually support all the functions of
> > this device in drivers within their appropriate subsystems, without them
> > interfering with each other.
> > 
> > Once enabled, the counter driver waits for enough high-to-low and
> > low-to-high interrupt signals to arrive, and then writes the cycle count
> > register values into some atomic members of the driver instance's state
> > struct. The read callback can then do the conversion from cycle count to
> > the more useful period and duty cycle nanosecond values, which require
> > knowledge of the clock rate, which requires a call that the interrupt
> > handler cannot make itself because said call may sleep.
> > 
> > To detect the condition of a PWM signal disappearing, i.e. turning off,
> > we modify the delay value of a delayed worker whose job it is to simply
> > set those atomic members to zero. Should the "timeout" so to speak be
> > reached, we assume the PWM signal is off. This isn't perfect; it
> > obviously introduces a latency between it being off and the counter
> > reporting it as such. Because there isn't a way to reset the internal
> > double-buffered cycle count in the hardware, we filter out unreliable
> > periods above the timeout value in the counter read callback.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> Hi Nicolas,

Hi William,

> 
> Would you help me understand the computations in this driver?
> 
> If I understand the purpose of this driver correctly, it's meant to
> compute the period and duty cycle of a PWM signal. What do LPC and HPC
> represent? I'm guessing they are the low period count (LPC) and the high
> period count (HPC). So then you calculate the total period by adding
> LPC and HPC, whereas the duty cycle derives from HPC.
> 
> Am I understanding the algorithm correctly? What are the units of HPC
> and LPC; are they ticks from the core clock? Are PWMV4_INT_LPC and
> PWM4_INT_HPC the change-of-state interrupts for LPC and HPC
> respectively?

HPC = High Polarity Cycles, LPC = Low Polarity Cycles. They are counted
based on the pwm clock that the hardware runs at. PWMV4_INT_LPC and
PWMV4_INT_HPC are one-bit flags that are raised in the interrupt register
of this hardware when the interrupt is fired, to signal that LPC or HPC
changed state.

Your understanding of the algorithm appears to be correct, from my memory
of when I wrote the code. The 4 captures left logic is because the
hardware needs 4 level transitions before it can provide a useful
number for those two counts; thinking about it more now, I'm surprised it
can't do it in 3, so I'll need to double-check that next time I work on
this.

As an aside note, Rockchip has recently published the RK3506 Technical
Reference Manual, and the RK3506 SoC uses the same PWM IP as the RK3576
for which this driver is for. You can find it here in Chapter 31:

https://opensource.rock-chips.com/images/3/36/Rockchip_RK3506_TRM_Part_1_V1.2-20250811.pdf

This driver specifically implements "31.3.1 Capture Mode", later down
the line I may want to add "31.3.4 Clock Counter", "31.3.5 Clock
Frequency Meter" and "31.3.6 Biphasic Counter" but I lack a proper
signal generator so didn't want to bite off more than I could test.

> 
> The Counter subsystem can be used to derive the period and duty cycle of
> a signal, but I believe there's a more idiomatic way to implement this.
> Existing counter drivers such as microchip-tcb-capture achieve this by
> leveraging Counter events exposed via the Counter chrdev interface.
> 
> The basic idea would be:
>     * Expose LPC and HPC as count0 and count1;
>     * Push the PWMV4_INT_LPC and PWMV4_INT_HPC interrupts as
>       COUNTER_EVENT_CHANGE_OF_STATE events on channel 0 and channel 1
>       respectively;
>     * Register Counter watches in userspace to capture LPC and HPC on
>       each interrupt;
> 
> The Counter chrdev interface records a timestamp in nanoseconds with
> each event capture. So to compute period and duty cycle, you would
> subtract the difference between two HPC/LPC captures; the difference in
> the timestamps gives you the elapsed time between the two captures in
> nanoseconds.
> 
> Would that design work for your use case?

Basically, any design would work for me. I've only implemented the
counter driver to make sure the PWM reading part of the hardware works,
and Uwe advised me that new PWM drivers should use the counter
subsystem as opposed to implementing the PWM capture operation.

So I think your design makes more sense; any user of this driver would
likely want it to work like the other counter drivers, and exposing
LPC and HPC directly would also let me get rid of the quirky "is the
PWM actually off now" logic.

I'll do this when I get the chance to work on this patch series again,
as it needs a rewrite anyway to plug it into the MFD subsystem.

> 
> William Breathitt Gray
> 

Thank you for your review and suggestions!

Kind regards,
Nicolas Frattaroli




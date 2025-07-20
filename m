Return-Path: <linux-pwm+bounces-6855-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 114E2B0B2F7
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Jul 2025 02:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EAAC17DC44
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Jul 2025 00:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3DD299;
	Sun, 20 Jul 2025 00:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp/L4yUe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7815A8;
	Sun, 20 Jul 2025 00:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752970847; cv=none; b=bdliAp7R8+2mWdd8i+nVCKYxKVKj4mMfeaACMf1DFIJVBREUhSRI6jQNt5iPx028EyYUrq6zXbbTVxDIf1xr2KB9RwoOn7lQxgt1/f9YxkGoHsLO4zBuRSCNwJbyYb5Wwi6h9V540FdLkXaVScyI6tNmQALWf13Ga36EUFUxIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752970847; c=relaxed/simple;
	bh=OtFSKnQJLty8pNLNiDG+01ViY9iOpad5TmroInGnKcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJTFZUSHxbx3356YFalhtkTTNo2d181UTWXY5Lln8e07Qw7tIf9QJJ3N2ZzODX8rMzAzWwCmfKYZv5Vyr8w6cOATA1TtzOrnICVr7sWtYPHdHQjnLOe75LStJIgguOLCr69LJvPJg0QZYyav3Wh3YvMelNM5qwe/vEZ7b+vNuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp/L4yUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF514C4CEE3;
	Sun, 20 Jul 2025 00:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752970846;
	bh=OtFSKnQJLty8pNLNiDG+01ViY9iOpad5TmroInGnKcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gp/L4yUeeuj6moNS7hE8ns2uEdOo4Nyg0bhcpd4SZ0ID+jaFjSLW4qjENp5xWKOxs
	 ba8zlU3l729BseY5uWou352gHYh1h/FgxSDKWrIyUfnCsVExiTxOQCXPXTKSGHn04e
	 Fr3B4B8EjJUZLppBfVeGODlDFcqnQerC6JLGlTJwFzDf40DACNofGhMJwffixr24qK
	 FwoRyYbnlLpwGXOo84BbZQj899W/CBoVmQerDv65bcQvKrpeCxCNx0T8uYn5Lmm4MC
	 jc7IQ/t1Ct51Hz605ZImGBeZZVVmGfcYGybqxA/S9eHoRo4jldYV/1sAIKwwqnd4gF
	 2yghXXgl36L3w==
From: William Breathitt Gray <wbg@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	kernel@collabora.com,
	Jonas Karlman <jonas@kwiboo.se>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v2 6/7] counter: Add rockchip-pwm-capture driver
Date: Sun, 20 Jul 2025 09:20:15 +0900
Message-ID: <20250720002024.696040-1-wbg@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250602-rk3576-pwm-v2-6-a6434b0ce60c@collabora.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3362; i=wbg@kernel.org; h=from:subject; bh=OtFSKnQJLty8pNLNiDG+01ViY9iOpad5TmroInGnKcw=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBk1ZoZ8Gz+aTdhw53D1hbVX5Nc3ZaxsPTyL8/YuN56Cw FKrq62WHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBEli5g+GcXl79B3f4I/867 8fImitd+ThGcE1JmLzIzvlMjR/6602qG/9H/Jmx+MC3/sEbhh10T7266ybuXNelCScrmxZ2RmW0 3XnMBAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Mon, Jun 02, 2025 at 06:19:17PM +0200, Nicolas Frattaroli wrote:
> Among many other things, Rockchip's new PWMv4 IP in the RK3576 supports
> PWM capture functionality.
> 
> Add a basic driver for this that works to capture period and duty cycle
> values and return them as nanoseconds to the user. It's quite basic, but
> works well enough to demonstrate the device function exclusion stuff
> that mfpwm does, in order to eventually support all the functions of
> this device in drivers within their appropriate subsystems, without them
> interfering with each other.
> 
> Once enabled, the counter driver waits for enough high-to-low and
> low-to-high interrupt signals to arrive, and then writes the cycle count
> register values into some atomic members of the driver instance's state
> struct. The read callback can then do the conversion from cycle count to
> the more useful period and duty cycle nanosecond values, which require
> knowledge of the clock rate, which requires a call that the interrupt
> handler cannot make itself because said call may sleep.
> 
> To detect the condition of a PWM signal disappearing, i.e. turning off,
> we modify the delay value of a delayed worker whose job it is to simply
> set those atomic members to zero. Should the "timeout" so to speak be
> reached, we assume the PWM signal is off. This isn't perfect; it
> obviously introduces a latency between it being off and the counter
> reporting it as such. Because there isn't a way to reset the internal
> double-buffered cycle count in the hardware, we filter out unreliable
> periods above the timeout value in the counter read callback.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Hi Nicolas,

Would you help me understand the computations in this driver?

If I understand the purpose of this driver correctly, it's meant to
compute the period and duty cycle of a PWM signal. What do LPC and HPC
represent? I'm guessing they are the low period count (LPC) and the high
period count (HPC). So then you calculate the total period by adding
LPC and HPC, whereas the duty cycle derives from HPC.

Am I understanding the algorithm correctly? What are the units of HPC
and LPC; are they ticks from the core clock? Are PWMV4_INT_LPC and
PWM4_INT_HPC the change-of-state interrupts for LPC and HPC
respectively?

The Counter subsystem can be used to derive the period and duty cycle of
a signal, but I believe there's a more idiomatic way to implement this.
Existing counter drivers such as microchip-tcb-capture achieve this by
leveraging Counter events exposed via the Counter chrdev interface.

The basic idea would be:
    * Expose LPC and HPC as count0 and count1;
    * Push the PWMV4_INT_LPC and PWMV4_INT_HPC interrupts as
      COUNTER_EVENT_CHANGE_OF_STATE events on channel 0 and channel 1
      respectively;
    * Register Counter watches in userspace to capture LPC and HPC on
      each interrupt;

The Counter chrdev interface records a timestamp in nanoseconds with
each event capture. So to compute period and duty cycle, you would
subtract the difference between two HPC/LPC captures; the difference in
the timestamps gives you the elapsed time between the two captures in
nanoseconds.

Would that design work for your use case?

William Breathitt Gray


Return-Path: <linux-pwm+bounces-7767-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61446CAA37A
	for <lists+linux-pwm@lfdr.de>; Sat, 06 Dec 2025 10:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BBD530131D8
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Dec 2025 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833D7239E7D;
	Sat,  6 Dec 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx700QVJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205819F137;
	Sat,  6 Dec 2025 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765013677; cv=none; b=U8wWPE7iXSioUXGGax/vOCSn/kmDG08kiSp2Ng43jq6BVcymaYWQ8wJNE+fjpMxJ+182g0Zc6zC9QeNwtmtaBoM29W7UGZITG2ZqxUwXAINYwSpM6LgPCZZsuZnxTBr4AiubcsIgJ+WWHeokjF0INqVwkUfLiVP+DTxB2hdiebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765013677; c=relaxed/simple;
	bh=LVpVlpi6OB57YEEuOdpQyyiZg0u6TcCf1CGA1h9vpBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPVeDaOyCunOHqWEcrsBA55neBDwopY9yN8bJWuGDcinL/ogFXBKMpctkL7lVrkhPU2aj1400zqgxd98xlJgPtl38lXEnw3CcCDcBhyyQWjpaqRhQuUXc7is1t9Yk6K1DPbzvZVNJm8gnYkwbX3L4eZOzvXF0sUGteFK10vJQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx700QVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3542CC4CEF5;
	Sat,  6 Dec 2025 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765013676;
	bh=LVpVlpi6OB57YEEuOdpQyyiZg0u6TcCf1CGA1h9vpBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bx700QVJbLTGUIeKm0O22TtLPhUtMrkFcl7fdbcJZVOwdiqeLbjF5hrQeiOdJCXdC
	 krutnylAbtSh9mi3fVU7U3Zf94ROz3cOezsxTnOp72rIOV1wxreOzIlSI3LBBeD3LU
	 PO4RKzI66ic6zAclhP+WlgH+vrzyXwxUkL21B+JxTy1WI87F8DejeP0TQie8riE1A1
	 G16crdFM3HpnnxUV/C4lSxpuDXimp0B9gJ+5vmkqIsU2HJGuob8KsyEnqSiWRlzeyZ
	 OdncME6viW0HhYT7EVURDb4SvohUqn4RP4h0A9yO8gWT3ZsGeoDPZNjQ2cBW8dTAYb
	 TYbJ2kwZIcq4g==
From: William Breathitt Gray <wbg@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Lee Jones <lee@kernel.org>,
	kernel@collabora.com,
	Jonas Karlman <jonas@kwiboo.se>,
	Alexey Charkov <alchark@gmail.com>,
	linux-rockchip@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 4/5] counter: Add rockchip-pwm-capture driver
Date: Sat,  6 Dec 2025 18:34:17 +0900
Message-ID: <20251206093419.40067-1-wbg@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251027-rk3576-pwm-v3-4-654a5cb1e3f8@collabora.com>
References: <20251027-rk3576-pwm-v3-4-654a5cb1e3f8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5608; i=wbg@kernel.org; h=from:subject; bh=LVpVlpi6OB57YEEuOdpQyyiZg0u6TcCf1CGA1h9vpBg=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJnGPyYceT6/uuOowkeJzKMXdru+8oyTXW/9KnZb0Npb5 7YnyTsHdJSyMIhxMciKKbL0mp+9++CSqsaPF/O3wcxhZQIZwsDFKQATKctj+B/fezxbrcnBZa22 wAYGEZnP65yLGeM210wtSArdtY9jiTYjwy/3uODLKTURuz+fPbGii+Pa+yd/Tl7sa/pnEH5pndn eClYA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

> +struct rockchip_pwm_capture {
> +	struct rockchip_mfpwm_func *pwmf;
> +	struct counter_device *counter;

Is this structure member used at all? If not, you should just remove it.

> +	bool is_enabled;

Does this device offer some way to probe whether PWM capture mode is
enabled? I suspect so, because I see PWM_ENABLE.pwm_en enables the
channel and PWM_CTRL.pwm_mode selects capture mode, so perhaps we're
able to read the current state of those registers. If you're able to
read those registers to determine the enable state, I'd suggest wrapping
that into a helper function and calling it when you need to determine
whether the capture mode is currently enabled.

If we're not able to probe the enable state, is it safe to assume we're
in a disabled state when the module loads, or should we ensure it by
unconditionally disabling PWM capture mode during
rockchip_pwm_capture_probe()?

> +	spinlock_t enable_lock;
> +};
> +
> +/*
> + * Channel 0 receives a state changed notification whenever the LPC interrupt
> + * fires.
> + *
> + * Channel 1 receives a state changed notification whenever the HPC interrupt
> + * fires.
> + */
> +static struct counter_signal rkpwmc_signals[] = {
> +	{
> +		.id = 0,
> +		.name = "Channel 0"
> +	},
> +	{
> +		.id = 1,
> +		.name = "Channel 1"
> +	},
> +};

From "31.3.1 Capture Mode" of the Rockchip RK3506 Technical Reference
Manual[^1], it looks like "clk_pwm" is the only signal that is counted
for PWM_HPC AND PWM_LPC. So instead of two Signals, you would have just
one Signal named "PWM Clock" which sources your two Synapses defined below.

Technically, "pwm_in" is also a signal evaluated (its polarity is used
to determine whether we're counting for PWM_HPC or PWM_LPC) but the
respective Synapse would be COUNTER_SYNAPSE_ACTION_NONE because this
signal not actually triggering the change in the count value. You're
welcome to add the "pwm_in" signal here if you like, but I'd say it's
optional if you actually want to expose it here.

> +static const enum counter_synapse_action rkpwmc_hpc_lpc_actions[] = {
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +
> +};

Add COUNTER_SYNAPSE_ACTION_NONE to this array. When the polarity is
high, the Synapse for PWM_HPC will be active with
COUNTER_SYNAPSE_ACTION_BOTH_EDGES, while the Synapse for PWM_LPC will be
inactive with COUNTER_SYNAPSE_ACTION_NONE; the inverse occurs when the
polarity switches to low.

> +static struct counter_synapse rkpwmc_pwm_synapses[] = {
> +	{
> +		.actions_list = rkpwmc_hpc_lpc_actions,
> +		.num_actions = ARRAY_SIZE(rkpwmc_hpc_lpc_actions),
> +		.signal = &rkpwmc_signals[0]
> +	},
> +	{
> +		.actions_list = rkpwmc_hpc_lpc_actions,
> +		.num_actions = ARRAY_SIZE(rkpwmc_hpc_lpc_actions),
> +		.signal = &rkpwmc_signals[1]
> +	},
> +};

Both Synapses are sourced by the same single Signal ("PWM Clock") so set
both "signal" members to &rkpwmc_signals[0].

> +enum rkpwmc_count_id {
> +	COUNT_LPC = 0,
> +	COUNT_HPC = 1,
> +};
> +
> +static struct counter_count rkpwmc_counts[] = {
> +	{
> +		.id = COUNT_LPC,
> +		.name = "PWM core clock cycles during which the signal was low",
> +		.functions_list = rkpwmc_functions,
> +		.num_functions = ARRAY_SIZE(rkpwmc_functions),
> +		.synapses = rkpwmc_pwm_synapses,
> +		.num_synapses = ARRAY_SIZE(rkpwmc_pwm_synapses),
> +		.ext = rkpwmc_ext,
> +		.num_ext = ARRAY_SIZE(rkpwmc_ext),
> +	},
> +	{
> +		.id = COUNT_HPC,
> +		.name = "PWM core clock cycles during which the signal was high",
> +		.functions_list = rkpwmc_functions,
> +		.num_functions = ARRAY_SIZE(rkpwmc_functions),
> +		.synapses = rkpwmc_pwm_synapses,
> +		.num_synapses = ARRAY_SIZE(rkpwmc_pwm_synapses),
> +		.ext = rkpwmc_ext,
> +		.num_ext = ARRAY_SIZE(rkpwmc_ext),
> +	},
> +};

Count names should be short and descriptive. I think the RK3506 manual
section "31.4.2 Registers Summary" description for the PWM_HPC and
PWM_LPC register do a pretty good job of that:

* Low Polarity Capture
* High Polarity Capture

How about changing the two Count names to those respectively?

> +static int rkpwmc_count_read(struct counter_device *counter,
> +			     struct counter_count *count, u64 *value)
> +{
> +	struct rockchip_pwm_capture *pc = counter_priv(counter);
> +
> +	guard(spinlock)(&pc->enable_lock);
> +
> +	if (!pc->is_enabled) {
> +		*value = 0;
> +		return 0;
> +	}

I don't think there's a need to check whether capture mode is disabled.
The user should be aware of the enable state of the Count by checking
the respective "enable" attribute; and if they ignore that, a value of
"0" doesn't inherently tell them that the Count is disabled which makes
it moot to do so. I'd suggest just removing this check entirely and
returning the register values unconditionally.

> +
> +	switch (count->id) {
> +	case COUNT_LPC:
> +		*value = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_LPC);
> +		return 0;
> +	case COUNT_HPC:
> +		*value = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_HPC);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct counter_ops rkpwmc_ops = {
> +	.count_read = rkpwmc_count_read,
> +};

You should implement a signal_read() callback if its possible to probe
the current state of PWM Clock. You should implement action_read() if
its possible to probe the current polarity of "pwm_in" in order to set
which Synapse is currently active.

William Breathitt Gray

[^1] https://opensource.rock-chips.com/images/3/36/Rockchip_RK3506_TRM_Part_1_V1.2-20250811.pdf


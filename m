Return-Path: <linux-pwm+bounces-8759-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3ZIDIq8n92kJdAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8759-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 03 May 2026 12:47:11 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C950E4B527E
	for <lists+linux-pwm@lfdr.de>; Sun, 03 May 2026 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F42013008769
	for <lists+linux-pwm@lfdr.de>; Sun,  3 May 2026 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96181282F2E;
	Sun,  3 May 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG3TWM1O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC71C5D44;
	Sun,  3 May 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777805227; cv=none; b=HXoBUUFWUGCKZiR0euW4OKEbbkWuL2jxwOdhw8Wh+67l9IYCGU56olNCLAJIcEfyRzww8zOerIQlQpxpf3t4CEhShkcHgtBAVc83CK9gLvIFnJYR8a8CJ87u0envQE6uXAQzvF70SgHRpYAGhd60V1MZqm6qbug/eWL+/78i33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777805227; c=relaxed/simple;
	bh=3pCV6LH2vYCWmblublKkhdz5LTIMxW5qGQGwzJOdVX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVJiOTY9XHRAzhD40iquTFL+mhDOjzbxb5QgVJCNNKVBVVV63y9cVJT6TCPOWanQ/vohVq1drlDHJLb9383yhvaNgjr6Tf/zv5RfHx4W/E/pxhMnCNUR2NmB3ve2LDAIJjUUxWW1ANIgko4wuD32bQwupDsAZNrMwWaC6m2j6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG3TWM1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D55C2BCB4;
	Sun,  3 May 2026 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777805227;
	bh=3pCV6LH2vYCWmblublKkhdz5LTIMxW5qGQGwzJOdVX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fG3TWM1OI4lfJrryBwdIAdznMDOynkpdZwkjn+94qy9ryuZ63cyDMfYzi8S2tttrF
	 LQkV3+9X4DgYua95Zh14HzfdI3uuWJjFHzQepL9ecI+iB6RelRvyl9mTspJOeK0Mcp
	 40U0W2lkPR58VnW8Kf4ce/cwqjG0a2kO26uE/j8KxPAd/Ffqx1v0YvckMjxoAgInsh
	 koiR2Q+6DeAjqR4oANnzSszFgfm/BKGstmVsLJVmuoSphzppCsVQIUqWLJR6gheZW2
	 ECtV7Dz+5WcF4814BWPgHkdl2kltuktC6+IDE7Ba+vAs/eUaUCO9x9mygNT3CrLGHc
	 dgX6i5kBujJHg==
From: William Breathitt Gray <wbg@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Lee Jones <lee@kernel.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	kernel@collabora.com,
	Jonas Karlman <jonas@kwiboo.se>,
	Alexey Charkov <alchark@gmail.com>,
	linux-rockchip@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 4/6] counter: Add rockchip-pwm-capture driver
Date: Sun,  3 May 2026 19:46:23 +0900
Message-ID: <20260503104624.459765-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260420-rk3576-pwm-v5-4-ae7cfbbe5427@collabora.com>
References: <20260420-rk3576-pwm-v5-4-ae7cfbbe5427@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6676; i=wbg@kernel.org; h=from:subject; bh=3pCV6LH2vYCWmblublKkhdz5LTIMxW5qGQGwzJOdVX4=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJnf1WOOPLL01ulYkW+90T/xlOzJv6dzgwQ3lk9Rt/h3c +pitsUnO0pZGMS4GGTFFFl6zc/efXBJVePHi/nbYOawMoEMYeDiFICJWDxj+F/u9FK8KipthVvW yvy/19g2f8l/fshgx8nnp958vVZnWcPNyPAzoaz5sN3KeOdpR2sXK6zl7zh+0ffthWsHTl88Wmy ovIoNAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C950E4B527E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,rock-chips.com,collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-8759-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wbg@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email]

On Mon, Apr 20, 2026 at 03:52:41PM +0200, Nicolas Frattaroli wrote:
> Among many other things, Rockchip's new PWMv4 IP in the RK3576 supports
> PWM capture functionality.
> 
> Add a basic driver for this that works to expose HPC/LPC counts and
> state change events to userspace through the counter framework. It's
> quite basic, but works well enough to demonstrate the device function
> exclusion stuff that mfpwm does, in order to eventually support all the
> functions of this device in drivers within their appropriate subsystems,
> without them interfering with each other.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Hi Nicolas,

Forgive me if I asked this before, but I'm having trouble finding it
online: do you have a link to a publicly available RK357 technical
reference manual? I think that will help me better understand how this
PWMv4 IP works.

Regardless, some comments inline below from my current understanding.

> +static struct counter_signal rkpwmc_signals[] = {
> +	{
> +		.id = 0,
> +		.name = "PWM Clock"
> +	},
> +};

If the capture mode is used to measure the duty cycle of the PWM input,
then we actually have two Signals to define here: "PWM Clock" and "PWM
Input".

I imagine the capture mode waveforms look something like this:

               __    __    __    __    __    __    __
    clk     __|  |__|  |__|  |__|  |__|  |__|  |__|  |__
    
                      __________________ LPC: 2 edges ____
    pwm_in  _________|   HPC: 3 edges   |____________|

So the level of the pwm_in signal is counted each rising edge of clk;
the number of clk edges while pwm_in is high is the HPC count, whereas
the number of clk edges while pwm_in is low is the LPC count.

In the Generic Counter paradigm, this would look like the following:

    Signals             Synapses              Counts
    =======             ========              ======
    +-----------+                               _______________________
    |           | <---- "Rising Edge" ---+---> /                       \
    |"PWM Clock"|                        |     |"High Polarity Capture"|
    |           |                    +---|---> \                       /
    +-----------+                    |   |      -----------------------
                                     |   |
    +-----------+                    |   |      _______________________
    |           |                    |   +---> /                       \
    |"PWM Input"|                    |         | "Low Polarity Capture |
    |           | <---- "None" ------+-------> \                       /
    +-----------+                               -----------------------

The key idea is that the clock and PWM input Signals are associated to
both Counts (HPC and LPC) through their respective Synapses. However,
while the clock Synapse ("Rising Edge") indicates the clock Signal
state triggers updates in the Counts, the PWM input Synapse ("None")
indicates the PWM input Signal state does not trigger but is simply
evaluated to determine the new Count value.

> +static const enum counter_synapse_action rkpwmc_hpc_lpc_actions[] = {
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +};

To simplify my above example, I assumed that the HPC and LPC counts are
only updated on rising edges of the clock Signal. If the Count values
actually update on both edges, then you don't need to make a change
here. Otherwise, change the "both edges" enum constant to "rising edge"
or "falling edge" as required.

> +static struct counter_synapse rkpwmc_pwm_synapses[] = {
> +	{
> +		.actions_list = rkpwmc_hpc_lpc_actions,
> +		.num_actions = ARRAY_SIZE(rkpwmc_hpc_lpc_actions),
> +		.signal = &rkpwmc_signals[0]
> +	},
> +};

Add a Synapse here for the "PWM Input" Signal.

You should also implement an action_read() callback. Check the value of
synapse->signal->id to determine which Signal is associated to the
Synapse and set the respective action; i.e. for the PWM clock set
COUNTER_SYNAPSE_ACTION_BOTH_EDGES, while for the PWM input set
COUNTER_SYNAPSE_ACTION_NONE.

> +static const enum counter_function rkpwmc_functions[] = {
> +	COUNTER_FUNCTION_INCREASE,
> +};

I wonder if we need a new enum counter_function constant to express
what's happening in this driver. In theory, the
COUNTER_FUNCTION_INCREASE represent a Count whose value only increases,
but what we're describing here is more of a duty cycle sample, right?

I haven't made up my mind on this, so for now you can stick with
COUNTER_FUNCTION_INCREASE. I'll reconsider it in the next revision.

> +static int rkpwmc_enable_write(struct counter_device *counter,
> +			       struct counter_count *count,
> +			       u8 enable)
> +{
> +	struct rockchip_pwm_capture *pc = counter_priv(counter);
> +	int ret;
> +
> +	ret = mfpwm_acquire(pc->pwmf);
> +	if (ret)
> +		return ret;
> +
> +	if (!!enable != rkpwmc_is_enabled(pc->pwmf)) {

The Counter subsystem gurantees enable is a boolean value so there's no
need for the double negation here in the conditional.

Also, instead of checking if the enable value is different from
rkpwm_is_enabled(), check if it is the same and exit early. That will
avoid the large conditional block as what you have inside can now move
outside after the conditional check.

> +		if (enable) {
> +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> +					 PWMV4_EN(false));
> +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_CTRL,
> +					 PWMV4_CTRL_CAP_FLAGS);
> +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_INT_EN,
> +					 PWMV4_INT_LPC_W(true) |
> +					 PWMV4_INT_HPC_W(true));
> +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> +					 PWMV4_EN(true) | PWMV4_CLK_EN(true));
> +
> +			ret = clk_enable(pc->pwmf->core);
> +			if (ret)
> +				goto err_release;
> +
> +			ret = clk_rate_exclusive_get(pc->pwmf->core);
> +			if (ret)
> +				goto err_disable_pwm_clk;
> +
> +			ret = mfpwm_acquire(pc->pwmf);
> +			if (ret)
> +				goto err_unprotect_pwm_clk;
> +		} else {
> +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_INT_EN,
> +					 PWMV4_INT_LPC_W(false) |
> +					 PWMV4_INT_HPC_W(false));
> +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> +					 PWMV4_EN(false) | PWMV4_CLK_EN(false));
> +			clk_rate_exclusive_put(pc->pwmf->core);
> +			clk_disable(pc->pwmf->core);
> +			mfpwm_release(pc->pwmf);
> +		}
> +	}
> +
> +	mfpwm_release(pc->pwmf);

The call to mfpwm_release() in the else block is redundant because it is
called immediately again here.

William Breathitt Gray


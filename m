Return-Path: <linux-pwm+bounces-5849-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F159AAAF6D7
	for <lists+linux-pwm@lfdr.de>; Thu,  8 May 2025 11:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100041C04AB1
	for <lists+linux-pwm@lfdr.de>; Thu,  8 May 2025 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2512641DE;
	Thu,  8 May 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YMzoFk1Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m3282.qiye.163.com (mail-m3282.qiye.163.com [220.197.32.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7B221294;
	Thu,  8 May 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746696941; cv=none; b=CxgGp30SyBGA/jMBMCZJWDS9QJFzAScXRlTdkTO+PmpqesbUOGG6VXCCdgySmraIVa4TrLOCGoPweNujrsCFBo8dWYYhf5VEH5t3C4ybyMbhQZ0wcYkWpue4I+BNBplaNbUzgJRfmr3JKCWCuGPhIehTtRB58bnXpxzF0WoTcJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746696941; c=relaxed/simple;
	bh=4eEACbyRyrL3GIa+V+Q42J3HTovhVzHNTNkS737EI5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIXt/oWk2iBxPenwaGrGcLCh+5emPTaeScwP0viKa9DqwrqqynS7KGBMY34+siEQL6MZZOtZNjXpflt9Lf5fW+CspVSLj4LoyxIBfM5AxBYIl0shw1AhLG85pyoyzPwsCV3cGEcRoXuYzQ/0UvREf/GLMWbN5N0Rtq/KCsZ1Re4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YMzoFk1Q; arc=none smtp.client-ip=220.197.32.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 145a410e0;
	Thu, 8 May 2025 15:13:01 +0800 (GMT+08:00)
Message-ID: <c4296af2-e7f1-4f5c-9f33-a6b5b2ddb244@rock-chips.com>
Date: Thu, 8 May 2025 15:13:01 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] soc: rockchip: add mfpwm driver
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, William Breathitt Gray <wbg@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>
References: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <20250408-rk3576-pwm-v1-4-a49286c2ca8e@collabora.com>
 <5559308.Sb9uPGUboI@diego> <3362145.mvXUDI8C0e@workhorse>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <3362145.mvXUDI8C0e@workhorse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlJQ1ZDGkgZT0tMS0hDHxpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96aebd927d03a3kunm145a410e0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSo6Ljo5CDJDSg8*N0kzTSk9
	OFEwCxRVSlVKTE9NTUNDSENISENJVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSEhDTzcG
DKIM-Signature:a=rsa-sha256;
	b=YMzoFk1Qp1pR1/JUCHh5psK6u8ofTJw+CyC3fAnpP1pldZKl7dePcu9En22Oddc2WFqgguFF3qHj9O32KbNKBUP6apGGDMECgBy1ZYSuhtwDhfAZ8FhY+EYfVU9jKdm5r0cvYe82BjbqHXFdn/4y4WzXzJVTTXzIPvQ4dhX0X58=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=q1j4CdOQSMAZG/JE09mATkCWC/+UCfMM4ry4j1wAOeo=;
	h=date:mime-version:subject:message-id:from;

Hi Nicolas:

On 2025/4/9 21:01, Nicolas Frattaroli wrote:
> On Tuesday, 8 April 2025 22:03:01 Central European Summer Time Heiko Stübner wrote:
>> Hi,
>>
>> not a full review, just me making a first pass.
>>
>>> +unsigned long mfpwm_clk_get_rate(struct rockchip_mfpwm *mfpwm)
>>> +{
>>> +	if (!mfpwm || !mfpwm->chosen_clk)
>>> +		return 0;
>>> +
>>> +	return clk_get_rate(mfpwm->chosen_clk);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(mfpwm_clk_get_rate, "ROCKCHIP_MFPWM");
>>
>> aren't you just re-implemeting a clk-mux with the whole chosen-clk
>> mechanism? See drivers/clk/clk-mux.c, so in theory you should be
>> able to just do a clk_register_mux(...) similar to for example
>> sound/soc/samsung/i2s.c .
> 
> Probably yes. I didn't know clk-mux was a thing. If I do decide to keep the
> clock switching at all (more on that below), then I'll rewrite it around
> clk-mux.
> 
>>> +
>>> +__attribute__((nonnull))
>>> +static int mfpwm_do_acquire(struct rockchip_mfpwm_func *pwmf)
>>> +{
>>> +	struct rockchip_mfpwm *mfpwm = pwmf->parent;
>>> +	unsigned int cnt;
>>> +
>>> +	if (mfpwm->active_func && pwmf->id != mfpwm->active_func->id)
>>> +		return -EBUSY;
>>> +
>>> +	if (!mfpwm->active_func)
>>> +		mfpwm->active_func = pwmf;
>>> +
>>> +	if (!check_add_overflow(mfpwm->acquire_cnt, 1, &cnt)) {
>>> +		mfpwm->acquire_cnt = cnt;
>>> +	} else {
>>> +		WARN(1, "prevented acquire counter overflow in %s\n", __func__);
>>
>> dev_warn, as you have the mfpwm pointing to a pdev?
> 
> Will do.
> 
>>> +		return -EOVERFLOW;
>>> +	}
>>> +
>>> +	dev_dbg(&mfpwm->pdev->dev, "%d acquired mfpwm, acquires now at %u\n",
>>> +		pwmf->id, mfpwm->acquire_cnt);
>>> +
>>> +	return clk_enable(mfpwm->pclk);
>>> +}
>>
>>> +/**
>>> + * mfpwm_get_clk_src - read the currently selected clock source
>>> + * @mfpwm: pointer to the driver's private &struct rockchip_mfpwm instance
>>> + *
>>> + * Read the device register to extract the currently selected clock source,
>>> + * and return it.
>>> + *
>>> + * Returns:
>>> + * * the numeric clock source ID on success, 0 <= id <= 2
>>> + * * negative errno on error
>>> + */
>>> +static int mfpwm_get_clk_src(struct rockchip_mfpwm *mfpwm)
>>> +{
>>> +	u32 val;
>>> +
>>> +	clk_enable(mfpwm->pclk);
>>> +	val = mfpwm_reg_read(mfpwm->base, PWMV4_REG_CLK_CTRL);
>>> +	clk_disable(mfpwm->pclk);
>>> +
>>> +	return (val & PWMV4_CLK_SRC_MASK) >> PWMV4_CLK_SRC_SHIFT;
>>> +}
>>> +
>>> +static int mfpwm_choose_clk(struct rockchip_mfpwm *mfpwm)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = mfpwm_get_clk_src(mfpwm);
>>> +	if (ret < 0) {
>>> +		dev_err(&mfpwm->pdev->dev, "couldn't get current clock source: %pe\n",
>>> +			ERR_PTR(ret));
>>> +		return ret;
>>> +	}
>>> +	if (ret == PWMV4_CLK_SRC_CRYSTAL) {
>>> +		if (mfpwm->osc_clk) {
>>> +			mfpwm->chosen_clk = mfpwm->osc_clk;
>>> +		} else {
>>> +			dev_warn(&mfpwm->pdev->dev, "initial state wanted 'osc' as clock source, but it's unavailable. Defaulting to 'pwm'.\n");
>>> +			mfpwm->chosen_clk = mfpwm->pwm_clk;
>>> +		}
>>> +	} else {
>>> +		mfpwm->chosen_clk = mfpwm->pwm_clk;
>>> +	}
>>> +
>>> +	return clk_rate_exclusive_get(mfpwm->chosen_clk);
>>> +}
>>>
>>> +/**
>>> + * mfpwm_switch_clk_src - switch between PWM clock sources
>>> + * @mfpwm: pointer to &struct rockchip_mfpwm driver data
>>> + * @clk_src: one of either %PWMV4_CLK_SRC_CRYSTAL or %PWMV4_CLK_SRC_PLL
>>> + *
>>> + * Switch between clock sources, ``_exclusive_put``ing the old rate,
>>> + * ``clk_rate_exclusive_get``ing the new one, writing the registers and
>>> + * swapping out the &struct_rockchip_mfpwm->chosen_clk.
>>> + *
>>> + * Returns:
>>> + * * %0        - Success
>>> + * * %-EINVAL  - A wrong @clk_src was given or it is unavailable
>>> + * * %-EBUSY   - Device is currently in use, try again later
>>> + */
>>> +__attribute__((nonnull))
>>> +static int mfpwm_switch_clk_src(struct rockchip_mfpwm *mfpwm,
>>> +					  unsigned int clk_src)
>>> +{
>>> +	struct clk *prev;
>>> +	int ret = 0;
>>> +
>>> +	scoped_cond_guard(spinlock_try, return -EBUSY, &mfpwm->state_lock) {
>>> +		/* Don't fiddle with any of this stuff if the PWM is on */
>>> +		if (mfpwm->active_func)
>>> +			return -EBUSY;
>>> +
>>> +		prev = mfpwm->chosen_clk;
>>> +		ret = mfpwm_get_clk_src(mfpwm);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +		if (ret == clk_src)
>>> +			return 0;
>>> +
>>> +		switch (clk_src) {
>>> +		case PWMV4_CLK_SRC_PLL:
>>> +			mfpwm->chosen_clk = mfpwm->pwm_clk;
>>> +			break;
>>> +		case PWMV4_CLK_SRC_CRYSTAL:
>>> +			if (!mfpwm->osc_clk)
>>> +				return -EINVAL;
>>> +			mfpwm->chosen_clk = mfpwm->osc_clk;
>>> +			break;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +
>>> +		clk_enable(mfpwm->pclk);
>>> +
>>> +		mfpwm_reg_write(mfpwm->base, PWMV4_REG_CLK_CTRL,
>>> +				PWMV4_CLK_SRC(clk_src));
>>> +		clk_rate_exclusive_get(mfpwm->chosen_clk);
>>> +		if (prev)
>>> +			clk_rate_exclusive_put(prev);
>>> +
>>> +		clk_disable(mfpwm->pclk);
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>

First of all, I'm truly delighted to see your nice PWM v4 driver codes. 
I was once intensely struggling with porting the v4 PWM implementation 
into the Linux 6.1 ​​PWM framework. ;-)

>> ok, the relevant part might be the
>> 	/* Don't fiddle with any of this stuff if the PWM is on */
>> thing, which will require special set_rate operation, but in general I
>> think, if it ticks like a clock, it probably should be a real clock ;-) .
> 
> I agree; we can guarantee it doesn't get changed after all by just marking it
> as exclusive instead of marking either pwm_clk or osc_clk as exclusive.
> 
>>> +static ssize_t chosen_clock_show(struct device *dev,
>>> +				 struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct rockchip_mfpwm *mfpwm = dev_get_drvdata(dev);
>>> +	unsigned long clk_src = 0;
>>> +
>>> +	/*
>>> +	 * Why the weird indirection here? I have the suspicion that if we
>>> +	 * emitted to sysfs with the lock still held, then a nefarious program
>>> +	 * could hog the lock by somehow forcing a full buffer condition and
>>> +	 * then refusing to read from it. Don't know whether that's feasible
>>> +	 * to achieve in reality, but I don't want to find out the hard way
>>> +	 * either.
>>> +	 */
>>> +	scoped_guard(spinlock, &mfpwm->state_lock) {
>>> +		if (mfpwm->chosen_clk == mfpwm->pwm_clk)
>>> +			clk_src = PWMV4_CLK_SRC_PLL;
>>> +		else if (mfpwm->osc_clk && mfpwm->chosen_clk == mfpwm->osc_clk)
>>> +			clk_src = PWMV4_CLK_SRC_CRYSTAL;
>>> +		else
>>> +			return -ENODEV;
>>> +	}
>>> +
>>> +	if (clk_src == PWMV4_CLK_SRC_PLL)
>>> +		return sysfs_emit(buf, "pll\n");
>>> +	else if (clk_src == PWMV4_CLK_SRC_CRYSTAL)
>>> +		return sysfs_emit(buf, "crystal\n");
>>> +
>>> +	return -ENODEV;
>>> +}
>>
>> which brings me to my main point of contention. Why does userspace
>> need to select a clock source for the driver via sysfs.
> 
> It doesn't need to. Basically, this is a weird hardware feature. Downstream did
> not bother implementing it at all, and I found out through the TRM's register
> listing and thought "that's weird, I wonder if it even works", and lo and behold
> it does. At that point, like two rewrites ago, I was committed to ensuring that
> the driver can handle this edge case of the PWM clock being changed. As I lacked
> the imagination as to why someone would change it and the knowledge as to which
> kernel interfaces exist to change it, sysfs offered itself as a natural dumping
> ground for switches that probably shouldn't exist.
> 
>> Neither the commit message nor the code does seem to explain that,
>> or I'm just blind - which is also a real possibility.
>>
>> In general I really think, userspace should not need to care about if
>> a PLL or directly the oscillator is used a clock input.
>> I assume which is needed results from some runtime factor, so the
>> driver should be able to select the correct one?
>>
>> A mux-clock could ust use clk_mux_determine_rate_flags() to select
>> the best parent depending on a requested rate instead.
> 
> Yeah, the only use-case I can come up with is that we really want to use an
> either 100 MHz or 50 MHz clock on one chip, but have a channel hit a precise
> timing with the 24 MHz clock on the same chip. If the fixed crystal oscillator
> were 25 MHz instead of 24 MHz, this would be entirely pointless, as they're all
> multiples of it.
> 

The 24MHz OSC clock source is mainly for the use of the IR input, which 
is also called the power key capture mode. When the system enters 
suspend state, it relies on the OSC to ensure the PWM remains 
operational and can serve as a system wake-up source.

In addition, the PWM v4 also supports the 400KHz RC clock source for the 
wave generator mode, and it can be used for the deeper sleep state.

> Thanks for the hint about clk_mux_determine_rate_flags, it doesn't appear to be
> documented (classic) but it looks to do at least half of what a proper solution
> would need to do. The other half is figuring out what ideal target rate we
> actually want to optimise for for a given e.g. waveform consisting of period
> and duty cycle in nanoseconds. There's some logic to think about regarding where
> rounding errors are acceptable, e.g. a long period with a low duty cycle is
> probably better off using the 100-50-24 mux with 100 MHz as the rate. I'm not
> sure if 50 MHz is ever a sensible option since it is a dividend of 100 MHz, and
> I'm not about to reason about imagined power draw of the PWM hardware without
> laboratory grade test equipment.
> 
> For what it's worth, this is a niche enough hardware feature that if it causes
> too much friction getting it supported in a driver, I'll just drop it entirely
> instead. I tried to preemptively combat technical debt by supporting this in
> some way, but instead managed to introduce scope creep.
> 
> One option is to always just choose the PLL muxed clock and then always set it
> to 100 MHz, because it's probably the best option unless there are specific
> PWM-based applications that make heavy use of 24-derived timings (maybe the IR
> stuff?)
> 
>>
>>> +static ssize_t chosen_clock_store(struct device *dev,
>>> +				  struct device_attribute *attr,
>>> +				  const char *buf, size_t count)
>>> +{
>>> +	struct rockchip_mfpwm *mfpwm = dev_get_drvdata(dev);
>>> +	int ret;
>>> +
>>> +	if (sysfs_streq(buf, "pll")) {
>>> +		ret = mfpwm_switch_clk_src(mfpwm, PWMV4_CLK_SRC_PLL);
>>> +		if (ret)
>>> +			return ret;
>>> +		return count;
>>> +	} else if (sysfs_streq(buf, "crystal")) {
>>> +		ret = mfpwm_switch_clk_src(mfpwm, PWMV4_CLK_SRC_CRYSTAL);
>>> +		if (ret)
>>> +			return ret;
>>> +		return count;
>>> +	} else {
>>> +		return -EINVAL;
>>> +	}
>>> +}
>>> +
>>> +static DEVICE_ATTR_RW(chosen_clock);
>>> +
>>> +static ssize_t available_clocks_show(struct device *dev,
>>> +				     struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct rockchip_mfpwm *mfpwm = dev_get_drvdata(dev);
>>> +	ssize_t size = 0;
>>> +
>>> +	size += sysfs_emit_at(buf, size, "pll\n");
>>> +	if (mfpwm->osc_clk)
>>> +		size += sysfs_emit_at(buf, size, "crystal\n");
>>> +
>>> +	return size;
>>> +}
>>> +
>>> +static DEVICE_ATTR_RO(available_clocks);
>>> +
>>> +static struct attribute *mfpwm_attrs[] = {
>>> +	&dev_attr_available_clocks.attr,
>>> +	&dev_attr_chosen_clock.attr,
>>> +	NULL,
>>> +};
>>
>> Not understanding the need for the sysfs stuff was my main point this
>> evening :-)
>>
>> Heiko
>>
> 
> Thank you for your quick preliminary review! This already gives me some good
> points to look into for a v2.
> 

I'm eagerly looking forward to your v2 patch submission, and I will 
thoroughly validate the proper functioning of the PWM 
backlight/regulator based on your code changes.

Best regards,
Damon



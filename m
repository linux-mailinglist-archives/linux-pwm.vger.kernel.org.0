Return-Path: <linux-pwm+bounces-5400-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F5BA82588
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB873AB1B1
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FF025E820;
	Wed,  9 Apr 2025 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="U5Ze5L32"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC625634;
	Wed,  9 Apr 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203741; cv=pass; b=kKrY3jqQ8N1JA/DpuWVepVm/7fSuDim1sjjS/JebNPyP8Qr+IiwJaRG4uC5l0mUE6D9aRCCi7Nr2y9KKBD8gYTH3l5CjTkHZ7LGOhPjQhzq1u4XMX5hOWPT2aGIH3Mj0nqBu6AXeU8CLJAnT8jX+EycQSasjt9VApiID8eOQEcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203741; c=relaxed/simple;
	bh=fJCRIdvfNIin7h3bUErme7A3yqHBqeHhSkc/RmGxjxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RazT1BjFI4heaabuUwyEWZrwbQAyDtPEQp7l03Dn34LvxHkhKu0k/e0T0Ut0Y9nEDH2OFOLGKYFEqqnsilxov98Bdsey50Wn59/hPxs8mRlarQI5Dfn97zvoFS1LpUqV/pWDVjFmVf3Tb6yd+fB4WsTJeB9K+wXxSNqpcZbxp1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=U5Ze5L32; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744203700; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nqF/dZ/ZJmPpsF+zuJVRYR6v2/GGtjr42uD+/aZQ5PBrWi4fN4jt5b3N153fLgHPfgx1BvhY/byBv97VIiwsLqk8qi6+i2SzydnS4uLfbC4VGeusoW/SbVftEhLqzWZopJOOHLibYUzih3oCFaPerXsYs0Vj4rltpA5xXRuItJE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744203700; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=U+QoT2IyJTsl4lBDNM3YDzV0X1IfFE9Y/W4KVU4CS7M=; 
	b=EuUSJEljX7eD5WlXjT8V4urpU/ITkOC8USzXoNUyoG0xjE+3fPBWv2E5BbhiAYP/oSlnrw/oLpDBM1PrWPv2teaDhHaL4DVsiL8zDJeFd/W533RcNMIGOQTNtSbBzary/SlqUY7laO/W9boVOA4+rwnqnuq7nLHqxdZ2zfAiVlI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744203699;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=U+QoT2IyJTsl4lBDNM3YDzV0X1IfFE9Y/W4KVU4CS7M=;
	b=U5Ze5L32qzWPB68f4ekcTdFf4WLdofjD58DI3WZnba5Ow9rWxutxMt9YWA5ryDMn
	u56NCov5U2ZhbEqPz6wfNCw/9Zobon98zd+phh7947BLHn/q+NIkN73PYtxE5idfZ0F
	zN7RhFi3GmkCT/bwq8MqfUKmbAmJdMvBn2LZg270=
Received: by mx.zohomail.com with SMTPS id 1744203697644149.25126288812328;
	Wed, 9 Apr 2025 06:01:37 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 William Breathitt Gray <wbg@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 4/7] soc: rockchip: add mfpwm driver
Date: Wed, 09 Apr 2025 15:01:30 +0200
Message-ID: <3362145.mvXUDI8C0e@workhorse>
In-Reply-To: <5559308.Sb9uPGUboI@diego>
References:
 <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <20250408-rk3576-pwm-v1-4-a49286c2ca8e@collabora.com>
 <5559308.Sb9uPGUboI@diego>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 8 April 2025 22:03:01 Central European Summer Time Heiko St=C3=
=BCbner wrote:
> Hi,
>=20
> not a full review, just me making a first pass.
>=20
> > +unsigned long mfpwm_clk_get_rate(struct rockchip_mfpwm *mfpwm)
> > +{
> > +	if (!mfpwm || !mfpwm->chosen_clk)
> > +		return 0;
> > +
> > +	return clk_get_rate(mfpwm->chosen_clk);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(mfpwm_clk_get_rate, "ROCKCHIP_MFPWM");
>=20
> aren't you just re-implemeting a clk-mux with the whole chosen-clk
> mechanism? See drivers/clk/clk-mux.c, so in theory you should be
> able to just do a clk_register_mux(...) similar to for example
> sound/soc/samsung/i2s.c .

Probably yes. I didn't know clk-mux was a thing. If I do decide to keep the
clock switching at all (more on that below), then I'll rewrite it around
clk-mux.

> > +
> > +__attribute__((nonnull))
> > +static int mfpwm_do_acquire(struct rockchip_mfpwm_func *pwmf)
> > +{
> > +	struct rockchip_mfpwm *mfpwm =3D pwmf->parent;
> > +	unsigned int cnt;
> > +
> > +	if (mfpwm->active_func && pwmf->id !=3D mfpwm->active_func->id)
> > +		return -EBUSY;
> > +
> > +	if (!mfpwm->active_func)
> > +		mfpwm->active_func =3D pwmf;
> > +
> > +	if (!check_add_overflow(mfpwm->acquire_cnt, 1, &cnt)) {
> > +		mfpwm->acquire_cnt =3D cnt;
> > +	} else {
> > +		WARN(1, "prevented acquire counter overflow in %s\n", __func__);
>=20
> dev_warn, as you have the mfpwm pointing to a pdev?

Will do.

> > +		return -EOVERFLOW;
> > +	}
> > +
> > +	dev_dbg(&mfpwm->pdev->dev, "%d acquired mfpwm, acquires now at %u\n",
> > +		pwmf->id, mfpwm->acquire_cnt);
> > +
> > +	return clk_enable(mfpwm->pclk);
> > +}
>=20
> > +/**
> > + * mfpwm_get_clk_src - read the currently selected clock source
> > + * @mfpwm: pointer to the driver's private &struct rockchip_mfpwm inst=
ance
> > + *
> > + * Read the device register to extract the currently selected clock so=
urce,
> > + * and return it.
> > + *
> > + * Returns:
> > + * * the numeric clock source ID on success, 0 <=3D id <=3D 2
> > + * * negative errno on error
> > + */
> > +static int mfpwm_get_clk_src(struct rockchip_mfpwm *mfpwm)
> > +{
> > +	u32 val;
> > +
> > +	clk_enable(mfpwm->pclk);
> > +	val =3D mfpwm_reg_read(mfpwm->base, PWMV4_REG_CLK_CTRL);
> > +	clk_disable(mfpwm->pclk);
> > +
> > +	return (val & PWMV4_CLK_SRC_MASK) >> PWMV4_CLK_SRC_SHIFT;
> > +}
> > +
> > +static int mfpwm_choose_clk(struct rockchip_mfpwm *mfpwm)
> > +{
> > +	int ret;
> > +
> > +	ret =3D mfpwm_get_clk_src(mfpwm);
> > +	if (ret < 0) {
> > +		dev_err(&mfpwm->pdev->dev, "couldn't get current clock source: %pe\n=
",
> > +			ERR_PTR(ret));
> > +		return ret;
> > +	}
> > +	if (ret =3D=3D PWMV4_CLK_SRC_CRYSTAL) {
> > +		if (mfpwm->osc_clk) {
> > +			mfpwm->chosen_clk =3D mfpwm->osc_clk;
> > +		} else {
> > +			dev_warn(&mfpwm->pdev->dev, "initial state wanted 'osc' as clock so=
urce, but it's unavailable. Defaulting to 'pwm'.\n");
> > +			mfpwm->chosen_clk =3D mfpwm->pwm_clk;
> > +		}
> > +	} else {
> > +		mfpwm->chosen_clk =3D mfpwm->pwm_clk;
> > +	}
> > +
> > +	return clk_rate_exclusive_get(mfpwm->chosen_clk);
> > +}
> >
> > +/**
> > + * mfpwm_switch_clk_src - switch between PWM clock sources
> > + * @mfpwm: pointer to &struct rockchip_mfpwm driver data
> > + * @clk_src: one of either %PWMV4_CLK_SRC_CRYSTAL or %PWMV4_CLK_SRC_PLL
> > + *
> > + * Switch between clock sources, ``_exclusive_put``ing the old rate,
> > + * ``clk_rate_exclusive_get``ing the new one, writing the registers and
> > + * swapping out the &struct_rockchip_mfpwm->chosen_clk.
> > + *
> > + * Returns:
> > + * * %0        - Success
> > + * * %-EINVAL  - A wrong @clk_src was given or it is unavailable
> > + * * %-EBUSY   - Device is currently in use, try again later
> > + */
> > +__attribute__((nonnull))
> > +static int mfpwm_switch_clk_src(struct rockchip_mfpwm *mfpwm,
> > +					  unsigned int clk_src)
> > +{
> > +	struct clk *prev;
> > +	int ret =3D 0;
> > +
> > +	scoped_cond_guard(spinlock_try, return -EBUSY, &mfpwm->state_lock) {
> > +		/* Don't fiddle with any of this stuff if the PWM is on */
> > +		if (mfpwm->active_func)
> > +			return -EBUSY;
> > +
> > +		prev =3D mfpwm->chosen_clk;
> > +		ret =3D mfpwm_get_clk_src(mfpwm);
> > +		if (ret < 0)
> > +			return ret;
> > +		if (ret =3D=3D clk_src)
> > +			return 0;
> > +
> > +		switch (clk_src) {
> > +		case PWMV4_CLK_SRC_PLL:
> > +			mfpwm->chosen_clk =3D mfpwm->pwm_clk;
> > +			break;
> > +		case PWMV4_CLK_SRC_CRYSTAL:
> > +			if (!mfpwm->osc_clk)
> > +				return -EINVAL;
> > +			mfpwm->chosen_clk =3D mfpwm->osc_clk;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		clk_enable(mfpwm->pclk);
> > +
> > +		mfpwm_reg_write(mfpwm->base, PWMV4_REG_CLK_CTRL,
> > +				PWMV4_CLK_SRC(clk_src));
> > +		clk_rate_exclusive_get(mfpwm->chosen_clk);
> > +		if (prev)
> > +			clk_rate_exclusive_put(prev);
> > +
> > +		clk_disable(mfpwm->pclk);
> > +	}
> > +
> > +	return ret;
> > +}
>=20
> ok, the relevant part might be the=20
> 	/* Don't fiddle with any of this stuff if the PWM is on */
> thing, which will require special set_rate operation, but in general I
> think, if it ticks like a clock, it probably should be a real clock ;-) .

I agree; we can guarantee it doesn't get changed after all by just marking =
it
as exclusive instead of marking either pwm_clk or osc_clk as exclusive.

> > +static ssize_t chosen_clock_show(struct device *dev,
> > +				 struct device_attribute *attr, char *buf)
> > +{
> > +	struct rockchip_mfpwm *mfpwm =3D dev_get_drvdata(dev);
> > +	unsigned long clk_src =3D 0;
> > +
> > +	/*
> > +	 * Why the weird indirection here? I have the suspicion that if we
> > +	 * emitted to sysfs with the lock still held, then a nefarious program
> > +	 * could hog the lock by somehow forcing a full buffer condition and
> > +	 * then refusing to read from it. Don't know whether that's feasible
> > +	 * to achieve in reality, but I don't want to find out the hard way
> > +	 * either.
> > +	 */
> > +	scoped_guard(spinlock, &mfpwm->state_lock) {
> > +		if (mfpwm->chosen_clk =3D=3D mfpwm->pwm_clk)
> > +			clk_src =3D PWMV4_CLK_SRC_PLL;
> > +		else if (mfpwm->osc_clk && mfpwm->chosen_clk =3D=3D mfpwm->osc_clk)
> > +			clk_src =3D PWMV4_CLK_SRC_CRYSTAL;
> > +		else
> > +			return -ENODEV;
> > +	}
> > +
> > +	if (clk_src =3D=3D PWMV4_CLK_SRC_PLL)
> > +		return sysfs_emit(buf, "pll\n");
> > +	else if (clk_src =3D=3D PWMV4_CLK_SRC_CRYSTAL)
> > +		return sysfs_emit(buf, "crystal\n");
> > +
> > +	return -ENODEV;
> > +}
>=20
> which brings me to my main point of contention. Why does userspace
> need to select a clock source for the driver via sysfs.

It doesn't need to. Basically, this is a weird hardware feature. Downstream=
 did
not bother implementing it at all, and I found out through the TRM's regist=
er
listing and thought "that's weird, I wonder if it even works", and lo and b=
ehold
it does. At that point, like two rewrites ago, I was committed to ensuring =
that
the driver can handle this edge case of the PWM clock being changed. As I l=
acked
the imagination as to why someone would change it and the knowledge as to w=
hich
kernel interfaces exist to change it, sysfs offered itself as a natural dum=
ping
ground for switches that probably shouldn't exist.

> Neither the commit message nor the code does seem to explain that,
> or I'm just blind - which is also a real possibility.
>=20
> In general I really think, userspace should not need to care about if
> a PLL or directly the oscillator is used a clock input.
> I assume which is needed results from some runtime factor, so the
> driver should be able to select the correct one?
>=20
> A mux-clock could ust use clk_mux_determine_rate_flags() to select
> the best parent depending on a requested rate instead.

Yeah, the only use-case I can come up with is that we really want to use an
either 100 MHz or 50 MHz clock on one chip, but have a channel hit a precise
timing with the 24 MHz clock on the same chip. If the fixed crystal oscilla=
tor
were 25 MHz instead of 24 MHz, this would be entirely pointless, as they're=
 all
multiples of it.

Thanks for the hint about clk_mux_determine_rate_flags, it doesn't appear t=
o be
documented (classic) but it looks to do at least half of what a proper solu=
tion
would need to do. The other half is figuring out what ideal target rate we
actually want to optimise for for a given e.g. waveform consisting of period
and duty cycle in nanoseconds. There's some logic to think about regarding =
where
rounding errors are acceptable, e.g. a long period with a low duty cycle is
probably better off using the 100-50-24 mux with 100 MHz as the rate. I'm n=
ot
sure if 50 MHz is ever a sensible option since it is a dividend of 100 MHz,=
 and
I'm not about to reason about imagined power draw of the PWM hardware witho=
ut
laboratory grade test equipment.

=46or what it's worth, this is a niche enough hardware feature that if it c=
auses
too much friction getting it supported in a driver, I'll just drop it entir=
ely
instead. I tried to preemptively combat technical debt by supporting this in
some way, but instead managed to introduce scope creep.

One option is to always just choose the PLL muxed clock and then always set=
 it
to 100 MHz, because it's probably the best option unless there are specific
PWM-based applications that make heavy use of 24-derived timings (maybe the=
 IR
stuff?)

>=20
> > +static ssize_t chosen_clock_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf, size_t count)
> > +{
> > +	struct rockchip_mfpwm *mfpwm =3D dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	if (sysfs_streq(buf, "pll")) {
> > +		ret =3D mfpwm_switch_clk_src(mfpwm, PWMV4_CLK_SRC_PLL);
> > +		if (ret)
> > +			return ret;
> > +		return count;
> > +	} else if (sysfs_streq(buf, "crystal")) {
> > +		ret =3D mfpwm_switch_clk_src(mfpwm, PWMV4_CLK_SRC_CRYSTAL);
> > +		if (ret)
> > +			return ret;
> > +		return count;
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static DEVICE_ATTR_RW(chosen_clock);
> > +
> > +static ssize_t available_clocks_show(struct device *dev,
> > +				     struct device_attribute *attr, char *buf)
> > +{
> > +	struct rockchip_mfpwm *mfpwm =3D dev_get_drvdata(dev);
> > +	ssize_t size =3D 0;
> > +
> > +	size +=3D sysfs_emit_at(buf, size, "pll\n");
> > +	if (mfpwm->osc_clk)
> > +		size +=3D sysfs_emit_at(buf, size, "crystal\n");
> > +
> > +	return size;
> > +}
> > +
> > +static DEVICE_ATTR_RO(available_clocks);
> > +
> > +static struct attribute *mfpwm_attrs[] =3D {
> > +	&dev_attr_available_clocks.attr,
> > +	&dev_attr_chosen_clock.attr,
> > +	NULL,
> > +};
>=20
> Not understanding the need for the sysfs stuff was my main point this
> evening :-)
>=20
> Heiko
>=20

Thank you for your quick preliminary review! This already gives me some good
points to look into for a v2.

Kind regards,
Nicolas Frattaroli




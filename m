Return-Path: <linux-pwm+bounces-7934-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE1D3AD27
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 15:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC5113008C42
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE289327783;
	Mon, 19 Jan 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+EN7LOJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B646236437;
	Mon, 19 Jan 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833444; cv=none; b=CVa+Yqfxh1f8aZERW6aDAfQVd2Ob4dE8bjw1Y+XrT9RAqSii8B6I5yxsjTQduv8i4vRs0YU6ppo3RvQJ3rRRqJXOzfqXvNWNdfckz2+Lc5Hj3esEQ+g3+MSw7unePj2thTGri3icHAzkzCQF9VpRBdLKrqvFdEUOCfSjGeKlnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833444; c=relaxed/simple;
	bh=CSTmPBA6jWnROZuwiJTIQySlhBcVu9NnVrQTCL3GAR4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=KJUTwt3U9oue1WtBeLTj8zVCaLmeEuDMpWHUWwK/2GOJnGowX0CX71HSGVD4Y7ETYdlLirghC4gPYpAkP6LRabjhmgKbxMpeH+5kMjsqv6HbMUl/mVLByoQv/Run5zOGzXTIMRDMG2AGZWQjJtovXdrV4V8j5naG2czS3MGxIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+EN7LOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64A4C116C6;
	Mon, 19 Jan 2026 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833444;
	bh=CSTmPBA6jWnROZuwiJTIQySlhBcVu9NnVrQTCL3GAR4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=g+EN7LOJd5DlifzhjK5E3WGKGFyat9PZSAr8WAdmz92XyVQwA0sE/+zXvsfHrjksQ
	 OzdVmrMR3A/aRfcu/3/a0yumSxnw0rPX+iBlowxF1yAGR8zh/F1xYC90p+YvxlsH3O
	 wMLpMieaxjyyQMQeCeBS1XOvZKPKITy9j2MgViu9ZHZow3Ud3u7Gv8+AziAiCXF8so
	 En3otoLhwMVyrfC6vukQRGMfXLyhBp3d5j6ey6aacwOFGcn+gDlSVGFgm1iS1mX6DW
	 e7vP5v4tJCpBSILrj/cOdTfMrqHDnqSUfdzt0XVst1ej3wx6AJUgrv8QMkU5OLUF5/
	 HWAhYAbPvnOuw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 15:37:17 +0100
Message-Id: <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Drew Fustini" <fustini@kernel.org>, "Guo Ren"
 <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
 <20260119-thundering-tested-robin-4be817@houat>
 <aW4lCfUyumOKRRJm@google.com>
 <518D8B09-B9A1-4DB4-85CD-37A2DD3D5FB1@collabora.com>
 <DFSLCI9U4NCW.2HI2UPUI7G134@kernel.org>
 <20260119-weightless-pelican-of-anger-190db0@houat>
In-Reply-To: <20260119-weightless-pelican-of-anger-190db0@houat>

On Mon Jan 19, 2026 at 3:18 PM CET, Maxime Ripard wrote:
> On Mon, Jan 19, 2026 at 02:13:48PM +0100, Danilo Krummrich wrote:
>> On Mon Jan 19, 2026 at 1:54 PM CET, Daniel Almeida wrote:
>> >> On 19 Jan 2026, at 09:35, Alice Ryhl <aliceryhl@google.com> wrote:
>> >> I think that if you still want an API where you just call enable/disa=
ble
>> >> directly on it with no protection against unbalanced calls, then that
>> >> should be the special API. Probably called RawClk and functions marke=
d
>> >> unsafe. Unbalanced calls seem really dangerous and use should not be
>> >> encouraged.
>>=20
>> +1; and unless there is a use-case that requires otherwise, it should no=
t even
>> be possible to do this at all -- at least for driver code.
>
> I mean, it's great, it's safe, etc. but it's also suboptimal from a PM
> perspective on many platforms. It's totally fine to provide nice, safe,
> ergonomic wrappers for the drivers that don't care (or can't, really),
> but treating a legitimate optimisation as something we should consider
> impossible to do is just weird to me.

I said that an unsafe API with potentially unbalanced calls is something we
should clearly avoid for drivers. This is *not* equivalent to "treating a
legitimate optimisation as something we should consider impossible".

If we discover use-cases where the current API doesn't work well, we can
invenstigate further.

>> > I think we should discourage RawClk if at all possible. But if the con=
sensus
>> > is that we *really* need this easily-abused thing, I can provide a fol=
low-up.
>>=20
>> I think we should only do this if there are use-case with no alternative=
, so far
>> there haven't been any AFAIK.
>
> I don't really care about which alternative we come up with, but look at
> devm_regmap_init_mmio_clk for example. It is a valid use-case that
> already exists today, and has had for more than a decade at this point.

I don't see the issue with devm_regmap_init_mmio_clk()? It takes a referenc=
e
count of the clock and prepares it when called and unprepares the clk in dr=
ops
its reference in regmap_mmio_free_context() called from the devres callback=
.

That something we can easily do with the current API, no?


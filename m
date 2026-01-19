Return-Path: <linux-pwm+bounces-7928-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C9AD3AA09
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 14:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6940300CCFE
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059E8361DBB;
	Mon, 19 Jan 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXNWw6OB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D262031E0FB;
	Mon, 19 Jan 2026 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828435; cv=none; b=DHje536lpuwU74QSOlf15FEpfT+b6MCvXSPrL+h1E4Ly7Fh+AtDaPT1BbeV8RiSY7YYp8/ydjfjRo5Z8k1ySAJgaAXYJ/KV21zTZBWcluoKb8bg6+XuBhyVjq+SX3jzSzmQB9oj/FCXCq+Q65bnO2coP8Mzdv6qdBbPYTKCHilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828435; c=relaxed/simple;
	bh=+CgZWcmNGygQjfD27T+jBsRojt6pw3uvENO+XS4NxvM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=TduSc39UmMvxXaM01uF6uTRlluFmeLxY50+rP9QuuIugdNrX7OMi7+zUqzjuhiUPTFoC8E4E0SNCESN42S4hfUj1VQ62v7EwQUpc7yGXbpE5kIoi0eB9qwQaWeb43mLEXBM4fZdv4yG/NTVbBgMKcu34bn8bGsBO3q0Rtw2Mc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXNWw6OB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1A7C116C6;
	Mon, 19 Jan 2026 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768828435;
	bh=+CgZWcmNGygQjfD27T+jBsRojt6pw3uvENO+XS4NxvM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=XXNWw6OBkSaH02cWAwZjvJOZJZXBsqeN2f6csk5pLRwKU5shzpE2NsU3v9YEDJPsH
	 HxcwDQK7tfuapzHJdyV+rrcU0+Zk3kVTeosGsJkNUBJx435U7ra+OcGeR+pY8ZKOQ9
	 8TxtniuuKmJqYxSO1/7NavnefBHny0TvTF+OOQHEdgAimnSmdAqtcpBm8PucbDJIPf
	 9WiKs0Lota3kNRR8lNBq1JsrnWksFx/gDG9myqT+rW7Gd+EjT9DDu/Fabd0IcdQZyb
	 ENN4Eoo2lb4iuTU98WnZi+/J3/RPgApwF0FqMzEtPGu+zO7NKR7n0dGkPsaRXw1whH
	 gO9xFz8YVSIrg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 14:13:48 +0100
Message-Id: <DFSLCI9U4NCW.2HI2UPUI7G134@kernel.org>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
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
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
 <20260119-thundering-tested-robin-4be817@houat>
 <aW4lCfUyumOKRRJm@google.com>
 <518D8B09-B9A1-4DB4-85CD-37A2DD3D5FB1@collabora.com>
In-Reply-To: <518D8B09-B9A1-4DB4-85CD-37A2DD3D5FB1@collabora.com>

On Mon Jan 19, 2026 at 1:54 PM CET, Daniel Almeida wrote:
>> On 19 Jan 2026, at 09:35, Alice Ryhl <aliceryhl@google.com> wrote:
>> I think that if you still want an API where you just call enable/disable
>> directly on it with no protection against unbalanced calls, then that
>> should be the special API. Probably called RawClk and functions marked
>> unsafe. Unbalanced calls seem really dangerous and use should not be
>> encouraged.

+1; and unless there is a use-case that requires otherwise, it should not e=
ven
be possible to do this at all -- at least for driver code.

> I think we should discourage RawClk if at all possible. But if the consen=
sus
> is that we *really* need this easily-abused thing, I can provide a follow=
-up.

I think we should only do this if there are use-case with no alternative, s=
o far
there haven't been any AFAIK.


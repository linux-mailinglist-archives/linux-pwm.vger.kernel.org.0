Return-Path: <linux-pwm+bounces-7875-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A03D01AE0
	for <lists+linux-pwm@lfdr.de>; Thu, 08 Jan 2026 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2FF53022AA6
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jan 2026 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BFD38A9DB;
	Thu,  8 Jan 2026 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlN06fkJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1E38A9C1;
	Thu,  8 Jan 2026 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858808; cv=none; b=ZIVxtx7D8Wa9oXG8BgLpjN3P06Af4paE65E5b7RuNM4kfNOE8h1WSe36F6mhIVUJd0I0+0fLIPJE9EXEb+Ta0JcowzvAcTWmulMf3fIm9cuGdwNrSgaygeipeAf9xERKuf0hEDG2R7c1kKzo+UHfEl4cHeHlRE/kMlJtPshQpY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858808; c=relaxed/simple;
	bh=nDXnKNmAJw0ktNPTmlWu+Kn+sJ7O1F/SsAeUoE2v82g=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=kZSEGH8AkJP6VU7PH3RQICCxJ+NzP/ZGjIi5mqDYpY+Q8rBs0A8u4IwZe5PxrHXBte2wvgctkUuXw0W8AoxW2ewxiFsfoByesqhBVSf9jx+j42VVqWCi4v8l3Rz/WBYAsgZCSWdPuFRpv0nDfS+QfJ1jpAyxYUM7ZgjY8fr77Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlN06fkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA84C116C6;
	Thu,  8 Jan 2026 07:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767858807;
	bh=nDXnKNmAJw0ktNPTmlWu+Kn+sJ7O1F/SsAeUoE2v82g=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=OlN06fkJI0hxv93SXzC+CYpIP/kFOQcISMk2RWljUBx/d0ktBFoLB7U2Ba2WHU3AT
	 7xbOdIou+i8HnYwGPBLJxcKDDQfqyCK6jNuXRtrQTvVV8o6tlNvxCKEbX1Zsvk2w4e
	 t0BlUPrRHZSGiIH/xFeq1I7tWleZ01Vbtz3Q/L51bmRbIfR5p2Mj+D2yFFzQeH589f
	 cBNIM5g/4pyh2Yzbuy7yVwPQwRiXUm8RA9UipWoy8T+6vOC2i1D9qEaigqw5pqPsZ8
	 O/cQsxG/rnZKhGOtG45dyrVXFNITrxin/pU4T1VDYCulX2npFOb4zizxLsgkNFWXzt
	 bV6gZ5IN8YoEw==
Message-ID: <8bc73ccedec95c7054fb6e38e72d865a@kernel.org>
Date: Thu, 08 Jan 2026 07:53:22 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Subject: Re: [PATCH v3 3/3] rust: clk: use 'kernel vertical style' for
 imports
In-Reply-To: <20260107-clk-type-state-v3-3-77d3e3ee59c2@collabora.com>
References: <20260107-clk-type-state-v3-3-77d3e3ee59c2@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org, "Alice
 Ryhl" <aliceryhl@google.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Benno
 Lossin" <lossin@kernel.org>, =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Danilo Krummrich" <dakr@kernel.org>, "David
 Airlie" <airlied@gmail.com>, "Drew Fustini" <fustini@kernel.org>, "Fu Wei" <wefu@redhat.com>, "Gary
 Guo" <gary@garyguo.net>, "Guo Ren" <guoren@kernel.org>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Michael Turquette" <mturquette@baylibre.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "\"\\\"\\\\\\\"\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"Rafael
 J. Wysocki\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\"\\\\\\\"\\\"\"" <rafael@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Stephen Boyd" <sboyd@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Trevor Gross" <tmgross@umich.edu>,
 =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

On Wed, 7 Jan 2026 12:09:54 -0300, Daniel Almeida wrote:
> Convert all imports to use the new import style. This will make it easier
> to land new changes in the future.
>=20
> No change of functionality implied.
>=20
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


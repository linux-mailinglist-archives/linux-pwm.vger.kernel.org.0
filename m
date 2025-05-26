Return-Path: <linux-pwm+bounces-6128-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06FDAC40E3
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 16:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382241606B6
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D3202C3E;
	Mon, 26 May 2025 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LncjDDat"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924731DDC08
	for <linux-pwm@vger.kernel.org>; Mon, 26 May 2025 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268153; cv=none; b=kSAXk65ZBf4YVlLZYnw7VlAgJCsUGGOZXdHQK1G285QcswHHSPr9Iw1OTbNOt/bZIEB/llWIGL+i1hbhSMWuQbR5RcQspB+3huEFCwm+6/fvitiamP24q2akympOs7HhzYtS+TSPDuFhrbXMaiPGweG8vnDB0Fp+wR/37ZRPcb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268153; c=relaxed/simple;
	bh=1FPYTLYFolCPqa4UiErcCX9Vk38FXUDWIxtP75x1kQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=igM11tcWpOeFNvQhVPU8NJUXqElq2QbkRkijOae4tJkSjvDQOV6eMfbVtnGQCErxQ5PDy9h5OdICOToxq974bZUkmm87nDo5VBcych/NBYLxoz6Ru/a6xcKYbR75p1wSMgfnXKGtkTnXgOFQfaQ2sYNzllY2h6w6/7twm5SXhxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LncjDDat; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250526140229euoutp017cf01ff5d3cbffe7679f8617428cce5e~DGJ6ZaH2q0720707207euoutp01j
	for <linux-pwm@vger.kernel.org>; Mon, 26 May 2025 14:02:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250526140229euoutp017cf01ff5d3cbffe7679f8617428cce5e~DGJ6ZaH2q0720707207euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748268149;
	bh=X9hidhnbjeXr79/7hjWdiP66/YfJFrDGrP9fti1zI8k=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LncjDDatBDAFyd8dSMOXhSUWNzHT/wRYhIls3esbaJZnr9ufGHCuIeBUqXlzPNEAn
	 3yRKkT6HOjdP0cSwXC6CW+HiLrwjwQ3sgaPFtLfKxXVvJTiPOmoItgIt/Ep0dyYhTH
	 +zvLkck0VJPtip1ZELVDgfYh7qfus1bqVVLUqPUk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250526140229eucas1p29ab92fba79975fb3f6f5d3f9831f9da6~DGJ5v-bu92582525825eucas1p2e;
	Mon, 26 May 2025 14:02:29 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250526140227eusmtip1fc55917f132ab805ce6dd5cdab5f4fe9~DGJ4sSGgu1355013550eusmtip1C;
	Mon, 26 May 2025 14:02:27 +0000 (GMT)
Message-ID: <fec3e2d8-592a-4474-9a15-3a196829c9f6@samsung.com>
Date: Mon, 26 May 2025 16:02:27 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/6] rust: Add basic PWM abstractions
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
	Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
	Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
	Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <enxctdseecqz765nmd24vziiaksmyhltqfwycdszmfq3s7orjm@lnpc7czuluis>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250526140229eucas1p29ab92fba79975fb3f6f5d3f9831f9da6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c
X-EPHeader: CA
X-CMS-RootMailID: 20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
	<CGME20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c@eucas1p1.samsung.com>
	<20250524-rust-next-pwm-working-fan-for-sending-v1-1-bdd2d5094ff7@samsung.com>
	<enxctdseecqz765nmd24vziiaksmyhltqfwycdszmfq3s7orjm@lnpc7czuluis>



On 5/26/25 09:53, Uwe Kleine-König wrote:
> Hello Michal,
> 
> On Sat, May 24, 2025 at 11:14:55PM +0200, Michal Wilczynski wrote:
>> Introduce initial Rust abstractions for the Linux PWM subsystem. These
>> abstractions provide safe wrappers around the core C data structures and
>> functions, enabling the development of PWM chip drivers in Rust.
> 
> Oh wow, thanks for rustifying PWM. That might be my chance to actually
> learn Rust.
> 
> I don't know when I will find the time to look into that in detail but
> one thing I'd like to have for Rust support is that the drivers use the
> new abstraction (i.e. .round_waveform_tohw() + .round_waveform_fromhw()
> + .read_waveform() + .write_waveform()) instead of the older .apply()
> callback.

Hi Uwe,

Thanks for the valuable feedback. You're right, building on the newer
waveform abstractions is a correct approach.

I'll rework the patches to use .round_waveform_tohw(),
.round_waveform_fromhw(), .read_waveform(), and .write_waveform() as you
suggested, instead of the .apply() callback.

I appreciate you steering me in the right direction.

> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


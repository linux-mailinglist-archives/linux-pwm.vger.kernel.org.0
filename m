Return-Path: <linux-pwm+bounces-7704-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F55C898A1
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Nov 2025 12:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D47A4E3DEA
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Nov 2025 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DE2321445;
	Wed, 26 Nov 2025 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tiRnR90C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07875248F7C;
	Wed, 26 Nov 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156870; cv=none; b=DRYLzoZaCd1xgJ4n5G8qI8IG/DvQb7jgRr+KvKKUh1XLL5fVhQ76P4D4NbReFrer5cLfsfiDAfLFd6JvpGbsCa1LVhnWu60Hddt71k31ibzrxcBpxWVEdOGI5M4uL1ptICcy9mAY0X7aPcyQXnayPg5RZ0ZOSI0YnPVCm+tQsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156870; c=relaxed/simple;
	bh=QWOeG+hAnYZqWr5qwOOpn60eMY9exWyqB4FUqstj6Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=bqT1+EK30q+8bw/akbnia2SFJFFJ6aGKLhaXrbwbivEEGppnbTol45D6gXgNKSHGR2lsYVie5HcL9xQ8WVy6sKU3d7gU40qVAV00k7p/hQDUB9zTZkGfEW9ecrSQLWguxi9ZS0e6WkYbwIF0LKMAhXnJa60xWFRpjwbjbqIRDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tiRnR90C; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251126113425euoutp0207410ed3fde7d7fb681922cd80c86f37~7i1KQG6Df3162131621euoutp02_;
	Wed, 26 Nov 2025 11:34:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251126113425euoutp0207410ed3fde7d7fb681922cd80c86f37~7i1KQG6Df3162131621euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764156865;
	bh=Mlk/8cVuM1r8cgr34kGmewo0VCLvDAclx64Kzq7IU10=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tiRnR90C/z2zgZPKygxThBoTiu4KqlPU0OaQwH6dp6i76ubEfSiAM9znavX/GF7Rb
	 RAFCNSTuOurGjRXsJvkb8/G0My+M92lJmm6hMlawYDQO2TxN8UKncGYm6UuLhBWRpA
	 P0cee2QTEJo4ppVsAjcc2gTALBB+yYyV4JExx53Y=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251126113425eucas1p20472c28098c08344e4348a1ee22407ae~7i1J8Jf2K2271922719eucas1p2R;
	Wed, 26 Nov 2025 11:34:25 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251126113423eusmtip1f3fa48d667a8b110b0790a7b70bca88e~7i1Ij3pon2329423294eusmtip1h;
	Wed, 26 Nov 2025 11:34:23 +0000 (GMT)
Message-ID: <cca5c7e8-d9c4-4e28-8da2-62dd521ceea3@samsung.com>
Date: Wed, 26 Nov 2025 12:34:23 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] rust: kernel: Update ARef and AlwaysRefCounted
 imports to use sync::aref
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Shankari Anand <shankari.ak0208@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?=
	<arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen
	<maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, Christian
	Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, Suren
	Baghdasaryan <surenb@google.com>, Danilo Krummrich <dakr@kernel.org>, Alice
	Ryhl <aliceryhl@google.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Alexandre Courbot <acourbot@nvidia.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Igor Korotin
	<igor.korotin.linux@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
	Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Daniel
	Almeida <daniel.almeida@collabora.com>, Abdiel Janulgue
	<abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	linux-pwm@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CANiq72mQ4cu9wehGKxS92EK2H3kcX8XPpRmv2DdYmn6Ve9iDAw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251126113425eucas1p20472c28098c08344e4348a1ee22407ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251125123134eucas1p230415281df788e787f4b71e4d7b3ac3f
X-EPHeader: CA
X-CMS-RootMailID: 20251125123134eucas1p230415281df788e787f4b71e4d7b3ac3f
References: <20251123092438.182251-1-shankari.ak0208@gmail.com>
	<20251123092438.182251-7-shankari.ak0208@gmail.com>
	<44gv3fhqppn4fyg5fnxkhhanlbbxr2slqq7k3kr3owx7frpnxw@idgwxlcv4otn>
	<CGME20251125123134eucas1p230415281df788e787f4b71e4d7b3ac3f@eucas1p2.samsung.com>
	<CANiq72mQ4cu9wehGKxS92EK2H3kcX8XPpRmv2DdYmn6Ve9iDAw@mail.gmail.com>



On 11/25/25 13:31, Miguel Ojeda wrote:
> On Mon, Nov 24, 2025 at 5:10 PM Uwe Kleine-König
> <u.kleine-koenig@baylibre.com> wrote:
>>
>> having no clue about Rust:
>>
>> Can this patch be applied independent of the others via the pwm tree? If
>> I understand correctly it's only patch #10 that depends on the previous
>> patches, right?
>>
>> Is there already a merge plan for this series?
> 
> Yeah, if subsystems pick the independent patches at their own pace,
> then that is great, so please do!
> 
> Then, after 1 or 2 cycles, we can do the flag day change on the Rust
> tree (with any last changes needed Ack'd, but ideally there will be
> none remaining).
> 
> It is what did in similar cases for renaming (or moving across the
> path hierarchy) things in Rust. For simple things that get Ack'd quick
> enough by everyone, sometimes we may be able to take everything in the
> Rust tree.
> 
> Thanks!
> 
> Cheers,
> Miguel
> 

I think code wise it's fine, provided the subject is fixed like Uwe suggested.

Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>


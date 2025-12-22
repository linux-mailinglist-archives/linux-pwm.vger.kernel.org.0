Return-Path: <linux-pwm+bounces-7823-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC7ACD65A1
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Dec 2025 15:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DF9F3026B2F
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Dec 2025 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21412DC348;
	Mon, 22 Dec 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="DCvWmjBy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF4F2BE048;
	Mon, 22 Dec 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766413323; cv=pass; b=Eah//3Z34iAL6YS/dUQvs6QWZBYghrsEN4uQphe/H+PDs2lMKN0nwxujAsr5GpnZ1OWb+2gXdEaWmGuurjgeXnkLcC9+CykfE8/St6TNEWhve5tOWABA0Fmv51ZoW6sYP8lMyzBFgklJK/gu0Ol6o20X3m9m49oklRTA8sq9RoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766413323; c=relaxed/simple;
	bh=R2nplfYnI5UXtK/0Y8D6GrkdO71eLFjuU0Q8vbZoidU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O4jL3xl6ADSldCj7WodkUEl7ORhahcfoVhWMKUWkoBmAo0AFH9WHv2g+z2II2gUZEymmqRYxpccLfgMRw78XY915yG70Y1Fc+K+AJpkN65EyV6cKmuqRgQwHoOEenMOn/LIqZyC9ZnjlwdHazBjOJ7uBttZkCa0brAhQiNYw/lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=DCvWmjBy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766413299; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dSJA3frU6QuloPJJDWgkZ6o1bJd9LXPMPFMfvnII4R3z4ppxhQHfsbXfnJ75hZdquAOUQmDkfs9/UqpqSqsY6zE8E0gKxAQDpZSY+HS0+51R3f6q4gVaLo9GE6CBmge35G/KeQ6zB4/kiYkPKbuFlT18rvsC+jcUA5yAUeE0Mb4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766413299; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=a9KrdtA4sTPYPLeGS9oWNYHBt1scy7mdbGzi7GGj4R4=; 
	b=CwE0Vd7HAzfAJJGN3Fo4IUd8X9+79ZVriSQu2cBXMgB9WFJDn3ADQj7OE1FILJPbubUQsGTWJoLXGqMC1cDtyHO2h7jdgnueKP3AYqygV0M2n40PBzYhD6F2KAZVMEbsIxYqIAKmce3QnF1u6tpwxDVIyGDoGfg5Pq/HdrcFj2s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766413299;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=a9KrdtA4sTPYPLeGS9oWNYHBt1scy7mdbGzi7GGj4R4=;
	b=DCvWmjBy68tXZW/QwbdL7dV6gfGYITgZbzVws93gdr0fl4UloTTJU4+WSuP028e+
	bfDLsJcEq33TfuLT9FUB+bfOOkg+79ZNnOU8VsnNYY2/53H2kZipnVZy6aYLOMr2YV0
	z9/MB4UPC8DO6kE/iCy6AgfDEy9Tull5TJwmWwGA=
Received: by mx.zohomail.com with SMTPS id 1766413298347127.09238611384126;
	Mon, 22 Dec 2025 06:21:38 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>
Date: Mon, 22 Dec 2025 11:21:21 -0300
Cc: Drew Fustini <fustini@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Tamir Duberstein <tamird@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <607D76B0-1A8A-4A62-A961-14796A7FD31E@collabora.com>
References: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>
To: Tamir Duberstein <tamird@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Dec 2025, at 09:24, Tamir Duberstein <tamird@kernel.org> wrote:
> 
> From: Tamir Duberstein <tamird@gmail.com>
> 
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> drivers/pwm/pwm_th1520.rs | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index e3b7e77356fc..8ae8f852ec02 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -22,7 +22,6 @@
> 
> use core::ops::Deref;
> use kernel::{
> -    c_str,
>     clk::Clk,
>     device::{Bound, Core, Device},
>     devres,
> @@ -327,7 +326,7 @@ fn drop(self: Pin<&mut Self>) {
>     OF_TABLE,
>     MODULE_OF_TABLE,
>     <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
> -    [(of::DeviceId::new(c_str!("thead,th1520-pwm")), ())]
> +    [(of::DeviceId::new(c"thead,th1520-pwm"), ())]
> );
> 
> impl platform::Driver for Th1520PwmPlatformDriver {
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cstr-pwm-c9b9a4701157
> 
> Best regards,
> --  
> Tamir Duberstein <tamird@gmail.com>
> 
> 

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>



Return-Path: <linux-pwm+bounces-7677-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88630C7E13E
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 14:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308A93A1AAE
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 13:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF21B2D2486;
	Sun, 23 Nov 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdGVhLps"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FF176ADE
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763903791; cv=none; b=T/wKZuSzigiQyjGBu95C4+aMydQfqAuAA5f8w4hKrEAU++do7bC9CW3Rk/lyehB8O3HIg5S4mGN4Eua+ocFC9xEYlY2A5SIXiRp1yDLc/bDKgDB1P0Rbspex+HMXlptUVeb/i1ravyoPVO2EyykqrpoFT3Y63EAt1gJ7+dhkIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763903791; c=relaxed/simple;
	bh=54vi7KmAT+1m3az/BKhHowS24K4TkexlSujhLJMigzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbTn+v0bLnXb7VhopWfL275YeR71/BIBjuSiwYEchif/g9pZURPVvPXcRKNTkkK0aiKKjoNKj4T5giLbS6DS1KUN4BE2YKiHXWgx4xia5dens/6UFPHpf1NJsE5F0wRoX81qw1MBNoxsgVHeK1Sa8/AwoKNciMrhhNxxEby6aNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdGVhLps; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso20950255e9.1
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 05:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763903787; x=1764508587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWsYIQ2Ggbhbzka70Nij3a4arpdwqNARnWCMeN/qSWA=;
        b=hdGVhLpsx71DM1Z2KF42+GUYyGncfHK5SG5TXv0FOOE1O/WCejhBl+C4QRB1p0pCH9
         NZXgjYZKYWyyAGnytkKrexyaObgps6FfMTwmBKyHPA5/glfwCTzaKmlpPef5JXryC3ex
         x7uDoLz1qiihOJ12d0V6IFHIJyaqux2mAz0MvL12ch4Z3Opf34zJwFBP6oggUWwO4FmN
         4SimP4S0BLIkHLhXT0ifKPi9HEhXgt8u0lIvD/90TB+CUuOUffMRcjAzi6nTnv1pi/e4
         Eib4LPc5ReLsKckISK8SqFeZRk7DVitCXlMVCwAb1wHpPV6w/wvgAYycjvtG/dU3QX2x
         HXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763903787; x=1764508587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWsYIQ2Ggbhbzka70Nij3a4arpdwqNARnWCMeN/qSWA=;
        b=dBxZJL8b80rYcHKZI/ms5PUg++s5ttj8UiEF5xc9OWFgG4v+jzGbdV3FZUzHBEZu+2
         C9XZzsf3ChQIgGMjTCfFFAVPoKlST2BArMmjprHDKmuurLMMeCvn9JV1wx7rMGNjL6rC
         jyeRAWYLV3EBoBZEZYCuRcjEXUz0x08mh5TxhXJi9+0wtb6Fc4P7RIPxeta3Mu8SYv6j
         v+Hoi0LyGMj33V8Gb2FnVPr8AvN4WeRqBtBv5IeV5wmzzEK+vypFYH8/OBFRuFaThDDS
         N+VB6Zgh/1pTKzEMBBilbpCWHs83wzDHGrfEHPFrB25u7mRwLjGjKDZ4nVKHGDFRmDC3
         Lblw==
X-Forwarded-Encrypted: i=1; AJvYcCUdIhT8eOzyNNM6xn/e9MhZeydcRLYyrm2wf1vB+73Yr3VpC4WI5q/GFYIsEt1j0CWqdqwnnFOLrAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DCjGs7Mr3L/76DxiXM4dwr7G6K+kE6115yx+wmYe5q35aSHc
	l7YqavbJlN6/IX4QLSSw4lBmCrv844uw0OHi2VKZlseGxgZZljp3ZQEl
X-Gm-Gg: ASbGncsdhZaKtwwEuNBvy+ysucqvV1YL5rapX13g0y6boQbRG02g77WkzeK5wDyMghs
	LHYVlHDruXuy8zn5UnQ8o6pcCV6BuYwkRSNK4hIhzyJb/gv1koqXSi8YhFseAER6rmKm6obQ4te
	V09t2ts0IMvUkj5Qh70FUyWO9Zzvx+IqOnj7erWuJidzYtstEhCmbPikhSspuAYFJCVkKrbiyTc
	c4EByC/27UMRerVfgzE2tKYmA5IdJGJLyO+FK5zmLAbZIl2MQs/rmBwhsxuDi77MgZhKOvkjzHj
	hYGD3FTuC9L+ur+MJNGMVL67FBz7x07nj2ukN66CY1jyKrfFOH8Iw8k30DLghbbVoXyLu1aLyJd
	3fs4Y4FG3QoEIs5bXXsG8+ZG+SZY4slqmOkzNtGJMbOR2tEghueVAzfeeUEAh+PfqGLhEvKvKap
	xBy2MIYsDRrNCZPaxSOwxXORkw+gs3LoC8RIT0bmTA57nV8IedboZWd44Be5jEyUwhid2czjpWL
	c/m4g==
X-Google-Smtp-Source: AGHT+IGwu9HAU1GTXcVV6PqyT2WVWbNnyTLYP+26LVoRcWUnFI2rUjGr2LZvtLw3Ln81be9Wp+f1+Q==
X-Received: by 2002:a05:600c:840f:b0:477:632a:fd67 with SMTP id 5b1f17b1804b1-477c10d6d13mr93671615e9.12.1763903786586;
        Sun, 23 Nov 2025 05:16:26 -0800 (PST)
Received: from ?IPV6:2a06:5906:2618:cb00:f1a3:6462:6c03:ec0e? ([2a06:5906:2618:cb00:f1a3:6462:6c03:ec0e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb919bsm22549569f8f.34.2025.11.23.05.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 05:16:26 -0800 (PST)
Message-ID: <7bd3232c-90cc-4e71-8aed-2ac911cb20f9@gmail.com>
Date: Sun, 23 Nov 2025 13:16:24 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] rust: kernel: Update ARef and AlwaysRefCounted
 imports to use sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandre Courbot <acourbot@nvidia.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20251123092438.182251-1-shankari.ak0208@gmail.com>
 <20251123092438.182251-6-shankari.ak0208@gmail.com>
Content-Language: en-US
From: Igor Korotin <igor.korotin.linux@gmail.com>
In-Reply-To: <20251123092438.182251-6-shankari.ak0208@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Shankari

On 11/23/2025 9:24 AM, Shankari Anand wrote:
> Update call sites in `i2c.rs` to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
>   rust/kernel/i2c.rs | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 1aee46f59460..c50ca464d87c 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
> @@ -17,10 +17,8 @@
>       of,
>       prelude::*,
>       str::CStrExt as _,
> -    types::{
> -        AlwaysRefCounted,
> -        Opaque, //
> -    }, //
> +    sync::aref::AlwaysRefCounted,
> +    types::Opaque, //
>   };
>   
>   use core::{
> @@ -32,7 +30,7 @@
>       }, //
>   };
>   
> -use kernel::types::ARef;
> +use kernel::sync::aref::ARef;
>   
>   /// An I2C device id table.
>   #[repr(transparent)]
> @@ -408,7 +406,7 @@ pub fn get(index: i32) -> Result<ARef<Self>> {
>   kernel::impl_device_context_into_aref!(I2cAdapter);
>   
>   // SAFETY: Instances of `I2cAdapter` are always reference-counted.
> -unsafe impl crate::types::AlwaysRefCounted for I2cAdapter {
> +unsafe impl crate::sync::aref::AlwaysRefCounted for I2cAdapter {

NIT: This module already imports `AlwaysRefCounted`, so please use the
imported name instead of the full path for consistency.

>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::i2c_get_adapter(self.index()) };

Thanks
Igor


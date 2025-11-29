Return-Path: <linux-pwm+bounces-7734-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2683C93D71
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Nov 2025 13:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D0864E1C11
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Nov 2025 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682EF30ACF2;
	Sat, 29 Nov 2025 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiD12NmY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CBE269AE9
	for <linux-pwm@vger.kernel.org>; Sat, 29 Nov 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764418875; cv=none; b=WN+6aqVS/FwgCktm+9kH+si+O5xpRMpvdIGcrU+NdXfWZdLz0s/1c0Sml2QT0Qq2w/DRgftgTLMkHOx3CCnAddQk1XSFiIEMx0KCfVdtUIKOEVpoLdrnuRG1EORUtEW9beIRYIGGTrsad219M/D3OUZiuXtI0QOx5TEPJQTu/gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764418875; c=relaxed/simple;
	bh=/hGs8mbiQCRTygnbfmLXoaV4fdNOp1DAthk0vwLWjrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGSrDJmTfFjrSdLLC70hEmtavpnSwfcM+uJPRgymoYkmBNIYa1h1o6MPM71LG0HUwa1MAsWqs2WCTRpY0exKN8rzsTQxh91R4gSTWjb4UEhC9g4dURVjhgBdoKiG4aBBuksu2wOmuyeKemHFq+GcG4ZME7t4YOsmfr/hgmS60bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiD12NmY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so24658025e9.2
        for <linux-pwm@vger.kernel.org>; Sat, 29 Nov 2025 04:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764418871; x=1765023671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcVPfmTekyLiABGhJu4xmxadfb6FIwZsqQzyLFSkQjE=;
        b=eiD12NmYqerrQm7fuebXYtgVn3zuoPTe9VqJWJFSIVxbvok/4JoXwaGIEV9Hjr/Nq/
         OOwfdmKfaztM/cfCeW9g3ZTyK5haxLe9qV9w07gosZmr6FeoZ8dB2qIWwp0wQi/aGAu5
         p1DmM9VhOm/+Sk7L61Vki1dBVw6eeRmp2PCLXc4O3XwrbYdKe7coijNa/e2Ol1HYftwa
         bnuknRIlB7V4043eOA5wUgUp4gKhQvqqtPefiEfFUqPlH7j/YbvXFWZChuo0Hf6a7nJd
         /l/mnsdZyoetHu4s+cuBpE8DwA0YmbZpIGYorscIvnOvFYVTUsjwyPgZUxtYlF224m3t
         J5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764418871; x=1765023671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcVPfmTekyLiABGhJu4xmxadfb6FIwZsqQzyLFSkQjE=;
        b=MaVsW8o3g3h2NO5+HgkQT+/3qCGfI9BWRLzwFbryveqadnHzUjqC4cboZ/QQkhsgJU
         Mv29govNNnS27ifKRJ25OxGpwp7Kx6bpe7YqRb13sZrsTTDp+wU+DMInwEEaZc0ceZxt
         45T0O0etQ3/K2Z6YWyHDjuK8Hzlrqk/5B7dbNpEDnTx5AaQzRoPGAQ4eQjTTPhAIyx4h
         v8p/TD+PyNK8J1/vreE0809rOkzDyxkOaMuCIX2yA/DkTggA1P8D1Mmk3AiSXBm45X96
         0ofO19wgq0YerJQPv80LG5uef3DwYWxk2lBYoXCx8jfcLz0fSTJTDBR96XGZA/NrLFgB
         vOUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVRVOTytnQMWKBa2vJnU+1ODVybT46rj8U2YDmE3u0c5SU3MQRdh8adLBIQoieDycWsUWJ9H9u4oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrKG55J5XA8FH/BfLW5uU3mOVE0KtDHscekJFgNdppj/JUggfX
	s2DOWDKE63Xlxl2ITuAIx/t4cXEU1nOdnijxEGBPYbWCbULQUJwMs8Y/
X-Gm-Gg: ASbGncs26Hfp42YIafJjwkfbV0LziJW7mgG7jTnuyynbFKZx9Yxs1Jw7Ul/wzAeK9w/
	3LIGt3mWajR4AFtxFcrfAFuaMdJ4KJWUpRxHcdiu762/D+bxk8v3Evy5GNJ20vPAW8rUtsF6yU8
	wVQjcGoYMdlFOlRV7WAmLzxfcKSHCCLocT+SJ47OOldTesNBBv3mfO51onSjYfVw1ZA9CwpC0d+
	vwYpiWkCfkRMWoNeO39qhZeq0StQbPJ9Lf6o/9pEOv9HkGWtpMz+SxnYAoXgl9HhrKs71D1Efs7
	VU0crXtAFDeFCfGoDTCCsgFUqitigD8Ie5+H6oBVqHrPEPYo2bIAaKMQEXMIINgQ9UKYo+uXssR
	+e7Y3cb/Ndb/oCn8JA7qXDXhk7ewfTrqpLHPnAsg850cZrTcvijNB5MAKJ9MlQN8naHmrXoBZGp
	0cXVkdBkHptqo0fH48//CfclPvGvfEVbfL6SW3wr6/uoR+eUuE3mp1gds4xI5Q2OBLUXalNP/N/
	AhzfX4iAz3rHsME
X-Google-Smtp-Source: AGHT+IHPdRho1zaUXZGS4ozcekK0LR1lA9bfnMYzOaD4j+9k0x7QM6vylSP8/9z2op9t+DSRd2h1Jw==
X-Received: by 2002:a05:600c:3b96:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47904ad907amr211433865e9.10.1764418870809;
        Sat, 29 Nov 2025 04:21:10 -0800 (PST)
Received: from ?IPV6:2a06:5906:2618:cb00:ddd6:3141:6a4a:f8d8? ([2a06:5906:2618:cb00:ddd6:3141:6a4a:f8d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a3f1sm15343627f8f.28.2025.11.29.04.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 04:21:09 -0800 (PST)
Message-ID: <1b7408c5-64a8-42f1-92ab-dd90a883c1a4@gmail.com>
Date: Sat, 29 Nov 2025 12:21:09 +0000
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
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::i2c_get_adapter(self.index()) };

I'm fine with this going through either tree.

Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>

Thanks


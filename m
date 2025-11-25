Return-Path: <linux-pwm+bounces-7698-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B63C85026
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 13:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE1774E87CF
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E618302777;
	Tue, 25 Nov 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbLmKVfF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654182D8363
	for <linux-pwm@vger.kernel.org>; Tue, 25 Nov 2025 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074392; cv=none; b=Ga8eno9jlNidGz5raSEzL2ebtqciuFnenQwdS956e/qynq6IyBmzyFpgrL1yZcDkqA3fIZohwSD7ZUEBQUJhbsQzCKKqchaidCHcIqo5a5Ro2oahUVqrCeRm2SDBfyqWy+VEvCaJ+7WxETM/fYY3/fxGMGUn83ggX39QFEkSEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074392; c=relaxed/simple;
	bh=G10RNBV+jYHZ+2n7e6/S3MjEijJxngQtVmbZp8vJqdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVjc6uCgkLal2rvQtUc7DZC//YMaOBsX6FK34hMzxR12olLnzQxGbPhBP4cfqc65n9Zsg+jJNl53sAVWqggO9o0RPwi+sXFkIpDIK4iFgI9znJ5sbyqOe7I/gQ9aa+Z1GLw+AW6brutSp75hJS7Nw19VwFiuFrJEDznMy/XR5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sbLmKVfF; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47777158a85so72151325e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 25 Nov 2025 04:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764074389; x=1764679189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojWe1b8r/UImKNNJCHWtNLHUmExFFE68AIjW9wlYavw=;
        b=sbLmKVfFEkm6wFYIwMuiApMg5BMeqilny8I1pnIyDIQpfnD93jaM4DSHR6W7HEJnNK
         5VAjK6ohkg/LgaF+q0k0989ZhHoeVzg5r1nCDMz8Odj+IaaVxTmk0aLo6prvuAR+L1J6
         xafUqSGYrili2Tv5acG8EwOKIHTmBpkSIjKwW3qxbtTo6sh0VU1n3cAgLwDT1oJhG2nW
         B9ghqvcMWQGVcw6TUJ+wjeg8jO8MNtSQr5wJn3owdXpZ+Pg01nNaA2IiczqGUVD6FJid
         yv+DEr2gqfFsCc+z6aDLCaF+/5lpm1e4WaMPNmyQXFja+YUp4n3EsVrYCtkw4Gl8X3ys
         8KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764074389; x=1764679189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojWe1b8r/UImKNNJCHWtNLHUmExFFE68AIjW9wlYavw=;
        b=cAomVDTVONZq5O8Jy2Gc7LInvUghfDSHQbqIlEtNUvtP1ergIDiQvwZxRI4g/gnN32
         SvoKCGHpvARAfGXORNXWGIk11Au8x4erEB3nDqbPtUJjKMEHPx6whtIGCEaBWKFookIZ
         LWGUZuRP3sgJO6OaHrgFz2IjeUwFc0y9egu2kboZ8isbxrc1K//7qBJrINLEXWTl/cKR
         P2j8Vz1xEE3I4F4S78HaNcPle/PYPBZpSCdBdgI9tsKnk0psxQ5I+qWp3lu1zNM/7n5J
         LBcros2ohpUfT6QQMFceQLJqTyx8Cqb9lcrPHVRWeERiSeGsaFf1aiG9njIF4qzq/or2
         hsYw==
X-Forwarded-Encrypted: i=1; AJvYcCWhNQEQ5nr6tSpePck+qmlmjozO1VbCulZjvdHaHDV5j4RC/FCO6R/V+VvoG1qfUB6rkp1QEfIOuRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNJ5sJ/StPfkn7ljUm1fABLhS3VmEZdKXKSZ0du5mOS6KfTrg
	/71QpKk/MkBfdflYHxi2eVx/ajHcmPq0y9TRz09yzJb0rqJIZOhrgGS9FQfrzwDyxq8v0tKjKF3
	Bfyfi5vXLqrrlxXxzMg==
X-Google-Smtp-Source: AGHT+IGGYXbl3NW70HoCq1BUicduv2r9uYzD+uC5Jcg7P8rx3FquzssE0TqvF8nfpxyfE19H4MBFZ8Ly+NNtPC0=
X-Received: from wmbc14.prod.google.com ([2002:a7b:c00e:0:b0:477:a4d4:607a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b35:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-477c10d6fdamr159756165e9.10.1764074388898;
 Tue, 25 Nov 2025 04:39:48 -0800 (PST)
Date: Tue, 25 Nov 2025 12:39:48 +0000
In-Reply-To: <20251123092438.182251-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251123092438.182251-1-shankari.ak0208@gmail.com>
Message-ID: <aSWjlJFD6SVGXBqE@google.com>
Subject: Re: [PATCH 00/10] rust: refactor ARef and AlwaysRefCounted imports
From: Alice Ryhl <aliceryhl@google.com>
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexandre Courbot <acourbot@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Igor Korotin <igor.korotin.linux@gmail.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Nov 23, 2025 at 02:54:28PM +0530, Shankari Anand wrote:
> This series updates the import sites of `ARef` and
> `AlwaysRefCounted` in the Rust kernel code to use `sync::aref` instead
> of the previous `types` module.
> 
> The refactor to `sync::aref` from `types::` was introduced in the commit: 
> commit 07dad44aa9a9 
> ("rust: kernel: move ARef and AlwaysRefCounted to sync::aref")
> link [1]
> 
> The goal of this series is to complete the migration of these
> types to `sync`, as discussed with Miguel Ojeda [2].
> The last commit in this series removes the temporary re-exports
> from `types.rs` that were originally added to avoid breaking the
> build during the transition.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
> [2]: https://lore.kernel.org/lkml/CANiq72=hSTpAj7w8bvcwoJkivxD_FPKnx9jD6iNvhsENnnXBzg@mail.gmail.com/
> 
> Shankari Anand (10):
>   drivers: android: binder: Update ARef imports from sync::aref
>   drivers: gpu: Update ARef imports from sync::aref
>   rust: device: Update ARef and AlwaysRefCounted imports from sync::aref
>   rust: drm: Update AlwaysRefCounted imports to use sync::aref
>   rust: kernel: Update ARef and AlwaysRefCounted imports to use
>     sync::aref
>   rust: kernel: Update ARef and AlwaysRefCounted imports to use
>     sync::aref
>   rust: kernel: Update ARef imports to use sync::aref
>   rust: kernel: Update AlwaysRefCounted imports to use sync::aref
>   samples: rust: Update ARef imports to use sync::aref
>   rust: kernel: remove temporary re-exports of ARef and AlwaysRefCounted
> 
>  drivers/android/binder/process.rs      |  2 +-
>  drivers/android/binder/thread.rs       |  3 +--
>  drivers/gpu/drm/tyr/driver.rs          |  2 +-
>  drivers/gpu/nova-core/gsp/sequencer.rs |  2 +-
>  drivers/gpu/nova-core/vbios.rs         |  2 +-
>  rust/kernel/device.rs                  |  4 ++--
>  rust/kernel/device/property.rs         |  5 +++--
>  rust/kernel/drm/gem/mod.rs             |  2 +-
>  rust/kernel/i2c.rs                     | 10 ++++------
>  rust/kernel/pwm.rs                     |  3 ++-
>  rust/kernel/scatterlist.rs             |  3 ++-
>  rust/kernel/types.rs                   |  2 --
>  rust/kernel/usb.rs                     |  3 ++-
>  samples/rust/rust_debugfs.rs           |  2 +-
>  14 files changed, 22 insertions(+), 23 deletions(-)

I will pick up the DRM ones (patch 2 & 4) once the branch re-opens on
Dec 15th.

Alice


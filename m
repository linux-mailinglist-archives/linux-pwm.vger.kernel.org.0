Return-Path: <linux-pwm+bounces-7695-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F5BC84F47
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 13:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA8774E061A
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 12:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D503F286417;
	Tue, 25 Nov 2025 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1YTrDZQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4F1A9B58
	for <linux-pwm@vger.kernel.org>; Tue, 25 Nov 2025 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073485; cv=none; b=W0y+nehpedxxqGwUmOsvsa6LsstzWXGqMNUANtEvAP6/I5rF/bxvU81ao4wFHBOUKrgOeEH/1sq/Pmh3snWOq++8zzfY2zx8laBAs4HP4BdrECzjz63RS3z+6g0NhC0UvkT/89KnSK/dD+ChEgIjXjCmID+j1XDQs7knFlrH5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073485; c=relaxed/simple;
	bh=AipkYeLxqOofPJKfE6kYPtZb1dNoROJ4hDU3QSocins=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JW31JjnMPYIm9FQVxInzqOWCOgsSMbhNxXi6cSP9bKvsby88EFJ/lQpL2CdryqzVAmiEMFIWFHzIIRe9wPx8E8Y/bex/tlGuBbQUItbgPmjebobfRR4J38710tjd0rePvsOagEJoCj5u4vh+H8Y/XbVJMB1Kv006g+zLlg2phxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1YTrDZQ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429cbd8299cso2635257f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 25 Nov 2025 04:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764073482; x=1764678282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UWqCGf4yniNYnv+0gGu8q0Azun9cQVkGzauYt4WzdGE=;
        b=h1YTrDZQJULe4vbwVUm/7xWr1kx6vCgDexxfzikjmRXQ9BkXkxKI8BL+08s26SBD9Z
         ncCgEP+MUpTnZnNuQowjaqf2XClhQT+WorIxvnqX0o8Y9decG/IazD8cP0ee7+wzjNH4
         cJSYockEXFjPhiPROvG0rPJK+hTa269xt32e4NRQTa8FYOHf69klkuHVJqfo7iqdAFY6
         2TDYeWo5fcCBNKkEzyQE7vmThxtN1+keBpDcDPeDA1ainIdTLH9/X0pgFmo89vW4SsaP
         NoWQf6mcK2CzUW4GDsPhuaQ/yHCIU+c5DE7O+xnsfDHDUw7VrJ73t1t+k0s72IzjRuAN
         Yy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764073482; x=1764678282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWqCGf4yniNYnv+0gGu8q0Azun9cQVkGzauYt4WzdGE=;
        b=mhi93lozZuLYx83QNtgv4KJMpgf3KJKncfStAA6batGzZ6siHr8lS/9L1f17s5nfU3
         OIfl63Qf3OfSExC9rGExmA5tGUFzY09EaWRJJVXAKnNsjuJVS2s6JX+dQevYExllLgcw
         4mJXVgpmFfqBU0ibJ9DWNIeRjQPLmUkGhVb4Xe2XnbA4X72OqQ6BuAQUoH5JenP5bfjK
         Nqqarvf/PtyoV3KxBDkjA48MC5U5zpq9xzSbdSxkREuE0uuN8FopTnpXPaGY2iRU0i+g
         GNj7GjniZK0vqA+Q5h0PGdIIVAzxWGu2rgKv9GTWkJ+G2KZ+K0S6PnCXwpS7bnFF90cd
         B5EA==
X-Forwarded-Encrypted: i=1; AJvYcCXubEdIeIGwcY/yG+/Pu0ZPNX84bF693vluh7LsdMSdvSfEQdQ6KzngtzTKoi74lgu5AVaTSZfekms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3N9AzPE/2R5ZuL1bQIGpkoGLcWOISUdjnV+99uLIfPY+CtNd
	A1pd6IJNQNaIWhAjRkJSIOlqHJDA7KrL9xCDTrDTTV9ceAcyczBs7kukt6AawHTRDtfAUrdm14n
	JiUi2MDLX9I/hhlw2fQ==
X-Google-Smtp-Source: AGHT+IG2G97KKRtl5QTLxOePIordMgMh99WR16j540538wZ8wcvVCkUBTwb1GuKCnER5wu5hmB/vT2jtUiJeEds=
X-Received: from wrrt17.prod.google.com ([2002:a5d:42d1:0:b0:42b:29df:cc2c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d02:0:b0:42b:3339:c7ff with SMTP id ffacd0b85a97d-42cc1d19a16mr16939785f8f.43.1764073482439;
 Tue, 25 Nov 2025 04:24:42 -0800 (PST)
Date: Tue, 25 Nov 2025 12:24:41 +0000
In-Reply-To: <20251123092438.182251-2-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251123092438.182251-1-shankari.ak0208@gmail.com> <20251123092438.182251-2-shankari.ak0208@gmail.com>
Message-ID: <aSWgCT0beyqaD4jE@google.com>
Subject: Re: [PATCH 01/10] drivers: android: binder: Update ARef imports from sync::aref
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shankari Anand <shankari.ak0208@gmail.com>, 
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

On Sun, Nov 23, 2025 at 02:54:29PM +0530, Shankari Anand wrote:
> Update call sites in binder files to import `ARef`
> from `sync::aref` instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Greg, please go ahead and pick up this one, thanks!

Acked-by: Alice Ryhl <aliceryhl@google.com>



Return-Path: <linux-pwm+bounces-9255-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gmtuFotgIWprFQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9255-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 13:24:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C992E63F660
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 13:24:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ivsLnTTa;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9255-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9255-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A06300A131
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 11:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137B73DFC6C;
	Thu,  4 Jun 2026 11:17:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D4409108
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2026 11:17:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571836; cv=none; b=h1RGVxKp5ZFCwEeFopbIFxpnTpa8p892TBjEPsBD1g+jM8Ml76flIqP63iIxXirbiieLcy31PTfUbdcWfQRPFccQzc9yaO79kOX6vo7lOlh/IsRywNYFeIRtCVVsG7C7udqPjYSNcwHb5W4VD5FKj2Zm57bzxh3C49hWUMwSPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571836; c=relaxed/simple;
	bh=Li3Wd9vZ2do7YIFFIrvPQ4L5MznI5BwPjL7AunXsO9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZtFXCywAVZjeZ1aVvjJgs01awXB1p46v7f3IV3SF5Fr9ba5IzRfHvejUz8KY0Bdl5PWgKh56jZPjXtMiR+b4QXOQedUNSDQUF91BO44SlmKPUWLI77lhyqqB49Os+Yo3kGlT4fhdpqkpa+RSnpHqpnYLmzJaKIon8BVtTCPzCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivsLnTTa; arc=none smtp.client-ip=209.85.128.73
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso3041295e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2026 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780571833; x=1781176633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bL3cr/N4yYTt9Xr62pbCqd/6k/zRQ+lTKB/ioJiYtd8=;
        b=ivsLnTTanW/nUJfToVzGLrP8aPC39hcFvo9+j6K+4wVvBmgyLxwQkR0ZQPK5SA3XV4
         Tjagv/7GALQCeBLxZee7yQxdIn5PAgZ0iD4GiZ+vCIFwLcRxIbFEUX3dUnrHC2818WMg
         bONOgIwPUbhDO2jB5s9y+K6fOvN9W1YiOFPFpI/xmtZyL4J3fXl8KJNT+79+Kmt42ehP
         EPjlx5QajL2pXk0D431dpu9WRZdAEL3Gx2dk8va/yXNlVF3Vi1+NVYY/v1ZGvwrT2/C2
         83fR5nKoM0+wm6Le0MbAKEsETFRBqvnNmcoEsFicptWqLDrXB5uX4jeK/rzuR0swcrVy
         LJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780571833; x=1781176633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bL3cr/N4yYTt9Xr62pbCqd/6k/zRQ+lTKB/ioJiYtd8=;
        b=n23AvS5I3Ry1WAsaXR03cIf1IRADX7Rgd6sdCsbhvf1lhApKlZMBM4g35yAATTId+r
         SCP58H7Zou31fiLq+eAXnVUqnKuQ/XmrPK4bdMKJ4aOFHX0K6L3IRdgpIjQjaz0Old2W
         uhpLX2PvHhKexGD2tnGR2SKgHBCluTu7cEXEW7vJIUralA4+Cm9so9uPjzdizHlK+Ebo
         3/EZIHR0treSE5wWoh3GF7J7oAtIb5sWJXiUXRv0yd9scoeZrtAxoOnAXbj0tajqiI9Y
         e44oLVjYXpGANQHHup8bq9EK8x7sGOhv8QJUDWwhSrmTA2aQsENTl4xyw/WXPO10UyAx
         zayA==
X-Forwarded-Encrypted: i=1; AFNElJ/9RrDFFu/ZJwkOtOucacrVFiwsobvWlL+Xdvl9wgVqsWWR3TcORV6RrCSoe9YEkPGxf5mqR/Vws2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXldNqp+jZiW4TZJPtX6hAeG+UsjvTjsL8V7nQ/VU5lsC5psBr
	eg7J3Wz9k+U2WmfGT29g+Zf6B7/QWnJAeVZ4TZ7JsmekWtBWCLQOrUcfIJibRvGsWI7Y0hpouJA
	vtIoa94YevbDyyimxiw==
X-Received: from wrvx5.prod.google.com ([2002:a5d:54c5:0:b0:45e:ee1e:37d3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1993:b0:490:bb19:b110 with SMTP id 5b1f17b1804b1-490bb19b19amr73563895e9.27.1780571832368;
 Thu, 04 Jun 2026 04:17:12 -0700 (PDT)
Date: Thu, 4 Jun 2026 11:17:11 +0000
In-Reply-To: <20260526-rate-exclusive-get-th1520-v1-1-34cf034e1764@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526-rate-exclusive-get-th1520-v1-0-34cf034e1764@mailbox.org> <20260526-rate-exclusive-get-th1520-v1-1-34cf034e1764@mailbox.org>
Message-ID: <aiFet_2SNAwj6o2O@google.com>
Subject: Re: [PATCH 1/2] rust: clk: Add ExclusiveClk wrapper for clk_rate_exclusive_get
From: Alice Ryhl <aliceryhl@google.com>
To: mhi@mailbox.org
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	"Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9255-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mhi@mailbox.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,garyguo.net,protonmail.com,umich.edu,redhat.com,samsung.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C992E63F660

On Tue, May 26, 2026 at 07:04:57PM +0200, Maurice Hieronymus via B4 Relay wrote:
> From: Maurice Hieronymus <mhi@mailbox.org>
> 
> Add Rust bindings for clk_rate_exclusive_get() and
> clk_rate_exclusive_put().
> 
> Clk::rate_exclusive_get() consumes the Clk and returns an ExclusiveClk;
> the matching put is issued from its Drop impl. ExclusiveClk derefs to
> Clk so existing rate / prepare / enable APIs remain available on the
> locked handle.
> 
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Overall looks okay to me. With below comments fixed:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/clk.rs | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> index 7abbd0767d8c..8cda40cb01e4 100644
> --- a/rust/kernel/clk.rs
> +++ b/rust/kernel/clk.rs
> @@ -249,6 +249,23 @@ pub fn set_rate(&self, rate: Hertz) -> Result {
>              // [`clk_set_rate`].
>              to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rate.as_hz()) })
>          }
> +
> +        /// Acquire exclusive control over the clock's rate.
> +        ///
> +        /// Consumes the [`Clk`] and returns an [`ExclusiveClk`] that releases the exclusivity
> +        /// when dropped. While held, no other consumer may change the clock's rate.
> +        ///
> +        /// Equivalent to the kernel's [`clk_rate_exclusive_get`] API. Must not be called from
> +        /// atomic context.
> +        ///
> +        /// [`clk_rate_exclusive_get`]:
> +        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_rate_exclusive_get

Avoid the newline here. Links are long, and it's okay that they are
long. They must be on one line.

> +        pub fn rate_exclusive_get(self) -> Result<ExclusiveClk> {
> +            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
> +            // [`clk_rate_exclusive_get`].
> +            to_result(unsafe { bindings::clk_rate_exclusive_get(self.as_raw()) })?;
> +            Ok(ExclusiveClk(self))
> +        }
>      }
>  
>      impl Drop for Clk {
> @@ -329,6 +346,54 @@ fn deref(&self) -> &Clk {
>              &self.0
>          }
>      }
> +
> +    /// A [`Clk`] with exclusive control over its rate.
> +    ///
> +    /// While an [`ExclusiveClk`] exists, no other consumer of the same clock may change its rate.
> +    /// Obtained by calling [`Clk::rate_exclusive_get`]; the exclusivity is released automatically
> +    /// when the value is dropped, after which the inner [`Clk`] is dropped as usual.
> +    ///
> +    /// # Invariants
> +    ///
> +    /// An [`ExclusiveClk`] instance owns a [`Clk`] for which `clk_rate_exclusive_get` has been
> +    /// called and the matching `clk_rate_exclusive_put` has not yet been called.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::clk::{Clk, ExclusiveClk};
> +    /// use kernel::device::Device;
> +    /// use kernel::error::Result;
> +    ///
> +    /// fn lock_rate(dev: &Device) -> Result<ExclusiveClk> {
> +    ///     let clk = Clk::get(dev, None)?;
> +    ///     clk.prepare_enable()?;
> +    ///     clk.rate_exclusive_get()
> +    /// }
> +    /// ```
> +    ///
> +    /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html

Unused link.

> +    pub struct ExclusiveClk(Clk);
> +
> +    // Make [`ExclusiveClk`] behave like [`Clk`].
> +    impl Deref for ExclusiveClk {
> +        type Target = Clk;
> +
> +        fn deref(&self) -> &Clk {
> +            &self.0
> +        }
> +    }
> +
> +    impl Drop for ExclusiveClk {
> +        fn drop(&mut self) {
> +            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
> +            // [`clk_rate_exclusive_put`] and balances the [`clk_rate_exclusive_get`] call from
> +            // [`Clk::rate_exclusive_get`].
> +            unsafe {
> +                bindings::clk_rate_exclusive_put(self.as_raw());
> +            }

Nit: usually we format this with the semicolon outside the unsafe block.

unsafe { bindings::clk_rate_exclusive_put(self.as_raw()) };

Alice


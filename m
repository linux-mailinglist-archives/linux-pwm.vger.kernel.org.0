Return-Path: <linux-pwm+bounces-9271-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5pByE/uiJmo2aQIAu9opvQ
	(envelope-from <linux-pwm+bounces-9271-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Jun 2026 13:09:47 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5265583D
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Jun 2026 13:09:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onurozkan.dev header.s=protonmail header.b=NsXeS3L0;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9271-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9271-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=onurozkan.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD1BF3007B98
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2026 11:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932CC3438BC;
	Mon,  8 Jun 2026 11:09:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D233F5B0
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jun 2026 11:09:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916977; cv=none; b=iAcYCMrUXUrj/5C6Y5tfUoRtET3yJMrrxNaf/g1W5hPAZx6zQ6gQTdf5ygSaH/IuI8s1RG+2r5n4Ld1rUCYr1IuXWHcrY65eGxKzZOj0yfbGFPxxvZOcaJhigRC9+YQmnv8wBDulHXCDiQEcMvha9ONp+DTHX+rYbC3bVqW9OpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916977; c=relaxed/simple;
	bh=ulh0evGVPPNjBy7iwCTYBFGX/Ds4y8hHb8LHBFs/1Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9ABlyTNp0/s/fZ5TNfLdejM8DyVfSURj6xiN1dy1dd2n6dedyaIefMkDSmtgqiYe0sBeOZ3dtrbeXdUba2Y4ua0HtDQFADk9YB/pmBiIMulcD2LojgdzffXdruzT7Ozc7oahzTID2sPYHdsd3BQw6BzMHoop0AIemqPOeI9luU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=NsXeS3L0; arc=none smtp.client-ip=109.224.244.108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780916965; x=1781176165;
	bh=yE0kow4cPVmFeFmEU4SXwVIDnwzfPDzpouaEmX4Fpfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NsXeS3L04i15iimqeQaZUZYdMfXHdM6AtyVzrrKg6DzkZAeUqnoVni7BzJWv9tRFy
	 md3+OCdXghTfJSoR7pe0a32hH6HbsE3/WiSon673+Vzdp7zjehk0QrZuFh8V7JUADg
	 VagBPktDkP4duqhHP0LKSf3pbngkzHAxrYI/+t66RRB2Nbbi/cMmjkNTxluw+wB1sz
	 EqHNtng0Aw6ptyHkF0y/b0/bBKW/ke9ZZxYQ0Sym5HHdXGxDoN8veFLY/PYa/aUXO+
	 QXLE2vECd+/1NoVCBvSNLCAPl+xobUREhrcqv0ZNrJ1kW7+EgxZHeVY7vGViw7Bi+N
	 haetP5ApFakYg==
X-Pm-Submission-Id: 4gYq755lFlz2ScNk
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-clk@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: clk: Add ExclusiveClk wrapper for clk_rate_exclusive_get
Date: Mon,  8 Jun 2026 14:09:13 +0300
Message-ID: <20260608110920.422773-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260605-rate-exclusive-get-th1520-v2-1-695640bf7249@mailbox.org>
References: <20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org> <20260605-rate-exclusive-get-th1520-v2-1-695640bf7249@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onurozkan.dev,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[onurozkan.dev:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[work@onurozkan.dev,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:mhi@mailbox.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9271-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[onurozkan.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[work@onurozkan.dev,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,redhat.com,samsung.com,vger.kernel.org,lists.infradead.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mailbox.org:email,onurozkan.dev:mid,onurozkan.dev:from_mime,onurozkan.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1D5265583D

On Fri, 05 Jun 2026 08:59:59 +0200=0D
Maurice Hieronymus <mhi@mailbox.org> wrote:=0D
=0D
> Add Rust bindings for clk_rate_exclusive_get() and=0D
> clk_rate_exclusive_put().=0D
> =0D
> Clk::rate_exclusive_get() consumes the Clk and returns an ExclusiveClk;=0D
> the matching put is issued from its Drop impl. ExclusiveClk derefs to=0D
> Clk so existing rate / prepare / enable APIs remain available on the=0D
> locked handle.=0D
> =0D
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>=0D
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>=0D
> ---=0D
>  rust/kernel/clk.rs | 60 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++=0D
>  1 file changed, 60 insertions(+)=0D
> =0D
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs=0D
> index 7abbd0767d8c..f834f4833f18 100644=0D
> --- a/rust/kernel/clk.rs=0D
> +++ b/rust/kernel/clk.rs=0D
> @@ -249,6 +249,22 @@ pub fn set_rate(&self, rate: Hertz) -> Result {=0D
>              // [`clk_set_rate`].=0D
>              to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rat=
e.as_hz()) })=0D
>          }=0D
> +=0D
> +        /// Acquire exclusive control over the clock's rate.=0D
> +        ///=0D
> +        /// Consumes the [`Clk`] and returns an [`ExclusiveClk`] that re=
leases the exclusivity=0D
> +        /// when dropped. While held, no other consumer may change the c=
lock's rate.=0D
> +        ///=0D
> +        /// Equivalent to the kernel's [`clk_rate_exclusive_get`] API. M=
ust not be called from=0D
> +        /// atomic context.=0D
> +        ///=0D
> +        /// [`clk_rate_exclusive_get`]: https://docs.kernel.org/core-api=
/kernel-api.html#c.clk_rate_exclusive_get=0D
> +        pub fn rate_exclusive_get(self) -> Result<ExclusiveClk> {=0D
> +            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for=0D
> +            // [`clk_rate_exclusive_get`].=0D
> +            to_result(unsafe { bindings::clk_rate_exclusive_get(self.as_=
raw()) })?;=0D
> +            Ok(ExclusiveClk(self))=0D
> +        }=0D
=0D
We usually inline FFI wrappers.=0D
=0D
>      }=0D
>  =0D
>      impl Drop for Clk {=0D
> @@ -329,6 +345,50 @@ fn deref(&self) -> &Clk {=0D
>              &self.0=0D
>          }=0D
>      }=0D
> +=0D
> +    /// A [`Clk`] with exclusive control over its rate.=0D
> +    ///=0D
> +    /// While an [`ExclusiveClk`] exists, no other consumer of the same =
clock may change its rate.=0D
> +    /// Obtained by calling [`Clk::rate_exclusive_get`]; the exclusivity=
 is released automatically=0D
> +    /// when the value is dropped, after which the inner [`Clk`] is drop=
ped as usual.=0D
> +    ///=0D
> +    /// # Invariants=0D
> +    ///=0D
> +    /// An [`ExclusiveClk`] instance owns a [`Clk`] for which `clk_rate_=
exclusive_get` has been=0D
> +    /// called and the matching `clk_rate_exclusive_put` has not yet bee=
n called.=0D
> +    ///=0D
> +    /// # Examples=0D
> +    ///=0D
> +    /// ```=0D
> +    /// use kernel::clk::{Clk, ExclusiveClk};=0D
> +    /// use kernel::device::Device;=0D
> +    /// use kernel::error::Result;=0D
> +    ///=0D
> +    /// fn lock_rate(dev: &Device) -> Result<ExclusiveClk> {=0D
> +    ///     let clk =3D Clk::get(dev, None)?;=0D
> +    ///     clk.prepare_enable()?;=0D
> +    ///     clk.rate_exclusive_get()=0D
> +    /// }=0D
> +    /// ```=0D
> +    pub struct ExclusiveClk(Clk);=0D
> +=0D
> +    // Make [`ExclusiveClk`] behave like [`Clk`].=0D
> +    impl Deref for ExclusiveClk {=0D
> +        type Target =3D Clk;=0D
> +=0D
> +        fn deref(&self) -> &Clk {=0D
> +            &self.0=0D
> +        }=0D
> +    }=0D
> +=0D
> +    impl Drop for ExclusiveClk {=0D
> +        fn drop(&mut self) {=0D
> +            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for=0D
> +            // [`clk_rate_exclusive_put`] and balances the [`clk_rate_ex=
clusive_get`] call from=0D
> +            // [`Clk::rate_exclusive_get`].=0D
=0D
I think [`...`] wouldn't work on regular comments. They are only for=0D
doc-comments.=0D
=0D
Thanks,=0D
Onur=0D
=0D
> +            unsafe { bindings::clk_rate_exclusive_put(self.as_raw()) };=
=0D
> +        }=0D
> +    }=0D
>  }=0D
>  =0D
>  #[cfg(CONFIG_COMMON_CLK)]=0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D


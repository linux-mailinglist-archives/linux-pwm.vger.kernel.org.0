Return-Path: <linux-pwm+bounces-9313-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kXfIK2SlM2qSEgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9313-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 09:59:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D8769E49D
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 09:59:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onurozkan.dev header.s=protonmail header.b=bu5voEUH;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9313-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9313-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=onurozkan.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E377302D957
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 07:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941153D7D6B;
	Thu, 18 Jun 2026 07:59:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A0A33F8BC
	for <linux-pwm@vger.kernel.org>; Thu, 18 Jun 2026 07:59:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769547; cv=none; b=aOlbswURrdQWV7qN/d6Il+HGW2KkesXx4vApN7Sh3M3kQDER7AIC5zvArp3ljIOLUL9RXbysJAySKlwiIPq3/KHimB1f67u50jS4JYASP2RV2SnMPUc4MI1u1bac5Y7q+2y+8/VnL8TfL//9WlzL9ETUjiTKBuiVW2nsbIKua3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769547; c=relaxed/simple;
	bh=YJM6wrmGhKXn+d/Bq+J5FDixvimrwMNCUE20hZ3q+jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rv0aMhes8O7WOK1zJP+6G+vFS2hd+cirStWKL4MSgnscJ0mjnZvii6Qvn4ZlXH9f54tUzDyD4TnBYbB8hUwXau7L6gE+xdWoAFoUy9cwBbLvj5jQC8f8kT29R3Pde7yCFMQN4LqCn/Qikg8orBd6OKqd2whniahWw3qtuKbBGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=bu5voEUH; arc=none smtp.client-ip=109.224.244.106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781769537; x=1782028737;
	bh=FQ9h1CNqtUIN9Ufq0CQyLuGN5g3JqgqYIsoSVJmPyDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bu5voEUHxZ16s5NR8RCnQZSzKOtOARepFItcD+renzYYsuo0H9OMI/sh+bvQb8WYR
	 kcl8QhRR6Lk/89oPQ+kCcVsecOdlEjmbIXH3ScoNfbtC0p5/MYwjUkewI2/VOq7Cq3
	 1de2jMTVMIVu00IhN1HxtAbwLH4D1u/ZTvSssC+QmH59KiF1IFKsQT+gGcIJPQbogT
	 iZpROoSfiW/M0lurXIzcW9AXtETcxUXGelZkEu5t4oG/UE/wdFkAdZbvKOux/+52Ts
	 6z89OgPGkxuAmYKvyT1Akt9meuGh61PJebzFQsGydcKaQioBdDyRD1nmdrUL7HlM20
	 1RNW0/QdxAy4A==
X-Pm-Submission-Id: 4ggtQf3jNcz2ScmS
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Brian Masney <bmasney@redhat.com>,
	Boqun Feng <boqun@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v4 3/3] rust: clk: use 'kernel vertical style' for imports
Date: Thu, 18 Jun 2026 10:58:47 +0300
Message-ID: <20260618075848.28017-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com> <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[onurozkan.dev:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:daniel.almeida@collabora.com,m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:dakr@kernel.org,m:aliceryhl@google.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:m.wilczynski@samsung.com,m:bmasney@redhat.com,m:boqun@kernel.org,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:boris.brezillon@collabora.com,m:work@onurozkan.dev,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[work@onurozkan.dev,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9313-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[onurozkan.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[work@onurozkan.dev,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,google.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,samsung.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,collabora.com,onurozkan.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,onurozkan.dev:dkim,onurozkan.dev:email,onurozkan.dev:mid,onurozkan.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08D8769E49D

On Thu, 18 Jun 2026 00:46:37 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> Convert all imports to use the new import style. This will make it easier=
=0D
> to land new changes in the future.=0D
> =0D
> No change of functionality implied.=0D
> =0D
> Link: https://docs.kernel.org/rust/coding-guidelines.html#imports=0D
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
> ---=0D
>  rust/kernel/clk.rs | 56 ++++++++++++++++++++++++++++++++++++++++++++----=
------=0D
>  1 file changed, 46 insertions(+), 10 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs=0D
> index 692ee88ca772..1412a2f0aedf 100644=0D
> --- a/rust/kernel/clk.rs=0D
> +++ b/rust/kernel/clk.rs=0D
> @@ -80,12 +80,23 @@ fn from(freq: Hertz) -> Self {=0D
>  mod common_clk {=0D
>      use super::Hertz;=0D
>      use crate::{=0D
> -        device::{Bound, Device},=0D
> -        error::{from_err_ptr, to_result, Result},=0D
> -        prelude::*,=0D
> +        device::{=0D
> +            Bound,=0D
> +            Device, //=0D
> +        },=0D
> +        error::{=0D
> +            from_err_ptr,=0D
> +            to_result,=0D
> +            Result, //=0D
> +        },=0D
> +        prelude::*, //=0D
>      };=0D
>  =0D
> -    use core::{marker::PhantomData, mem::ManuallyDrop, ptr};=0D
> +    use core::{=0D
> +        marker::PhantomData,=0D
> +        mem::ManuallyDrop,=0D
> +        ptr, //=0D
> +    };=0D
>  =0D
>      mod private {=0D
>          pub trait Sealed {}=0D
> @@ -189,8 +200,15 @@ impl<State: ClkState> From<Error<State>> for kernel:=
:error::Error {=0D
>          /// original [`Clk`], e.g.:=0D
>          ///=0D
>          /// ```=0D
> -        /// use kernel::clk::{Clk, Enabled, Unprepared};=0D
> -        /// use kernel::device::{Bound, Device};=0D
> +        /// use kernel::clk::{=0D
> +        ///     Clk,=0D
> +        ///     Enabled,=0D
> +        ///     Unprepared, //=0D
> +        /// };=0D
> +        /// use kernel::device::{=0D
> +        ///     Bound,=0D
> +        ///     Device, //=0D
> +        /// };=0D
>          /// use kernel::error::Result;=0D
>          ///=0D
>          /// fn get_enabled(dev: &Device<Bound>) -> Result<Clk<Enabled>> =
{=0D
> @@ -240,8 +258,17 @@ fn from(err: Error<State>) -> Self {=0D
>      /// The following example demonstrates how to obtain and configure a=
 clock for a device.=0D
>      ///=0D
>      /// ```=0D
> -    /// use kernel::clk::{Clk, Enabled, Hertz, Unprepared, Prepared};=0D
> -    /// use kernel::device::{Bound, Device};=0D
> +    /// use kernel::clk::{=0D
> +    ///     Clk,=0D
> +    ///     Enabled,=0D
> +    ///     Hertz,=0D
> +    ///     Prepared,=0D
> +    ///     Unprepared, //=0D
> +    /// };=0D
> +    /// use kernel::device::{=0D
> +    ///     Bound,=0D
> +    ///     Device, //=0D
> +    /// };=0D
>      /// use kernel::error::Result;=0D
>      ///=0D
>      /// fn configure_clk(dev: &Device<Bound>) -> Result {=0D
> @@ -287,7 +314,11 @@ fn from(err: Error<State>) -> Self {=0D
>      /// and move between the variants:=0D
>      ///=0D
>      /// ```=0D
> -    /// use kernel::clk::{Clk, Enabled, Prepared};=0D
> +    /// use kernel::clk::{=0D
> +    ///     Clk,=0D
> +    ///     Enabled,=0D
> +    ///     Prepared, //=0D
> +    /// };=0D
>      /// use kernel::error::Result;=0D
>      ///=0D
>      /// enum DeviceClk {=0D
> @@ -481,7 +512,12 @@ pub fn enable(self) -> Result<Clk<Enabled>, Error<Pr=
epared>> {=0D
>          /// clock or threading it through an intermediate state, e.g.:=0D
>          ///=0D
>          /// ```=0D
> -        /// use kernel::clk::{Clk, Enabled, Hertz, Prepared};=0D
> +        /// use kernel::clk::{=0D
> +        ///     Clk,=0D
> +        ///     Enabled,=0D
> +        ///     Hertz,=0D
> +        ///     Prepared, //=0D
> +        /// };=0D
>          /// use kernel::error::Result;=0D
>          ///=0D
>          /// fn read_rate(clk: &Clk<Prepared>) -> Result<Hertz> {=0D
> =0D
> -- =0D
> 2.54.0=0D
> =0D


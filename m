Return-Path: <linux-pwm+bounces-9627-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J8O/FhYATmruBQIAu9opvQ
	(envelope-from <linux-pwm+bounces-9627-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 09:45:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A9A722CB5
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 09:45:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=temperror reason="server fail" header.from=linkmauve.fr (policy=temperror);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9627-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9627-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BAD33003EE8
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 07:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC633EE1C4;
	Wed,  8 Jul 2026 07:39:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B73F54B0;
	Wed,  8 Jul 2026 07:39:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496385; cv=none; b=P+BfUAl2ZUh+dd9M1Oio0zn3IH98rIlGD51HqFvHKELrAMPPS7hyTK7CKAoylurN8wWGQ6qRTtTNhQWUQt2gB+SX6ktDXnBdoPaoFRcez0LcZAeXfQchtP+aBL0KyopdvZwfkhMNaD2uAyyHxu/2dgPwImO1v85ZprAXu/MW7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496385; c=relaxed/simple;
	bh=hE80zLMucVCYhHzwDByDl4nPpyiOoITY4WrX5mG/B9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4h1KJ/j5RjjxHVltfMsSgwOZx+bf6AqRJqg/iLrHct1XQ5vTavC+7BTOXOoizFVKmQMUBBKrm7JqtkkRd5qEmjpHCJUNPa77aQYaFY0IodrHurwmBa0D9Cx/qgAQ71XuFczFDW4+df49GPJZJOseOPkv5qUVTgxSlL/6rWmETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 1183CF40CC8; Wed, 08 Jul 2026 09:39:25 +0200 (CEST)
Date: Wed, 8 Jul 2026 09:39:25 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] pwm: th1520: use vertical import style
Message-ID: <ak3-rU3IRYaLTCC5@luna>
References: <20260705-pwm-rust-vert-imp-v1-1-753dbbfc6061@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-pwm-rust-vert-imp-v1-1-753dbbfc6061@gurudas.dev>
Jabber-ID: linkmauve@linkmauve.fr
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9627-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@gurudas.dev,m:m.wilczynski@samsung.com,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[linkmauve@linkmauve.fr,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[samsung.com,kernel.org,redhat.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,gmail.com,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkmauve@linkmauve.fr,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[linkmauve.fr : server fail];
	TAGGED_RCPT(0.00)[linux-pwm,lkml];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linkmauve.fr:from_mime,luna:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3A9A722CB5

On Sun, Jul 05, 2026 at 07:52:05PM -0700, Guru Das Srinagesh wrote:
> Convert `use` imports to vertical layout for better readability and
> maintainability.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
> Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
> vertical import style") and found a few more locations that could
> benefit from this cleanup. No functional changes.
> 
> Separating out patches per-subsystem as per the review feedback in [0].
> 
> Tested via:
> 
>     $ make LLVM=1 rustfmtcheck || echo "fail"
>     $
> 
> [0]: https://lore.kernel.org/lkml/20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev/
> ---
>  drivers/pwm/pwm_th1520.rs | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index 3e3fa51ccef9..2a3b107157ac 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -23,15 +23,21 @@
>  use core::ops::Deref;
>  use kernel::{
>      clk::Clk,
> -    device::{Bound, Core, Device},
> +    device::{
> +        Bound,
> +        Core,
> +        Device, //
> +    },
>      devres,
>      io::{
>          mem::IoMem,
>          Io, //
>      },
> -    of, platform,
> +    of,
> +    platform, //

Same here, you just need the empty comment after time, not the one after
platform.

>      prelude::*,
> -    pwm, time,
> +    pwm,
> +    time, //
>  };
>  
>  const TH1520_MAX_PWM_NUM: u32 = 6;
> 
> ---
> base-commit: 1a4920940ebfd8d907858abd8f8dd09b13752946
> change-id: 20260705-pwm-rust-vert-imp-59a3d18bd0cf
> 
> Best regards,
> --  
> Guru Das Srinagesh <linux@gurudas.dev>
> 
> 

-- 
Link Mauve


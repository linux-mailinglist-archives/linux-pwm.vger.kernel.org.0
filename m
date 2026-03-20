Return-Path: <linux-pwm+bounces-8298-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGJJLf0yvWmI7QIAu9opvQ
	(envelope-from <linux-pwm+bounces-8298-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:43:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7852D9C1E
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24F7E3008E18
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693C39BFE1;
	Fri, 20 Mar 2026 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNPBILJF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287538A72C;
	Fri, 20 Mar 2026 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007034; cv=none; b=iXwdudP2HvJavSy5qoov0N26XZllic4ewa+8kWxbDxhq4dVMmRBJKQUMsxoKaD/ZVLxOfq2sLkX+UL1anUu4Eto0SALZQm2aKwN5tXhncD3WSx4UU8rJeD2xOVKP0+7X0zL05cSso9BSUUFTSkgkxdM6cTGrpC9VFywNPHb32cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007034; c=relaxed/simple;
	bh=Rp2R12YtoEPaPhn+6Glp5nodLFyhyQINVrjxcl6ZFPM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ugtwTxuv4TC8CC2H7uW9N6UFVkm7PqpfSC/9zS8Oxtahz9UvZqpwTSirP46Wp+JXECZQe0mZh3DyxSmJdCbKQXTwuB3V5WBOxhi2oSG1G7ujaAM5gCKA3yFbjzOx6/O6PH8MVSFeM5iNkBjupNF4lXM/203ReZurI6JSxfogQ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNPBILJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D5AC4CEF7;
	Fri, 20 Mar 2026 11:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774007034;
	bh=Rp2R12YtoEPaPhn+6Glp5nodLFyhyQINVrjxcl6ZFPM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ZNPBILJFImehQ5vsVgWdx2URfMRpRXVNIayv0g3/6SAM0zTgNAAe6pxgaEX9grMiL
	 2W9VUKVIIif2i4OUt3JzNeYyrwSFPFRq4NUsRr7sZ9antdizaXdJXaJBWZ1Wk3aP1B
	 CvBZKtuMe5frdSdP5I0pc0yki3j9HmuVv3C+hZW22HAbxnvNIzX7kRkshngxgoUUAg
	 lTLbKbnSW9ndNbOl4rkf4E5BUB0AinI7Zbfw8pfdOhNv/cWQAX3pHjPJUCPVUYgxOE
	 P/4BIWURqQIQi28UddOpanvvytutODRQc8tRXwrfryBrPigFGzic8r93bfakdjRSFa
	 PqWJDwaOue7ww==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 12:43:47 +0100
Message-Id: <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Drew Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu
 Wei" <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>, "Boqun
 Feng" <boqun@kernel.org>
To: "Stephen Boyd" <sboyd@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
In-Reply-To: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8298-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,baylibre.com,linux.intel.com,kernel.org,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.943];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2C7852D9C1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Stephen,

On Mon Feb 23, 2026 at 11:08 AM CET, Alice Ryhl wrote:
> The Clk type is thread-safe, so let's mark it as thread-safe in the type
> system. This lets us get rid of hacks in drivers.
>
> For Stephen's clk tree.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v5:
> - Rebase on v7.0-rc1.
> - Pick up Reviewed-by tags.
> - Link to v4: https://lore.kernel.org/r/20260113-clk-send-sync-v4-0-712bc=
7d94a79@google.com
>
> Changes in v4:
> - Pick up Reviewed-by tags.
> - Link to v3: https://lore.kernel.org/r/20251218-clk-send-sync-v3-0-e48b2=
e2f1eac@google.com
>
> Changes in v3:
> - Rebase on v6.19-rc1.
> - Pick up tags.
> - Add fix for pwm driver as well.
> - Link to v2: https://lore.kernel.org/r/20251020-clk-send-sync-v2-0-44ab5=
33ae084@google.com
>
> Changes in v2:
> - Rebase on v6.18-rc1.
> - Add patch to tyr driver.
> - Link to v1: https://lore.kernel.org/r/20250904-clk-send-sync-v1-1-48d02=
3320eb8@google.com

Alice has resent this over the past three cycles, but it hasn't been picked=
 up
yet. Please let me know if there are any concerns -- otherwise, I plan to t=
ake
it through the drm-rust tree in a few days.

Thanks,
Danilo


Return-Path: <linux-pwm+bounces-8050-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEsQOPAagmmZPAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8050-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:57:36 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B99DB96E
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52B5B30992F7
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BEF3BFE34;
	Tue,  3 Feb 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3+Ob8zk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6333B95FC;
	Tue,  3 Feb 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134039; cv=none; b=CpXbuYFTHLkaepdRGWF7b8VbTqV/VhWqEj133IMjy6OHctogIpsa6Ev9EP14xRKY/uKzT4f4Io9mMxiTZOBL6ul8qysXbBk/uEBXbWoFtbGoKUKQsd4yhV1o5LL2zZkU5RIiLY0svj5fK0ajC7C+KfVKdJXhExhWXqfYrSUjAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134039; c=relaxed/simple;
	bh=1nS4AO22symQeFy3tcdMNBtHeJUlbBFqz1B5VpUBa6Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=AWeXrWtb+lnB6Ee1iMW7WAz9z2ac+pW0vxhPZclLLmxKTZ1zV7uRbX3KE0fCSOJvRRP3P2cFJgKVrWCCIgUODh5rg/AjzikywFLmOIqldHWYEdkuPnr/R3FMp1jU6KLSJeXj+dppHYWn4CVAJrWjq3W/GWqLRBsDTvrqVWXw/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3+Ob8zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D661AC19421;
	Tue,  3 Feb 2026 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770134039;
	bh=1nS4AO22symQeFy3tcdMNBtHeJUlbBFqz1B5VpUBa6Y=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=D3+Ob8zkiZjMhafcOfTN1MUr9UGmopuQ1uHGIYvDxb5qvvGvdYL0OTSF3tok13Cl5
	 xkqRQucdFd7u2DMKRlVCd8HpSBsN8VHAgKCg0IOOtSgbVNV9CosRNUbRRWZVoPtL2Y
	 4ccnSqQpaAkrqZzvrPINZ476YLJZ9gf8EzKqwC5hNa2lKEJi5Z3jVsHHqJKCSN9kLV
	 4r7Rsfq+vD94Dcn46vp5mBWKIsBPcn+1TjoxCh3R+xHGhJl/3Mi9zjDaQOEoDR/6Jh
	 SLgTo+9bd0uAHwwAedeKQH9+rfMRY3WCAWVaftbQ6TEh1X253zfm3K3AZWPzzadLyc
	 puGofnWid+Wng==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 16:53:51 +0100
Message-Id: <DG5G57S9G1HK.3T2CT6RLURWPT@kernel.org>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Satya Durga Srinivasu Prabhala"
 <satyap@quicinc.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Trilok Soni" <tsoni@quicinc.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/6] rust: io: Support copying arrays and slices
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-2-d6719db85637@google.com>
In-Reply-To: <20260203-qcom-socinfo-v2-2-d6719db85637@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8050-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,linuxfoundation.org,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zulipchat.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45B99DB96E
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 4:46 PM CET, Matthew Maurer wrote:
> Adds support for doing array copies of data in and out of IO regions.
> Fixed size arrays allow for compile-time bound checking, while slice
> arguments allow for dynamically checked copies.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

This patch needs to go on top of the recent I/O rework and should be genera=
lized
through an IoSlice type [1].

[1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/top=
ic/Generic.20I.2FO.20backends/with/571639597


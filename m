Return-Path: <linux-pwm+bounces-8067-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBoBKEEqgmnFPwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8067-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 18:02:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA2BDC6F8
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 18:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 576CB300D252
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB8F3D34A3;
	Tue,  3 Feb 2026 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PatvW/Fe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D433D34A0;
	Tue,  3 Feb 2026 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137915; cv=none; b=iZa0xhXeLjdVkDDSCtyJ/lRZsmyUJZXK7t77QgCp+cx4Xkn1uVmxawKQ25xuTVm2GzOgYIsKk0LMiCB8eZ2YSbhiOl5KYFGySwA/jQX5NsRddr+MEu2r6BJ7rcQP9/ONT2moMhtu4j01AtHGLiJ+g7Z0I/HSOBvBNJZ0ip3E51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137915; c=relaxed/simple;
	bh=WxmlTgy0bTXH+yTAEyI8pJk9rrPb8d6K81hCjqQk99E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=urtw+7O6h9MMbR8MgraAirwRooCsJmXsxECn6sedlVMWG1Og5/VXvQ2TwH3/Q5RGjF+OP4nWKKe/jnw/2t65dLGE38chzZaDc5J70KiBiAzbv5YqhJ2TcHrBvWMqvTvid6or8IxaBCNCI3nKDocgJ0Qa40YKDcmaSPJkspuTFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PatvW/Fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB20C116D0;
	Tue,  3 Feb 2026 16:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770137914;
	bh=WxmlTgy0bTXH+yTAEyI8pJk9rrPb8d6K81hCjqQk99E=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=PatvW/FeOqaD0/AGUGWfu+D/oZ5PFg0xDRNlYV+ebA78rtsQYefCAXTKRXXG5aJ4S
	 P8Wcu4gN+/6xCdbzi0UzOduiWN5nLel1xOmS3l5XMvCDW67Z96PGTvhM6QSC4oye4B
	 mRMU3m8cZkmfP3deqtdtcyMUp2qWPtiKpdVTWPSoDa2MOfrs6jU5OJY9lhT9h+/eCd
	 GG2AJSiH8lKZZ0zsWGhBVATSEe3A4Z5IwpPbuRIBVN3izJqMMLl24cZZz9JdwCMapS
	 XcibbwAB1OWctZLYRGuRBbqEYseEXQC756WNjxeokuXJpPM1j3ZtIQV/2SRZMTkgoE
	 U9el1uBjxXRcg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 17:58:28 +0100
Message-Id: <DG5HIOSFBM2O.1ZKURNJFQN1KB@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 5/6] rust: debugfs: Allow access to device in
 Devres-wrapped scopes
Cc: "Matthew Maurer" <mmaurer@google.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Satya
 Durga Srinivasu Prabhala" <satyap@quicinc.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
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
To: "Gary Guo" <gary@garyguo.net>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-5-d6719db85637@google.com>
 <DG5HAM6F5QYE.1ZFO7GD3SL9V0@garyguo.net>
In-Reply-To: <DG5HAM6F5QYE.1ZFO7GD3SL9V0@garyguo.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8067-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,quicinc.com,gmail.com,protonmail.com,umich.edu,collabora.com,linuxfoundation.org,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_TWELVE(0.00)[28];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: ABA2BDC6F8
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 5:47 PM CET, Gary Guo wrote:
> I think it is a big strange to have this on `Devres` (in patch v6 it has =
`Devres::dir` doesn't make
> too much sense). I would suggest that we domsomething like
>
>     impl<'a, T: 'a + Send> Scope<T> {
>         pub fn devres_dir(
>             ...
>         ) -> impl PinInit<Devres<Self>, Error> + 'a;
>     }

Good catch, I did not notice that this is implemented on Devres, rather tha=
n
debugfs. This should not be implemented on Devres.

> To me `Devres` is just a generic container type, just like `Arc` and `ARe=
f`, so
> the assoc functions should be defined on the concrete type.

Indded.


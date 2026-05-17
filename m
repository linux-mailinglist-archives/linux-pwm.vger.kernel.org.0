Return-Path: <linux-pwm+bounces-8933-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OYWBXPRCWrlqwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8933-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 16:32:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF326561AD7
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 16:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA34F3003417
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 14:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E39283FC4;
	Sun, 17 May 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7hn5KyF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72812264C0;
	Sun, 17 May 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779028336; cv=none; b=TBAu+vzs1Do8Wp+zvn1l7PQuNWEmpy3HTazkhQSXiC0NWFlSZ4Gd3Z8XcfTOy+ED8E+xiTkKRdAhaId/dyGRYLWGKsFA0ga07nnKsLp2Vdvs49ZzRSs6hTDGbhr1U3B2OtsHyBXu4tcdr8kQm26l0l291np4n626Ct6Hzx2K56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779028336; c=relaxed/simple;
	bh=ulaOuKvCeT6t5jbenSb1LbQU7lp8mpBN6cfjZZoeaOw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=BKRcDvak/idARv0Qh9MkgAf3F9+YhzzdEPmezW9Ytt0TNwNseNKOs8Pia9wCtCt+/WoK//RA1UnoH6ZhSzgIFxGN7ygKgaUwBX+1W01LnFfxdDwT76ReKAPF1smRC9bz0+5Ux5WH/8vl6HxSWxekASRB4rihsBLTWeuJY1kypHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7hn5KyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A257AC2BCB0;
	Sun, 17 May 2026 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779028336;
	bh=ulaOuKvCeT6t5jbenSb1LbQU7lp8mpBN6cfjZZoeaOw=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=b7hn5KyFLmpCLuD3zK9Svmq9lIXAno/+es90/BP2+vlpLNcZVDHpVD1P+Je8H1j7A
	 3uhnNDNQxihXm10aFTSJ9zEvo2h8iB91wrpUdRqP5yQGKhrc02O52UHmADR6/yrlEY
	 Ygpk51UPFE9/iMiKddQLVtziwtaVwY/8rLgVLeR8sG0Lr7gU5L+XYpbHwSUR1dBwR7
	 rE5V84b7XieaRLK7+0tZXUUShD/vW88LUIguHXd5MGejGAJsXrwxhAUmUbCdBk4xp5
	 P4UUB8RvE9/P+vY9VBAO3VKq8sVkJjWinWYjd5t+biZbp8UPCwc0hYJUhNbY6b3izq
	 kBAHFbMBrhCeQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 17 May 2026 16:32:09 +0200
Message-Id: <DIL0WRS36ZL2.2CT5UNXVH8VKE@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <pcolberg@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 03/27] rust: driver: decouple driver private data
 from driver type
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-4-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-4-dakr@kernel.org>
X-Rspamd-Queue-Id: BF326561AD7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8933-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun May 17, 2026 at 2:00 AM CEST, Danilo Krummrich wrote:
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index 586091cfa45c..3506b4e8bff9 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
> @@ -17,6 +17,9 @@
>  //!     /// The type holding information about each device ID supported =
by the driver.
>  //!     type IdInfo: 'static;
>  //!
> +//!     /// The type of the driver's bus device private data.
> +//!     type Data;

Should be:

@@ -13,10 +13,13 @@
 //! The main driver interface is defined by a bus specific driver trait. F=
or instance:
 //!
 //! ```ignore
-//! pub trait Driver: Send {
+//! pub trait Driver {
 //!     /// The type holding information about each device ID supported by=
 the driver.
 //!     type IdInfo: 'static;
 //!
+//!     /// The type of the driver's bus device private data.
+//!     type Data: Send;


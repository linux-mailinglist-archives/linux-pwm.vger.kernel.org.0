Return-Path: <linux-pwm+bounces-8867-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCVnHSMwAmq/ogEAu9opvQ
	(envelope-from <linux-pwm+bounces-8867-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 21:38:11 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6E5152E3
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 21:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C521A3052C86
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 19:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B14D2EDC;
	Mon, 11 May 2026 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlsSeWZ3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BD43D4FA;
	Mon, 11 May 2026 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528287; cv=none; b=Gk7eGzWp7ODvE4TrtCoMTpbChyQITldtfaaj+CBLpivHYPd8kEA+ynptPsaqgNbcmIMQjBaU7JoZLfHTSduCE60PXNC1RExtA8JF8PhTSgGM9K72SOcD/URUrQC7FZXdUk85NPNboXuZHwdgI2kVzrpGxUa2jnNxOS2Rg16IeQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528287; c=relaxed/simple;
	bh=v3ZaN4VpL9Hl5zsxFJzl0kBDXKiuushsUjMXH2kS3gY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZReNOgN0fwtiX2QJg3XPcWDoY+6chVCDrgQ+ome7RsKZhvI7CEZTjo4rWgOy2xg+Fnu1OkEJldufVOEGhE7ZaAOaMWeMQSloyqavbclCFqxJoncIn7uVeFQVtFqd6WeGmwYmWLE+1hTFrx3xroQ9R82ixKsg1P2AIL9yZu2s7j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlsSeWZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB69EC2BCB0;
	Mon, 11 May 2026 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778528286;
	bh=v3ZaN4VpL9Hl5zsxFJzl0kBDXKiuushsUjMXH2kS3gY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=NlsSeWZ39A92JT+IPpgrVDN8forOFX9Ii2YOYc3OKiFZ2aXkvMP2Mc8d/ZKldK2XL
	 MtYFPteH3Zfepl6bdeD3byk1HgXqrSLiqPNpG+8MPC0CVMUYSHaSI7vkYEU73sbPJi
	 7R0wbX9d1NsdvPYZSASU1LzC0NCdHVEdIME9R888lhamQr6/Rg87lyfFqcigSHuJys
	 3atWaMuB+bTHvH+eCNJyi6jhuYrv0I+lV0tfEN7NUFVJovCQBmDlfr0TMp7SE7h673
	 WKWuWTBBgr90ru53k+HpiUi1xWg57PYjdWsheWg9J1b+2XBKIrqYixQt7BwoQtUrpZ
	 o03baRFxA+pCQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 21:37:59 +0200
Message-Id: <DIG3NO2QSP5U.2A5UCM1DYQ3ZO@kernel.org>
Subject: Re: [PATCH v2 04/25] rust: driver: make Adapter trait
 lifetime-parameterized
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
 <20260506215113.851360-5-dakr@kernel.org>
 <DICFXB4BLACF.3GTAQPRYURQCB@garyguo.net>
In-Reply-To: <DICFXB4BLACF.3GTAQPRYURQCB@garyguo.net>
X-Rspamd-Queue-Id: D6A6E5152E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8867-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,protonmail.com,umich.edu,linux.dev,collabora.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu May 7, 2026 at 2:24 PM CEST, Gary Guo wrote:
> I applied the following diff and it doesn't require
> additional transmute?

You are correct, this patch isn't needed -- at least it is not needed anymo=
re,
it was at some point during the implementation of this series. I will drop =
it.


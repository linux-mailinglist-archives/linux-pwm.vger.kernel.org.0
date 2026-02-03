Return-Path: <linux-pwm+bounces-8059-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKfQMXokgmnPPgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8059-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:38:18 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C942DC166
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E656317A5E5
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066F23D2FE2;
	Tue,  3 Feb 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvJBgqVq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D313B299927;
	Tue,  3 Feb 2026 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136163; cv=none; b=SRjvqGRotBCTwiOT5GjsOplsCzT1u7+VyODnf7y2oEtSjk4EQoqV5gxVBX7wsCM8/mQP6gm9hQEOIfEoY36ZAAdUDjYfn4TWUCGmRuWw2klZageTv7s+Yg+e4miw3vu7VVUiOtm0weQMJuo3s2iNgxhvGRZK979uHZtfO0kzJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136163; c=relaxed/simple;
	bh=FfyDH8l1QGBNfc5KpjHWRkafoUyts8NRjsB26ikGaJE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jLrNYGqY4v0f9vSEZ1+P94NWjeEs9im78zTUp9VdRVzkTEGUL8BijLya6vw87aVDcRMH8wwvQgT1DQIBdpH0Rt5N9eT/5HyCZL8A2o6Sgc8Wpg8kAqPf00gEwvDAy4vvSLFEAvmFfDLEMgOnNufsCzFhU+G5KR8Zxzh+PTjEMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvJBgqVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66768C2BC87;
	Tue,  3 Feb 2026 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770136163;
	bh=FfyDH8l1QGBNfc5KpjHWRkafoUyts8NRjsB26ikGaJE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=lvJBgqVqLGE1cn54IpO/ZvWT7HCDjwhSe0NV+7zLwq2OSZUiSvim6tQcfsG+H/wAr
	 75a5LOf6zBQinjg9f7w9Lt8x/vhkzHKR3Tk1+TaGjny+WDx1KYiwQbtnJqCcc7ikV8
	 ovxyy8wNUCuYCeo+8uvoZlHL++Ru+wB4mIogM2IOGzaH8SlNW2cBlFLQlBgQfNNtaN
	 R7zfDICXAUXilWzSjmUjBE02NemSuXfIeoiNkOg/cYo+RRbF6EZb0y5BPdSH1YaIRu
	 BLBe73JsutlYeqMXGzn35W1nTk3FsSWrhvkK1HnHRwbUnC2cdrUmL5oyCZukfcQ/ME
	 BfKqg1OGG3lQw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 17:29:16 +0100
Message-Id: <DG5GWC5MR1ZC.3VFVRL0G0NMUW@kernel.org>
Subject: Re: [PATCH v2 3/6] rust: device: Support testing devices for
 equality
Cc: "Matthew Maurer" <mmaurer@google.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Satya
 Durga Srinivasu Prabhala" <satyap@quicinc.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Trilok Soni" <tsoni@quicinc.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>
 <2026020338-gratitude-overplay-98b0@gregkh>
In-Reply-To: <2026020338-gratitude-overplay-98b0@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8059-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C942DC166
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 5:17 PM CET, Greg Kroah-Hartman wrote:
> And I don't see what patch in this series uses this, am I missing it?

	impl Smem {
	    pub(crate) fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Option<&=
'a Mmio> {
	        if *dev !=3D *self.dev {
	            return None;
	        }
=09
	        // SAFETY: By our invariant, this was a subrange of what was retur=
ned by smem_aux_get, for
	        // self.dev, and by our above check, that auxdev is still availabl=
e.
	        Some(unsafe { Mmio::from_raw(&self.raw) })
	    }
	}

It's used to ensure that the Smem provided by the auxiliary parent can only=
 be
accessed as long as the auxiliary parent device is bound.


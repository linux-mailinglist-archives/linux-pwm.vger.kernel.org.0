Return-Path: <linux-pwm+bounces-9187-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE7cOJBhF2p+DAgAu9opvQ
	(envelope-from <linux-pwm+bounces-9187-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 23:26:40 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F67A5EA676
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 23:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 539C7304B24E
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 21:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03CA3C0A1B;
	Wed, 27 May 2026 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSCgBgiz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86182221723;
	Wed, 27 May 2026 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779917198; cv=none; b=VJe+9InNZT5bg2EbZ69BYOOOm4zvzLI5GdAtUdl43xCAaZJY9AP9RCOkDRFRV4klNzCKM3wo86zJmaR7jd8uCmBsgWNlrhFo3DM/q3vqPRGtXxj4qKptxkch/aK2jzppC6xhbKDmvw9Dq+L9eMbiXGSIAEAcgP+O08dURmhAP3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779917198; c=relaxed/simple;
	bh=U/nVILSuVlRzn0eGzzoQqzZfL4zTu2eOto+lszu/SMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3Razd66cRhqjNAeCnJjxCWS5hbWajcBLJggZFwOMvIDCyYyBAKPLHtJKlSuSgXz4dmkcdmHOA8/JodhQYOG6vLwodXbt30IX+EnlYNdKgI38VqWv/3GdHTvFeMWJiHHfHAMLrjpmtEmu/dbMevzqp9Xlv0gNMO3eztHzfRANwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSCgBgiz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0018D1F000E9;
	Wed, 27 May 2026 21:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779917197;
	bh=vNRtcKe/VrnPWd08v/e3phvPSfc8rENS+DLm2ORP08k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CSCgBgizbEY3kXallzJU7ibiCgwCJwPQy0QtOakmUKJRkkCI5LnTYlcyR0bM4nP3r
	 mwHi0OBuW9Z5n2qZ5sA8MLq+OECjzujI4ubmbp3gsW27dJ0hAGGb0U88fC83g6LaEh
	 bSIJINfBsEipyizGLj+V2Ax/0IpG+T7DtcbNhHB7bpPn4rNGX94nS+IPwQfuJx39IU
	 L8oFStGOqsp3JowPO/gXoEYyEhd/toZjZ7GYVYW0NOBTw4fZHN8ESA+/3QiwDt48y2
	 AetqVFudWqvRCAJbaa7rJ425ef3jDsIb1/uRelRgfxtaAfhRvPlWUw0ymdTc1thAWZ
	 SXpHpmAJwxW/A==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	viresh.kumar@linaro.org,
	m.wilczynski@samsung.com,
	ukleinek@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	abdiel.janulgue@gmail.com,
	robin.murphy@arm.com,
	markus.probst@posteo.de,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	igor.korotin@linux.dev,
	daniel.almeida@collabora.com,
	pcolberg@redhat.com,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 00/24] rust: device: Higher-Ranked Lifetime Types for device drivers
Date: Wed, 27 May 2026 23:24:53 +0200
Message-ID: <20260527212453.1506899-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9187-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5F67A5EA676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 22:20:47 +0200, Danilo Krummrich wrote:
> [PATCH v5 00/24] rust: device: Higher-Ranked Lifetime Types for device drivers

Applied, thanks!

  Branch: topic/dd-lifetimes
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/24] rust: pci: use 'static lifetime for PCI BAR resource names
      commit: e566a9e17f37
[2/24] rust: alloc: remove `'static` bound on `ForeignOwnable`
      commit: e9df918d61e0
[3/24] rust: driver: move 'static bounds to constructor
      commit: c8a43666bade
[4/24] rust: driver: decouple driver private data from driver type
      commit: 7fdffdda630e
[5/24] rust: driver core: drop drvdata before devres release
      commit: be31fcf5af75
[6/24] rust: pci: implement Sync for Device<Bound>
      commit: 0b9a29c3a4e2
[7/24] rust: platform: implement Sync for Device<Bound>
      commit: a89111c00b68
[8/24] rust: auxiliary: implement Sync for Device<Bound>
      commit: 5bbcefe8db74
[9/24] rust: usb: implement Sync for Device<Bound>
      commit: 3bb1655192ae
[10/24] rust: device: implement Sync for Device<Bound>
      commit: de12e48a1be3
[11/24] rust: device: make Core and CoreInternal lifetime-parameterized
      commit: 24799831d631
[12/24] rust: pci: make Driver trait lifetime-parameterized
      commit: 16c2b8fdab7c
[13/24] rust: platform: make Driver trait lifetime-parameterized
      commit: 81fdc7881443
[14/24] rust: auxiliary: make Driver trait lifetime-parameterized
      commit: 46f651d88662
[15/24] rust: usb: make Driver trait lifetime-parameterized
      commit: a3f09f8e47c4
[16/24] rust: i2c: make Driver trait lifetime-parameterized
      commit: 71e6b6a80b51
[17/24] rust: driver: update module documentation for GAT-based Data type
      commit: d31a349a7fd8
[18/24] rust: pci: make Bar lifetime-parameterized
      commit: 8ea0b6d5bef5
[19/24] rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized
      commit: 89f55d04c602
[20/24] samples: rust: rust_driver_pci: use HRT lifetime for Bar
      commit: e397d405c4c6
[21/24] gpu: nova-core: separate driver type from driver data
      commit: bb1cf43f2fa8
[22/24] rust: types: add `ForLt` trait for higher-ranked lifetime support
      commit: e189bdb687a5

      [ Handle macro_rules! invocations in the ForLt! proc macro's covariance
        and WF checks. Since proc macros cannot expand macro_rules!, add a
        visit_macro() implementation to conservatively assume macro
        invocations may contain lifetimes, forcing them through the
        compiler-assisted covariance proof.
      
        Fix a few typos in the documentation and in the commit message, add
        empty lines before samples, add missing periods and consistently use
        markdown.
      
        - Danilo ]

[23/24] rust: auxiliary: generalize Registration over ForLt
      commit: 4555291ddae9

      [ Use PhantomData<F::Of<'a>> instead of
        PhantomData<(fn(&'a ()) -> &'a (), F)>], which also gets us rid of
        #[allow(clippy::type_complexity)]. - Danilo ]

[24/24] samples: rust: rust_driver_auxiliary: showcase lifetime-bound registration data
      commit: d18f3646184f

The patches are in the topic/dd-lifetimes topic branch and will be merged into
the corresponding target branch soon.


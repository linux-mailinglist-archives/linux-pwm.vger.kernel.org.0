Return-Path: <linux-pwm+bounces-9623-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oLtRNhU1TWpnwgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9623-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 19:19:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6897C71E383
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 19:19:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=ORVn9N7W;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9623-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9623-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80575305EE2C
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2026 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4991F43787F;
	Tue,  7 Jul 2026 17:15:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF0437857;
	Tue,  7 Jul 2026 17:15:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783444515; cv=pass; b=IJrOe0Zlh3ol/ng9VpuUbbgIiLNqaQZq5tceSHPc0nKswkqVksFVwaVyYqHw9qWWB8ltnuN6dGq0WgNVDFm73S8nT49xfqdJIHIDU2EeWNVxCJFGoaSILJPa3cfFljmrSyzTC/S0f7oa5aS08nrscdpOmIV5dEE3M4ggjN1XytA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783444515; c=relaxed/simple;
	bh=Fk3AkZVjgqLR06RoMyFMddArIDiVOz+n2M7Zso8MwdE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CIIxNkXV1CmGcT2qYTBUXvB2Dbni58HwFEXBtUlOpB6jNn1XOwUxZfj5nRJAGTz5w5jaJsFsmne2QzWUF367Fe8SnCU+jLVFgeD2Gjln/0a4VqOrV2ivwSKVrBj4DGV56X2je+quQsLGAHGfs4a8zvJ72Xgyx4zbjDesIu8T1EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ORVn9N7W; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783444482; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=II9cW/m5Vv18fw/Fz0WLyRsiGR6pKU06k+7ZwMGqReK255ZDRP+Jcp5dBlcizDWNyvEanGLJAxhtbX2689uNiQHmw6Wa9j+MeejeWwFXdRa3Ncl0GBynkxxAnywIU1y/SXh88KtqABYgZGvhyTmTfatUwJ3YXgWTJFyTLnnGjLk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783444482; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fEaD+gRjp8aYJ0as2zjJ9AwHePMS8+98otLPU9UgGEY=; 
	b=NF3cGoe+89Uz0P9E6l0xjqep6c1vBs5OJJ3jFlQYC94rlcmLovPksrhYRmUI7e/1t+kOWHicCBLvO14LH3btunv4gfXdtllXAcfzHSRxzc6+82CHXvuaV37slE/Y56sDnPSRM9Us1YGpWIGEFGfxdFKZavuEJ5VgKK5GzuUw+ms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783444482;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=fEaD+gRjp8aYJ0as2zjJ9AwHePMS8+98otLPU9UgGEY=;
	b=ORVn9N7W+sewhCy0ODkKQiTiYiIu8blGoZgZYks+GXl3DwIhze+UBxhL88yseY7q
	KZsWnlwNvAalMQUWiqQ/AUv+RVX3Em9Tfc0Exhem3ygzUzXJLA3rbf48HlVJnyoKL0X
	dhD/xcgwYmXTkDul9KnOmpl+HpUxZDMb/qKpIKTM=
Received: by mx.zohomail.com with SMTPS id 1783444480458298.4850949227821;
	Tue, 7 Jul 2026 10:14:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 01/20] rust: io: add dynamically-sized `Region` type
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net>
Date: Tue, 7 Jul 2026 14:14:20 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9AC77170-279D-4C0A-89F7-8D07F418AADF@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9623-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	APPLE_MAILER_COMMON(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,vger.kernel.org:from_smtp,garyguo.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6897C71E383

Hi Gary,

A bit late to the party here, but going through this series one by one :)

> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
> 
> Currently many I/O related structs carry a `SIZE` parameter to denote the
> minimum size of the I/O region, while they also carry a field indicating
> the actual size. Proliferation of the pattern creates a lot of duplicated
> code, and makes it hard to create typed views of I/O.
> 
> Introduce a `Region` type that carries the `SIZE` parameter. It is a
> wrapper of `[u8]`, which makes it dynamically sized with a metadata of
> `usize`. This way, pointers to `Region` naturally carry size information.
> This type is required to be 4-byte aligned.

Why 4, specifically? i.e.: I wonder if this breaks u64 mmio accessors?
> 
> Expose the minimum size information via `MIN_SIZE` constant of the
> `KnownSize` trait. Similarly, expose the minimum alignment information via
> `KnownSize::MIN_ALIGN`.
> 
> With these changes, it is possible to add an associated type to `Io` trait
> to represent the type of I/O region. For untyped regions, this is the newly
> added `Region` type. Remove `IoKnownSize` as it is no longer necessary. Use
> the same mechanism to indicate minimum size of PCI config spaces.
> 
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

If MIN_ALIGN = 4 is actually intentional:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>



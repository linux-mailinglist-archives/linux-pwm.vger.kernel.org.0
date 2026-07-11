Return-Path: <linux-pwm+bounces-9696-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jxd4NCVrUmpcPgMAu9opvQ
	(envelope-from <linux-pwm+bounces-9696-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 18:11:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DE9742255
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 18:11:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lArd3Na1;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9696-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9696-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4EE1300D720
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE5D3C7DE1;
	Sat, 11 Jul 2026 16:11:12 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841D2C21E6;
	Sat, 11 Jul 2026 16:11:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783786272; cv=none; b=Y/m1XE2+ipSB+nxNf2YabZzi7NcqmPw7yB9Mo4hb0on80LhbltnTapE1hTyxfPWwaritCXI73UP6algB3yFejW6ZC2D/obnfKSmXC3AHUYN5LcLSlBCO02OGK7113QehDYBXFm4a+YMrxACPySqGKcvboJEt8dC6pDvzIof3WyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783786272; c=relaxed/simple;
	bh=PEmfnP3Viq0Iq57bVtkUe663Z9qvI2bWV0EPII+zm3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHD6SciXtHgrcJ6ILjhIZ4l72CVGGmf1WUKG251cfbcOz1otVtUoFYmXsXjhqh9yR6In/3pKB2LC7AsfDfGgpBxvDVh/o9JI7yuqFoFdddVgnaHH/9TX8ohvCWxXxZeVkfxyg63z/e5hR09j6mzsVEN9gdHjhm0w0BGX1uJrvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lArd3Na1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5631F000E9;
	Sat, 11 Jul 2026 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783786271;
	bh=l157i8Cbrra3gsqHh/wXLRqMCSqeyLs3OdEljp8wurU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lArd3Na1tBACCTa0rtlAkbcQ+djURemz6aRjlt6N0k/8t6r0PBRgovVvcyHCDbHzA
	 LJwYirK/usCJULhtOoOIqTJDf9ZLKevYYc2OU8GG9bTsLm281wrQNBsbZF8u8B6LOC
	 w8G3MjGwmEdaPpbIlk4SZBdIr/XLdvY8Km86tNKxbqPu+BCHBwyqaEXqLtUCW5kGAk
	 mTs10adg9ucQ/28mQ4N/G7R9GfS7sJuMi4pzJgxHJ7r9v/9/rhbVh5Lv83aDCB/mG4
	 CdVGUi5+2Z1raFOA8856mTZUnkfLayu7BgYnzHGHZgAEAXkMPpEbXMw72EsjOsfXsZ
	 92Ix6+oXxDefA==
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pwm@vger.kernel.org,
	Laura Nao <laura.nao@collabora.com>
Subject: Re: [PATCH v6 00/20] rust: I/O type generalization and projection
Date: Sat, 11 Jul 2026 18:10:36 +0200
Message-ID: <20260711161035.370023-2-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9696-lists,linux-pwm=lfdr.de];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:laura.nao@collabora.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48DE9742255

On Mon, 06 Jul 2026 13:44:13 +0100, Gary Guo wrote:=0D
> [PATCH v6 00/20] rust: I/O type generalization and projection=0D
=0D
Applied, thanks!=0D
=0D
  Branch: topic/rust_io-7.2-rc1=0D
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-=
core.git=0D
=0D
[1/20] rust: io: add dynamically-sized `Region` type=0D
      commit: 426c92ca1bdd=0D
=0D
      [ Add brief explanation on MIN_ALIGN. - Danilo ]=0D
=0D
[2/20] rust: io: add missing safety requirement in `IoCapable` methods=0D
      commit: 65f6abf9fa81=0D
[3/20] rust: io: restrict untyped IO access and `register!` to `Region`=0D
      commit: 6461c5776bf0=0D
[4/20] rust: io: implement `Io` on reference types instead=0D
      commit: 46b1b54139c3=0D
[5/20] rust: io: generalize `MmioRaw` to pointer to arbitrary type=0D
      commit: 9734e905119c=0D
[6/20] rust: io: rename `Mmio` to `MmioOwned`=0D
      commit: 691c75967d44=0D
[7/20] rust: io: implement `Mmio` as view type=0D
      commit: 9f64c84af008=0D
[8/20] rust: pci: io: make `ConfigSpace` a view=0D
      commit: 6e5f28968d7b=0D
[9/20] rust: io: use view types instead of addresses for `Io`=0D
      commit: e0454ec1220c=0D
[10/20] pwm: th1520: remove unnecessary `deref`=0D
      commit: 0adc93b85374=0D
[11/20] rust: io: remove `MmioOwned`=0D
      commit: bed01ca9e9cf=0D
[12/20] rust: io: move `Io` methods to extension trait=0D
      commit: 9b36c13cbd4f=0D
=0D
      [ Add comment explaining the purpose of the Io blanket implementation=
.=0D
        - Danilo ]=0D
=0D
[13/20] rust: io: add projection macro and methods=0D
      commit: 1f989555fe5c=0D
[14/20] rust: io: add I/O backend for system memory with volatile access=0D
      commit: 2fabff780785=0D
[15/20] rust: io: implement a view type for `Coherent`=0D
      commit: 1d409d1e7a87=0D
[16/20] rust: io: add `read_val` and `write_val` functions on `Io`=0D
      commit: 89814c42c19e=0D
[17/20] gpu: nova-core: use I/O projection for cleaner encapsulation=0D
      commit: 0722567f5085=0D
[18/20] rust: dma: drop `dma_read!` and `dma_write!` API=0D
      commit: 6ff7d69b7e6e=0D
[19/20] rust: io: add copying methods=0D
      commit: e7219e53c525=0D
[20/20] rust: io: implement `IoSysMap`=0D
      commit: 11a4784f902e=0D
=0D
The patches are in the topic/rust_io-7.2-rc1 topic branch and will be merge=
d=0D
into the corresponding target branch soon.=0D


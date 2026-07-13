Return-Path: <linux-pwm+bounces-9703-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hw77A8xqVWpToAAAu9opvQ
	(envelope-from <linux-pwm+bounces-9703-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 00:46:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B874F92A
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 00:46:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IDPceOJt;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9703-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9703-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC1003036608
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2026 22:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253253B83F0;
	Mon, 13 Jul 2026 22:46:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D435C19F;
	Mon, 13 Jul 2026 22:46:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982793; cv=none; b=tEAa3sX1WvpiqZT4ITtGieByjBRl/z2fJ4fDV1A4onRDFfW/x3uDmG+LPLfL6ULFfLe+Jk0cTN7Sk3Gu/U/0HRtXy2qQ2LNZOD5/nk6JVhLKmOYy1XpCjD5iMc9q/+sCnqEVpVDsjgwn3mm0AsUp5A0IFhLP9HqIuK8vO2EusUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982793; c=relaxed/simple;
	bh=ki0rf5KXacbCrzLLJ68G/ZKvopgBN+PE/LQidwi3tPE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Tc4gaUhL6M1kp2U6ACbV4Y3rphs/c9jtCnpvfN0cdhFreR57bY10nFLUBO3gPA08kBhMz8LSaGOIWqZl5LybbfV2dZ9tvqCGaJGGN2uXuw3m08MhPixes+t+61JOX00z6WpqGDgyhoZtGBSkgOKQ0kTAGpzaAqeoLjkgBdlhzzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDPceOJt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EFD1F000E9;
	Mon, 13 Jul 2026 22:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783982791;
	bh=v/c9cJvLiRUh0chD13eoJnb/QVSK0PEeoY/ZOsgieZg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=IDPceOJti8yjJTBHFR/PJstHcpy5h9nOpUFSwcTgPBT3+IeSs0qigOxd/Utj7ob/r
	 616LSjIgzvakV7IRTDokAowfnRuKuyFD2ARi0jsLG1Qaq3QlQcsYqRUp1TRom5MIWz
	 2znZQMzmZ3oZvtG1loeTGp57R4o6Dk1VQUFK9xP636/aeuem84FHzqwVc55gucAUeL
	 hk/hgly4VxBVThEtB2B8QpRaq/PijFbG5KVzNtd/zfEAYm16zQC927QhbxsrIfVtXF
	 1D/Y7O854UGxSn5pgCyRYMF5CMn6owa2l/GSTrDG+2QQNlKfJ60UtpqQPVprgTm363
	 KQoips+yb76pw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 00:46:22 +0200
Message-Id: <DJXT48G5GZAJ.346BAPDEQ53FT@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, "Laura Nao" <laura.nao@collabora.com>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 00/20] rust: I/O type generalization and projection
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260711161035.370023-2-dakr@kernel.org>
In-Reply-To: <20260711161035.370023-2-dakr@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9703-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:laura.nao@collabora.com,m:ecourtney@nvidia.com,m:jhubbard@nvidia.com,m:apopple@nvidia.com,m:zhiw@nvidia.com,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 585B874F92A

On Sat Jul 11, 2026 at 6:10 PM CEST, Danilo Krummrich wrote:
> On Mon, 06 Jul 2026 13:44:13 +0100, Gary Guo wrote:
>> [PATCH v6 00/20] rust: I/O type generalization and projection
>
> Applied, thanks!
>
>   Branch: topic/rust_io-7.2-rc1
>   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/drive=
r-core.git
>
> [1/20] rust: io: add dynamically-sized `Region` type
>       commit: 426c92ca1bdd
>
>       [ Add brief explanation on MIN_ALIGN. - Danilo ]
>
> [2/20] rust: io: add missing safety requirement in `IoCapable` methods
>       commit: 65f6abf9fa81
> [3/20] rust: io: restrict untyped IO access and `register!` to `Region`
>       commit: 6461c5776bf0
> [4/20] rust: io: implement `Io` on reference types instead
>       commit: 46b1b54139c3
> [5/20] rust: io: generalize `MmioRaw` to pointer to arbitrary type
>       commit: 9734e905119c
> [6/20] rust: io: rename `Mmio` to `MmioOwned`
>       commit: 691c75967d44
> [7/20] rust: io: implement `Mmio` as view type
>       commit: 9f64c84af008
> [8/20] rust: pci: io: make `ConfigSpace` a view
>       commit: 6e5f28968d7b
> [9/20] rust: io: use view types instead of addresses for `Io`
>       commit: e0454ec1220c
> [10/20] pwm: th1520: remove unnecessary `deref`
>       commit: 0adc93b85374
> [11/20] rust: io: remove `MmioOwned`
>       commit: bed01ca9e9cf
> [12/20] rust: io: move `Io` methods to extension trait
>       commit: 9b36c13cbd4f
>
>       [ Add comment explaining the purpose of the Io blanket implementati=
on.
>         - Danilo ]
>
> [13/20] rust: io: add projection macro and methods
>       commit: 1f989555fe5c
> [14/20] rust: io: add I/O backend for system memory with volatile access
>       commit: 2fabff780785
> [15/20] rust: io: implement a view type for `Coherent`
>       commit: 1d409d1e7a87
> [16/20] rust: io: add `read_val` and `write_val` functions on `Io`
>       commit: 89814c42c19e
> [17/20] gpu: nova-core: use I/O projection for cleaner encapsulation
>       commit: 0722567f5085
> [18/20] rust: dma: drop `dma_read!` and `dma_write!` API
>       commit: 6ff7d69b7e6e
> [19/20] rust: io: add copying methods
>       commit: e7219e53c525
> [20/20] rust: io: implement `IoSysMap`
>       commit: 11a4784f902e
>
> The patches are in the topic/rust_io-7.2-rc1 topic branch and will be mer=
ged
> into the corresponding target branch soon.

Now in driver-core-next and drm-rust-next, thanks!


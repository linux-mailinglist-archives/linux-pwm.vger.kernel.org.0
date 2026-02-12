Return-Path: <linux-pwm+bounces-8123-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFBZJF3djWna8AAAu9opvQ
	(envelope-from <linux-pwm+bounces-8123-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 15:02:05 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EDE12E0D3
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECD083009000
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A02D283FEA;
	Thu, 12 Feb 2026 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhB2vmVh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325623EBF1F;
	Thu, 12 Feb 2026 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904899; cv=none; b=nL1yv9+zeRlnCJdI4a5FtuemqSsTbativaygAwloPGuyYCYBJJHk6a0Qy2K3C7n2CvRPVfgKyya/mrgme17gVzHmnCoO7Q8zReuhoSKM9L1c5vcn+1nubYJTzW4ZWhI5xDuW6DGLcrqVy24XP9pfafgWphDVqQi4bRjzLW0nt4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904899; c=relaxed/simple;
	bh=q255LW2NGXZnwgvkPm1VB5LcqPE0iLSjOErv9KPVwLg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=qIsgKvJzXZBCCNB/J8zG/KzudnqnL9TseE6LMf834R54iGtAVmeEC9+U4c5avlrI5/zHA2zV0WIxwcciq5iXrrllz7OAz8W15rqjxfVZ6VCUjBLOZunybCKT6EN2GmwfCkeUO48sBfNDE4DH1FYSgrsATpTrSNVZtmzJeDZ6U1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhB2vmVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816CDC4CEF7;
	Thu, 12 Feb 2026 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770904898;
	bh=q255LW2NGXZnwgvkPm1VB5LcqPE0iLSjOErv9KPVwLg=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=IhB2vmVh93ZzFpYfLyXgfCB1XI973SeOPjXHCjdMvT2tc/eMxFyIfieVCzaYm9z17
	 phvUwl525/GGPCwGxxssIVFbsLg9YhPKbEE3Q8vslSuE05Ax1ZJpEJPzzXHKmhnDjz
	 GnNQ/5wPMCZA72tf8pP0BZ818qNi1T/mtVUVSj99ln+pejsM4nmFLFGEZLZffsvtb8
	 D1hs/Pcb5sezJw9Zk+jcqSLGODjIaeyrlE3lG7EIw7afLqgzfunbQPgLoxpUamwnjH
	 wYtae+6pWDPbVZD80Fzzap5GAkaWR8AxZZWF6V0PBAZT/zqdZ+13TP1yt0RK5k96Bo
	 sxC/eW4sbF2Zg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 15:01:31 +0100
Message-Id: <DGD1E42JOSQ3.28RPL84IP5R9I@kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Cc: "Boris Brezillon" <boris.brezillon@collabora.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Drew Fustini" <fustini@kernel.org>, "Guo Ren"
 <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
References: <20260119-weightless-pelican-of-anger-190db0@houat>
 <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org>
 <20260122-majestic-masterful-jaguarundi-d0abde@houat>
 <2F3D3A40-6EF9-46FC-A769-E5A3AAF67E65@collabora.com>
 <20260204-nickel-seal-of-poetry-8fdefb@houat>
 <91A92D84-1F2E-45F3-82EC-6A97D32E2A78@collabora.com>
 <20260204-angelic-vermilion-beagle-fd1507@houat>
 <20260209105047.693f2515@fedora>
 <20260211-flawless-feathered-boar-0b87ad@houat>
 <DGCAAE4YEDLO.299F5M641E90B@kernel.org>
 <20260212-obedient-faithful-koel-d8aaf6@houat>
 <DGCVH2B2OSFR.1C912TO7G7DGL@kernel.org>
In-Reply-To: <DGCVH2B2OSFR.1C912TO7G7DGL@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8123-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 07EDE12E0D3
X-Rspamd-Action: no action

On Thu Feb 12, 2026 at 10:23 AM CET, Danilo Krummrich wrote:
> In particular, I don't think we need an unsafe API until we see a concret=
e
> example where the proposed safe API does not work (and no other safe API =
would
> work either).

One additional note for clarification, I'm not saying that I'm against an u=
nsafe
API if it is necessary.

In fact, I have added an unsafe API for drivers myself with the dma::Device
trait [1]. This was not an easy decision and I discussed this back and fort=
h
with a lot of people and, unfortunately, we had to come to the conclusion t=
hat
any attempt to make this safe from the Rust side of things would cause
unreasonable overhead and can't be considered an overall improvement.

But as I said, I am convinced that need clear evidence that an unsafe API i=
s
actually needed and that there is no reasonable alternative.

[1] https://rust.docs.kernel.org/kernel/dma/trait.Device.html


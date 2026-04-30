Return-Path: <linux-pwm+bounces-8757-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAajHNlb82lfzwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8757-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 15:40:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4414A3988
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF3E83051BE8
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 13:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC43426690;
	Thu, 30 Apr 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGoPJO7X"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FE640242D;
	Thu, 30 Apr 2026 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556179; cv=none; b=oX0d4c7RDZRtTvaFiA/Da9n0oIBTwwlZVqlkw2WlHi9HPKJEGHzOzTgZ0AnBerfX12hwK7Wu+ofYB6NXQcEGgffgz4LlIECFtP8aO0UlUUy6Az7XCmu4osQ6xLzuO/IaULHQ3rM+EhBu+o9HHR08fTm9YDCvLycuHsMj0iA3OJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556179; c=relaxed/simple;
	bh=yY9NYXCtY5JDgSBUBfNy8huUBY+6EKtf7LJCZ9GZzQk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=JiJAI60ktHzvceUECmrYKCqm5bs/Vi3nrC9IAknSbSv5Br8MDNxXZcYKl2Ql0CWaEZMuCU5oYsPanpm5lHI/FHJ/zmwOKe8hbU5j0tfGOgHlcN1HAkmD1I69pxRYLnG8OIIZ9rsw/IKoiGKCpLfkNgXj3d4I0PfZIWZTX9SgzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGoPJO7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9CFC2BCB3;
	Thu, 30 Apr 2026 13:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777556178;
	bh=yY9NYXCtY5JDgSBUBfNy8huUBY+6EKtf7LJCZ9GZzQk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=fGoPJO7XTCigvOtBssq5CuKro5zjXHaSAu2tlgV8d2dFBKv9/1bRfnaqayqKiyWKA
	 U/Draq/tJjr7hA4oxqU0OrrzZE5kvGJJcVikG5KuXIEBrjie34C8e5wnxwvV5dVLQt
	 rADxS3J3rGUEU2M3QK+Vv2wr9a62TqF5a52Y4prW9YLt+juStiKtQgNRxwT2jEZ/vS
	 Dvyr50gw13sSY7M+NoJI5VP9G5fSCByL1j+NXSBXkzbI+l35hZhjcCRmU00QzZ63fj
	 T5yIJohCC410Vnx5l4x3kDQi8kLfbQ8XjUs5thZfTRAAvPvIVZ7Y9zjP82YtuzQFIb
	 cIdBPz/DTo5NA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 15:36:11 +0200
Message-Id: <DI6J2O3THBON.30TCZ9GDGHJO1@kernel.org>
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <afMdfs0segrRBx34@google.com>
In-Reply-To: <afMdfs0segrRBx34@google.com>
X-Rspamd-Queue-Id: DE4414A3988
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-8757-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,intel.com,linaro.org,samsung.com,google.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[30];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu Apr 30, 2026 at 11:14 AM CEST, Alice Ryhl wrote:
> Super cool to see this!
>
> On Tue, Apr 28, 2026 at 12:10:58AM +0200, Danilo Krummrich wrote:
>> Before:
>>=20
>> 	struct MyDriver {
>> 	    pdev: ARef<pci::Device>,
>> 	    bar: Devres<pci::Bar<BAR_SIZE>>,
>> 	}
>>=20
>> 	let io =3D self.bar.access(dev)?;
>> 	io.read32(OFFSET);
>>=20
>> After:
>>=20
>> 	struct MyDriver<'a> {
>> 	    pdev: &'a pci::Device,
>> 	    bar: pci::Bar<'a, BAR_SIZE>,
>> 	}
>>=20
>> 	self.bar.read32(OFFSET);
>
> I think we should establish a convention for how to name the lifetime
> early. Using just the generic name 'a is probably not ideal.
>
> How about using 'dev for lifetimes that correspond to the lifetime of
> the device being bound?

I'd rather not go for 'dev, as it could be confused with the lifetime of th=
e
struct device itself, which is reference counted and independent from the d=
evice
/ driver binding lifecycle.

People already confuse this all the time, so I'd rather go for 'bound, whic=
h is
more precise, but could be a bit long on the other hand.


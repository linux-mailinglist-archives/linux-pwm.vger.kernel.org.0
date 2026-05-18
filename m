Return-Path: <linux-pwm+bounces-8978-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KVLOfM6C2qWEwUAu9opvQ
	(envelope-from <linux-pwm+bounces-8978-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 18:14:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D1570AE2
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 18:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C256130207D0
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB097495504;
	Mon, 18 May 2026 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6oBjBu2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2AF37266D;
	Mon, 18 May 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120668; cv=none; b=bIXyjvgwB9ruEK+2uBI5bgbqewB2xMcl9FkC8X7ZlYPL66l3A5U3fM/WKdc72ALWORtpUD9pxuPXmg+sPrvcmcJhrdP1M6oYgceNtq9r3wVt6Ked+bbxVKN5EQJYbtptV+6MKA1y9BD7p5SUeG7O5HJNm4n2fBzsbJMZ272eVRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120668; c=relaxed/simple;
	bh=T//OFr0mDkF3tjl7LVEO5CAeVXbcx9hS1UZdVnD6HbY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=HfiVZrow7Loo7i+aPTrvLp/jduAP0TWNpylAoqf6RF/Yj9lv9rO/GFZP+NpHMZmIvw90iQqFSodtygrQSjCWIGLOMdDYZGuOxizfsKI5RY379NGMC4PWHUxcdnt5B0tcPIs5hupPddosr43FHr7EyRRI/Hwu+tBtAVxlCcFUqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6oBjBu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958D6C2BCB7;
	Mon, 18 May 2026 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779120666;
	bh=T//OFr0mDkF3tjl7LVEO5CAeVXbcx9hS1UZdVnD6HbY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=n6oBjBu2u5eB7+AzCKDXdsSysgW9ESFJCjw3WVuUNdCBHbWUXCdjX1Arojah/0BdF
	 nKNBuUS5VOqDCgFOEZMV1yU9JkRhCsl8h9NawTLNDeE7w1I3bteaVKpduxkna8iFlB
	 aeJ9dlodQK+ADM0SgQ99v0qvaFxHitbemJgWAIxq9ad3rnXru+dxFQR6lnciSr5D3e
	 0mEs08OWS64wVltIxzrYvWEVU3TT6g++3+x27u+ef9Ru5OtEZ472Mdd9Xm50v8GzoC
	 MNef426y7LLrakd0VPAH+efoP9eiJ0Enyl66yUIolFpGjhiUaOHbI1QiVkt99VNOS9
	 RcrPOg2IoQLtg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 18:10:58 +0200
Message-Id: <DILXMZIF3NYC.2G7E0DEBJS90R@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-11-dakr@kernel.org>
 <DILWWIPKW00V.2W06IJU4ET4AX@garyguo.net>
In-Reply-To: <DILWWIPKW00V.2W06IJU4ET4AX@garyguo.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8978-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 492D1570AE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 18, 2026 at 5:36 PM CEST, Gary Guo wrote:
>> +    fn probe<'bound>(
>> +        pdev: &'bound pci::Device<Core>,
>
> This is technically incorrect, as the `Device<Core>` only lives as long a=
s the
> callback. Having `'bound` would be incorrect.

I think that's more on the theoretical side, as Core is not Sync, but I agr=
ee it
makes sense to address.

> or perhaps by adding a lifetime to `Core<'_>`
>
>     pdev: &'bound pci::Device<Core<'_>>,

This seems reasonable.


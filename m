Return-Path: <linux-pwm+bounces-8997-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COhvE7hDDGrQcQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8997-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:04:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EFE57D239
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5690A3221D83
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92F24DC529;
	Tue, 19 May 2026 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H31fv2H7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C75370AE3;
	Tue, 19 May 2026 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187184; cv=none; b=tZ3XvPmOOY2dAXgHsLPtF0xsZwGxJXoesJVnL/ujdjvcNEafGMXacGxcxzO1fvRZg9Jq1FRbJTdLAroIQJVKVHGHZJiZQsubOQK42rxuTh5+GflnurS5pQrNeF5KHXGRvY0XaGEuKK0C6jOnLNOAXBUeuPQ4m8b0gBmrjeX5W+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187184; c=relaxed/simple;
	bh=8d9cpV7MYabXiaU/WPwazqmKL15k0EHx4/GtitV+QU4=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version:
	 References:In-Reply-To; b=C9teXddmzYem285CBx+MzwnegKFOztkT6ojQchUSd5u4NqOnx3RVkyA58pZGN85WllcZyR3z6sysqhDoe4I+SpH7zh+0q5wDV5X2rFwKQM1g91kHdyK3tUgakZK2IO3fE3fnBmLGBiNftpiWBgKtNBY5/5ag0YTgf9QaQAEXswY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H31fv2H7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CCBC2BCF6;
	Tue, 19 May 2026 10:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779187184;
	bh=8d9cpV7MYabXiaU/WPwazqmKL15k0EHx4/GtitV+QU4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=H31fv2H7Ias22CXBpSvo+ewqfFwVMzz7gnADIyQKS0WjPxHcwn4Y9f9IWghXxGQ4T
	 g6ZtDZP354KXG6/9XPA6DNIoE7MMlbcM3bJx/engJFqqD9O+UmIpCtsJB98sPRmG5N
	 3IDAD+V+Br5uYM7gEN/epmZwIc8Hxlr2/8BFjiBcWZlPwo60Fp8Llby2uAhwfiFLhe
	 HPhGYBNxwEie/cw527WdH4byKYHRyYRU3ecjDFFHjiy0EA41H/4DV08fYrhEKGzaep
	 jXlsz/Fyufsk/Gi92Fd56mtpb+/KWaK3t4HuQByRxJ2Tu9oRZ9i+SwJxpbqQddZnq/
	 lAojQ4HSxpc7g==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 12:39:36 +0200
Message-Id: <DIML7T3R6BXP.2WSFVG2VY63LP@kernel.org>
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <pcolberg@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-11-dakr@kernel.org>
 <DIMDU2XL6PKO.RUXA0XPFT94R@nvidia.com>
In-Reply-To: <DIMDU2XL6PKO.RUXA0XPFT94R@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8997-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A4EFE57D239
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 6:52 AM CEST, Eliot Courtney wrote:
> Is this really sound without a covariance proof? For example, with this
> version you could stash a Cell<Option<&'bound pci::Device<Bound>> (even
> with Gary's suggested Core<'_> change) and then observe that reference
> on Drop of Data, which seems unsound to me.

The Core<'_> change seems unrelated, Core is not Sync, so you can't store i=
t in
the first place.

Otherwise, I don't see how one can exploit this. The formal invariance of
Cell<Option<&'bound pci::Device<Bound>> is not practically exploitable beca=
use
the framework controls what lifetimes are available and everything reachabl=
e
through 'bound outlives the data; something that is shorter lived than 'bou=
nd
can't be stored either.

Bringing back ForLt for this reason seems undesirable, as it has a real des=
ign
cost.

